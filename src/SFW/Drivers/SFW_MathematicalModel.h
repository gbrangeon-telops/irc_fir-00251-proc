#ifndef SFW_MATHEMATICALMODEL_H__
#define SFW_MATHEMATICALMODEL_H__

#include <stdint.h>
#include <stdbool.h>
#include "Genicam.h"
#include "GC_Registers.h"
#include "SFW_ctrl.h"

 

typedef enum {   
   EXPOSURE_TIME_CHANGED, 
   FRAME_RATE_CHANGED,
   WIDTH_CHANGED,
   HEIGHT_CHANGED,
   ALL_CHANGED
} SFW_ChangedParameterEnum;


void InitMathematicalModel(gcRegistersData_t *pGCRegs);
void SFW_CalculateMaximalValues(gcRegistersData_t *pGCRegs, SFW_ChangedParameterEnum changedParameter);
float SFW_GetAcquisitionFrameRateMax();
float SFW_GetExposureTimeMax();

// Getters of the calculated maximal values
//float SFW_GetAcquisitionFrameRateMax();
float SFW_GetMaxExposureTime(gcRegistersData_t *pGCRegs);
float SFW_GetExposureTimeMax();
uint16_t SFW_GetCurrentWidthMax();
uint16_t SFW_GetCurrentHeightMax();

// Getters of filter max position deltas
//uint16_t SFW_GetDeltaFilterBegin();
//uint16_t SFW_GetDeltaFilterEnd();

void SFW_LimitParameter(gcRegistersData_t * pGCRegs);

#endif //SFW_MATHEMATICALMODEL_H__
