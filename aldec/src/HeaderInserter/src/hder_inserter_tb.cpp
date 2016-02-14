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
#include "hder_inserter.h"
#include "GC_Manager.h"
#include "Protocol_F1F2.h"
#include "GC_Callback.h"
#include "FlashSettings.h"
#include "tel2000_param.h"

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
   gcRegistersData_t   TB_Cfg; 
   t_HderInserter   HDER_Cfg = HderInserter_Ctor(TEL_PAR_TEL_HEADER_CTRL_BASEADDR);

   // Config
   
   TB_Cfg.ExposureTime          = 100;  // en usec
   TB_Cfg.Width          = 128;  // 
   TB_Cfg.Height         = 2;  // 
      
   #ifdef SIM
   cout << "*****************************************" << endl;
   cout << "** Starting Header Inserter testbench." << endl;
   cout << "*****************************************" << endl;
   #endif
   
  // // Envoi de la config
   HDER_SendConfigGC(&HDER_Cfg, &TB_Cfg);
   HDER_SendHeaderGC(&HDER_Cfg, &TB_Cfg);
//   
//   
//   //HDER_Start(&HDER_Cfg);
//   
   #ifdef SIM
      cout << "------- Envoi Config1= trig interne.-------" << endl;
      cout << "eff_hder_len         = " << HDER_Cfg.eff_hder_len << endl;
      cout << "zero_pad_len         = " << HDER_Cfg.zero_pad_len << endl;
      cout << "hder_len             = " << HDER_Cfg.hder_len << endl;
      cout << "eff_hder_len_div2_m1 = " << HDER_Cfg.eff_hder_len_div2_m1 << endl;
      cout << "zero_pad_len_div2_m1 = " << HDER_Cfg.zero_pad_len_div2_m1 << endl;
      cout << "need_padding         = " << HDER_Cfg.need_padding << endl;
   #endif  
//
//

   #ifdef SIM
      cout << "***********************************" << endl;
      cout << " END of Header Inserter testbench. " << endl;
      cout << "***********************************" << endl;
   #endif
}                   


