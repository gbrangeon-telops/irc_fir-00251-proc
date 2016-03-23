/**
 *  @file proc_boot.c
 *  Processing FPGA boot loader main() function.
 *  
 *  $Rev$
 *  $Author$
 *  $LastChangedDate$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "tel2000_param.h"
#include "xparameters.h"
#include "proc_prom.h"
#include "utils.h"
#include "printf_utils.h"
#include "xuartns550_l.h"
#include "xbasic_types.h"
#include "xil_exception.h"
#include "IRC_Status.h"
#include "led_ctrl.h"
#include "QSPIFlash.h"
#include "SREC.h"
#include "StackUtils.h"
#include <string.h>


/**
 * Processing FPGA boot loader state machine state enumeration.
 */
enum procBootStateEnum {
   PBS_INIT = 0,
   PBS_READ_FLASH,
   PBS_PARSE_SREC
};

/**
 * Processing FPGA boot loader state machine state datatype.
 */
typedef enum procBootStateEnum procBootState_t;

IRC_Status_t ProcBoot_SM(qspiFlash_t *qspiFlash);

/**
 * Progress character values definition.
 */
#define PROC_BOOT_PROGRESS_SIZE  8
char gProgress[PROC_BOOT_PROGRESS_SIZE] = {'|', '/', '-', '\\', '|', '/', '-', '\\'};

/**
 * Vector section information
 */
#define PROC_BOOT_VECTOR_SECTION_ADDR  0x00000000
#define PROC_BOOT_VECTOR_SECTION_SIZE  0x50

/**
 * Global variables
 */
ledCtrl_t gLedCtrl;
XIntc gIntc;
qspiFlash_t gQSPIFlash;

/*--------------------------------------------------------------------------------------*/
/* main                                                                                 */
/*--------------------------------------------------------------------------------------*/
int main()
{
   IRC_Status_t status;

   Stack_ConfigStackViolationException();

   // Initialize general purpose 64-bit timer
   Timer_Init(XPAR_TMRCTR_0_BASEADDR, XPAR_TMRCTR_0_CLOCK_FREQ_HZ);
   //Timer_Test(300);

   WAIT_US(30);
   XUartNs550_SetBaud(STDOUT_BASEADDRESS, XPAR_XUARTNS550_CLOCK_HZ, 115200);
   XUartNs550_SetLineControlReg(STDOUT_BASEADDRESS, XUN_LCR_8_DATA_BITS);
   PRINTF("Boot loader starting...\n");

   // Initialize LED
   Led_Init(&gLedCtrl, XPAR_AXI_GPIO_0_DEVICE_ID);

   // Initialize the interrupt controller driver.
   status = XIntc_Initialize(&gIntc, XPAR_INTC_0_DEVICE_ID);
   if (status != XST_SUCCESS)
   {
      PRINTF("Failed to initialize interrupt controller.\n");
   }

   // QSPI flash initialization
   status = QSPIFlash_Init(&gQSPIFlash,
         XPAR_AXI_QUAD_SPI_0_DEVICE_ID,
         &gIntc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_QUAD_SPI_0_IP2INTC_IRPT_INTR);
   if (status != IRC_SUCCESS)
   {
      PRINTF("Failed to initialize QSPI flash.\n");
   }

   /*
    * Start the interrupt controller such that interrupts are enabled for
    * all devices that cause interrupts, specifies real mode so that only
    * hardware interrupts are enabled.
    */
   status = XIntc_Start(&gIntc, XIN_REAL_MODE);
   if (status != XST_SUCCESS)
   {
      PRINTF("Failed to start interrupt controller.\n");
   }

   // Enable the interrupt for the SPI driver instances.
   XIntc_Enable(&gIntc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_QUAD_SPI_0_IP2INTC_IRPT_INTR);

   // Initialize the exception table.
   Xil_ExceptionInit();

   // Register the interrupt controller handler with the exception table.
   Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
          (Xil_ExceptionHandler)XIntc_InterruptHandler,
          &gIntc);

   // Enable exceptions.
   Xil_ExceptionEnable();

   PRINTF("Loading application image...\n");

   // Main loop
   while(1)
   {
      Led_ToggleDebugLedState(&gLedCtrl);
      if (ProcBoot_SM(&gQSPIFlash) != IRC_SUCCESS)
      {
         // Halt
         PRINTF("Boot loader halted.\n");
         while (1);
      }
   }
}

/**
 * Processing FPGA boot loader state machine.

\dot
digraph G {
PBS_INIT -> PBS_READ_FLASH -> PBS_PARSE_SREC;
}
\enddot

 */
IRC_Status_t ProcBoot_SM(qspiFlash_t *qspiFlash)
{
   static procBootState_t state = PBS_INIT;
   static uint32_t qspiFlashPageIndex = 0;
   static uint8_t flashData[PAGE_SIZE];
   static char lbuffer[SREC_MAX_LINE_SIZE] = "\0";
   static uint32_t lbuflen = 0;
   static uint32_t srecLineIndex = 0;
   static uint32_t progress;
   static uint8_t vectorSection[PROC_BOOT_VECTOR_SECTION_SIZE];

   uint8_t *p_vectorSection = (uint8_t *)PROC_BOOT_VECTOR_SECTION_ADDR;
   IRC_Status_t status;
   srecInfo_t srecInfo;
   uint8_t *p_flashData;
   uint32_t flashDataCount;
   uint32_t charRead;
   uint32_t i;
   void (*startAddr)();

   switch (state)
   {
      case PBS_INIT:
         memset(vectorSection, 0, PROC_BOOT_VECTOR_SECTION_SIZE);

         state = PBS_READ_FLASH;
         break;

      case PBS_READ_FLASH:
         do {
            status = QSPIFlash_Read(qspiFlash, PROM_SOFTWARE_SREC_BASEADDR + (qspiFlashPageIndex * PAGE_SIZE), flashData, PAGE_SIZE);
         } while (status == IRC_NOT_DONE);
         if (status != IRC_SUCCESS)
         {
            PRINTF("QSPI flash page read failed (page idx = %d).\n", qspiFlashPageIndex);
            return IRC_FAILURE;
         }

         PRINTF("%c\r", gProgress[(progress++ >> 8) % PROC_BOOT_PROGRESS_SIZE]);

         state = PBS_PARSE_SREC;
         break;

      case PBS_PARSE_SREC:
         p_flashData = flashData;
         flashDataCount = PAGE_SIZE;

         status = SREC_GetNextLine((char *)p_flashData, flashDataCount, lbuffer, &lbuflen, &charRead);
         while (status == IRC_SUCCESS)
         {
            srecLineIndex++;
            lbuffer[lbuflen-2] = '\0';

            status = SREC_ParseLine(lbuffer, lbuflen, &srecInfo);
            if (status != IRC_SUCCESS)
            {
               PRINTF("Failed to parse SREC line %d: %s.\n", srecLineIndex, lbuffer);
               return IRC_FAILURE;
            }

            switch (srecInfo.type)
            {
               case SRECT_S0:
                  for (i = 0; i < srecInfo.dalaLength; i++)
                  {
                     PRINTF("%c", srecInfo.dataBytes[i]);
                  }
                  PRINTF("\n");
                  break;

               case SRECT_S1:
               case SRECT_S2:
               case SRECT_S3:
                  if (srecInfo.addr < PROC_BOOT_VECTOR_SECTION_SIZE)
                  {
                     memcpy(&vectorSection[srecInfo.addr], srecInfo.dataBytes, srecInfo.dalaLength);
                  }
                  else
                  {
                     memcpy((void *)srecInfo.addr, srecInfo.dataBytes, srecInfo.dalaLength);
                  }
                  break;

               case SRECT_S9: /** Start address (16-bit address) */
               case SRECT_S8: /** Start address (24-bit address) */
               case SRECT_S7: /** Start address (32-bit address) */
                  startAddr = (void (*)())srecInfo.addr;
                  for (i = 0; i < PROC_BOOT_VECTOR_SECTION_SIZE; i++)
                  {
                     p_vectorSection[i] = vectorSection[i];
                  }
                  PRINTF("Executing program starting @ 0x%08X\n", (uint32_t)startAddr);
                  (*startAddr)();

                  // Should never get there
                  return IRC_FAILURE;
                  break;

               case SRECT_S4:
               case SRECT_S5:
               case SRECT_S6:
                  // Unsupported SREC types
                  break;
            }

            p_flashData += charRead;
            flashDataCount -= charRead;
            lbuflen = 0;
            status = SREC_GetNextLine((char *)p_flashData, flashDataCount, lbuffer, &lbuflen, &charRead);
         }

         if (status == IRC_FAILURE)
         {
            PRINTF("Failed to get next SREC line (%d).\n", srecLineIndex);
            return IRC_FAILURE;
         }

         qspiFlashPageIndex++;
         state = PBS_READ_FLASH;
         break;
   }

   return IRC_SUCCESS;
}

