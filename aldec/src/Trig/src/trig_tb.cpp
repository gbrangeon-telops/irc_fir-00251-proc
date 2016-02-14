/**
 *  @file proc_ctrl.c
 *  Processing FPGA main() function.
 *  
 *  This file contains the main() function.
 *  
 *  $Rev: 13064 $
 *  $Author: enofodjie $
 *  $LastChangedDate: 2014-02-10 15:49:38 -0500 (lun., 10 févr. 2014) $
 *  $Id: proc_ctrl.c 13064 2014-02-10 20:49:38Z enofodjie $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc%20(sandbox)/trunk/src/sw/proc_ctrl.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "xparameters.h"
#include "utils.h"
#include "xbasic_types.h"	
#include "IRC_Status.h"
#include "trig_gen.h"
#include "GC_Manager.h"
#include "Protocol_F1F2.h"
#include "GC_Callback.h"
#include "FlashSettings.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"   
#endif

#define CLINK_UART_BUFFER_SIZE   F1F2_MAX_DLLCOUNT
#define PLEORA_UART_BUFFER_SIZE  100
#define OEM_UART_BUFFER_SIZE     F1F2_MAX_DLLCOUNT
#define FPGA_UART_BUFFER_SIZE    F1F2_MAX_DLLCOUNT

IRC_Status_t GC_Manager_Start(XIntc *intc);
IRC_Status_t Intc_Start(XIntc *intc);

static void StartSubModuleTB();

/*--------------------------------------------------------------------------------------*/
/* main                                       
*/
/*--------------------------------------------------------------------------------------*/
#ifdef SIM
   sc_port<mb_transactor_task_if> *global_trans_ptr; /*< Pointer to a transactor interface */ 
   void proc_ctrl::main()  // We are now defining the main() function of proc_ctrl (THREAD) for SystemC
#else
   int main()  // Defining the standard main() function 
#endif
{
   #ifdef SIM
      global_trans_ptr = &(this->transactor_interface);  // Link the pointer to the SystemC transactor interface
   #endif

//   XSysMon XADC;

   #ifdef SIM
      (*global_trans_ptr)->initialize();  // Initialize the SystemC ports
   #endif
   
   WAIT_US(30);
   PRINT("main() starting... \n"); 
   
   PRINT("StartSubModuleTB... \n");
   StartSubModuleTB();  

   #ifndef SIM
      return 0;
   #endif

}


void StartSubModuleTB()
{
   uint32_t ii;
   t_PosixTime  TimeStamp; 
   uint32_t Status;
   uint32_t StartProblem;
   uint32_t flushProblem;
   uint32_t StopProblem; 
   uint32_t PPCTimeOffset;
   uint32_t OverwriteOffset;
   gcRegistersData_t   TB_Cfg; 
   uint32_t TRIG_BASE_ADD = 0x44A80000;
   t_Trig      TRIG_Cfg = Trig_Ctor(TRIG_BASE_ADD);

   // Config
   
   TB_Cfg.ExposureTime          = 5; 
   TB_Cfg.Width                 = 320;   
   TB_Cfg.Height                = 256; 
   TB_Cfg.AcquisitionFrameRate  = 10000;
      
   #ifdef SIM
   cout << "*******************************" << endl;
   cout << "** Starting TRIGGER  testbench." << endl;
   cout << "*******************************" << endl;
   #endif
   
   // Envoi de la config 
   TRIG_SendConfigGC(&TRIG_Cfg, &TB_Cfg);	
   #ifdef SIM
      cout << "------- Envoi Config1= trig interne.-------" << endl;
      cout << "TRIG_Mode = " << TRIG_Cfg.TRIG_Mode << endl;
      cout << "TRIG_Period = " << TRIG_Cfg.TRIG_Period << endl;
      cout << "TRIG_FpaTrigDly = " << TRIG_Cfg.TRIG_FpaTrigDly << endl;
      cout << "TRIG_TrigOutDly = " << TRIG_Cfg.TRIG_TrigOutDly << endl;
      cout << "TRIG_ForceHigh = " << TRIG_Cfg.TRIG_ForceHigh << endl;
      cout << "TRIG_Activation = " << TRIG_Cfg.TRIG_Activation << endl;
      cout << "TRIG_AcqWindow = " << TRIG_Cfg.TRIG_AcqWindow << endl; 
   #endif  
    
    TRIG_ChangeAcqWindow(&TRIG_Cfg, TRIG_ExtraTrig, &TB_Cfg);
    
   // lancement de l'execution de la config
   //StartProblem = TRIG_Start(&TRIG_Cfg);	
   #ifdef SIM
      cout << "------- Lancement du bloc-------" << endl;
      //cout << "Error found = " << StartProblem << endl;   
   #endif 
   
   #ifdef SIM
      cout << "*******************************" << endl;
      cout << "   END of  TRIGGER  testbench. " << endl;
      cout << "*******************************" << endl;
   #endif
}                   


