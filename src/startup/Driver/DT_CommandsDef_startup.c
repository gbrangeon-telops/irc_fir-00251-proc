/**
 * @file DT_CommandsDef_startup.c
 *  Debug terminal startup commands implementation.
 *  
 *  This file implements the debug terminal startup commands.
 * 
 * $Rev: 18084 $
 * $Author: vreiher $
 * $Date: 2016-02-22 15:30:33 -0500 (lun., 22 févr. 2016) $
 * $Id: DT_CommandsDef.c 18084 2016-02-22 20:30:33Z vreiher $
 * $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2016-01-19%20Jig%20de%20Test/src/sw/DT_CommandsDef.c $
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "DT_CommandsDef_startup.h"
#include "DebugTerminal.h"

extern IRC_Status_t AutoTest_Routine(void);
extern netIntf_t gNetworkIntf;

/**
 * Debug terminal ATR command parser.
 * This parser is used to launch the automated tests routine.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t DebugTerminalParseATR(circByteBuffer_t *cbuf) {

   if (isRunningATR)
   {
      uint32_t value;
      uint16_t arglen;
      uint8_t  argStr[11];

      arglen = GetNextArg(cbuf, argStr, sizeof(argStr) - 1);
      if (arglen == 0)
      {
         DT_ERR("Invalid ATR command argument.");
         return IRC_FAILURE;
      }
      argStr[arglen] = '\0'; // Add string terminator
      // arglen does not include the string terminator to be used with ParseNumArg

      if (waitingForTI)
      {
         if (strcasecmp((char *)argStr, "EX") == 0) {
            waitingForTI = false;
            exitUnitaryTests = true;
            unitaryTestIndex = 0;            // Ensure testIndex is not ATID_Count, which would launch tests in batch mode
            return IRC_SUCCESS;
         }

         if (strcasecmp((char *)argStr, "BM") == 0) {
            waitingForTI = false;
            exitUnitaryTests = true;
            unitaryTestIndex = ATID_Count;   // Setting testIndex to ATID_Count launches all tests in batch mode.
            return IRC_SUCCESS;
         }

         if (ParseNumArg((char *)argStr, arglen, &value) != IRC_SUCCESS) {
            DT_ERR("Invalid value");
            return IRC_FAILURE;
         }
         else
         {
            waitingForTI = false;
            unitaryTestIndex = value;
            exitUnitaryTests = false;
            return IRC_SUCCESS;
         }
      }

      else {
         if (strcasecmp((char *)argStr, "BREAK") == 0) {
            ATR_INF("Aborting Batch Mode...");
            breakBatchMode = true;
            return IRC_SUCCESS;
         }
         else {
            DT_ERR("Unsupported command arguments.");
            return IRC_FAILURE;
         }
      }
   }

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments.");
      return IRC_FAILURE;
   }

   if (TDCStatusTst(WaitingForOutputFPGAMask))
   {
      DT_ERR("Cannot run Automated Tests: Network Interface is not Ready.");
      return IRC_FAILURE;
   }

   AutoTest_Routine();

   return IRC_SUCCESS;
}

/**
 * Debug terminal YES command parser.
 * This parser is used to enter a positive answer to a program query.
 *
 * @return IRC_SUCCESS if the program was waiting for a user answer.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseYES(circByteBuffer_t *cbuf) {

   if (!waitingForYN)
   {
      DT_ERR("Unknown command");
      return IRC_FAILURE;
   }

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Clear the query flag and set user's answer to YES
   userAns = true;
   waitingForYN = false;

   return IRC_SUCCESS;
}

/**
 * Debug terminal NO command parser.
 * This parser is used to enter a negative answer to a program query.
 *
 * @return IRC_SUCCESS if the program was waiting for a user answer.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseNO(circByteBuffer_t *cbuf) {

   if (!waitingForYN)
   {
      DT_ERR("Unknown command");
      return IRC_FAILURE;
   }

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Clear the query flag and set user's answer to NO
   userAns = false;
   waitingForYN = false;

   return IRC_SUCCESS;
}

/**
 * Debug terminal NULL command parser.
 * This parser is used to enter an acknowledge to a program query.
 *
 * @return IRC_SUCCESS if the program was waiting for user acknowledge.
 * @return IRC_FAILURE otherwise.
 */
IRC_Status_t DebugTerminalParseNULL(circByteBuffer_t *cbuf) {

   if (!waitingForNULL)
   {
      DT_ERR("Unknown command");
      return IRC_FAILURE;
   }

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   // Clear the query flag
   waitingForNULL = false;

   return IRC_SUCCESS;
}

/**
 * Debug terminal TRS command parser.
 * This parser is used by the Output FPGA to transmit automated test results
 * back to the Processing FPGA.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t DebugTerminalParseTRS(circByteBuffer_t *cbuf) {

   if (!waitingForTR)
   {
      DT_ERR("Unknown command");
      return IRC_FAILURE;
   }

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   oTestResult = IRC_SUCCESS;
   waitingForTR = false;

   return IRC_SUCCESS;
}

/**
 * Debug terminal TRF command parser.
 * This parser is used by the Output FPGA to transmit automated test results
 * back to the Processing FPGA.
 *
 * @return IRC_SUCCESS always.
 */
IRC_Status_t DebugTerminalParseTRF(circByteBuffer_t *cbuf) {

   if (!waitingForTR)
   {
      DT_ERR("Unknown command");
      return IRC_FAILURE;
   }

   if (!DebugTerminal_CommandIsEmpty(cbuf))
   {
      DT_ERR("Unsupported command arguments");
      return IRC_FAILURE;
   }

   oTestResult = IRC_FAILURE;
   waitingForTR = false;

   return IRC_SUCCESS;
}

