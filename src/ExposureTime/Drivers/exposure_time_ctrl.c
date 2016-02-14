/*-----------------------------------------------------------------------------
--
-- Title       : exposure_time_ctrl
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 12286 $
-- $Author: pdaraiche $
-- $LastChangedDate: 2013-01-25 14:24:16 -0500 (ven., 25 janv. 2013) $
--
-------------------------------------------------------------------------------
--
-- Description :
--
------------------------------------------------------------------------------*/

#include "GeniCam.h"
#include "exposure_time_ctrl.h"
#include "utils.h"
#include "IRC_status.h"
#include "fpa_intf.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"   
#endif

// adresse des registres
#define A_EXP_SOURCE         0x00000000
#define A_EXP_TIME_MIN       0x00000004
#define A_EXP_TIME_MAX       0x00000008

// les differents modes d'operation du controleur
#define VHD_MB_SOURCE         0x00 
#define VHD_FW_SOURCE         0x01
#define VHD_EHDRI_SOURCE      0x02

//--------------------------------------------------------------------------
//  Initialisation
//--------------------------------------------------------------------------
void EXP_Init(t_ExposureTime *a, const gcRegistersData_t *GCRegs)
{
   a->EXP_Source     = VHD_MB_SOURCE;  // pour l'instant, source du temps d'integration = VHD_MB_SOURCE
   a->EXP_Time_Min   = (uint32_t)((float)FPA_MIN_EXPOSURE * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ/1E+6F); // plus tard, ce sera (uint32_t)((float)GCRegs.ExposureTimeMin * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ)
   a->EXP_Time_Max   = (uint32_t)((float)FPA_MAX_EXPOSURE * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ/1E+6F); // plus tard, ce sera (uint32_t)((float)GCRegs.ExposureTimeMax * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ)     
   a->EXP_Time       = (uint32_t)((float)FPA_DEFAULT_EXPOSURE * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ/1E+6F);             
   WriteStruct(a);
}

//--------------------------------------------------------------------------
//  Envoi de la configuration
//--------------------------------------------------------------------------
void EXP_SendConfigGC(t_ExposureTime *a, const gcRegistersData_t *GCRegs)
{     
   if (GCRegs->FWMode == FWM_SynchronouslyRotating)
   {
      a->EXP_Source     = VHD_FW_SOURCE;  // Filter Wheel sync mode
   }
   else if (GCRegs->EHDRINumberOfExposures == 1)
   {
      a->EXP_Source     = VHD_MB_SOURCE;  // GCRegs->EHDRINumberOfExposures == 1 desactive le EHDRI
   }
   else
   {
      a->EXP_Source     = VHD_EHDRI_SOURCE;  // GCRegs->EHDRINumberOfExposures != 1 active le EHDRI
   }
   a->EXP_Time_Min   = (uint32_t)((float)FPA_MIN_EXPOSURE * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ/1E+6F); // plus tard, ce sera (uint32_t)((float)GCRegs.ExposureTimeMin * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ)
   a->EXP_Time_Max   = (uint32_t)((float)FPA_MAX_EXPOSURE * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ/1E+6F); // plus tard, ce sera (uint32_t)((float)GCRegs.ExposureTimeMax * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ)     
   a->EXP_Time       = (uint32_t)((float)GCRegs->ExposureTime * (float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ/1E+6F);             
   WriteStruct(a);  
}

