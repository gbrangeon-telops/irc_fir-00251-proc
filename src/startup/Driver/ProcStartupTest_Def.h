/**
 * @file ProcStartupTestDef.h
 * Automated functionality tests list header
 *
 * This file defines the automated functionality tests list
 *
 * $Rev: 17563 $
 * $Author: dalain $
 * $Date: 2015-11-30 14:35:06 -0500 (lun., 30 nov. 2015) $
 * $Id: BuiltInTestsDef.h 17563 2015-11-30 19:35:06Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/BuiltInTestsDef.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#ifndef PROCSTARTUPTESTDEF_H
#define PROCSTARTUPTESTDEF_H

/*
 *  Automated Test ID
 */

enum automatedTestIDEnum {

   ATID_InternalFanControl = 0,
   ATID_ExternalFanControl,
   ATID_PowerConnectorOnOff,
   ATID_CameraLEDColors,
   ATID_PowerButtonInterrupt,
   ATID_XADCPowerMonitoring,

   // Communication tests
   ATID_CLINKUART,
   ATID_OEMUART,
   ATID_GIGEUART,
   ATID_USBUART,
   ATID_FilterWheelUART,
   ATID_CoolerUART,

   // Detector interface test
   ATID_DetectorInterface,

   // Temporal synchronization tests
   ATID_GPSSync,
   ATID_IRIGSync,

   // XADC tests
   ATID_XADCExternalInterfaceReading,
   ATID_XADCExternalVoltageReading,
   ATID_XADCInternalVoltageReading,

   // Hardware interface tests
   ATID_ICUInterface,
   ATID_TriggerInterface,
   ATID_SFWInterface,

   // USART tests
   ATID_USARTPacketTransfer,
   ATID_USARTFileWrite,

   // Video output tests
   ATID_GIGEOutput,
   ATID_CamLinkOutput,
   ATID_SDIOutput,

   // ADC tests
   ATID_ADCReadout,

   // Memory tests
   ATID_ProcessingCalibrationMemory,
   ATID_OutputBufferMemory,
   ATID_FlashMemory,

   // Storage board interface tests
   // TBD

   // Automated Test Count
   ATID_Count
};

/*
 * Automated test ID data type
 */
typedef enum automatedTestIDEnum autoTestID_t;


#endif // PROCSTARTUPTESTDEF_H
