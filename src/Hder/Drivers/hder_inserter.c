/**
 * @file hder_inserter.c
 * IR camera header inserter driver module implementation.
 *
 * This file implements the IR camera header inserter driver module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */
 
#include "hder_inserter.h"
#include "IRCamHeader.h"
#include "utils.h"
#include "IRC_status.h"
#include "Calibration.h"
#include "calib.h"
#include "FlashSettings.h"
#include <string.h>
#include "ReleaseInfo.h"
#include "Actualization.h"

#ifdef SIM
   #include "proc_ctrl.h" // Contains the class SC_MODULE for SystemC simulation
   #include "mb_transactor.h" // Contains virtual functions that emulates microblaze functions
   #include "mb_axi4l_bridge_SC.h" // Used to bridge Microblaze AXI4-Lite transaction in SystemC transaction
#else                  
   //#include "dosfs.h"
   //#include "xtime_l.h"
   //#include "xcache_l.h"   
   #include "mb_axi4l_bridge.h"
#endif

//----------------------------------------------------------------
// pour connaitre l'etat du Done 
//----------------------------------------------------------------
IRC_Status_t HDER_Done(const t_HderInserter *a)
 {
   uint32_t Status;
   uint32_t DoneBit;
   
   Status = AXI4L_read32(a->ADD + A_STATUS);
   DoneBit = bitget(Status, HDER_DONE_BIT);
     
   if (DoneBit == 0)
   {
      return IRC_NOT_DONE;
   }
   else
   {
      return IRC_DONE;
   }      
 }															  
  
//----------------------------------------------------------------
// pour envoyer la configuration de CLINK Interface
//----------------------------------------------------------------
void HDER_SendConfigGC(t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   a->eff_hder_len = EFFECTIVE_HDER_LENGTH;
   a->zero_pad_len = 2*pGCRegs->Width - a->eff_hder_len;	
   a->hder_len = a->eff_hder_len + a->zero_pad_len ;
   a->eff_hder_len_div2_m1 = a->eff_hder_len/2 - 1;
   a->zero_pad_len_div2_m1     = a->zero_pad_len/2 - 1;   
   if (a->zero_pad_len > 0)                         // necessite du padding
   {
      a->need_padding       = 1;
   } 
   else
   {
      a->need_padding      = 0;
   }   
   a->hder_tlast_en  = (uint32_t) HDER_TLAST_ENABLED;   //
   WriteStruct(a);                                      // envoi de la structure
}                  

//----------------------------------------------------------------
////pour envoyer le header 
//----------------------------------------------------------------
void HDER_SendHeaderGC(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{  
   static const char headerSignature[3] = "TC";
   uint32_t data32;
   uint8_t i;

   uint8_t hdrTestImageSelector;

   // Manage special Pleora NTx-Mini test image selector value (0x80000000)
   if (pGCRegs->TestImageSelector < 0xFF)
   {
      hdrTestImageSelector = pGCRegs->TestImageSelector;
   }
   else
   {
      hdrTestImageSelector = 0xFF;
   }

// Il est important d'envoyer chaque champ separement avec la fonction 
// AXI4L_write8 AXI4L_write16 ou AXI4L_write32 dependamment de la taille du champ.
// ne pas faire de concatenation
// Les adresses doit etre exactement ceux decrit dans le fichier excel/xml du header
// si jamais un mot de 24 bits doit etre envoyé, il faut le convertir en 32 bits et l'envoyer avec AXI4L_write32

/* AUTO-CODE BEGIN */
// Auto-generated IRCam header inserter driver.
// Generated from the IRCam header definition XLS file version 11.4
// using generateIRCamHeaderInserterDriver.m Matlab script.

   for (i = 0; i < 2; ++i)
   {
      AXI4L_write8((uint8_t)(headerSignature[i]), a->ADD + A_BASE_HEADER + SignatureHdrAddr + i);
   }
   AXI4L_write8((uint8_t)(pGCRegs->DeviceXMLMinorVersion), a->ADD + A_BASE_HEADER + DeviceXMLMinorVersionHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->DeviceXMLMajorVersion), a->ADD + A_BASE_HEADER + DeviceXMLMajorVersionHdrAddr);
   AXI4L_write16((uint16_t)(2 * (2 * pGCRegs->Width)), a->ADD + A_BASE_HEADER + ImageHeaderLengthHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + FrameIDHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + DataOffsetHdrAddr);
   AXI4L_write8((int8_t)(0), a->ADD + A_BASE_HEADER + DataExpHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + ExposureTimeHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->CalibrationMode), a->ADD + A_BASE_HEADER + CalibrationModeHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->BadPixelReplacement), a->ADD + A_BASE_HEADER + BPRAppliedHdrAddr);
   AXI4L_write8((uint8_t)(0), a->ADD + A_BASE_HEADER + FrameBufferModeHdrAddr);
   AXI4L_write8((uint8_t)(0), a->ADD + A_BASE_HEADER + CalibrationBlockIndexHdrAddr);
   AXI4L_write16((uint16_t)(pGCRegs->Width), a->ADD + A_BASE_HEADER + WidthHdrAddr);
   AXI4L_write16((uint16_t)(pGCRegs->Height), a->ADD + A_BASE_HEADER + HeightHdrAddr);
   AXI4L_write16((uint16_t)(pGCRegs->OffsetX), a->ADD + A_BASE_HEADER + OffsetXHdrAddr);
   AXI4L_write16((uint16_t)(pGCRegs->OffsetY), a->ADD + A_BASE_HEADER + OffsetYHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->ReverseX), a->ADD + A_BASE_HEADER + ReverseXHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->ReverseY), a->ADD + A_BASE_HEADER + ReverseYHdrAddr);
   AXI4L_write8((uint8_t)(hdrTestImageSelector), a->ADD + A_BASE_HEADER + TestImageSelectorHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->SensorWellDepth), a->ADD + A_BASE_HEADER + SensorWellDepthHdrAddr);
   AXI4L_write32((uint32_t)(pGCRegs->AcquisitionFrameRate * 1000.0F), a->ADD + A_BASE_HEADER + AcquisitionFrameRateHdrAddr);
   memcpy((void*)&data32, (void*)&(TriggerDelayAry[TS_AcquisitionStart]), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + TriggerDelayHdrAddr);
   AXI4L_write8((uint8_t)(TriggerModeAry[TS_AcquisitionStart]), a->ADD + A_BASE_HEADER + TriggerModeHdrAddr);
   AXI4L_write8((uint8_t)(TriggerSourceAry[TS_AcquisitionStart]), a->ADD + A_BASE_HEADER + TriggerSourceHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->IntegrationMode), a->ADD + A_BASE_HEADER + IntegrationModeHdrAddr);
   AXI4L_write8((uint8_t)(1), a->ADD + A_BASE_HEADER + AveragingNumberHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->ExposureAuto), a->ADD + A_BASE_HEADER + ExposureAutoHdrAddr);
   memcpy((void*)&data32, (void*)&(pGCRegs->AECResponseTime), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + AECResponseTimeHdrAddr);
   memcpy((void*)&data32, (void*)&(pGCRegs->AECImageFraction), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + AECImageFractionHdrAddr);
   memcpy((void*)&data32, (void*)&(pGCRegs->AECTargetWellFilling), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + AECTargetWellFillingHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->FWMode), a->ADD + A_BASE_HEADER + FWModeHdrAddr);
   AXI4L_write16((uint16_t)(pGCRegs->FWSpeedSetpoint), a->ADD + A_BASE_HEADER + FWSpeedSetpointHdrAddr);
   AXI4L_write16((uint16_t)(pGCRegs->FWSpeed), a->ADD + A_BASE_HEADER + FWSpeedHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + POSIXTimeHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + SubSecondTimeHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->TimeSource), a->ADD + A_BASE_HEADER + TimeSourceHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->GPSModeIndicator), a->ADD + A_BASE_HEADER + GPSModeIndicatorHdrAddr);
   AXI4L_write32((int32_t)(pGCRegs->GPSLongitude), a->ADD + A_BASE_HEADER + GPSLongitudeHdrAddr);
   AXI4L_write32((int32_t)(pGCRegs->GPSLatitude), a->ADD + A_BASE_HEADER + GPSLatitudeHdrAddr);
   AXI4L_write32((int32_t)(pGCRegs->GPSAltitude), a->ADD + A_BASE_HEADER + GPSAltitudeHdrAddr);
   AXI4L_write16((uint16_t)(0), a->ADD + A_BASE_HEADER + FWEncoderAtExposureStartHdrAddr);
   AXI4L_write16((uint16_t)(0), a->ADD + A_BASE_HEADER + FWEncoderAtExposureEndHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->FWPosition), a->ADD + A_BASE_HEADER + FWPositionHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->ICUPosition), a->ADD + A_BASE_HEADER + ICUPositionHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->NDFilterPosition), a->ADD + A_BASE_HEADER + NDFilterPositionHdrAddr);
   AXI4L_write8((uint8_t)(5), a->ADD + A_BASE_HEADER + EHDRIExposureIndexHdrAddr);
   AXI4L_write8((uint8_t)(0), a->ADD + A_BASE_HEADER + FrameFlagHdrAddr);
   AXI4L_write8((uint8_t)(0), a->ADD + A_BASE_HEADER + PostProcessedHdrAddr);
   AXI4L_write16((uint16_t)(0), a->ADD + A_BASE_HEADER + SensorTemperatureRawHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + AlarmVectorHdrAddr);
   memcpy((void*)&data32, (void*)&(pGCRegs->ExternalBlackBodyTemperature), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + ExternalBlackBodyTemperatureHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_Sensor] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureSensorHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_InternalLens] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureInternalLensHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_ExternalLens] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureExternalLensHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_InternalCalibrationUnit] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureInternalCalibrationUnitHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_ExternalThermistor] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureExternalThermistorHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_SpectralFilterWheel] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureFilterWheelHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_Compressor] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureCompressorHdrAddr);
   AXI4L_write16((int16_t)(DeviceTemperatureAry[DTS_ColdFinger] * 100.0F), a->ADD + A_BASE_HEADER + TemperatureColdFingerHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + CalibrationBlockPOSIXTimeHdrAddr);
   AXI4L_write32((uint32_t)(pGCRegs->ExternalLensSerialNumber), a->ADD + A_BASE_HEADER + ExternalLensSerialNumberHdrAddr);
   AXI4L_write32((uint32_t)(pGCRegs->ManualFilterSerialNumber), a->ADD + A_BASE_HEADER + ManualFilterSerialNumberHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->SensorID), a->ADD + A_BASE_HEADER + SensorIDHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->PixelDataResolution), a->ADD + A_BASE_HEADER + PixelDataResolutionHdrAddr);
   AXI4L_write8((uint8_t)(CALIB_BLOCKFILEMAJORVERSION), a->ADD + A_BASE_HEADER + DeviceCalibrationFilesMajorVersionHdrAddr);
   AXI4L_write8((uint8_t)(CALIB_BLOCKFILEMINORVERSION), a->ADD + A_BASE_HEADER + DeviceCalibrationFilesMinorVersionHdrAddr);
   AXI4L_write8((uint8_t)(CALIB_BLOCKFILESUBMINORVERSION), a->ADD + A_BASE_HEADER + DeviceCalibrationFilesSubMinorVersionHdrAddr);
   AXI4L_write8((uint8_t)(CALIB_DATAFLOWMAJORVERSION), a->ADD + A_BASE_HEADER + DeviceDataFlowMajorVersionHdrAddr);
   AXI4L_write8((uint8_t)(CALIB_DATAFLOWMINORVERSION), a->ADD + A_BASE_HEADER + DeviceDataFlowMinorVersionHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->DeviceFirmwareMajorVersion), a->ADD + A_BASE_HEADER + DeviceFirmwareMajorVersionHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->DeviceFirmwareMinorVersion), a->ADD + A_BASE_HEADER + DeviceFirmwareMinorVersionHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->DeviceFirmwareSubMinorVersion), a->ADD + A_BASE_HEADER + DeviceFirmwareSubMinorVersionHdrAddr);
   AXI4L_write8((uint8_t)(pGCRegs->DeviceFirmwareBuildVersion), a->ADD + A_BASE_HEADER + DeviceFirmwareBuildVersionHdrAddr);
   AXI4L_write32((uint32_t)(0), a->ADD + A_BASE_HEADER + ActualizationPOSIXTimeHdrAddr);
   AXI4L_write32((uint32_t)(pGCRegs->DeviceSerialNumber), a->ADD + A_BASE_HEADER + DeviceSerialNumberHdrAddr);

/* AUTO-CODE END */
}

////----------------------------------------------------------------
//// pour lancer le bloc et s'assurer qu'il est lancé
////----------------------------------------------------------------
//IRC_Status HDER_Start(const t_HderInserter *a)
//{
//   IRC_Status DoneStatus;
//   // on lance le bloc
//    AXI4L_write32(C_HDER_START, a->ADD + A_CONTROL); 
//	return IRC_SUCCESS;
//}
//
////----------------------------------------------------------------
//// pour stoper le bloc
////----------------------------------------------------------------
//IRC_Status HDER_Stop(const t_HderInserter *a)
//{
//   IRC_Status DoneStatus;   
//   AXI4L_write32(C_HDER_STOP, a->ADD + A_CONTROL); // denmande de stop		 
//	return IRC_SUCCESS;
//}

//-------------------------------------------------------------------------
// Pour update du NDF dans le Header
// 0-2 for position
// 3 in transition
// 4 Not implemented
//-------------------------------------------------------------------------
void HDER_UpdateNDFPositionHeader(const t_HderInserter *a, uint8_t position)
{
   AXI4L_write8(position, a->ADD + A_BASE_HEADER + NDFilterPositionHdrAddr);
}

//-------------------------------------------------------------------------
// Pour update du ICU dans le Header
// 0-2 for position
// 3 in transition
// 4 Not implemented
//-------------------------------------------------------------------------
void HDER_UpdateICUPositionHeader(const t_HderInserter *a, uint8_t position)
{
   AXI4L_write8(position, a->ADD + A_BASE_HEADER + ICUPositionHdrAddr);
}

// see GenICam.h for the possible values for position
void HDER_UpdateFWPositionHeader(const t_HderInserter *a, uint8_t position)
{
   AXI4L_write8(position, a->ADD + A_BASE_HEADER + FWPositionHdrAddr);
}

/**
 * Update Image header temperature fields.
 *
 * @param a is the header inserter structure pointer.
 * @param dts is the device temperature selector of the temperature to update.
 */
void HDER_UpdateTemperaturesHeader(const t_HderInserter *a, DeviceTemperatureSelector_t dts)
{
   uint32_t hdrAddress = 0;

   switch (dts)
   {
      case DTS_Sensor:
         hdrAddress = TemperatureSensorHdrAddr;
         break;

      case DTS_InternalLens:
         hdrAddress = TemperatureInternalLensHdrAddr;
         break;

      case DTS_ExternalLens:
         hdrAddress = TemperatureExternalLensHdrAddr;
         break;

      case DTS_InternalCalibrationUnit:
         hdrAddress = TemperatureInternalCalibrationUnitHdrAddr;
         break;

      case DTS_ExternalThermistor:
         hdrAddress = TemperatureExternalThermistorHdrAddr;
         break;

      case DTS_SpectralFilterWheel:
         hdrAddress = TemperatureFilterWheelHdrAddr;
         break;

      case DTS_Compressor:
         hdrAddress = TemperatureCompressorHdrAddr;
         break;

      case DTS_ColdFinger:
         hdrAddress = TemperatureColdFingerHdrAddr;
         break;

      default:
         // Temperature is not supported by the header inserter
         return;
   }

   AXI4L_write16((int16_t)(DeviceTemperatureAry[dts] * 100.0F), a->ADD + A_BASE_HEADER + hdrAddress);
}

/**
 * Update Image header temperature fields.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateGPSHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write8((uint8_t)(pGCRegs->GPSModeIndicator), a->ADD + A_BASE_HEADER + GPSModeIndicatorHdrAddr);
   AXI4L_write32((int32_t)(pGCRegs->GPSLongitude), a->ADD + A_BASE_HEADER + GPSLongitudeHdrAddr);
   AXI4L_write32((int32_t)(pGCRegs->GPSLatitude), a->ADD + A_BASE_HEADER + GPSLatitudeHdrAddr);
   AXI4L_write32((int32_t)(pGCRegs->GPSAltitude), a->ADD + A_BASE_HEADER + GPSAltitudeHdrAddr);
}

/**
 * Update Image header AEC fields.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateAECHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   uint32_t data32;

   AXI4L_write8((uint8_t)(pGCRegs->ExposureAuto), a->ADD + A_BASE_HEADER + ExposureAutoHdrAddr);
   memcpy((void*)&data32, (void*)&(pGCRegs->AECResponseTime), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + AECResponseTimeHdrAddr);
   memcpy((void*)&data32, (void*)&(pGCRegs->AECImageFraction), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + AECImageFractionHdrAddr);
   memcpy((void*)&data32, (void*)&(pGCRegs->AECTargetWellFilling), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + AECTargetWellFillingHdrAddr);
}

/**
 * Update Image header ExternalBlackBodyTemperature field.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateExternalBBTempHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   uint32_t data32;

   memcpy((void*)&data32, (void*)&(pGCRegs->ExternalBlackBodyTemperature), sizeof(uint32_t));
   AXI4L_write32(data32, a->ADD + A_BASE_HEADER + ExternalBlackBodyTemperatureHdrAddr);
}

/**
 * Update Image header TimeSource field.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateTimeSourceHeader(const t_HderInserter *a, uint8_t timeSource)
{
   AXI4L_write8(timeSource, a->ADD + A_BASE_HEADER + TimeSourceHdrAddr);
}

/**
 * Update Image header optical serial number fields.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateOpticalSerialNumbersHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write32((uint32_t)(pGCRegs->ExternalLensSerialNumber), a->ADD + A_BASE_HEADER + ExternalLensSerialNumberHdrAddr);
   AXI4L_write32((uint32_t)(pGCRegs->ManualFilterSerialNumber), a->ADD + A_BASE_HEADER + ManualFilterSerialNumberHdrAddr);
}

/**
 * Update Image header reverse X field.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateReverseXHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write8((uint8_t)(pGCRegs->ReverseX), a->ADD + A_BASE_HEADER + ReverseXHdrAddr);
}

/**
 * Update Image header reverse Y field.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateReverseYHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write8((uint8_t)(pGCRegs->ReverseY), a->ADD + A_BASE_HEADER + ReverseYHdrAddr);
}

/**
 * Update Image header AcquisitionFrameRate Source field.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateAcquisitionFrameRateHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write32((uint32_t)(pGCRegs->AcquisitionFrameRate * 1000.0F), a->ADD + A_BASE_HEADER + AcquisitionFrameRateHdrAddr);
}


//----------------------------------------------------------------
 //pour avoir le statut du bloc
//----------------------------------------------------------------
uint32_t HDER_GetStatus(const t_HderInserter *a) 
{ 
   uint32_t Status;
   Status = AXI4L_read32(a->ADD + A_STATUS);
   return Status;
} 

/**
 * Update Image header FWSpeedSetpoint field.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateFWSpeedSetpointHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write16((uint16_t)(pGCRegs->FWSpeedSetpoint), a->ADD + A_BASE_HEADER + FWSpeedSetpointHdrAddr);
}

/**
 * Update Image header BadPixelReplacement field.
 *
 * @param a is a pointer to the header inserter structure.
 * @param pGCRegs is a pointer to registers data.
 */
void HDER_UpdateBadPixelReplacementHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs)
{
   AXI4L_write8((uint8_t)(pGCRegs->BadPixelReplacement), a->ADD + A_BASE_HEADER + BPRAppliedHdrAddr);
}
