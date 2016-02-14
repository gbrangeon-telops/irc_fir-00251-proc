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
#include "GC_Manager.h"
#include "GeniCam.h"
#include "tel2000_param.h"
#include "axil32_lut.h"
#include "calib.h"
#include "calibration_tb.h"
#include "CalibFiles.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"   
#endif









calibBlockInfo_t calibBlockInfo;
 
  // calHdrData.nlc_lut;            // t_lut    
//   calHdrData.rqc_lut;            // t_lut    
   


IRC_Status_t GC_Manager_Start(XIntc *intc);
IRC_Status_t Intc_Start(XIntc *intc);
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
   t_calib             CAL_Cfg = CAL_Ctor(TEL_PAR_TEL_CAL_CTRL_BASEADDR);
   int16_t fpa_temperature;
   
   TB_Cfg = gcRegsDataFactory;
   // Config
   TB_Cfg.ExposureTime        = 1000; 
   TB_Cfg.IntegrationMode     = IM_IntegrateThenRead;	
   TB_Cfg.SensorWellDepth     = 0;    
   TB_Cfg.OffsetX             = 11; 
   TB_Cfg.OffsetY             = 10; 
   TB_Cfg.Width               = 640;   
   TB_Cfg.Height                 = 512;   
   TB_Cfg.TestImageSelector      = TIS_Off; //TIS_TelopsStaticShade;//TIS_TelopsDynamicShade
   TB_Cfg.AcquisitionFrameRate   =  10000;
   TB_Cfg.CalibrationMode   =  CM_NUC;  // CM_IBR, CM_RT, CM_NUC, CM_Raw, CM_Raw0
   
   //calHdrData.delta_f          = 0.1F;            // float    
   calibBlockInfo.pixelData.Alpha_Off  = 0.2F;       // float    
   //calHdrData.data_offset      = 0.3F;        // float    
   //calHdrData.data_lsb         = 0.4F;           // float
   calibBlockInfo.pixelData.Range_Off  = 0.5F;           // float
   calibBlockInfo.block.NUCMultFactor  = 0.6F;    // float
   
   
   calibBlockInfo.pixelData.Offset_Exp = -3;
   calibBlockInfo.pixelData.Range_Exp  = +8;
   calibBlockInfo.pixelData.Alpha_Exp  = -8;
   calibBlockInfo.pixelData.Beta0_Exp  = -7;
   calibBlockInfo.pixelData.Kappa_Exp  = +3;
   
   
   calibBlockInfo.lutNL.LUT_Xmin   = 10; 
   calibBlockInfo.lutNL.LUT_Xrange = 100; 
   calibBlockInfo.lutNL.LUT_Size   = 256;
    
   calibBlockInfo.lutRQ.LUT_Xmin   = 20; 
   calibBlockInfo.lutRQ.LUT_Xrange = 200; 
   calibBlockInfo.lutRQ.LUT_Size   = 4096;
   calibBlockInfo.lutRQ.Data_Exp   = -2;
   calibBlockInfo.lutRQ.Data_Off   = 10000.0;
   
   
   
      
   #ifdef SIM
   cout << "*****************************************" << endl;
   cout << "** Starting calib testbench." << endl;
   cout << "*****************************************" << endl;
   #endif
   
   CAL_Init(&CAL_Cfg, &TB_Cfg);
   
   #ifdef SIM
      cout << "******Calib Init done *********" << endl;
   #endif
   

   CAL_SendConfigGC(&CAL_Cfg, &TB_Cfg);
  
  #ifdef SIM
      cout << "******CAL cfg1 sent *********" << endl;
      cout << "fpa_temperature = "  << fpa_temperature << endl;
   #endif
   
   
}                   


