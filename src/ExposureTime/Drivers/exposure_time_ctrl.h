/*-----------------------------------------------------------------------------
--
-- Title       : exposure_time_ctrl header
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
#ifndef __EXPOSURE_TIME_CTRL_H__
#define __EXPOSURE_TIME_CTRL_H__

#include "GC_Registers.h"
#include "tel2000_param.h"
#include <stdint.h>
#include "xbasic_types.h"


//#ifdef SIM
//   #define FPA_MIN_EXPOSURE  0.2F      // en usec 
//   #define FPA_MAX_EXPOSURE  1000000.0F    // en usec 
//#endif

#define EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ     CLK_100_FREQ_HZ  // horloge de reference des temps d'exposition
#define EXPOSURE_TIME_FACTOR                 ((float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ / 1E+6F) // convertit us en coups d'horloge
#define MAX_NUM_FILTER  8

// sources du temps d'int�gration
enum expSrc_Enum {source_micro_blaze, source_filter_wheel};  

// structure de configuration de exposure_time_ctrl
struct s_ExposureTime
{
   uint32_t SIZE;                   // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;

   uint32_t EXP_Source;             // dit qui forunit le temps d'int�gration au d�tecteur (microBlaze, roue � filtre etc...)
   uint32_t EXP_Time_Min;           // le temps d'int�gration minimal autoris� pour le detecteur (en coups d'horloge)
   uint32_t EXP_Time_Max;           // le temps d'int�gration maximal pour le detecteur (en coups d'horloge)
   uint32_t EXP_Time;               // le temps d'int�gration � utiliser (en coups d'horloge)
  };
typedef struct s_ExposureTime t_ExposureTime;

//Global Variable


// Function prototypes

#define ExposureTime_Ctor(add) {sizeof(t_ExposureTime)/4 - 2, add, 0, 0, 0, 0}

void EXP_Init(t_ExposureTime *a, const gcRegistersData_t *GCRegs);
void EXP_SendConfigGC(t_ExposureTime *a, const gcRegistersData_t *GCRegs);


#endif // __EXPOSURE_TIME_CTRL_H__
