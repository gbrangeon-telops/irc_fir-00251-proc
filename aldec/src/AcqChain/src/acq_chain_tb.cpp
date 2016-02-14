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
#include "hder_inserter.h"
#include "exposure_time_ctrl.h"
#include "trig_gen.h"
//#include "GC_Manager.h"
#include "GeniCam.h"
#include "tel2000_param.h"
//#include "CalibFiles.h"
//#include "calib.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"   
#endif

//calibBlockInfo_t calibBlockInfo;

//IRC_Status_t GC_Manager_Start(XIntc *intc);
//IRC_Status_t Intc_Start(XIntc *intc);
// Global variables
t_Trig gTrig = Trig_Ctor(TEL_PAR_TEL_TRIGGER_CTRL_BASEADDR);
t_ExposureTime gExposureTime = ExposureTime_Ctor(TEL_PAR_TEL_EXPTIM_CTRL_BASEADDR);
t_FpaIntf gFpaIntf = FpaIntf_Ctor(TEL_PAR_TEL_FPA_CTRL_BASEADDR);
t_HderInserter gHderInserter = HderInserter_Ctor(TEL_PAR_TEL_HEADER_CTRL_BASEADDR);

t_FpaStatus gFpaStatus;

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
   
   WAIT_US(60);
   PRINT("main() starting... \n"); 
   
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
   t_Trig      TRIG_Cfg = Trig_Ctor(TEL_PAR_TEL_TRIGGER_CTRL_BASEADDR);
   t_HderInserter   HDER_Cfg = HderInserter_Ctor(TEL_PAR_TEL_HEADER_CTRL_BASEADDR);
   t_ExposureTime      EXP_Cfg = ExposureTime_Ctor(TEL_PAR_TEL_EXPTIM_CTRL_BASEADDR);
//   t_calib             CAL_Cfg = CAL_Ctor(TEL_PAR_TEL_CAL_CTRL_BASEADDR);
   int16_t fpa_temperature;
   
   TB_Cfg = gcRegsDataFactory;
   // Config
   TB_Cfg.ExposureTime        = 1; 
   TB_Cfg.IntegrationMode     = IM_IntegrateThenRead;	
   TB_Cfg.SensorWellDepth     = 0;    
   TB_Cfg.OffsetX             = 0; 
   TB_Cfg.OffsetY             = 0; 
   TB_Cfg.Width               = 64;   
   TB_Cfg.Height                 = 64;   
   TB_Cfg.TestImageSelector      = TIS_TelopsStaticShade; //TIS_TelopsStaticShade;//TIS_TelopsDynamicShade
   TB_Cfg.AcquisitionFrameRate   =  10000;
   TB_Cfg.CalibrationMode   =  CM_Raw;  // CM_IBR, CM_RT, CM_NUC, CM_Raw, CM_Raw0
   
   //calHdrData.delta_f          = 0.1F;            // float    
//   calibBlockInfo.pixelData.Alpha_Off  = 0.2F;       // float    
   //calHdrData.data_offset      = 0.3F;        // float    
   //calHdrData.data_lsb         = 0.4F;           // float
//   calibBlockInfo.pixelData.Range_Off  = 0.5F;           // float
//   calibBlockInfo.block.NUCMultFactor  = 0.6F;    // float
   
   
//   calibBlockInfo.pixelData.Offset_Exp = -3;
//   calibBlockInfo.pixelData.Range_Exp  = +8;
//   calibBlockInfo.pixelData.Alpha_Exp  = -8;
//   calibBlockInfo.pixelData.Beta0_Exp  = -7;
//   calibBlockInfo.pixelData.Kappa_Exp  = +3;
   
   
//   calibBlockInfo.lutNL.LUT_Xmin   = 10; 
//   calibBlockInfo.lutNL.LUT_Xrange = 100; 
//   calibBlockInfo.lutNL.LUT_Size   = 256;
//    
//   calibBlockInfo.lutRQ.LUT_Xmin   = 20; 
//   calibBlockInfo.lutRQ.LUT_Xrange = 200; 
//   calibBlockInfo.lutRQ.LUT_Size   = 4096;
//   calibBlockInfo.lutRQ.Data_Exp   = 2;
//   calibBlockInfo.lutRQ.Data_Off   = 10000.0;
      
   #ifdef SIM
   cout << "*****************************************" << endl;
   cout << "** Starting Acq Chain testbench." << endl;
   cout << "*****************************************" << endl;
   #endif

   // TRIG
    //TB_Cfg.AcquisitionFrameRate = FPA_MaxFrameRate(&TB_Cfg);
     // FPA     
   FPA_Init(&Stat, &FPA_Cfg, &TB_Cfg);
   
      // Exposure Time
   EXP_Init(&EXP_Cfg, &TB_Cfg);
   
   TRIG_Init(&TRIG_Cfg, &TB_Cfg);
   //TRIG_ChangeAcqWindow(&TRIG_Cfg, TRIG_ExtraTrig, &TB_Cfg);   // TRIG_Normal or TRIG_ExtraTrig
    
    #ifdef SIM
      cout << "******PelicanD Init done *********" << endl;
   #endif
   
//   CAL_Init(&CAL_Cfg, &TB_Cfg);
   
   #ifdef SIM
      cout << "******Calib Init done *********" << endl;
   #endif
   
//   CAL_SendConfigGC(&CAL_Cfg, &TB_Cfg);
   
   WAIT_US(1);
   //TB_Cfg.Width               = 128;   
//   TB_Cfg.Height              = 2; 
//   TB_Cfg.ExposureTime        = 100; 
//
   EXP_SendConfigGC(&EXP_Cfg, &TB_Cfg);
//   HDER_SendConfigGC(&HDER_Cfg, &TB_Cfg);
//   HDER_SendHeaderGC(&HDER_Cfg, &TB_Cfg);
//   FPA_SendConfigGC(&FPA_Cfg, &TB_Cfg);
   // hder inserter
   //TB_Cfg.TestImageSelector      = TIS_TelopsStaticShade; //TIS_TelopsStaticShade
   HDER_SendConfigGC(&HDER_Cfg, &TB_Cfg);
   HDER_SendHeaderGC(&HDER_Cfg, &TB_Cfg);
   FPA_SendConfigGC(&FPA_Cfg, &TB_Cfg);
   TRIG_ChangeAcqWindow(&TRIG_Cfg, TRIG_Normal, &TB_Cfg); 
   fpa_temperature = FPA_GetTemperature(&FPA_Cfg);
   #ifdef SIM
      cout << "******PelicanD cfg1 sent *********" << endl;
      cout << "fpa_temperature = "  << fpa_temperature << endl;
   #endif
   
    
   // FPA     
   WAIT_US(300);
   TB_Cfg.Width               = 128;   
   TB_Cfg.Height              = 2; 
   TB_Cfg.ExposureTime        = 10; 

   EXP_SendConfigGC(&EXP_Cfg, &TB_Cfg);
   HDER_SendConfigGC(&HDER_Cfg, &TB_Cfg);
   HDER_SendHeaderGC(&HDER_Cfg, &TB_Cfg);
   FPA_SendConfigGC(&FPA_Cfg, &TB_Cfg);
//   CAL_SendConfigGC(&CAL_Cfg, &TB_Cfg);
   
//   // Envoi de la config
 //  FPA_SendConfigGC(&FPA_Cfg, &TB_Cfg);
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
   #ifdef SIM
      cout << "***********************************" << endl;
      cout << " END of PelicanD testbench. " << endl;
      cout << "***********************************" << endl;
   #endif
}                   


