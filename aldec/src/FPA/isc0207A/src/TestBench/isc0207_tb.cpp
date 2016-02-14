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
#include "fpa_intf.h"
//#include "GC_Manager.h"
#include "GeniCam.h"
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


//IRC_Status_t GC_Manager_Start(XIntc *intc);
//IRC_Status_t Intc_Start(XIntc *intc);

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
      PRINT("systemC main() defined... \n"); 
      global_trans_ptr = &(this->transactor_interface);  // Link the pointer to the SystemC transactor interface
   #endif
   
//   XSysMon XADC;

   #ifdef SIM
      (*global_trans_ptr)->initialize();  // Initialize the SystemC ports
   #endif
   
   //WAIT_US(30);
   PRINT("main() starting... \n"); 
//   
   PRINT("StartSubModuleTB... \n");
   StartSubModuleTB();  

   #ifndef SIM
      return 0;
   #endif

}


void StartSubModuleTB()
{
   t_FpaStatus Stat;
   gcRegistersData_t   TB_Cfg; 
   t_FpaIntf   FPA_Cfg = FpaIntf_Ctor(TEL_PAR_TEL_FPA_CTRL_BASEADDR);

   // Config
   TB_Cfg.ExposureTime        = 50; 
   TB_Cfg.IntegrationMode     = IM_IntegrateThenRead;	
//   TB_Cfg.SensorWellDepth     = SWD_Depth1_3M;    
   TB_Cfg.OffsetX             = 0; 
   TB_Cfg.OffsetY             = 0; 
   TB_Cfg.Width               = 64;   
   TB_Cfg.Height                 = 2;   
   TB_Cfg.TestImageSelector      = TIS_Off;//TIS_Off; //TIS_Off
   TB_Cfg.AcquisitionFrameRate   =  100;
      
   #ifdef SIM
   cout << "*****************************************" << endl;
   cout << "** Starting PelicanD testbench." << endl;
   cout << "*****************************************" << endl;
   #endif
   //
//   // effacement des bits d'erreurs	(initialisation des registres d'erreurs
   FPA_Init(&Stat, &FPA_Cfg, &TB_Cfg);
   #ifdef SIM
      cout << "******Init done *********" << endl;
   #endif
//
//   
//   // Envoi de la config
   FPA_SendConfigGC(&FPA_Cfg, &TB_Cfg);
//   
//   #ifdef SIM
//      cout << "****** Envoi Config1.*********" << endl;
//      cout << "fpa_telops_diag_mode    = "  << FPA_Cfg.fpa_telops_diag_mode     << endl;
//      cout << "fpa_telops_diag_type    = "  << FPA_Cfg.fpa_telops_diag_type     << endl;
//      cout << "fpa_pwr_on              = "  << FPA_Cfg.fpa_pwr_on               << endl;
//      cout << "fpa_xstart              = "  << FPA_Cfg.fpa_xstart               << endl;
//      cout << "fpa_ystart              = "  << FPA_Cfg.fpa_ystart               << endl;   	  
//	   cout << "fpa_xsize               = "  << FPA_Cfg.fpa_xsize                << endl;
//      cout << "fpa_ysize               = "  << FPA_Cfg.fpa_ysize                << endl;
//      cout << "fpa_gain                = "  << FPA_Cfg.fpa_gain                 << endl;
//      cout << "fpa_out_chn             = "  << FPA_Cfg.fpa_out_chn              << endl; 
//      cout << "fpa_diode_bias          = "  << FPA_Cfg.fpa_diode_bias           << endl;
//      cout << "fpa_int_mode            = "  << FPA_Cfg.fpa_int_mode             << endl;
//      cout << "fpa_pix_res             = "  << FPA_Cfg.fpa_pix_res              << endl;
//      cout << "fpa_hder_disable        = "  << FPA_Cfg.fpa_hder_disable         << endl;
//      cout << "fpa_pwron_mode          = "  << FPA_Cfg.fpa_pwron_mode           << endl;
//      cout << "fpa_fig1_or_fig2_t6_dly = "  << FPA_Cfg.fpa_fig1_or_fig2_t6_dly  << endl;
//      cout << "fpa_fig4_t1_dly         = "  << FPA_Cfg.fpa_fig4_t1_dly          << endl;
//      cout << "fpa_fig4_t2_dly         = "  << FPA_Cfg.fpa_fig4_t2_dly          << endl;
//      cout << "fpa_fig4_t6_dly         = "  << FPA_Cfg.fpa_fig4_t6_dly          << endl;
//      cout << "fpa_fig4_t3_dly         = "  << FPA_Cfg.fpa_fig4_t3_dly          << endl;
//      cout << "fpa_fig4_t5_dly         = "  << FPA_Cfg.fpa_fig4_t5_dly          << endl;
//      cout << "fpa_fig4_t4_dly         = "  << FPA_Cfg.fpa_fig4_t4_dly          << endl;
//      cout << "fpa_fig1_or_fig2_t5_dly = "  << FPA_Cfg.fpa_fig1_or_fig2_t5_dly  << endl;
//      cout << "fpa_fig1_or_fig2_t4_dly = "  << FPA_Cfg.fpa_fig1_or_fig2_t4_dly  << endl;
//      cout << "fpa_xsize_div2          = "  << FPA_Cfg.fpa_xsize_div2           << endl;
//      cout << "fpa_trig_ctrl_mode      = "  << FPA_Cfg.fpa_trig_ctrl_mode       << endl;
//      cout << "fpa_trig_ctrl_dly       = "  << FPA_Cfg.fpa_trig_ctrl_dly        << endl;
//      cout << "fpa_trig_period_min     = "  << FPA_Cfg.fpa_trig_period_min      << endl;
//   #endif 
//   
//   #ifdef SIM
//      cout << "***********************************" << endl;
//      cout << " END of PelicanD testbench. " << endl;
//      cout << "***********************************" << endl;
//   #endif
}                   


