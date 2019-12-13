/**
 *  @file proc_boot.c
 *  Processing FPGA boot loader main() function.
 *  
 *  $Rev: 17594 $
 *  $Author: dalain $
 *  $LastChangedDate: 2015-12-03 11:13:58 -0500 (jeu., 03 déc. 2015) $
 *  $Id: proc_boot.c 17594 2015-12-03 16:13:58Z dalain $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/proc_boot.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "tel2000_param.h"
#include "xparameters.h"
#include "proc_prom.h"
#include "utils.h"
#include "printf_utils.h"
#include "verbose.h"
#include "xuartns550_l.h"
#include "xil_exception.h"
#include "xil_testmem.h"
#include "IRC_Status.h"
#include "led_ctrl.h"
#include "QSPIFlash.h"
#include "SREC.h"
#include "IRC_Status.h"
#include <stdio.h>
#include <string.h>

#include "Startup_TestMem.h"

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
IRC_Status_t ProcessingCodeMemoryTest(uint32_t* memoryBaseAddr, uint32_t memorySize);

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
#define PROC_CODE_MEMORY_SIZE          (uint32_t)((XPAR_MIG_CODE_MIG_7SERIES_0_HIGHADDR - XPAR_MIG_CODE_MIG_7SERIES_0_BASEADDR) / 4)
#define PROC_CODE_MEMORY_ADDR          (uint32_t)XPAR_MIG_CODE_MIG_7SERIES_0_BASEADDR
#define ONE_SECOND_US                  1000000
#define STARTUP_MSG_REFRESH_TIMER      2 * ONE_SECOND_US



/*--------------------------------------------------------------------------------------*/
/* main                                                                                 */
/*--------------------------------------------------------------------------------------*/
int main()
{
   IRC_Status_t status;
   ledCtrl_t ledCtrl;
   XIntc intc;
   qspiFlash_t qspiFlash;

   char userAns = 0;
   uint64_t msg_refresh_tic;

   // Initialize general purpose 64-bit timer
   Timer_Init(XPAR_TMRCTR_0_BASEADDR, XPAR_TMRCTR_0_CLOCK_FREQ_HZ);
   //Timer_Test(300);

   WAIT_US(30);
   XUartNs550_SetBaud(XPAR_AXI_USB_UART_BASEADDR, XPAR_XUARTNS550_CLOCK_HZ, 115200);
   XUartNs550_SetLineControlReg(XPAR_AXI_USB_UART_BASEADDR, XUN_LCR_8_DATA_BITS);
   FPGA_PRINT("Boot loader starting...\n");

   // Initialize LED
   Led_Init(&ledCtrl, XPAR_AXI_GPIO_0_DEVICE_ID);
   FPGA_PRINT("Initialized LEDs.\n");

   // Initialize the interrupt controller driver.
   status = XIntc_Initialize(&intc, XPAR_INTC_0_DEVICE_ID);
   if (status != XST_SUCCESS)
   {
      FPGA_PRINT("Failed to initialize interrupt controller.\n");
   }
   FPGA_PRINT("Initialized interrupt controller.\n");

   // QSPI flash initialization
   status = QSPIFlash_Init(&qspiFlash,
         XPAR_AXI_QUAD_SPI_0_DEVICE_ID,
         &intc,
         XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_QUAD_SPI_0_IP2INTC_IRPT_INTR);
   if (status != IRC_SUCCESS)
   {
      FPGA_PRINT("Failed to initialize QSPI flash.\n");
   }
   FPGA_PRINT("Initialized QSPI flash.\n");

   /*
    * Start the interrupt controller such that interrupts are enabled for
    * all devices that cause interrupts, specifies real mode so that only
    * hardware interrupts are enabled.
    */
   status = XIntc_Start(&intc, XIN_REAL_MODE);
   if (status != XST_SUCCESS)
   {
      FPGA_PRINT("Failed to start interrupt controller.\n");
   }

   // Enable the interrupt for the SPI driver instances.
   XIntc_Enable(&intc, XPAR_MCU_MICROBLAZE_1_AXI_INTC_AXI_QUAD_SPI_0_IP2INTC_IRPT_INTR);

   // Initialize the exception table.
   Xil_ExceptionInit();

   // Register the interrupt controller handler with the exception table.
   Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
          (Xil_ExceptionHandler)XIntc_InterruptHandler,
          &intc);

   // Enable exceptions.
   Xil_ExceptionEnable();
   FPGA_PRINT("Enabled exceptions.\n\n");

   /*************************************************************************************
    * Processing Code Memory Test as per test 3.2.1 (EFA-00251-001)
    *************************************************************************************/
   GETTIME(&msg_refresh_tic);

   do {

      if (XUartNs550_IsReceiveData(XPAR_AXI_USB_UART_BASEADDR)) {
         userAns = XUartNs550_ReadReg(XPAR_AXI_USB_UART_BASEADDR, XUN_RBR_OFFSET);
      }

      if (elapsed_time_us(msg_refresh_tic) > STARTUP_MSG_REFRESH_TIMER) {
         // Reprint message in case the console was opened too late
         GETTIME(&msg_refresh_tic);
         PRINTF("\rSU2.2.1 : Perform a Processing Code Memory Test? (Y/N) ");
      }

   } while (userAns != 'Y' && userAns != 'N' && userAns != 'y' && userAns != 'n');

   if (userAns == 'Y' || userAns == 'y') {
      if (Startup_TestMem(PROC_CODE_MEMORY_ADDR, PROC_CODE_MEMORY_SIZE) != IRC_SUCCESS){
         return 0;
      }
   }

   /*************************************************************************************/

   PRINT("\n\n");
   FPGA_PRINT("Loading application image...\n");

   // Main loop
   while(1)
   {
      Led_ToggleDebugLedState(&ledCtrl);
      if (ProcBoot_SM(&qspiFlash) != IRC_SUCCESS)
      {
         // Halt
         FPGA_PRINT("Boot loader halted.\n");
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
            FPGA_PRINTF("QSPI flash page read failed (page idx = %d).\n", qspiFlashPageIndex);
            return IRC_FAILURE;
         }

         FPGA_PRINTF("%c\r\0", gProgress[(progress++ >> 8) % PROC_BOOT_PROGRESS_SIZE]);

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
               FPGA_PRINTF("Failed to parse SREC line %d: %s.\n", srecLineIndex, lbuffer);
               return IRC_FAILURE;
            }

            switch (srecInfo.type)
            {
               case SRECT_S0:
                  for (i = 0; i < srecInfo.dalaLength; i++)
                  {
                     PRINTF("%c", srecInfo.dataBytes[i]);
                  }
                  PRINT("\n\n");
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
                  PRINTF("\r");
                  FPGA_PRINTF("Executing program starting @ 0x%08X\n\n", (uint32_t)startAddr);
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
            FPGA_PRINTF("Failed to get next SREC line (%d).\n", srecLineIndex);
            return IRC_FAILURE;
         }

         qspiFlashPageIndex++;
         state = PBS_READ_FLASH;
         break;
   }

   return IRC_SUCCESS;
}

IRC_Status_t ProcessingCodeMemoryTest(uint32_t* memoryBaseAddr, uint32_t memorySize)
{
   int Status = 0;

   PRINT("\n\nWalking Ones Memory Test...     ");

   Status = Xil_TestMem32(memoryBaseAddr, memorySize, 0, XIL_TESTMEM_WALKONES);
   if (Status)
   {
      PRINT("FAIL\n");
      return IRC_FAILURE;
   }

   PRINT("PASS\n");
   PRINT("Walking Zeros Memory Test...    ");

   Status = Xil_TestMem32(memoryBaseAddr, memorySize, 0, XIL_TESTMEM_WALKZEROS);
   if (Status)
   {
      PRINT("FAIL\n");
      return IRC_FAILURE;
   }

   PRINT("PASS\n");
   PRINT("Incremental Memory Test...      ");

   Status = Xil_TestMem32(memoryBaseAddr, memorySize, 0, XIL_TESTMEM_INCREMENT);
   if (Status)
   {
      PRINT("FAIL\n");
      return IRC_FAILURE;
   }

   PRINT("PASS\n");
   PRINT("Inverse Address Memory Test...  ");

   Status = Xil_TestMem32(memoryBaseAddr, memorySize, 0, XIL_TESTMEM_INVERSEADDR);
   if (Status)
   {
      PRINT("FAIL\n");
      return IRC_FAILURE;
   }

   PRINT("PASS\n");
   PRINT("Fixed Pattern Memory Test...    ");

   Status = Xil_TestMem32(memoryBaseAddr, memorySize, 0, XIL_TESTMEM_FIXEDPATTERN);
   if (Status)
   {
      PRINT("FAIL\n");
      return IRC_FAILURE;
   }

   PRINT("PASS\n\n");
   PRINT("All Memtests PASS\n");


   return IRC_SUCCESS;
}
