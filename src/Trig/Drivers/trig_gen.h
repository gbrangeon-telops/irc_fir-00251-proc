/*-----------------------------------------------------------------------------
--
-- Title       : FPA_TRIG header
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
#ifndef __TRIG_GEN_H__
#define __TRIG_GEN_H__

#include "GC_Registers.h"
#include "tel2000_param.h"
#include <stdint.h>
#include "fpa_intf.h"


#define TRIG_BASE_CLOCK_FREQ_HZ    CLK_MB_FREQ_HZ  // horloge de reference des trigs


// structure de configuration du trigger
struct s_Trig
{
   uint32_t SIZE;                     // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;                      /**< register address */

   uint32_t TRIG_Mode;                // le mode de fonctionnement
   uint32_t TRIG_Period;              // la période du trig, en coups d'horloge
   uint32_t TRIG_FpaTrigDly;          // retard du trig envoyé au fpa local en coup d'horloge
   uint32_t TRIG_ForceHigh;           // si le trig doit rester indefiniment à '1' (convient au mode vitesse maximale)
   uint32_t TRIG_Activation;          // permet de savoir si le Trg du fpa local doit etre triggé  sur Rising_edge , HighLevel etc..
   uint32_t TRIG_AcqWindow;           // AcqWindow à '1' permet de generer les trigs d'acquisiiotn(image envoyées dans la chaine)
                                      // à '0' permet de generer des extra_trigs (images non envoyées dans la chaine)
   uint32_t TRIG_SeqFrameCount;       // En trig de sequence indique le nombre de frame a acquerir
   uint32_t TRIG_SeqTrigSource;       // En trig de sequence indique la source du trig, 0 = Hardware, 1 = Software
  };
typedef struct s_Trig t_Trig;

// statuts provenant du vhd
struct s_TrigStatus
{
   uint32_t ctlr_status;
   uint32_t trig_period_min[8];
   uint32_t trig_period_max[8];
   uint32_t trig_delay_min;       /**triger min time, */
   uint32_t trig_delay_max;       /**triger max time, */
};
typedef struct s_TrigStatus t_TrigStatus;

// structure PosixTime que retourne le bloc TRIGGER
struct s_PosixTime
{
   uint32_t Seconds;                 //
   uint32_t SubSeconds;              //
};
typedef struct s_PosixTime t_PosixTime;

enum TRIG_AcqWindow
{
   TRIG_ExtraTrig = 0,
   TRIG_Normal = 1
};


// Function prototypes

#define Trig_Ctor(add) {sizeof(t_Trig)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0}


void TRIG_Init(t_Trig *a, const gcRegistersData_t *pGCRegs);

void TRIG_SendConfigGC(t_Trig *a, const gcRegistersData_t *pGCRegs);

void TRIG_ChangeFrameRate(t_Trig *a, t_FpaIntf *b, const gcRegistersData_t *pGCRegs);

// pour commuter entre les modes extra trig et acq trig
// AcqWindow à '1' permet de generer les trigs d'acquisiiotn(image envoyées dans la chaine)
void TRIG_ChangeAcqWindow(t_Trig *a, const enum TRIG_AcqWindow AcqWindow, const gcRegistersData_t *pGCRegs);

//pour effacer les bits d'erreurs
void TRIG_ClearErr(const t_Trig *a);

//pour avoir les statuts complets
void TRIG_GetStatus(const t_Trig *a, t_TrigStatus *Stat);

//pour un overwrite du time
void TRIG_OverWritePOSIXNow(uint32_t PPCTime_Sec, const t_Trig *a);
void TRIG_OverWritePOSIXNextPPS(uint32_t Time_Sec, uint32_t Time_mSec, const t_Trig *a);
uint32_t TRIG_PpsTimeOut(const t_Trig *a);

//pour une lecture du temps réel
t_PosixTime TRIG_GetRTC(const t_Trig *a);

//pour savoir si un timeStamp est prêt
uint32_t TRIG_TimeStampReady(const t_Trig *a);

//pour effacer la memoire de stockage des TimeStamps
uint32_t TRIG_FlushTimeStamp(const t_Trig *a);

//pour selectionner la source du PPS
void TRIG_PpsSrcSelect(TimeSource_t TimeSource, const t_Trig *a);

//pour lire la source du PPS
uint32_t TRIG_GetPpsSrc(const t_Trig *a);

void TRIG_SendTrigSoft(t_Trig *a, const gcRegistersData_t *pGCRegs);
void TRIG_SeqTrig(const t_Trig *a);

#endif // __TRIG_H__
