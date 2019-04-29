/*
 * Autofocus.c
 *
 *  Created on: 2018-01-30
 *      Author: ecloutier
 */

#include "Autofocus.h"
#include "IRC_status.h"
#include "utils.h"
#include "Math.h"
#include "stdlib.h"
#include "SightLineSLAProtocol.h"
#include "RPOpticalProtocol.h"
#include "FlashSettings.h"
#include "GC_Events.h"
#include "GC_Registers.h"


extern uint8_t metricRegion;
extern lensTable_t lensLookUpTable;
bool autofocusLaunch;

static void Autofocus_backupGCRegisters( Autofocus_GCRegsBackup_t *p_GCRegsBackup );
static void Autofocus_restoreGCRegisters( Autofocus_GCRegsBackup_t *p_GCRegsBackup );

XStatus Autofocus_init(autofocusCtrl_t *aCtrl)
{
   aCtrl->autoState = initLentille;
   aCtrl->movingParamState = firstStep;
   aCtrl->line = 0;
   aCtrl->bestFocus = 5200;
   aCtrl->SMPFM = 1.4;
   aCtrl->SMPnbstep = 3;
   aCtrl->multstep = 3;
   aCtrl->SMPderiv = 0.1;
   aCtrl->SD = 0.2;
   aCtrl->SFM = 1.3;
   aCtrl->SFD = 0.4;
   aCtrl->coeff = 300;
   aCtrl->action = 1;
   aCtrl->focusTarget = 5200;
   aCtrl->focusMin = 0;
   aCtrl->focusMax = 0;
   aCtrl->nPoints = 0;
   aCtrl->stepDirChange = false;
   aCtrl->focusMetricData.min = 0;
   aCtrl->focusMetricData.max = 0;
   aCtrl->SignSDerivData.negPresent = false;
   aCtrl->SignSDerivData.posPresent = false;
   aCtrl->SignSDerivData.SignSDeriv = 0;
   aCtrl->sDeriv = 0.0;
   aCtrl->unReverse = true;
   autofocusLaunch = false;
   aCtrl->abort = 0;
   return IRC_SUCCESS;
}

void Autofocus_SM(autofocusCtrl_t* aCtrl, slCtrl_t* aSlCtrl, rpCtrl_t* aRpCtrl)
{
   autoState_t state = aCtrl->autoState;
   static uint64_t tic;
   static Autofocus_GCRegsBackup_t GCRegsBackup;

   if(flashSettings.AutofocusModuleType != AMT_SightlineSLA1500)
   {
      return;
   }

   switch(state)
   {
      case initLentille:
      {
         setCoordReportMode(aSlCtrl, 0, 0x80, 0);     // deactivate telemetry
         aRpCtrl->initDone += 1;
         aRpCtrl->parsingDone += 1;
         GETTIME(&tic);
         state = waitForBIT;
         break;
      }

      case waitForBIT:
      {
         if(aRpCtrl->initDone<1)
         {
            setAddress(aRpCtrl, 0x0064);
            readData(aRpCtrl, READ_BYTES_LENGTH);
            aRpCtrl->parsingDone += 1;
            state = waitForFocusLine;
         }
         /*else if(elapsed_time_us(tic) > (TIME_TEN_SECOND_US))      // ToDo ECL tester la valeur du timout ici
         {
            GETTIME(&tic);
            GC_GenerateEventError(EECD_MotorizedLensError);
            setAddress(aRpCtrl, 0x0064);
            readData(aRpCtrl, READ_BYTES_LENGTH);
            aRpCtrl->parsingDone += 1;
            state = waitForFocusLine;
         }*/
         break;
      }

      case readFocusTable:
      {
         readData(aRpCtrl, READ_BYTES_LENGTH);
         aRpCtrl->parsingDone += 1;
         GETTIME(&tic);
         state = waitForFocusLine;
         break;
      }

      case waitForFocusLine:
      {
         uint8_t ind = 0;
         uint16_t result;
         uint8_t byte0, byte1;
         if(aRpCtrl->parsingDone<1)
         {
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.zoom[aCtrl->line] = result;
            // Skip offset and delta at -40
            ind += 4;
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.focusAtTemp1[aCtrl->line] = result;
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.focusAtTemp2[aCtrl->line] = result;
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.focusAtTemp3[aCtrl->line] = result;
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.focusAtTemp4[aCtrl->line] = result;
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.focusAtTemp5[aCtrl->line] = result;
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.focusAtTemp6[aCtrl->line] = result;
            byte0 = aRpCtrl->dataBuf[ind++];
            byte1 = aRpCtrl->dataBuf[ind++];
            result = byte0 + 256 * byte1;
            lensLookUpTable.focusAtTemp7[aCtrl->line] = result;
            // Skip delta at 80
            aCtrl->line += 1;
            if(aCtrl->line > 40)
            {
               aCtrl->line = 0;
               state = readFLengthTable;
            }
            else
            {
               state = readFocusTable;
            }
         }
         else if(elapsed_time_us(tic) > (TIME_TEN_SECOND_US))
         {
            aCtrl->abort += 1;
            if(aCtrl->abort > 1)
            {
               GC_GenerateEventError(EECD_MotorizedLensError);
               aCtrl->abort = 0;
               state = idle;
            }
            else                                  // on essaie de lire la table à nouveau
            {
               ind = 0;
               setAddress(aRpCtrl, 0x0064);
               readData(aRpCtrl, READ_BYTES_LENGTH);
            }
            aCtrl->line = 0;
            GETTIME(&tic);
         }
         break;
      }

      case readFLengthTable:
      {
         if(aCtrl->line == 0)
         {
            setAddress(aRpCtrl, 0x802);
         }
         readData(aRpCtrl, READ_BYTES_LENGTH);
         aRpCtrl->parsingDone += 1;
         GETTIME(&tic);
         state = waitForFocalVector;
         break;
      }

      case waitForFocalVector:
      {
         if(aRpCtrl->parsingDone<1)
         {
            uint8_t byte0, byte1, i;
            uint8_t ind = 0;
            uint16_t result;
            state = readFLengthTable;
            if(aCtrl->line < 33)
            {
               for(i=0; i<READ_BYTES_LENGTH/2; i++)
               {
                  byte0 = aRpCtrl->dataBuf[ind++];
                  byte1 = aRpCtrl->dataBuf[ind++];
                  result = byte0 + 256 * byte1;
                  lensLookUpTable.focalLength[aCtrl->line++] = result;
               }
            }
            else
            {
               for(i=0; i<8; i++)
               {
                  byte0 = aRpCtrl->dataBuf[ind++];
                  byte1 = aRpCtrl->dataBuf[ind++];
                  result = byte0 + 256 * byte1;
                  lensLookUpTable.focalLength[aCtrl->line++] = result;
               }
               aCtrl->line = 0;
               state = moveLensToReady;
            }
         }
         else if(elapsed_time_us(tic) > (TIME_TEN_SECOND_US))
         {
            aCtrl->abort += 1;
            if(aCtrl->abort > 1)
            {
               GC_GenerateEventError(EECD_MotorizedLensError);
               aCtrl->abort = 0;
               state = idle;
            }
            else                                // on essaie de lire la table à nouveau
            {
               setAddress(aRpCtrl, 0x802);
               readData(aRpCtrl, READ_BYTES_LENGTH);
            }
            aCtrl->line = 0;
            GETTIME(&tic);
         }
         break;
      }

      case moveLensToReady:
      {
         aRpCtrl->readingDone = true;
         RPOpt_CalcFOVPositionLimits(&gcRegsData);
         GC_SetFOVPositionSetpoint(gcRegsData.FOVPositionSetpoint);
         state = waitForReady;

         break;
      }

      case waitForReady:
      {
         if(aRpCtrl->parsingDone < 1)
         {
            state = initMetricProcessing;
         }
         break;
      }

      case initMetricProcessing:
      {
         getParameter(aSlCtrl, 0);                    // 0 = version ID
         setCoordReportMode(aSlCtrl, 0, 0x80, 0);     // deactivate telemetry
         state = waitForVersion;
         break;
      }

      case waitForVersion:
      {
         if(aSlCtrl->parsingDone < 1)
         {
            state = idle;
         }
         /*else if(elapsed_time_us(tic) > (TIME_TEN_SECOND_US))
         {
            getParameter(aSlCtrl, 0);        // 0 = version ID
            GETTIME(&tic);
            GC_GenerateEventError(EECD_AutofocusModuleError);
            //state = idle;
         }*/
         break;
      }

      case initTelemetry:                    // Focus Stats (0x55 response ID) and ROI
      {
         setCoordReportMode(aSlCtrl, 1, 0x80, 0);
         setLensParams(aSlCtrl, 50);          // ToDo ECL à tester
         state = autoFocusInit;
         break;
      }

      case autoFocusInit:
      {
         aCtrl->focusMin = (uint16_t)gcRegsData.FocusPositionRawMin;
         aCtrl->focusMax = (uint16_t)gcRegsData.FocusPositionRawMax;
         aCtrl->focusValue[0] = aRpCtrl->currentResponseData.focusEncValue;
         aCtrl->bestFocus = aCtrl->focusValue[0];
         aCtrl->step[0] = 75;
         aSlCtrl->parsingDone += 1;
         state = waitForMetric;
         break;
      }

      case waitForMetric:
      {
         if(aSlCtrl->parsingDone<1)
         {
            aCtrl->focusMetricData.focusMetric[0] = aSlCtrl->currentMetricData;
            aCtrl->nPoints += 1;
            state = setMovingParams;
         }
         /*else if(elapsed_time_us(tic) > (TIME_TEN_SECOND_US))
         {
            GETTIME(&tic);
            GC_GenerateEventError(EECD_AutofocusModuleError);
            state = idle;
         }*/
         break;
      }

      case setMovingParams:
      {
         movingParams_t paramsState = aCtrl->movingParamState;
         uint8_t ind = aCtrl->nPoints;
         int32_t dmin, dmax;

         if(ind > 1)
         {
            if(!aCtrl->stepDirChange)
            {
               paramsState = sameDirection;
            }
            else
            {
               paramsState = changeDirection;
            }
         }

         switch(paramsState)
         {
            case firstStep:                  // un seul point soit le départ
            {
               int32_t temp = (int32_t)(aCtrl->focusValue[0]) - (int32_t)(aCtrl->focusMin);
               dmin = abs(temp);
               temp = (int32_t)(aCtrl->focusValue[0]) - (int32_t)(aCtrl->focusMax);
               dmax = abs(temp);
               if(dmin > dmax)
               {
                  if(aCtrl->focusMin < aCtrl->focusValue[0] && aCtrl->focusValue[0] < aCtrl->focusMax)
                  {
                     aCtrl->focusTarget = (uint16_t)(aCtrl->focusValue[0] - aCtrl->step[0]);
                     aCtrl->step[1] = -1 * aCtrl->step[0];
                  }
                  else
                  {
                     aCtrl->focusTarget = aCtrl->focusMax;
                     aCtrl->step[1] = -1 * aCtrl->step[0];
                  }
               }
               else
               {
                  if(aCtrl->focusMin < aCtrl->focusValue[0] && aCtrl->focusValue[0] < aCtrl->focusMax)
                  {
                     aCtrl->focusTarget = (uint16_t)(aCtrl->focusValue[0] + aCtrl->step[0]);
                     aCtrl->step[1] = aCtrl->step[0];
                  }
                  else
                  {
                     aCtrl->focusTarget = aCtrl->focusMin;
                     aCtrl->step[1] = aCtrl->step[0];
                  }
               }
               break;
            }

            case sameDirection:
            {
               uint16_t ind = aCtrl->nPoints;
               bool FMin, FMax, Deriv;
               uint8_t min = aCtrl->focusMetricData.min;
               uint8_t max = aCtrl->focusMetricData.max;

               if(aCtrl->focusMetricData.focusMetric[ind-1] < (aCtrl->focusMetricData.focusMetric[min] * aCtrl->SMPFM) )
               {
                  FMin = true;
               }
               else
               {
                  FMin = false;
               }

               if(aCtrl->focusMetricData.focusMetric[ind-1] < (aCtrl->focusMetricData.focusMetric[max] / aCtrl->SMPFM ) )
               {
                  FMax = true;
               }
               else
               {
                  FMax = false;
               }

               if(ind > 3 && ( fabs(aCtrl->derivFocusMetric[ind-1]) ) < aCtrl->SMPderiv )
               {
                  Deriv = true;
               }
               else
               {
                  Deriv = false;
               }

               // Acceleration
               if( (FMin || FMax || Deriv) && (ind > aCtrl->SMPnbstep) )
               {
                  aCtrl->step[ind] = sign(aCtrl->step[ind-1]) * 75 * aCtrl->multstep;
               }
               else
               {
                  aCtrl->step[ind] = sign(aCtrl->step[ind-1]) * 75;
               }

               if(aCtrl->focusTarget >= aCtrl->focusMax && aCtrl->step[ind-1] > 0)
               {
                  aCtrl->step[ind] = -1 * aCtrl->step[ind-1];
                  aCtrl->focusTarget= aCtrl->focusValue[0] + aCtrl->step[ind];
               }
               else if(aCtrl->focusTarget <= aCtrl->focusMin && aCtrl->step[ind-1] < 0)
               {
                  aCtrl->step[ind] = -1 * aCtrl->step[ind-1];
                  aCtrl->focusTarget = aCtrl->focusValue[0] + aCtrl->step[ind];
               }
               else
               {
                  aCtrl->focusTarget = aCtrl->focusValue[ind-1] + aCtrl->step[ind-1];
                  //aCtrl->step[ind] = aCtrl->step[ind-1];
               }

               // vérification pour un changement de direction
               if(aCtrl->step[ind] * aCtrl->step[ind-1] < 0 && ind > 1)
               {
                  aCtrl->stepDirChange = true;

                  float temp;
                  int16_t theStep;
                  uint8_t i, j;
                  uint8_t fin = (aCtrl->nPoints-1)/2;
                  for(i=0; i<fin; i++)
                  {
                     j = aCtrl->nPoints - 1 - i;

                     // Focus values
                     temp = aCtrl->focusValue[j];
                     aCtrl->focusValue[j] = aCtrl->focusValue[i];
                     aCtrl->focusValue[i] = temp;

                     // Focus Metric values
                     temp = aCtrl->focusMetricData.focusMetric[j];
                     aCtrl->focusMetricData.focusMetric[j] = aCtrl->focusMetricData.focusMetric[i];
                     aCtrl->focusMetricData.focusMetric[i] = temp;

                     // Focus Metric Relative Values
                     temp = aCtrl->focusMetricData.focusMetricRelative[j];
                     aCtrl->focusMetricData.focusMetricRelative[j] = aCtrl->focusMetricData.focusMetricRelative[i];
                     aCtrl->focusMetricData.focusMetricRelative[i] = temp;

                     // filtered Focus Metric values
                     temp = aCtrl->focusMetricData.filteredFocusMetric[j];
                     aCtrl->focusMetricData.filteredFocusMetric[j] = aCtrl->focusMetricData.filteredFocusMetric[i];
                     aCtrl->focusMetricData.filteredFocusMetric[i] = temp;

                     // Deriv Focus Metric Values
                     temp = aCtrl->derivFocusMetric[j];
                     aCtrl->derivFocusMetric[j] = aCtrl->derivFocusMetric[i];
                     aCtrl->derivFocusMetric[i] = temp;

                     // step values
                     theStep = aCtrl->step[j];
                     aCtrl->step[j] = aCtrl->step[i];
                     aCtrl->step[i] = theStep;
                  }

                  // swap max and min to respect de reverse ordering
                  aCtrl->focusMetricData.max = aCtrl->nPoints-1 - aCtrl->focusMetricData.max;
                  aCtrl->focusMetricData.min = aCtrl->nPoints-1 - aCtrl->focusMetricData.min;

               }
               else
               {
                  aCtrl->stepDirChange = false;
               }
               break;
            }

            case changeDirection:
            {
               uint16_t ind = aCtrl->nPoints;
               bool FMin, FMax, Deriv;
               uint8_t min = aCtrl->focusMetricData.min;
               uint8_t max = aCtrl->focusMetricData.max;

               if(aCtrl->focusMetricData.focusMetric[ind-1] < (aCtrl->focusMetricData.focusMetric[min] * aCtrl->SMPFM) )
               {
                  FMin = true;
               }
               else
               {
                  FMin = false;
               }

               if(aCtrl->focusMetricData.focusMetric[ind-1] < (aCtrl->focusMetricData.focusMetric[max] / aCtrl->SMPFM ) )
               {
                  FMax = true;
               }
               else
               {
                  FMax = false;
               }

               if(ind > 4 && ( fabs(aCtrl->derivFocusMetric[ind-1]) ) < aCtrl->SMPderiv )
               {
                  Deriv = true;
               }
               else
               {
                  Deriv = false;
               }

               // Acceleration
               if( (FMin || FMax || Deriv) && (ind > aCtrl->SMPnbstep) )
               {
                  aCtrl->step[ind] = sign(aCtrl->step[ind-1]) * 75 * aCtrl->multstep;
               }
               else
               {
                  aCtrl->step[ind] = sign(aCtrl->step[ind-1]) * 75;
               }

               aCtrl->focusTarget = aCtrl->focusValue[ind-1] + aCtrl->step[ind-1];
               aCtrl->step[ind] = aCtrl->step[ind-1];

               if( (aCtrl->focusTarget-aCtrl->step[ind-1]) >= aCtrl->focusMax && aCtrl->step[ind-1] > 0)
               {
                  aCtrl->action = 0;
               }
               else if( (aCtrl->focusTarget-aCtrl->step[ind-1]) <= aCtrl->focusMin && aCtrl->step[ind-1] < 0)
               {
                  aCtrl->action = 0;
               }

               break;
            }

            default:
            {
               // we do nothing
            }

         }
         aCtrl->movingParamState = paramsState;
         aRpCtrl->parsingDone = 0;
         CBB_Flush(&aRpCtrl->responses);
         state = moving;
      }

      case moving:
      {
         if(aCtrl->focusTarget > aCtrl->focusMax)
         {
            aCtrl->focusTarget = aCtrl->focusMax;
         }
         else if (aCtrl->focusTarget < aCtrl->focusMin)
         {
            aCtrl->focusTarget = aCtrl->focusMin;
         }
         goFastToFocus(aRpCtrl, aCtrl->focusTarget);
         AUTO_PRINTF("FocusTarget : %d\n", aCtrl->focusTarget);
         GETTIME(&tic);
         state = getFocus;
         break;
      }

      case getFocus:
      {
         if(aRpCtrl->parsingDone < 1)
         {
            if(aRpCtrl->currentResponseData.ack == 0xFE)
            {
               uint16_t ind = aCtrl->nPoints;
               uint16_t enc = aRpCtrl->currentResponseData.focusEncValue;
               if(abs(enc - aCtrl->focusTarget) > 50)
               {
                  state = moving;
               }
               else
               {
                  aCtrl->focusValue[ind] = enc;
                  AUTO_PRINTF("FocusEncValue: ----> %d\n",  aRpCtrl->currentResponseData.focusEncValue);
                  aSlCtrl->parsingDone += 1;
                  state = getFocusMetric;
               }
            }
            else
            {
               state = moving;
            }
         }
         else if(elapsed_time_us(tic) > (TIME_ONE_SECOND_US))        // La réponse du dernier déplacement est perdue donc
                                                                     // je copie le dernier point et je passe à IdentBestFocus
         {
            aCtrl->abort += 1;
            if(aCtrl->abort > 1)                                     // après 3 erreurs, on arrête l'autofocus
            {
               aCtrl->action = 0;
               aCtrl->abort = 0;
            }
            uint16_t ind = aCtrl->nPoints;
            aCtrl->focusValue[ind] = aCtrl->focusValue[ind-1];
            aCtrl->focusMetricData.focusMetric[ind] = aCtrl->focusMetricData.focusMetric[ind-1];
            aCtrl->nPoints += 1;
            state = IdentBestFocus;
            GETTIME(&tic);
         }
         break;
      }

      case getFocusMetric:
      {
         if(aSlCtrl->parsingDone < 1)
         {
            uint16_t ind = aCtrl->nPoints;
            uint8_t min = aCtrl->focusMetricData.min;
            uint8_t max = aCtrl->focusMetricData.max;
            float temp = aSlCtrl->currentMetricData;
            aCtrl->focusMetricData.focusMetric[ind] = temp;
            if(temp < aCtrl->focusMetricData.focusMetric[min])
            {
               aCtrl->focusMetricData.min = ind;
            }
            else if(temp > aCtrl->focusMetricData.focusMetric[max])
            {
               aCtrl->focusMetricData.max = ind;
            }

            aCtrl->nPoints += 1;
            if(aCtrl->nPoints > 127)
            {
               aCtrl->action = 0;                  // Le nombre maximum de points est atteint donc on quitte l'autofocus
            }
            state = IdentBestFocus;
         }
         /*else if(elapsed_time_us(tic) > (TIME_TEN_SECOND_US))
         {
            //getParameter(aSlCtrl, 0);        // 0 = version ID
            GETTIME(&tic);
            GC_GenerateEventError(EECD_AutofocusModuleError);
            state = idle;
         }*/
         break;
      }

      case IdentBestFocus:
      {
         uint8_t k = 0;
         uint16_t ind = aCtrl->nPoints;
         bool Gaussian = false;
         bool Maximum = false;
         bool Discrimin1 = false;
         //bool Discrimin2 = false;
         aCtrl->SignSDerivData.negPresent = false;
         aCtrl->SignSDerivData.posPresent = false;

         uint8_t min = aCtrl->focusMetricData.min;
         uint8_t max = aCtrl->focusMetricData.max;

         if(ind > 1)
         {
            // Evaluate all the Focus Metric Relative Values at every new point
            for(k=0; k<aCtrl->nPoints; k++)
            {
               aCtrl->focusMetricData.focusMetricRelative[k] =   (aCtrl->focusMetricData.focusMetric[k] - aCtrl->focusMetricData.focusMetric[min])
                                                                   / (aCtrl->focusMetricData.focusMetric[max] - aCtrl->focusMetricData.focusMetric[min]);
            }

            aCtrl->focusMetricData.filteredFocusMetric[0] = aCtrl->focusMetricData.focusMetricRelative[0];
            aCtrl->focusMetricData.filteredFocusMetric[1] = aCtrl->focusMetricData.focusMetricRelative[1];

            // filtering the focus metric relative data using a 3 taps average filter
            for(k=2; k<aCtrl->nPoints; k++)
            {
               aCtrl->focusMetricData.filteredFocusMetric[k] = (  aCtrl->focusMetricData.focusMetricRelative[k] +
                                                                  aCtrl->focusMetricData.focusMetricRelative[k-1] +
                                                                  aCtrl->focusMetricData.focusMetricRelative[k-2]   ) / 3;
            }

            // Evaluate the derivatives of the filtered focus metric data
            for(k=1; k<aCtrl->nPoints; k++)
            {
               aCtrl->derivFocusMetric[k] =  ( ( aCtrl->focusMetricData.filteredFocusMetric[k] - aCtrl->focusMetricData.filteredFocusMetric[k-1] ) /
                                             ( abs(aCtrl->step[k]) ) * aCtrl->coeff );

               if(aCtrl->derivFocusMetric[k] > aCtrl->SD)
               {
                  aCtrl->SignSDerivData.posPresent = true;
               }

               if(aCtrl->derivFocusMetric[k] < -aCtrl->SD)
               {
                  aCtrl->SignSDerivData.negPresent = true;
               }
            }


         }
         else
         {
            aCtrl->focusMetricData.filteredFocusMetric[ind-1] = aCtrl->focusMetricData.focusMetric[ind-1];
            aCtrl->derivFocusMetric[ind-1] = 0;
            aCtrl->sDeriv = 0.0;
            aCtrl->SignSDerivData.SignSDeriv = 0;
         }

         if(aCtrl->SignSDerivData.negPresent && aCtrl->SignSDerivData.posPresent)
         {
            Gaussian = true;
         }

         if(aCtrl->focusMetricData.focusMetric[max] > aCtrl->focusMetricData.focusMetric[min] * aCtrl->SFM)
         {
            Maximum = true;
         }

         if(aCtrl->focusMetricData.focusMetricRelative[0] < aCtrl->SFD && aCtrl->focusMetricData.focusMetricRelative[ind-1] < aCtrl->SFD)
         {
            Discrimin1 = true;
         }

         if( (Gaussian && Maximum && Discrimin1 ) || aCtrl->action == 0)
         {
            if(aCtrl->action == 0)
            {
               // Autofocus did not succeed, so generate error, even if it is not a real timeout...
               GC_GenerateEventError(EECD_AutofocusTimeout);

               aCtrl->bestFocus = aCtrl->focusValue[aCtrl->focusMetricData.max];
            }
            else
            {
               aCtrl->bestFocus = aCtrl->focusValue[aCtrl->focusMetricData.max];
            }
            state = moveToBest;
         }
         else
         {
            state = setMovingParams;
         }
         break;
      }

      case moveToBest:
      {
         if(aCtrl->bestFocus > aCtrl->focusMax)
         {
            aCtrl->bestFocus = aCtrl->focusMax;
         }
         else if (aCtrl->bestFocus < aCtrl->focusMin)
         {
            aCtrl->bestFocus = aCtrl->focusMin;
         }
         goManuallyToPos(aRpCtrl, aRpCtrl->currentResponseData.zoomEncValue, aCtrl->bestFocus);
         AUTO_INF("----> BestFocus is :%d\n", aCtrl->bestFocus);
         aCtrl->nPoints = 0;
         aCtrl->focusMetricData.min = 0;
         aCtrl->focusMetricData.max = 0;
         aCtrl->movingParamState = firstStep;
         aCtrl->stepDirChange = false;
         aCtrl->abort = 0;
         setCoordReportMode(aSlCtrl, 0, 0x80, 0);     // deactivate telemetry
         state = idle;

         // Clear AutofocusIsActive and share new value
         IsActiveFlagsClr(AutofocusIsActiveMask);

         // Restore registers value
         Autofocus_restoreGCRegisters( &GCRegsBackup );
         break;
      }

      default:
      case idle:
      {
         if(autofocusLaunch)
         {
            autofocusLaunch = false;
            state = initTelemetry;
            aCtrl->action = 1;

            // Set AutofocusIsActive and share new value
            IsActiveFlagsSet(AutofocusIsActiveMask);

            // Backup registers value
            Autofocus_backupGCRegisters( &GCRegsBackup );

            // Make sure AGC and VideoFreeze are off
            GC_SetVideoAGC(VAGC_Off);
            GC_SetVideoFreeze(0);
         }
         else if(elapsed_time_us(tic) > (TIME_ONE_MINUTE_US))
         {
            GETTIME(&tic);
            refreshTemperature(aRpCtrl);
         }
         break;
      }

   }
   aCtrl->autoState = state;
}

int8_t sign(int aNumber)
{
   return (aNumber > 0) - (aNumber < 0);
}


/**
 *  This function backs up genicam registers that are modified during
 *  autofocus.
 *
 *  This function accesses the global variable gcRegsData in read-only mode.
 *
 *  @param p_GCRegsBackup a pointer to the genicam registers subset
 *
 *  @return none
 *
 *  Note(s):
 *
 */
static void Autofocus_backupGCRegisters( Autofocus_GCRegsBackup_t *p_GCRegsBackup )
{
   p_GCRegsBackup->VideoAGC = gcRegsData.VideoAGC;
   p_GCRegsBackup->VideoFreeze = gcRegsData.VideoFreeze;
}

/**
 *  This function restores genicam registers that have been modified during
 *  autofocus.
 *
 *  This function writes the global variable gcRegsData.
 *
 *  @param p_GCRegsBackup a pointer to the genicam registers subset
 *
 *  @return none
 */
static void Autofocus_restoreGCRegisters( Autofocus_GCRegsBackup_t *p_GCRegsBackup )
{
   GC_SetVideoAGC(p_GCRegsBackup->VideoAGC);
   GC_SetVideoFreeze(p_GCRegsBackup->VideoFreeze);
}

