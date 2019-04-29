/*-----------------------------------------------------------------------------
--
-- Description : Faulhaber Motor Controller header file
--
-- Author   : PDA (TEL-1000), SSA (TEL-2000)
-- Company  : Telops inc.
--
-- $Revision$
-- $Author$
-- $LastChangedDate$
------------------------------------------------------------------------------*/

#ifndef FAULHABER_CONTROL_H
#define FAULHABER_CONTROL_H

#include "FaulhaberProtocol.h"

#include <stdint.h>
#include <stdbool.h>

#define FH_ABSOLUTE                          false
#define FH_RELATIVE                          true

// higher level sequence programs
bool setPosition(FH_ctrl_t* data, int32_t pos, bool relative);
bool setPositionWithoutNotification(FH_ctrl_t* data, int32_t pos, bool relative);
bool setPositionWithEarlyNotify(FH_ctrl_t* data, int32_t pos, int32_t notifPos, bool relative);
bool setNotificationPosition(FH_ctrl_t* data, int32_t notifPos);
bool setNotificationVelocity(FH_ctrl_t* data, int32_t notifVel);
bool setVelocity(FH_ctrl_t* data, int32_t v);
bool setVelocityWithoutNotification(FH_ctrl_t* data, int32_t v);
bool setEnableDrive(FH_ctrl_t* data, bool enable);
bool setControllerGain(FH_ctrl_t* data, uint8_t por, uint8_t integration, uint8_t positionGain, uint8_t Dterm, uint16_t MaxSpeed);
bool setHomePosition(FH_ctrl_t* data, int32_t pos);
bool initiateHomingSequence(FH_ctrl_t* data, uint8_t mask);
bool configurePositionLimits(FH_ctrl_t* data, int32_t pos, int32_t pmin, int32_t pmax);
bool setEnablePositionLimits(FH_ctrl_t* data, bool enable);
bool setCurrentLimits(FH_ctrl_t* data, uint16_t pc, uint16_t cc);

bool queryPosition(FH_ctrl_t* data);
bool queryVelocity(FH_ctrl_t* data);

// Low-level control Commands
uint8_t LoadAbsolutePosition(uint8_t node, int32_t pos, char *TxBuffer);
uint8_t LoadRelativePosition(uint8_t node, int32_t pos, char *TxBuffer);
uint8_t InitiateMotion(uint8_t node, char *TxBuffer);
uint8_t SetVelocity(uint8_t node, int32_t velocity, char *TxBuffer);
uint8_t DisableDrive(uint8_t node, char *TxBuffer);
uint8_t EnableDrive(uint8_t node, char *TxBuffer);
uint8_t NotifyPosition(uint8_t node, char *TxBuffer);
uint8_t NotifyPositionWithArg(uint8_t node, int32_t pos, char *TxBuffer);
uint8_t NotifyVelocity(uint8_t node, int32_t target, char *TxBuffer);
uint8_t Home(uint8_t node, char *TxBuffer);
uint8_t DefinePosition(uint8_t node, int32_t pos, char *TxBuffer);
uint8_t HomingSequence(uint8_t node, char *TxBuffer);
uint8_t SetHomingArming(uint8_t node, uint8_t mask, char *TxBuffer);
uint8_t SetHomingHardLimit(uint8_t node, uint8_t mask, char *TxBuffer);
uint8_t SetHomingHardNotify(uint8_t node, uint8_t mask, char *TxBuffer);
uint8_t HardLimit(uint8_t node, uint8_t mask, char *TxBuffer);
uint8_t HomeArming(uint8_t node, uint8_t mask, char *TxBuffer);
uint8_t HardNotify(uint8_t node, uint8_t mask, char *TxBuffer);
uint8_t FindHallIndex(uint8_t node, char *TxBuffer);
uint8_t SetPOR(uint8_t node, uint8_t por, char *TxBuffer);
uint8_t SetInt(uint8_t node, uint8_t integration, char *TxBuffer);
uint8_t SetPP(uint8_t node, uint8_t positionGain, char *TxBuffer);
uint8_t SetPD(uint8_t node, uint8_t Dterm, char *TxBuffer);
uint8_t SetSP(uint8_t node, uint16_t MaxSpeed, char *TxBuffer);
uint8_t SetAPL(uint8_t node, uint8_t apl, char *TxBuffer);
uint8_t SetPositionLimit(uint8_t node, int16_t pos, char *TxBuffer);
uint8_t SetCC(uint8_t node, uint16_t cc, char *TxBuffer);
uint8_t SetPC(uint8_t node, uint16_t pc, char *TxBuffer);

// Query Commands
uint8_t GetVelocity(uint8_t node, char *TxBuffer);
uint8_t GetCurrentPosition(uint8_t node, char *TxBuffer);
uint8_t GetCurrentTargetPosition(uint8_t node, char *TxBuffer);

#endif // FAULHABER_CONTROL_H
