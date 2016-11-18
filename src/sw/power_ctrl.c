/**
 * @file power_ctrl.c
 * Camera power manager module implementation.
 *
 * This file implements the camera power manager module.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "power_ctrl.h"
#include "GC_Registers.h"
#include "FPA_intf.h"
#include "XADC_channels.h"
#include "Acquisition.h"
#include "Calibration.h"
#include "Buffermanager.h"
#include "Actualization.h"
#include "BuiltInTests.h"
#include "DeviceKey.h"

powerCtrl_t gPowerCtrl;

uint32_t gTestLed = 0;
DeviceLedIndicatorState_t gTestLedState = DLIS_Error;

uint8_t gPowerOnIsAllowed = 1;

/**
 * Initializes power manager module.
 *
 * @param gpioDeviceId is the power manager GPIO device ID that can be found in xparameters.h file.
 * @param intc is the pointer to the Interrupt controller instance.
 * @param gpioIntrId is the power manager GPIO interrupt ID that can be found in xparameters.h file.
 *
 * @return IRC_SUCCESS if successfully initialized
 * @return IRC_FAILURE if failed to initialize.
 */
IRC_Status_t Power_Init(uint16_t gpioDeviceId, XIntc *p_intc, uint16_t gpioIntrId)
{
   XStatus status;

   status = XGpio_Initialize(&gPowerCtrl.GPIO, gpioDeviceId);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

   XGpio_InterruptEnable(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT);
	XGpio_InterruptGlobalEnable(&gPowerCtrl.GPIO);

	status = XIntc_Connect(p_intc, gpioIntrId, (XInterruptHandler)Power_IntrHandler, &gPowerCtrl);
   if (status != XST_SUCCESS)
   {
      return IRC_FAILURE;
   }

	// Set power management GPIO direction (0 for output, 1 for input)
	XGpio_SetDataDirection(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT, 0x00000400);

	// Set power management GPIO initial value
   XGpio_DiscreteWrite(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT, POWER_BUFFER_MASK);

   // Set direction for XADC mux address GPIO (0 for output, 1 for input)
	XGpio_SetDataDirection(&gPowerCtrl.GPIO, PGPIOC_ANALOG_MUX_ADDR, 0x00000000);

	// Set XADC mux address initial value
	XGpio_DiscreteWrite(&gPowerCtrl.GPIO, PGPIOC_ANALOG_MUX_ADDR, 0x00000000);

   return IRC_SUCCESS;
}

/**
 * Get channel power state.
 *
 * @param channel is the power channel.
 *
 * @return the channel power state.
 */
channelPowerState_t Power_GetChannelPowerState(powerChannel_t channel)
{
   return BitTst(XGpio_DiscreteRead(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT), channel)?CPS_ON:CPS_OFF;
}

/**
 * Get push button state.
 *
 * @return the push button state.
 */
pushButtonState_t Power_GetPushButtonState()
{
   if (Power_GetChannelPowerState(PC_PUSH_BUTTON) == CPS_OFF)
   {
      return PBS_PUSHED;
   }

   return PBS_RELEASED;
}

/**
 * Set channel power state.
 *
 * @param channel is the power channel.
 * @param state is the channel power state.
 *
 * @return the channel power state.
 */
channelPowerState_t Power_SetChannelPowerState(powerChannel_t channel, channelPowerState_t state)
{
   extern t_FpaIntf gFpaIntf;
   uint32_t mask = 1 << channel;
   uint32_t regValue;

   t_FpaStatus fpaStatus;
   uint32_t cooler_volt__mV;

   if ((channel == PC_BUFFER) && (state == CPS_OFF))
   {
      // Cannot turn off external memory buffer board
      state = CPS_ON;
   }

   if ((channel == PC_COOLER) && (state == CPS_ON))
   {
      // Cooler voltage verification
      state = CPS_OFF;

      FPA_GetStatus(&fpaStatus, &gFpaIntf);

      if ((fpaStatus.adc_ddc_detect_process_done == 1) &&
            (fpaStatus.adc_ddc_present == 1) &&
            (extAdcChannels[XEC_COOLER_SENSE].isValid))
      {
         cooler_volt__mV = (uint32_t)(*(extAdcChannels[XEC_COOLER_SENSE].p_physical) * 1000.0F);

         PM_DBG("Cooler supply voltage is %dmV (min = %dmV, max = %dmV).",
               cooler_volt__mV, fpaStatus.cooler_volt_min_mV, fpaStatus.cooler_volt_max_mV);

         if ((cooler_volt__mV >= fpaStatus.cooler_volt_min_mV) &&
               (cooler_volt__mV <= fpaStatus.cooler_volt_max_mV))
         {
            builtInTests[BITID_CoolerVoltageVerification].result = BITR_Passed;
            state = CPS_ON;
         }
         else
         {
            builtInTests[BITID_CoolerVoltageVerification].result = BITR_Failed;
         }
      }
   }

   regValue = XGpio_DiscreteRead(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT);

   if (state == CPS_ON)
   {
      regValue |= mask;
   }
   else
   {
      regValue &= ~mask;
   }

   XGpio_DiscreteWrite(&gPowerCtrl.GPIO, PGPIOC_POWER_MANAGEMENT, regValue);

   return state;
}

/**
 * Set analog measurement MUX address.
 *
 * @param p_powerCtrl is the pointer to the power manager data structure.
 * @param muxAddr is the analog measurement MUX address.
 */
void Power_SetMuxAddr(uint32_t muxAddr)
{
	XGpio_DiscreteWrite(&gPowerCtrl.GPIO, PGPIOC_ANALOG_MUX_ADDR, muxAddr);
}

/**
 * Update DeviceLedIndicatorState register according camera status and
 * update camera LED state if needed.
 *
 * @param p_powerCtrl is the pointer to the power manager data structure.
 * @param init indicates whether the function must initialize LED state.
 */
void Power_UpdateDeviceLedIndicatorState(ledCtrl_t *p_ledCtrl, uint8_t init)
{
   static uint64_t tic = 0;
   uint32_t prevDeviceLedIndicatorState;
   uint8_t busy;
   uint8_t error;
   uint8_t warning;

   if (elapsed_time_us(tic) > POWER_UPDATE_CAMERA_LED_STATE_PERIOD_US)
   {
      prevDeviceLedIndicatorState = gcRegsData.DeviceLedIndicatorState;

      if (gTestLed == 1)
      {
         gcRegsData.DeviceLedIndicatorState = gTestLedState;
      }
      else
      {
         busy = TDCStatusTstAny(WaitingForSensorMask |
               WaitingForInitMask |
               WaitingForICUMask |
               WaitingForNDFilterMask |
               WaitingForFilterWheelMask |
               WaitingForCalibrationDataMask |
               WaitingForImageCorrectionMask |
               WaitingForOutputFPGAMask |
               WaitingForPowerMask);

         error = TDCStatusTstAny(WaitingForValidParametersMask);

         warning = TDCStatusTstAny(WaitingForCalibrationInitMask | WaitingForFlashSettingsInitMask);

         if (busy)
         {
            gcRegsData.DeviceLedIndicatorState = DLIS_Busy;
         }
         else if (error)
         {
            gcRegsData.DeviceLedIndicatorState = DLIS_Error;
         }
         else if (warning && TDCStatusTst(AcquisitionStartedMask))
         {
            gcRegsData.DeviceLedIndicatorState = DLIS_WarningWhileStreaming;
         }
         else if (warning)
         {
            gcRegsData.DeviceLedIndicatorState = DLIS_Warning;
         }
         else if (gcRegsData.DevicePowerState == DPS_PowerStandby)
         {
            gcRegsData.DeviceLedIndicatorState = DLIS_Standby;
         }
         else if (TDCStatusTst(AcquisitionStartedMask))
         {
            gcRegsData.DeviceLedIndicatorState = DLIS_Streaming;
         }
         else
         {
            gcRegsData.DeviceLedIndicatorState = DLIS_Ready;
         }
      }

      if ((init) || (gcRegsData.DeviceLedIndicatorState != prevDeviceLedIndicatorState))
      {
         Power_UpdateCameraLedState(p_ledCtrl);
      }

      GETTIME(&tic);
   }
}

/**
 * Update camera LED state according to StealthMode and
 * DeviceLedIndicatorState registers.
 *
 * @param p_powerCtrl is the pointer to the power manager data structure.
 */
void Power_UpdateCameraLedState(ledCtrl_t *p_ledCtrl)
{
   cameraLedState_t ledState0 = CLS_OFF;
   cameraLedState_t ledState1 = CLS_OFF;
   uint64_t togglePeriod = 0;

   if (gcRegsData.StealthMode)
   {
      ledState0 = CLS_OFF;
      ledState1 = CLS_OFF;
      togglePeriod = 0;
   }
   else
   {
      switch (gcRegsData.DeviceLedIndicatorState)
      {
         case DLIS_Busy:
            ledState0 = CLS_YELLOW;
            ledState1 = CLS_OFF;
            togglePeriod = LED_BLINK_1HZ;
            break;

         case DLIS_Error:
            ledState0 = CLS_RED;
            ledState1 = CLS_OFF;
            togglePeriod = LED_BLINK_1HZ;
            break;

         case DLIS_WarningWhileStreaming:
            ledState0 = CLS_YELLOW;
            ledState1 = CLS_GREEN;
            togglePeriod = LED_BLINK_0_5HZ;
            break;

         case DLIS_Warning:
            ledState0 = CLS_YELLOW;
            ledState1 = CLS_YELLOW;
            togglePeriod = 0;
            break;

         case DLIS_Standby:
            ledState0 = CLS_RED;
            ledState1 = CLS_RED;
            togglePeriod = 0;
            break;

         case DLIS_Streaming:
            ledState0 = CLS_GREEN;
            ledState1 = CLS_OFF;
            togglePeriod = LED_BLINK_1HZ;
            break;

         case DLIS_Ready:
            ledState0 = CLS_GREEN;
            ledState1 = CLS_GREEN;
            togglePeriod = 0;
            break;
      }
   }

   Led_SetCameraLedBlinking(p_ledCtrl, ledState0, ledState1, togglePeriod);
}

void Power_ToggleDevicePowerState()
{
   // Toggle device power state
   switch (gcRegsData.DevicePowerState)
   {
      case DPS_PowerStandby:
         gcRegsData.DevicePowerStateSetpoint = DPSS_PowerOn;
         break;

      case DPS_PowerOn:
         gcRegsData.DevicePowerStateSetpoint = DPSS_PowerStandby;
         break;

      case DPS_PowerInTransition:
         // Do nothing
         break;
   }
}

/**
 * Power management state machine.
 */
void Power_SM()
{
   extern t_bufferManager gBufManager;
   static uint8_t startup = 1;

   switch (gcRegsData.DevicePowerState)
   {
      case DPS_PowerStandby:
         if (startup)
         {
            startup = 0;
            if (gcRegsData.PowerOnAtStartup)
            {
               gcRegsData.DevicePowerStateSetpoint = DPSS_PowerOn;
            }
         }

         if (gcRegsData.DevicePowerStateSetpoint == DPSS_PowerOn)
         {
            if (gPowerOnIsAllowed == 1)
            {
               PM_INF("Powering the camera...");
               // TODO Turn on FW.
               Acquisition_SetPowerState(DPSS_PowerOn);
               TDCStatusSet(WaitingForPowerMask);
               gcRegsData.DevicePowerState = DPS_PowerInTransition;
            }
            else
            {
               gcRegsData.DevicePowerStateSetpoint = DPSS_PowerStandby;
               PM_ERR("Power On is not allowed.");
            }
         }
         break;

      case DPS_PowerOn:
         if (gcRegsData.DevicePowerStateSetpoint == DPSS_PowerStandby)
         {
            PM_INF("Passing to standby mode...");
            // TODO Turn off FW.
            Acquisition_SetPowerState(DPSS_PowerStandby);
            TDCStatusSet(WaitingForPowerMask);
            gcRegsData.DevicePowerState = DPS_PowerInTransition;
         }
         break;

      case DPS_PowerInTransition:
         switch (gcRegsData.DevicePowerStateSetpoint)
         {
            case DPSS_PowerStandby:
               switch (Acquisition_GetPowerState())
               {
                  case DPS_PowerStandby:
                     BufferManager_ClearSequence(&gBufManager, &gcRegsData);
                     gcRegsData.DevicePowerState = DPS_PowerStandby;
                     if (gcRegsData.TestImageSelector == TIS_Off)
                     {
                        gcRegsData.TestImageSelector = gcRegsDataFactory.TestImageSelector;
                     }
                     TDCStatusClr(WaitingForPowerMask);
                     PM_INF("Device power state is Standby");

                     if (TDCFlagsTst(ImageCorrectionIsImplementedMask) && calibrationInfo.isValid)
                     {
                        ACT_invalidateActualizations(ACT_ALL);
                        // Reload the current calibration to revert actualization
                        Calibration_LoadCalibrationFilePOSIXTime(calibrationInfo.collection.POSIXTime);
                     }
                     break;

                  case DPS_PowerOn:
                     // Not supposed to get there
                     PM_ERR("Invalid acquisition power state.");
                     break;

                  case DPS_PowerInTransition:
                     // Power off is not done
                     break;
               }
               break;

            case DPSS_PowerOn:
               switch (Acquisition_GetPowerState())
               {
                  case DPS_PowerStandby:
                     gcRegsData.DevicePowerStateSetpoint = DPSS_PowerStandby;
                     gcRegsData.DevicePowerState = DPS_PowerStandby;
                     TDCStatusClr(WaitingForPowerMask);
                     PM_ERR("Power On failed, device power state is Standby");
                     break;

                  case DPS_PowerOn:
                     gcRegsData.DevicePowerState = DPS_PowerOn;
                     gcRegsData.TestImageSelector = TIS_Off;
                     TDCStatusClr(WaitingForPowerMask);
                     PM_INF("Device power state is On");

                     if (flashSettings.ImageCorrectionEnabled && flashSettings.ImageCorrectionAtPowerOn)
                     {
                        startActualization(true);
                     }
                     break;

                  case DPS_PowerInTransition:
                     // Power on is not done
                     break;
               }
               break;
         }
         break;
   }
}

void Power_CameraReset()
{
   Power_TurnOn(PC_SELFRESET);
   FPGA_PRINTF("Camera will be reset!\n");
}

/**
 * Power management push button interrupt handler.
 *
 * @param p_powerCtrl is the pointer to the power manager data structure.
 */
void Power_IntrHandler(powerCtrl_t *p_powerCtrl)
{
   if (!TDCStatusTst(WaitingForInitMask))
   {
      if (Power_GetPushButtonState() == PBS_RELEASED)
      {
         PM_DBG("Button released.");
         Power_ToggleDevicePowerState();
      }
      else
      {
         PM_DBG("Button pushed.");
      }
   }

   XGpio_InterruptClear(&p_powerCtrl->GPIO, PGPIOC_POWER_MANAGEMENT);
}
