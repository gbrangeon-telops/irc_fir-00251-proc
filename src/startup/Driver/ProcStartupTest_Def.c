/**
 * @file ProcStartupTestDef.h
 * Automated functionality tests list implementation
 *
 * This file implements the automated functionality tests list
 *
 * $Rev: 17563 $
 * $Author: dalain $
 * $Date: 2015-11-30 14:35:06 -0500 (lun., 30 nov. 2015) $
 * $Id: BuiltInTestsDef.h 17563 2015-11-30 19:35:06Z dalain $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/trunk/src/sw/BuiltInTestsDef.h $
 *
 * (c) Copyright 2016 Telops Inc.
 */

#include "ProcStartupTest_Def.h"
#include "ProcStartupTest_Master.h"


/*
 * Auto tests structure
 */
autoTest_t autoTests[ATID_Count] =
{
   // Test ID                          Test Description                                            Test Function                 Test Result
   {ATID_InternalFanControl,           "SU2.3.3  : Internal Fan Control Test",                     AutoTest_IntFanCtrl,          ATR_PENDING},
   {ATID_ExternalFanControl,           "SU2.3.4  : External Fan Control Test",                     AutoTest_ExtFanCtrl,          ATR_PENDING},
   {ATID_PowerConnectorOnOff,          "SU2.4.1  : Power Channel Control Test",                    AutoTest_PwrConnectOnOff,     ATR_PENDING},
   {ATID_CameraLEDColors,              "SU2.4.2  : Camera LED Status Test",                        AutoTest_CamLEDColors,        ATR_PENDING},
   {ATID_PowerButtonInterrupt,         "SU2.4.3  : POWER Button Interrupt Test",                   AutoTest_PwrBtnInt,           ATR_PENDING},
   {ATID_XADCPowerMonitoring,          "SU2.4.4  : XADC Power Monitoring Test",                    AutoTest_XADCPwrMonitor,      ATR_PENDING},
   {ATID_CLINKUART,                    "SU2.5.1  : CLINK UART Test",                               AutoTest_CLINK_UART,          ATR_PENDING},
   {ATID_OEMUART,                      "SU2.5.2  : OEM UART Test",                                 AutoTest_OEM_UART,            ATR_PENDING},
   {ATID_GIGEUART,                     "SU2.5.3  : GIGE UART Test",                                AutoTest_GIGE_UART,           ATR_PENDING},
   {ATID_USBUART,                      "SU2.5.4  : USB UART Test",                                 AutoTest_USB_UART,            ATR_PENDING},
   {ATID_FilterWheelUART,              "SU2.5.5  : Filter Wheel UART Test",                        AutoTest_FilterWheel_UART,    ATR_PENDING},
   {ATID_CoolerUART,                   "SU2.5.6  : Cooler UART Test",                              AutoTest_Cooler_UART,         ATR_PENDING},
   {ATID_DetectorInterface,            "SU2.6    : Detector Interface Test",                       AutoTest_Detector,            ATR_PENDING},
   {ATID_GPSSync,                      "SU2.7.1  : GPS Synchronization Test",                      AutoTest_GPSSync,             ATR_PENDING},
   {ATID_IRIGSync,                     "SU2.7.2  : IRIG-B Synchronization Test",                   AutoTest_IRIGSync,            ATR_PENDING},
   {ATID_XADCExternalInterfaceReading, "SU2.8.1  : XADC External Interface Reading Test",          AutoTest_XADCExtIntf,         ATR_PENDING},
   {ATID_XADCExternalVoltageReading,   "SU2.8.2  : XADC External Voltage Reading Test",            AutoTest_XADCExtVolt,         ATR_PENDING},
   {ATID_XADCInternalVoltageReading,   "SU2.8.3  : XADC Internal Voltage Reading Test",            AutoTest_XADCIntVolt,         ATR_PENDING},
   {ATID_ICUInterface,                 "SU2.9    : ICU Interface Test",                            AutoTest_ICUIntf,             ATR_PENDING},
   {ATID_TriggerInterface,             "SU2.10   : Trigger Interface Test",                        AutoTest_TrigIntf,            ATR_PENDING},
   {ATID_SFWInterface,                 "SU2.11   : SFW Interface Test",                            AutoTest_SWFIntf,             ATR_PENDING},
   {ATID_USARTPacketTransfer,          "SU2.12.1 : USART Packet Transfer Test",                    AutoTest_USARTLoopback,       ATR_PENDING},
   {ATID_USARTFileWrite,               "SU2.12.2 : USART File Write Test",                         AutoTest_USARTFileTx,         ATR_PENDING},
   {ATID_GIGEOutput,                   "SU2.13.1 : GIGE Video Output Test",                        AutoTest_GIGEVideoOut,        ATR_PENDING},
   {ATID_CamLinkOutput,                "SU2.13.2 : CameraLink Video Output Test",                  AutoTest_CamLinkVideoOut,     ATR_PENDING},
   {ATID_SDIOutput,                    "SU2.13.3 : SDI Video Output Test",                         AutoTest_SDIVideoOut,         ATR_PENDING},
   {ATID_ADCReadout,                   "SU2.14.1 : ADC reading Test",                              AutoTest_ADCReadout,          ATR_PENDING},
   {ATID_ProcessingCalibrationMemory,  "SU2.2.2  : Processing Calibration Memory Test",            AutoTest_ProcCalibMem,        ATR_PENDING},
   {ATID_OutputBufferMemory,           "SU2.2.3  : Output Buffer Memory Test",                     AutoTest_OBufMem,             ATR_PENDING},
   {ATID_FlashMemory,                  "SU2.2.4  : FLASH Memory Test",                             AutoTest_FlashMem,            ATR_PENDING}

};
