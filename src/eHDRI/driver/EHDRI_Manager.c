
#include "EHDRI_Manager.h"
#include "xparameters.h"
#include "tel2000_param.h"
#include "xil_io.h"
#include "irc_status.h"
#include "utils.h"
#include "hder_inserter.h"
#include "exposure_time_ctrl.h"
#include "Calibration.h"
#include <string.h>
#include <math.h>

extern float EHDRIExposureTime[EHDRI_IDX_NBR];

void EHDRI_GetUpdate(uint16_t *exp_occurrence, uint8_t *Q_idx, uint16_t *Q_max, uint16_t *N, uint8_t nb_index);

IRC_Status_t EHDRI_Init(t_EhdriManager *pEhdriCtrl)
{

	WriteStruct(pEhdriCtrl);

	EHDRI_PRINTF("Init\n\r");
	return IRC_SUCCESS;

}

void EHDRI_Reset(t_EhdriManager *pEhdriCtrl, gcRegistersData_t *pGCRegs)
{
   EHDRIExposureTime[0] = FPA_EHDRI_EXP_0;
   EHDRIExposureTime[1] = FPA_EHDRI_EXP_1;
   EHDRIExposureTime[2] = FPA_EHDRI_EXP_2;
   EHDRIExposureTime[3] = FPA_EHDRI_EXP_3;

   pGCRegs->EHDRIExposureOccurrence1 = 25.0f;
   pGCRegs->EHDRIExposureOccurrence2 = 25.0f;
   pGCRegs->EHDRIExposureOccurrence3 = 25.0f;
   pGCRegs->EHDRIExposureOccurrence4 = 25.0f;

   GC_RegisterWriteUI32(&gcRegsDef[EHDRINumberOfExposuresIdx], 1);

   EHDRI_SendConfig(pEhdriCtrl, pGCRegs);
}

void EHDRI_SendConfig(t_EhdriManager *a, gcRegistersData_t *pGCRegs)
{
   uint16_t i;

   if (EHDRIIsActive)
   {
      a->Enable = TRUE;

      for (i = 0; i < EHDRI_IDX_NBR; i++) {
         a->ExposureTime[i] = EHDRIExposureTime[i] * EXPOSURE_TIME_FACTOR;
      }

      EHDRI_UpdateExpIndexSequence(a, pGCRegs);
   }
   else
   {
      a->Enable = FALSE;
   }

   WriteStruct(a);

   EHDRI_PRINTF("SendConfig\n\r");

}

void EHDRI_UpdateExpIndexSequence(t_EhdriManager *pEhdriCtrl, const gcRegistersData_t *pGCRegs)
{
#ifndef SIM
   float EHDRIExposureOccurrenceAry[EHDRI_IDX_NBR] = {pGCRegs->EHDRIExposureOccurrence1,
         pGCRegs->EHDRIExposureOccurrence2, pGCRegs->EHDRIExposureOccurrence3, pGCRegs->EHDRIExposureOccurrence4};

   uint16_t exp_occurrence[EHDRI_IDX_NBR];
   uint8_t sequence[EHDRI_BRAM_SIZE];
   float sum_percent;
   uint16_t i,j;
   uint16_t N;
   uint16_t Q_max;
   uint8_t Q_idx;
   uint16_t N_odd;
   uint16_t idx;
   uint16_t step;
   uint16_t N_empty;
   uint8_t emptyFlags[EHDRI_BRAM_SIZE / 8];

   // Add all percentage... max 100% * EHDRI_IDX_NBR
   sum_percent = 0;
   for ( i = 0; i < pGCRegs->EHDRINumberOfExposures; i++ )
   {
      sum_percent += EHDRIExposureOccurrenceAry[i];
   }
   EHDRI_PRINTF( "sum_percent = " _PCF(2) "\n\r", _FFMT(sum_percent, 2) );

   // Transform percentage to occurrence ... max EHDRI_BRAM_SIZE
   for ( i = 0; i < pGCRegs->EHDRINumberOfExposures; i++ )
   {
      exp_occurrence[i] = (uint16_t)( roundf( ( EHDRIExposureOccurrenceAry[i] / sum_percent ) * (float) EHDRI_BRAM_SIZE ) );
   }

   EHDRI_GetUpdate( exp_occurrence, &Q_idx, &Q_max, &N, pGCRegs->EHDRINumberOfExposures );

   // If sum of occurrence is not equal to EHDRI_BRAM_SIZE, we adjust the maximum occurrence
   if( N != EHDRI_BRAM_SIZE )
   {
      exp_occurrence[Q_idx] += ( EHDRI_BRAM_SIZE - N );
      EHDRI_GetUpdate( exp_occurrence, &Q_idx, &Q_max, &N, pGCRegs->EHDRINumberOfExposures );
   }

   // Set empty flags to 1
   memset( emptyFlags, 0xFF, sizeof(emptyFlags) );
   N_empty = EHDRI_BRAM_SIZE;

   // emptyFlags[0] &= ~( 0x01 << 5 );

   // Determine the number of odd position in the sequence
   N_odd = (uint16_t) ceilf( (float) N / 2.0F );
   EHDRI_PRINTF( "N_odd = %d\n\r", N_odd );

   // First set the beginning index to the first position
   idx = 1;

   // Make sure the most numerous occurences are wee ditributed across the sequence
   // Priority to the most numerous occurences
   // Check if a given exposure time is requested more than half of the total number of
   // exposure times
   while( ( Q_max >= N_odd ) && ( Q_max > 0 ) )
   {
      EHDRI_PRINTF( "Beggining of while... Qmax = %d, N_odd = %d\n\r", Q_max, N_odd );

      // Replace "remaining odd positions with selected exposure time
      for ( i = ( idx - 1 ); i < EHDRI_BRAM_SIZE; i += ( idx * 2 ) )
      {
         sequence[i] = Q_idx;
         emptyFlags[i / 8] &= ~( 0x01 << ( i % 8 ) );
         N_empty--;
      }

      // Decrease the remaining occurence that are next requested
      exp_occurrence[Q_idx] -= N_odd;
      EHDRI_PRINTF("Decreasing remaining occurence exp_occurenec[%d] = %d\n\r", Q_idx, exp_occurrence[Q_idx] );

      EHDRI_GetUpdate( exp_occurrence, &Q_idx, &Q_max, &N , pGCRegs->EHDRINumberOfExposures);

      // Determine the number of odd positions in the remaining sequence
      N_odd = (uint16_t) ceilf( (float) N / 2.0F );
      EHDRI_PRINTF( "Number of odd position in remaining sequence  = %d\n\r", N_odd );

      // Update starting position
      idx *= 2;
      EHDRI_PRINTF( "Update starting position = %d\n\r", idx );
   }

   EHDRI_GetUpdate( exp_occurrence, &Q_idx, &Q_max, &N, pGCRegs->EHDRINumberOfExposures);

   // Make sure the most numerous occurrences are weel distributed across the
   // sequence
   // - priority to the most numerous occurrences
   // check if any requested occurence is still remaining
   while( N > 0 )
   {
      // Determine the desired distance between occurcences
      step = (uint16_t) ceilf( (float) N_empty / (float) Q_max );
      EHDRI_PRINTF( "Step = %d\n\r", step );

      // Decrease the remaining occurrences that are next requested
      exp_occurrence[Q_idx] -= (uint16_t) ceilf( (float) N_empty / (float) step );
      EHDRI_PRINTF( "exp_occurrence[%d] remaining = %d\n\r", Q_idx, exp_occurrence[Q_idx] );

      // Replace "remaining" odd positions with selected selected exposure time
      j = step;
      for ( i = 0; i < EHDRI_BRAM_SIZE; i++ )
      {
         if ( ( emptyFlags[i / 8] & ( 0x01 << ( i % 8 ) ) ) != 0 )
         {
            if ( j == step )
            {
               j = 0;
               sequence[i] = Q_idx;
               emptyFlags[i / 8] &= ~( 0x01 << ( i % 8 ) );
               N_empty--;
            }
            j++;
         }
      }

      EHDRI_GetUpdate( exp_occurrence, &Q_idx, &Q_max, &N, pGCRegs->EHDRINumberOfExposures);
   }

   memset(pEhdriCtrl->ExpIndex, 0, EHDRI_INDEX_TABLE_SIZE * sizeof(uint32_t));

   for ( i = 0; i < EHDRI_BRAM_SIZE; i++ ) {
      pEhdriCtrl->ExpIndex[i/16] |= (sequence[i] << ((i % 16) * 2) );
   }

//    // Verification
//    for ( i = 0; i < EHDRI_BRAM_SIZE; i++ )
//    {
//       EHDRI_PRINTF( "%d\n", p_sequence[i] );
//    }
#endif
}

/*void HDRA_UpdateExpectedTemp(gcRegistersData_t *pGCRegs)
{

   // TODO: This function is not ready for multi-bloc

   float tempResult;
   float *EHDRIExposureTimeAry = &pGCRegs->EHDRIExposureOccurrence1;
   uint16_t i;
   uint16_t id;
   uint16_t Ncoef = calibrationInfo.blocks[0].maxTKData.TvsINT_FitOrder;

   // DEBUG Fonctionne, Inttopolyfit ont les meme valeur que dans matlab
   // for(i=0;i<10;i++)
   // {
   //    EHDRI_PRINTF("INTtoT_polyFit[%x] = 0x%x,\n",i,SDHdrData.NDFilter[pGCRegs->NDFilterPositionSetpoint].INTtoT_polyFit[i]);     
   //    EHDRI_PRINTF("TtoINT_polyFit[%x] = 0x%x,\n",i,SDHdrData.NDFilter[pGCRegs->NDFilterPositionSetpoint].TtoINT_polyFit[i]);     
   // }
   
   EHDRI_PRINTF( "EHDRINumberOfExposures = %d\n", pGCRegs->EHDRINumberOfExposures );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[0] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[0] * 100.0F ) );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[1] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[1] * 100.0F ) );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[2] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[2] * 100.0F ) );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[3] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[3] * 100.0F ) );
   
   // EHDRIExposureTimeAry[0] must be the smallest exp time if not reorder the exptime
   tempResult = 0.0f;
   if ( EHDRIExposureTimeAry[0] < calibrationInfo.blocks[0].maxTKData.TCalMaxExpTimeMin )
   {
      tempResult = calibrationInfo.blocks[0].maxTKData.TCalMax;
   }
   else if ( EHDRIExposureTimeAry[0] > calibrationInfo.blocks[0].maxTKData.TCalMaxExpTimeMax )
   {
      tempResult = calibrationInfo.blocks[0].maxTKData.TCalMin;
   }
   else
   {
      for( i = 0; i <= Ncoef; i++ )
      {
         id = Ncoef - i;
         tempResult = tempResult + powf( log10f( EHDRIExposureTimeAry[0] ), i) * SDHdrData.NDFilter.INTtoT_polyFit[id];
         EHDRI_PRINTF( "Loop %x: Total: 0x=%x, pow:0x%x, CoefMax :%x, ID:%x\n", i, tempResult, powf( log10f( EHDRIExposureTimeAry[0] ), i ), SDHdrData.NDFilter.INTtoT_polyFit[id], id );
      }
   }
   pGCRegs->EHDRIExpectedTemperatureMax = tempResult - EHDRI_C_TO_KELVIN;
   EHDRI_PRINTF( "EHDRIMaxExpectedTemp : %x\n", (uint32_t) pGCRegs->EHDRIMaxExpectedTemp );
   
   // EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures-1] must be the largest exp time if not reorder the exptime
   tempResult = 0.0f;
   if ( EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures-1] < SDHdrData.NDFilter.TCalMinExpTimeMin )
   {
      tempResult = SDHdrData.NDFilter.TCalMax;
   }
   else if ( EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures-1] > SDHdrData.NDFilter.TCalMinExpTimeMax )
   {
      tempResult = SDHdrData.NDFilter.TCalMin;
   }
   else
   {
      for( i = 0; i <= Ncoef; i++ )
      {
         id = ( Ncoef + 1 ) + Ncoef - i;
         tempResult = tempResult + powf( log10f( EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures - 1] ), i ) * SDHdrData.NDFilter.INTtoT_polyFit[id];
         EHDRI_PRINTF( "Loop %x: Total: 0x=%x, pow:0x%x, CoefMin :%x, ID:%x\n", i, tempResult, powf( log10f( EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures - 1]), i ), SDHdrData.NDFilter.INTtoT_polyFit[id], id );
      }
   }
   pGCRegs->EHDRIExpectedTemperatureMin = tempResult - EHDRI_C_TO_KELVIN;
   EHDRI_PRINTF( "MinExpectedTemp : %x\n", (uint32_t) pGCRegs->EHDRIMinExpectedTemp );
}

void HDRA_UpdateExpectedExposure(GeniCam_Registers_Set_t *pGCRegs)
{
   float tempResult;
   uint32_t i;
   uint32_t Ncoef = SDHdrData.NDFilter.INTvsT_fitOrder;
   
   // Limit minimum expected temperature
   pGCRegs->EHDRIMinExpectedTemp = MIN( pGCRegs->EHDRIMinExpectedTemp, SDHdrData.NDFilter.TCalMax - EHDRI_C_TO_KELVIN );
   pGCRegs->EHDRIMinExpectedTemp = MAX( pGCRegs->EHDRIMinExpectedTemp, SDHdrData.NDFilter.TCalMin - EHDRI_C_TO_KELVIN );
      
   // Limit maximum expected temperature                                                 
   pGCRegs->EHDRIMaxExpectedTemp = MIN( pGCRegs->EHDRIMaxExpectedTemp, SDHdrData.NDFilter.TCalMax - EHDRI_C_TO_KELVIN );
   pGCRegs->EHDRIMaxExpectedTemp = MAX( pGCRegs->EHDRIMaxExpectedTemp, SDHdrData.NDFilter.TCalMin - EHDRI_C_TO_KELVIN );
      
   // Make sure minimum expected temperature is not greater than maximum expected temperature
   pGCRegs->EHDRIMinExpectedTemp = MIN( pGCRegs->EHDRIMinExpectedTemp, pGCRegs->EHDRIMaxExpectedTemp );
   
   // Compute first exposure time 
   tempResult = 0.0f;
   for( i = 0; i <= Ncoef; i++ )
   {
      tempResult += powf( ( pGCRegs->EHDRIMaxExpectedTemp + EHDRI_C_TO_KELVIN ), i ) * SDHdrData.NDFilter.TtoINT_polyFit[Ncoef - i];
      EHDRI_PRINTF( "Loop %x: 0x=%08X   Coef : 0x%08X\n", i, *( (uint32_t *) &tempResult ), *( (uint32_t *) &SDHdrData.NDFilter.TtoINT_polyFit[Ncoef - i] ) );
   }
   EHDRIExposureTimeAry[0] = powf( 10.0f, tempResult );
   
   // Limit first exposure time
   EHDRIExposureTimeAry[0] = MIN( MAX( EHDRIExposureTimeAry[0], pGCRegs->ExposureTimeMin ), pGCRegs->ExposureTimeMax );
   
   // Compute last exposure time 
   tempResult = 0.0f;
   for( i = 0; i <= Ncoef; i++ )
   {
      tempResult += powf( ( pGCRegs->EHDRIMinExpectedTemp + EHDRI_C_TO_KELVIN ), i ) * SDHdrData.NDFilter.TtoINT_polyFit[ Ncoef + 1 + Ncoef - i];
      EHDRI_PRINTF( "Loop %x: 0x=%08X   Coef : 0x%08X\n", i, *( (uint32_t *) &tempResult ), *( (uint32_t *) &SDHdrData.NDFilter.TtoINT_polyFit[ Ncoef + 1 + Ncoef - i ] ) );
   }
   EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures - 1] = powf( 10.0f, tempResult );

   // Limit last exposure time
   EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures - 1] =
      MIN( MAX( EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures - 1], pGCRegs->ExposureTimeMin ), pGCRegs->ExposureTimeMax );

   // Ensure first exposure time is greater than last exposure time
   if ( EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures-1] > EHDRIExposureTimeAry[0] )
   {
      // Switch first and last exposure times
      tempResult = EHDRIExposureTimeAry[0];
      EHDRIExposureTimeAry[0] = EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures-1];
      EHDRIExposureTimeAry[pGCRegs->EHDRINumberOfExposures-1] = tempResult;
   }
   
   // Set remaining exposure times and occurrences
   if(pGCRegs->EHDRINumberOfExposures == 2)
   {
      EHDRIExposureTimeAry[2] = 0.0f;
      EHDRIExposureTimeAry[3] = 0.0f;
      EHDRIExposureOccurrenceAry[0] = 50.0f;
      EHDRIExposureOccurrenceAry[1] = 50.0f;
      EHDRIExposureOccurrenceAry[2] = 0.0f;
      EHDRIExposureOccurrenceAry[3] = 0.0f;
   }
   else if(pGCRegs->EHDRINumberOfExposures == 3)
   {
      EHDRIExposureTimeAry[1] = EHDRIExposureTimeAry[0] * powf(EHDRIExposureTimeAry[2] / EHDRIExposureTimeAry[0],(1.0f/2.0f)); //exp(1)=T1*(Tn/T1)^((i-1)/N-1)) ; T1 = exp(0) Tn=Exp(2)    
      EHDRIExposureTimeAry[3] = 0.0f;
      EHDRIExposureOccurrenceAry[0] = 33.0f;
      EHDRIExposureOccurrenceAry[1] = 33.0f;
      EHDRIExposureOccurrenceAry[2] = 33.0f;
      EHDRIExposureOccurrenceAry[3] = 0.0f;
   }
   else if(pGCRegs->EHDRINumberOfExposures == 4)
   {
      EHDRIExposureTimeAry[1] = EHDRIExposureTimeAry[0] * powf(EHDRIExposureTimeAry[3]/EHDRIExposureTimeAry[0],(1.0f/3.0f)); //exp(1)=T1*(Tn/T1)^((i-1)/N-1)) ; T1 = exp(0) Tn=Exp(3)
      EHDRIExposureTimeAry[2] = EHDRIExposureTimeAry[0] * powf(EHDRIExposureTimeAry[3]/EHDRIExposureTimeAry[0],(2.0f/3.0f)); //exp(2)=T1*(Tn/T1)^((i-1)/N-1)) ; T1 = exp(0) Tn=Exp(3)
      EHDRIExposureOccurrenceAry[0] = 25.0f;
      EHDRIExposureOccurrenceAry[1] = 25.0f;
      EHDRIExposureOccurrenceAry[2] = 25.0f;
      EHDRIExposureOccurrenceAry[3] = 25.0f;
   }

   EHDRI_PRINTF( "EHDRINumberOfExposures = %d\n", pGCRegs->EHDRINumberOfExposures );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[0] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[0] * 100.0F ) );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[1] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[1] * 100.0F ) );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[2] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[2] * 100.0F ) );
   EHDRI_PRINTF( "EHDRIExposureTimeAry[3] x 100 = %d\n", (uint32_t) ( EHDRIExposureTimeAry[3] * 100.0F ) );
}*/

/**************************************************************************
   Get the sum N, the maximum occurrences Q_max and its index Q_idx from a
   exp_occurrence.
**************************************************************************/
void EHDRI_GetUpdate(uint16_t *exp_occurrence, uint8_t *Q_idx, uint16_t *Q_max, uint16_t *N, uint8_t nb_index)
{
   uint8_t i;

   //Sum of occurrence to know if it is 1024
   *N = 0;
   for (i=0; i<nb_index; i++)
   {
      *N += exp_occurrence[i];
      EHDRI_PRINTF( "exp_occurrence[%d] = %d\n\r", i, exp_occurrence[i] );
   }
   EHDRI_PRINTF("Sum of occurrence N = %d\n\r",*N);


   //Find the maximum occurrence
   *Q_max = 0;
   for (i=0; i<nb_index; i++)
   {
      if (exp_occurrence[i] > *Q_max)
      {
         *Q_max = exp_occurrence[i];
         *Q_idx = i;
      }
   }
   EHDRI_PRINTF("Q_max = %d, Q_idx = %d\n\r",*Q_max, *Q_idx);

}
