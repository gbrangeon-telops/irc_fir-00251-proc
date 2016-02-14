/*-----------------------------------------------------------------------------
--
-- Author      : Patrick Daraiche (Tel-1000 base), then Simon Savary (TEL-2000)
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision$
-- $Author$
-- $LastChangedDate$
--
-------------------------------------------------------------------------------
--
-- File        : Faulhaber_Control.cpp
-- Description : Command interpreter for Faulhaber Motor positioning controller
--
-- Command Structure: Node Number, Command, Argument, CR.
--    Node Number is optional and is only required if several drives are being operated on one interface. Default 0
--    Command consists of a letter character string.
--    Argument is optional and consists of an ASCII numeric value
--    CR is Carriage Return, ASCII decimal code 13
--
------------------------------------------------------------------------------*/

#include "FaulhaberControl.h"
#include <string.h>

bool setPosition(FH_ctrl_t* data, int32_t pos, bool relative)
{
   uint8_t (*cmdfun)(uint8_t, int32_t, char *);
   const int numAck = 3;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   if (relative)
      cmdfun = LoadRelativePosition;
   else
      cmdfun = LoadAbsolutePosition;

   n += cmdfun(node, pos, (char*)&data->buffers.txBuffer[n]);

   n += NotifyPosition(node, (char*)&data->buffers.txBuffer[n]);

   n += InitiateMotion(node, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setNotificationPosition(FH_ctrl_t* data, int32_t notifPos)
{
   const int numAck = 1;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += NotifyPositionWithArg(node, notifPos, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setNotificationVelocity(FH_ctrl_t* data, int32_t notifVel)
{
   const int numAck = 1;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += NotifyVelocity(node, notifVel, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}


bool setPositionWithoutNotification(FH_ctrl_t* data, int32_t pos, bool relative)
{
   uint8_t (*cmdfun)(uint8_t, int32_t, char *);
   const int numAck = 2;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   if (relative)
      cmdfun = LoadRelativePosition;
   else
      cmdfun = LoadAbsolutePosition;

   n += cmdfun(node, pos, (char*)&data->buffers.txBuffer[n]);

   n += InitiateMotion(node, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setPositionWithEarlyNotify(FH_ctrl_t* data, int32_t pos, int32_t notifPos, bool relative)
{
   uint8_t (*cmdfun)(uint8_t, int32_t, char *);
   const int numAck = 3;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   if (relative)
      cmdfun = LoadRelativePosition;
   else
      cmdfun = LoadAbsolutePosition;

   n += cmdfun(node, pos, (char*)&data->buffers.txBuffer[n]);

   n += NotifyPositionWithArg(node, notifPos, (char*)&data->buffers.txBuffer[n]);

   n += InitiateMotion(node, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setVelocity(FH_ctrl_t* data, int32_t v)
{
   const int numAck = 2;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += NotifyVelocity(node, v, (char*)&data->buffers.txBuffer[n]);

   n += SetVelocity(node, v, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setVelocityWithoutNotification(FH_ctrl_t* data, int32_t v)
{
   const int numAck = 1;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += SetVelocity(node, v, (char*)&data->buffers.txBuffer[n]);
   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setEnableDrive(FH_ctrl_t* data, bool enable)
{
   const int numAck = 1;
   int n = data->buffers.txDataCount;
   uint8_t (*cmdfun)(uint8_t, char *);
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   if (enable)
      cmdfun = EnableDrive;
   else
      cmdfun = DisableDrive;

   n += cmdfun(node, (char*)&data->buffers.txBuffer[n]);
   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setControllerGain(FH_ctrl_t* data, uint8_t por, uint8_t integration, uint8_t positionGain, uint8_t Dterm, uint16_t MaxSpeed)
{
   const int numAck = 5;
   const uint8_t node = data->fh_data.id;;

   int n = data->buffers.txDataCount;

   if (data->buffers.txBusy)
      return false;

   n += SetPOR(node, por, (char*)&data->buffers.txBuffer[n]);
   n += SetInt(node, integration, (char*)&data->buffers.txBuffer[n]);
   n += SetPP(node, positionGain, (char*)&data->buffers.txBuffer[n]);
   n += SetPD(node, Dterm, (char*)&data->buffers.txBuffer[n]);
   n += SetSP(node, MaxSpeed, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setHomePosition(FH_ctrl_t* data, int32_t pos)
{
   const int numAck = 1;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += Home(node, (char*)&data->buffers.txBuffer[n]);
   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool queryPosition(FH_ctrl_t* data)
{
   const int numAck = 0;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += GetCurrentPosition(node, (char*)&data->buffers.txBuffer[n]);
   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool queryVelocity(FH_ctrl_t* data)
{
   const int numAck = 0;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += GetVelocity(node, (char*)&data->buffers.txBuffer[n]);
   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool initiateHomingSequence(FH_ctrl_t* data, uint8_t mask)
{
   const int numAck = 4;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += SetHomingArming(node, mask, (char*)&data->buffers.txBuffer[n]);
   n += SetHomingHardLimit(node, mask, (char*)&data->buffers.txBuffer[n]);
   n += SetHomingHardNotify(node, mask, (char*)&data->buffers.txBuffer[n]);
   n += HomingSequence(node, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool configurePositionLimits(FH_ctrl_t* data, int32_t cur_pos, int32_t pmin, int32_t pmax)
{
   const int numAck = 4;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += DefinePosition(node, cur_pos, (char*)&data->buffers.txBuffer[n]);
   n += SetPositionLimit(node, pmin, (char*)&data->buffers.txBuffer[n]);
   n += SetPositionLimit(node, pmax, (char*)&data->buffers.txBuffer[n]);
   n += SetAPL(node, true, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setEnablePositionLimits(FH_ctrl_t* data, bool enable)
{
   const int numAck = 1;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += SetAPL(node, enable, (char*)&data->buffers.txBuffer[n]);
   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

bool setCurrentLimits(FH_ctrl_t* data, uint16_t pc, uint16_t cc)
{
   const int numAck = 2;
   int n = data->buffers.txDataCount;
   const uint8_t node = data->fh_data.id;

   if (data->buffers.txBusy)
      return false;

   n += SetPC(node, pc, (char*)&data->buffers.txBuffer[n]);
   n += SetCC(node, cc, (char*)&data->buffers.txBuffer[n]);

   data->buffers.txDataCount += n;

   data->fh_data.numExpectedAck += numAck;

   return true;
}

void commandPreamble(uint8_t node, char *TxBuffer)
{
   TxBuffer[0] = node + 0x30; // To convert in ascii
   TxBuffer[1] = 0; // terminate string for strcat
}

uint8_t commandPostamble(char *TxBuffer)
{
   strcat(TxBuffer, CR_STR);

   return strlen(TxBuffer);
}

void commandInsertNumber(char* TxBuffer, int32_t val)
{
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)val);
}

uint8_t HomingSequence(uint8_t node, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);

   strcat(TxBuffer,"GOHOSEQ");

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t SetHomingArming(uint8_t node, uint8_t mask, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"SHA");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)mask);

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t SetHomingHardLimit(uint8_t node, uint8_t mask, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"SHL");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)mask);

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t SetHomingHardNotify(uint8_t node, uint8_t mask, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"SHN");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)mask);

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t HardLimit(uint8_t node, uint8_t mask, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"HL");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)mask);

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t HomeArming(uint8_t node, uint8_t mask, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"HA");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)mask);

   length = commandPostamble(TxBuffer);

   return length;
}


/*
 * Name         : LoadAbsolutePosition
 *
 * Synopsis     : uint8_t LoadAbsolutePosition(uint8_t node, int32_t pos, char *TxBuffer) 
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                int32_t  pos : absolute target position.
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Load new absolute target position
 *                Value: –1.8e9 ... 1.8e9
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t LoadAbsolutePosition(uint8_t node, int32_t pos, char *TxBuffer)
{
   const int max = 1800000000;
   const int min = -1800000000;

   uint8_t length;

   //Check lower limit
   pos = (pos < min) ? min : pos;

   //Check higher limit
   pos = (pos > max) ? max : pos;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"LA");

   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)pos);

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : LoadRelativePosition
 *
 * Synopsis     : uint8_t LoadRelativePosition(uint8_t node, int32_t pos, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                int32_t  pos : new relative target position.
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Load new relative target position, in relation to last started target
 *                position. The resulting absolute target position must lie between
 *                the values given below.
 *                Value: –2.14e9 ... 2.14e9
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t LoadRelativePosition(uint8_t node, int32_t pos, char *TxBuffer)
{
   const int max = 2140000000;
   const int min = -2140000000;

   uint8_t length;

   //Check lower limit
   pos = (pos < min) ? min : pos;

   //Check higher limit
   pos = (pos > max) ? max : pos;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"LR");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)pos);

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : InitiateMotion
 *
 * Synopsis     : uint8_t InitiateMotion(uint8_t node, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Activate position control and start positioning
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t InitiateMotion(uint8_t node, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"M");

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : GetActualPosition
 *
 * Synopsis     : uint8_t GetActualPosition(uint8_t node, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Current actual position
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t GetCurrentPosition(uint8_t node, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"POS");

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : SetVelocity
 *
 * Synopsis     : uint8_t SetVelocity(uint8_t node, int32_t velocity, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                int32_t  velocity : velocity in RPM
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Activate velocity mode and set specified value as target velocity
 *                (velocity control).
 *                Unit: rpm
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t SetVelocity(uint8_t node, int32_t velocity, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"V");
   
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)velocity);
   
   length = commandPostamble(TxBuffer);
   
   return length;
}

/*
 * Name         : GetVelocity
 *
 * Synopsis     : uint8_t GetVelocity(uint8_t node, uint8_t *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Current target velocity in rpm
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t GetVelocity(uint8_t node, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"GN");

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : DisableDrive
 *
 * Synopsis     : uint8_t DisableDrive(uint8_t node, char *TxBuffer) *
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Deactivate drive
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t DisableDrive(uint8_t node, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"DI");

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : EnableDrive
 *
 * Synopsis     : uint8_t EnableDrive(uint8_t node, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Activate drive
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t EnableDrive(uint8_t node, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"EN");

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : NotifyPosition
 *
 * Synopsis     : uint8_t NotifyPosition(uint8_t node, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : A 'p' is returned when the target position is attained
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t NotifyPosition(uint8_t node, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"NP");

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t NotifyPositionWithArg(uint8_t node, int32_t pos, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"NP");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)pos);

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : NotifyVelocity
 *
 * Synopsis     : uint8_t NotifyVelocity(uint8_t node, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                int32_t target velocity
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : A “v” is returned when the nominal speed is reached or passed through.
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t NotifyVelocity(uint8_t node, int32_t target, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"NV");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)target);

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t HardNotify(uint8_t node, uint8_t mask, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"HN");
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)mask);

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : Home with arg
 *
 * Synopsis     : uint8_t DefinePosition(uint8_t node, int32_t pos, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Define Current Position
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t DefinePosition(uint8_t node, int32_t pos, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"HO");

   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)pos);

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t SetAPL(uint8_t node, uint8_t apl, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   if (apl)
      strcat(TxBuffer,"APL1");
   else
      strcat(TxBuffer,"APL0");

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t SetPositionLimit(uint8_t node, int16_t pos, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"LL");

   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)pos);

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : Home
 *
 * Synopsis     : uint8_t Home(uint8_t node, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Define Home Position
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t Home(uint8_t node, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"HO");

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : FindHallIndex
 *
 * Synopsis     : uint8_t FindHallIndex(uint8_t node, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Find the index of a BL-4 pol motor
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t FindHallIndex(uint8_t node, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"FHIX");

   length = commandPostamble(TxBuffer);

   return length;
}

/*
 * Name         : SetPOR
 *
 * Synopsis     : uint8_t SetPOR(uint8_t node, uint8_t por, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                uint8_t  por : proportional term
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Set the porportional term for the controller
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t SetPOR(uint8_t node, uint8_t por, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"POR");
   
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)por);
   
   length = commandPostamble(TxBuffer);
   
   return length;
}

/*
 * Name         : SetInt
 *
 * Synopsis     : uint8_t SetInt(uint8_t node, uint8_t integration, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                uint8_t  integration : proportional term
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Set the integration term for the controller
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t SetInt(uint8_t node, uint8_t integration, char *TxBuffer)
{

   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"I");
   
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)integration);
   
   length = commandPostamble(TxBuffer);
   
   return length;
}

/*
 * Name         : SetPP
 *
 * Synopsis     : uint8_t SetPP(uint8_t node, uint8_t positionGain, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                uint8_t  positionGain : position controller gain
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Set the position controller gain for the controller
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t SetPP(uint8_t node, uint8_t positionGain, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"PP");
   
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)positionGain);
   
   length = commandPostamble(TxBuffer);
   
   return length;
}

/*
 * Name         : SetPD
 *
 * Synopsis     : uint8_t SetInt(uint8_t node, uint8_t Dterm, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                uint8_t  Dterm : proportional term
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Set position controller D-term for the controller
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t SetPD(uint8_t node, uint8_t Dterm, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"PD");
   
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)Dterm);
   
   length = commandPostamble(TxBuffer);
   
   return length;
}

/*
 * Name         : SetSP
 *
 * Synopsis     : uint8_t SetSP(uint8_t node, uint16_t MaxSpeed, char *TxBuffer)
 * Arguments    : uint8_t  node : 1 -> ICU, 2 -> NDF, 3 -> SFW
 *                uint16_t MaxSpeed : Maximal Speed
 *                char  *TxBuffer : pointer to a string buffer to send to controller
 *
 * Description  : Set Maximal Speed for the controller
 *
 * Returns      : uint8_t length of string to send
 */
uint8_t SetSP(uint8_t node, uint16_t MaxSpeed, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"SP");
   
   sprintf(TxBuffer + strlen(TxBuffer), "%d", (int)MaxSpeed);
   
   length = commandPostamble(TxBuffer);
   
   return length;
}

uint8_t SetCC(uint8_t node, uint16_t cc, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"LCC");

   sprintf(TxBuffer + strlen(TxBuffer), "%d", cc);

   length = commandPostamble(TxBuffer);

   return length;
}

uint8_t SetPC(uint8_t node, uint16_t pc, char *TxBuffer)
{
   uint8_t length;

   commandPreamble(node, TxBuffer);
   strcat(TxBuffer,"LPC");

   sprintf(TxBuffer + strlen(TxBuffer), "%d", pc);

   length = commandPostamble(TxBuffer);

   return length;
}
