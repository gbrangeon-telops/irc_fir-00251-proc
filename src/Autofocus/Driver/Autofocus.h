/*
 * Autofocus.h
 *
 *  Created on: 2018-01-30
 *      Author: ecloutier
 */

#ifndef AUTOFOCUS_H_
#define AUTOFOCUS_H_

#include "verbose.h"
#include "SightLineSLAProtocol.h"
#include "RPOpticalProtocol.h"

#define READ_BYTES_LENGTH  22

#ifdef AUTO_VERBOSE
   #define AUTO_PRINTF(fmt, ...)   FPGA_PRINTF("RP: " fmt, ##__VA_ARGS__)
#else
   #define AUTO_PRINTF(fmt, ...)   DUMMY_PRINTF("RP: " fmt, ##__VA_ARGS__)
#endif

#define AUTO_INF(fmt, ...)        AUTO_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define AUTO_ERR(fmt, ...)         FPGA_PRINTF("AUTO: Error: " fmt "\n", ##__VA_ARGS__)


#define AUTOFOCUS_ROI_DEFAULT    25.0F

#define AUTO_TABLE_LENGTH        128

typedef enum
{
   initLentille = 0,
   waitForBIT,
   readFocusTable,
   waitForFocusLine,
   readFLengthTable,
   waitForFocalVector,
   moveLensToReady,
   waitForReady,
   initMetricProcessing,
   initTelemetry,
   waitForVersion,
   autoFocusInit,
   waitForMetric,
   setMovingParams,
   moving,
   getFocus,
   getFocusMetric,
   IdentBestFocus,
   IdentDefault,
   moveToBest,
   idle
}autoState_t;

typedef enum
{
   firstStep = 0,
   sameDirection,
   changeDirection
}movingParams_t;

typedef struct
{
   float          focusMetric[AUTO_TABLE_LENGTH];
   float          focusMetricRelative[AUTO_TABLE_LENGTH];
   float          filteredFocusMetric[AUTO_TABLE_LENGTH];
   uint8_t        min;     // of FocusMetric tab
   uint8_t        max;     // of FocusMetric tab
}focusMetric_t;

typedef struct
{
   int8_t         SignSDeriv;
   bool           posPresent;
   bool           negPresent;
}signSDeriv_t;

typedef struct
{
   uint16_t       bestFocus;
   uint16_t       focusMin;
   uint16_t       focusMax;
   uint16_t       focusTarget;
   float          SMPFM;
   uint8_t        SMPnbstep;
   uint8_t        multstep;
   float          SMPderiv;
   float          SD;
   float          SFM;
   float          SFD;
   uint16_t       coeff;
   uint8_t        action;
   int16_t        step[AUTO_TABLE_LENGTH];
   bool           stepDirChange;
   bool           unReverse;
   uint8_t        abort;
   uint16_t       focusValue[AUTO_TABLE_LENGTH];
   float          derivFocusMetric[AUTO_TABLE_LENGTH];
   float          sDeriv;
   signSDeriv_t   SignSDerivData;
   focusMetric_t  focusMetricData;
   uint8_t        nPoints;
   uint8_t        line;
   movingParams_t movingParamState;
   autoState_t    autoState;
}autofocusCtrl_t;

typedef struct {
   uint32_t VideoAGC;
   uint32_t VideoFreeze;
} Autofocus_GCRegsBackup_t;

XStatus Autofocus_init(autofocusCtrl_t *aCtrl);

void Autofocus_SM(autofocusCtrl_t* aCtrl, slCtrl_t* aSlCtrl, rpCtrl_t* aRpCtrl);

int8_t sign(int aNumber);

#endif /* AUTOFOCUS_H_ */
