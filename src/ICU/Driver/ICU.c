#include "ICU.h"

#include "utils.h"
#include "Genicam.h"
#include "xintc.h"
#include "mb_axi4l_bridge.h"

#include "flashSettings.h"
#include "Timer.h"
#include "HwRevision.h"

#include <stdbool.h>

// ICU current position
enum ICU_POSITION_enum
{
	ICU_POSITION_OFF = 0,
	ICU_POSITION_SCENE = 1,
	ICU_POSITION_CALIB = 2,
	ICU_POSITION_MOVING = 3
};

enum ICU_SETPOINT_enum
{
	ICU_SETPOINT_OFF = 0,
	ICU_SETPOINT_SCENE = 1,
	ICU_SETPOINT_CALIB = 2
};

extern ICU_config_t gICU_ctrl;
extern brd_rev_ver_t gBrdRevid;

static bool reset = true;

static timerData_t refreshRateTimer;

/***************************************************************************//**
   Initializes the ICU module.

   @param pGCRegs Pointer to the Genicam registers

   @return void

*******************************************************************************/
IRC_Status_t ICU_init(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl)
{
	IRC_Status_t retval = IRC_SUCCESS;

	pICU_ctrl->ICU_CalibPolarity = flashSettings.ICUCalibPosition;
	pICU_ctrl->ICU_Mode = flashSettings.ICUMode;
	pICU_ctrl->ICU_Period = flashSettings.ICUPeriod * ICU_CLK_PER_MS;
	pICU_ctrl->ICU_PulseWidth = flashSettings.ICUPulseWidth * ICU_CLK_PER_MS;
	pICU_ctrl->ICU_TransitionDuration = flashSettings.ICUTransitionDuration * ICU_CLK_PER_MS;

	// Check brd revision to know if we are using Si9986 or DRV8871 h-bridge
	if(gBrdRevid == BRD_REV_20x)
	{
      AXI4L_write32((uint32_t)1, pICU_ctrl->ADD + ICU_BRAKEPOLARITY_OFFSET); // DRV8871 h-bridge brake on  In1-in2 = '1'

	}
	else
	{
	   AXI4L_write32((uint32_t)0, pICU_ctrl->ADD + ICU_BRAKEPOLARITY_OFFSET);  // Si9986 h-birdge brake on InA-InB = '0'
	}

	// send config
	WriteStruct(pICU_ctrl);

	// set initial shutter position according to the genicam register
	// start the state machine
	ICU_setpointUpdated(pGCRegs, pICU_ctrl);

	return retval;
}

/***************************************************************************//**
   Put the ICU module out of place

   @return void

*******************************************************************************/
void ICU_scene(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl)
{
   ICU_INF("Scene mode");
	pGCRegs->ICUPositionSetpoint = ICUPS_Scene;
	ICU_setpointUpdated(pGCRegs, pICU_ctrl);
}

/***************************************************************************//**
   Put the ICU module in the OFF state

   @return void

*******************************************************************************/
void ICU_off(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl)
{
   ICU_INF("Off");
	AXI4L_write32((uint32_t)ICU_SETPOINT_OFF, pICU_ctrl->ADD + ICU_PULSE_CMD_OFFSET);
	pGCRegs->ICUPosition = ICUP_ICUNotImplemented;
}

/***************************************************************************//**
   Put the ICU module in place

   @return void

*******************************************************************************/
void ICU_calib(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl)
{
   ICU_INF("Calibration mode");
	pGCRegs->ICUPositionSetpoint = ICUPS_InternalCalibrationUnit;
	ICU_setpointUpdated(pGCRegs, pICU_ctrl);
}

/***************************************************************************//**
   Callback function following a write for ICUPositionSetpoint. The ICUPosition register
   and WaitingForICUMask are modified by this function.

   @return void

*******************************************************************************/
void ICU_setpointUpdated(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl)
{
	if (flashSettings.ICUPresent)
	{
		switch (pGCRegs->ICUPositionSetpoint)
		{
			case ICUPS_Scene:
				AXI4L_write32((uint32_t)ICU_SETPOINT_SCENE, pICU_ctrl->ADD + ICU_PULSE_CMD_OFFSET);
				// explicitly set to transition state ; only if current position is different
				if (pGCRegs->ICUPosition != ICUP_Scene)
					pGCRegs->ICUPosition = ICUP_ICUInTransition;
				break;
			case ICUPS_InternalCalibrationUnit:
				AXI4L_write32((uint32_t)ICU_SETPOINT_CALIB, pICU_ctrl->ADD + ICU_PULSE_CMD_OFFSET);

				// explicitly set to transition state ; only if current position is different
				if (pGCRegs->ICUPosition != ICUP_InternalCalibrationUnit)
					pGCRegs->ICUPosition = ICUP_ICUInTransition;
				break;
			default:
				;
		}
	}
	else
	{
		AXI4L_write32((uint32_t)ICU_SETPOINT_OFF, pICU_ctrl->ADD + ICU_PULSE_CMD_OFFSET);
      pGCRegs->ICUPosition = ICUP_ICUNotImplemented;
	}

	// since we explicitly modified ICUPosition, we must update the WaitingForICUMask
	// according to the current position, bypassing ICU_getCurrentState()
	if (pGCRegs->ICUPosition == ICUP_ICUInTransition)
		TDCStatusSet(WaitingForICUMask);
	else
		TDCStatusClr(WaitingForICUMask);
}

/***************************************************************************//**
   Callback function upon reading the ICUPosition register. Requests the current
   status using an AXI-lite transaction and updates the ICUPosition GenICam register.

   WaitingForICUMask is modified by this function.

   @return void
*******************************************************************************/
void ICU_getCurrentState(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl)
{
	uint32_t state = AXI4L_read32(pICU_ctrl->ADD + ICU_POSITION_OFFSET);
	uint32_t gc_status;

	if (flashSettings.ICUPresent)
	{
		switch (state)
		{
		case ICU_POSITION_SCENE:
			gc_status = (uint32_t)ICUP_Scene;
			break;
		case ICU_POSITION_CALIB:
			gc_status = (uint32_t)ICUP_InternalCalibrationUnit;
			break;
		case ICU_POSITION_MOVING:
			gc_status = (uint32_t)ICUP_ICUInTransition;
			break;
		case ICU_POSITION_OFF:
		default:
			gc_status = (uint32_t)ICUP_ICUNotImplemented;
		}
	}
	else
	{
		gc_status = (uint32_t)ICUP_ICUNotImplemented;
	}

	// update the actual register
	pGCRegs->ICUPosition = gc_status;

	// update the WaitingForICUMask according to the current position
	if (pGCRegs->ICUPosition == ICUP_ICUInTransition)
		TDCStatusSet(WaitingForICUMask);
	else
		TDCStatusClr(WaitingForICUMask);
}

/***************************************************************************//**
   This function is periodically called by the ICU_process
   function. This function calls ICU_getCurrentState(). It updates the ICU position
   in the header whenever the ICU status changes (and only when it changes).

   @return void
*******************************************************************************/
void ICU_updateHeader(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl, const t_HderInserter *a)
{
	static int8_t prev_position = -1;

	// read the current status from the controller
	ICU_getCurrentState(pGCRegs, pICU_ctrl);

	// fill in the header entry corresponding to the current ICU position
	// -> send only when its value has changed, to minimise the number of write operations to the header inserter
	if (prev_position != (uint8_t)pGCRegs->ICUPosition)
		HDER_UpdateICUPositionHeader(a, (uint8_t)pGCRegs->ICUPosition);

	prev_position = (uint8_t)pGCRegs->ICUPosition;
}

/***************************************************************************//**
   This function is the main ICU bookkeeper, periodically called by the main
   processing loop. This function calls ICU_getCurrentState().

   This function executes its core at a rate of at most ICU_STATUS_REFRESH_RATE

   @return void
*******************************************************************************/
void ICU_process(gcRegistersData_t *pGCRegs, ICU_config_t *pICU_ctrl, t_HderInserter* hderInserter)
{
   if (reset)
   {
      reset = false;
      StartTimer(&refreshRateTimer, ICU_STATUS_REFRESH_RATE);
   }

   if (TimedOut(&refreshRateTimer))
   {
      RestartTimer(&refreshRateTimer);
      ICU_updateHeader(pGCRegs, pICU_ctrl, hderInserter);
   }
}
