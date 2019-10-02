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

void SFW_FrameRateChanged(gcRegistersData_t *pGCRegs);
void SFW_ExposureTimeChanged(gcRegistersData_t *pGCRegs);
void SFW_AllChanged(gcRegistersData_t *pGCRegs);
void SFW_HeightChanged(gcRegistersData_t *pGCRegs);
void SFW_WidthChanged(gcRegistersData_t *pGCRegs);

void SFW_LimitExposureTime(gcRegistersData_t * pGCRegs);
float SFW_GetMaxExposureTime(gcRegistersData_t *pGCRegs);

#endif //SFW_MATHEMATICALMODEL_H__
