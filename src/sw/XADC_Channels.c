/**
 *  @file XADC_Channels.c
 *  XADC and XSysmon channels implementation.
 *  
 *  This file implements the XADC and XSysmon channels.
 *  
 *  $Rev$
 *  $Author$
 *  $Date$
 *  $Id$
 *  $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#include "XADC_Channels.h"
#include "GC_Registers.h"
#include "calib.h"
#include "hder_inserter.h"
#include "utils.h"
#include "FlashSettings.h"
#include "RpOpticalProtocol.h"

#define XADC_CUR_OFFSET -0.0936084549572219f
#define XADC_CUR_GAIN   7.03f    //12.6619557089536f  --> EC

// Temperature coefficients
#define TempCoeff_A 0
#define TempCoeff_B 1
#define TempCoeff_C 2
#define TempCoeff_D 3

// Thermistor conversions factors
const float Conv_Fact_MC65[4][4] =
   // Range 0        Range 1        Range 2         Range 3
  {{3.3538646e-3F, 3.3540154e-3F, 3.3539264e-3F,  3.3368620e-3F}, //TempCoeff_A
   {2.5654090e-4F, 2.5627725e-4F, 2.5609446e-4F,  2.4057263e-4F}, //TempCoeff_B
   {1.9243889e-6F, 2.0829210e-6F, 1.9621987e-6F, -2.6687093e-6F}, //TempCoeff_C
   {1.0969244e-7F, 7.3003206e-8F, 4.6045930e-8F, -4.0719355e-7F}};//TempCoeff_D

const float Conv_Fact_USX3431[4][2] =
   // Range 0        Range 1
{{1.14288192250106e-3F, 1.13929600457259e-3F}, //TempCoeff_A
 {2.31314273877631e-4F, 2.31949467390149e-4F}, //TempCoeff_B
 {1.0934242301857e-7F, 1.05992476218967e-7F}, //TempCoeff_C
 {-7.25110851146496e-11F, -6.67898975192618e-11F}};//TempCoeff_D


void XADC_ThPhyConv(xadcChannel_t *xadcCh);
void XADC_ThPhyConv_USX3431(xadcChannel_t *xadcCh);
void XADC_ThPhyConv_MotorLens(xadcChannel_t *xadcCh);
void XADC_ThUpdated(xadcChannel_t *xadcCh);

// Array for xadc calibration voltage reference
float DeviceVoltageCalibrationAry[3] = {0.0F, 0.0F, 0.0F};

xadcChannel_t intAdcChannels[XIC_COUNT] =
{
   // {id,                 isValid, muxAddr, polarity,      unit,          raw,  voltOffset, voltGain,         voltage, phyOffset,        phyGain,       phyConverter,     p_physical,                                           callback}
   {XIC_TEMP,              0,       0xFF,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    -273.15f,         503.975f,      XADC_OGPhyConv,   &DeviceTemperatureAry[DTS_ProcessingFPGA],            NULL},
   {XIC_VCCINT,            0,       0xFF,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             3.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_ProcessingFPGA_VCCINT],         NULL},
   {XIC_VCCAUX,            0,       0xFF,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             3.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_ProcessingFPGA_VCCAUX],         NULL},
   {XIC_VREFP,             0,       0xFF,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             3.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_ProcessingFPGA_VREFP],          NULL},
   {XIC_VREFN,             0,       0xFF,    XCP_BIPOLAR,   XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             3.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_ProcessingFPGA_VREFN],          NULL},
   {XIC_VBRAM,             0,       0xFF,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             3.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_ProcessingFPGA_VBRAM],          NULL}
};                                                                                                                            

xadcChannel_t extAdcChannels[XEC_COUNT] =                                                                                     
{                                                                                                                             
   // {id,                 isValid, muxAddr, polarity,      unit,          raw,  voltOffset, voltGain,         voltage, phyOffset,        phyGain,       phyConverter,     p_physical,                                           callback}
   {XEC_INTERNAL_LENS,     0,       0x00,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_InternalLens],              XADC_ThUpdated},
   {XEC_EXTERNAL_LENS,     0,       0x01,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_ExternalLens],              XADC_ThUpdated},
   {XEC_ICU,               0,       0x02,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_InternalCalibrationUnit],   XADC_ThUpdated},
   {XEC_SFW,               0,       0x03,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_SpectralFilterWheel],       XADC_ThUpdated},
   {XEC_COMPRESSOR,        0,       0x04,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_Compressor],                XADC_ThUpdated},
   {XEC_COLD_FINGER,       0,       0x05,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_ColdFinger],                XADC_ThUpdated},
   {XEC_SPARE,             0,       0x06,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_Spare],                     XADC_ThUpdated},
   {XEC_EXT_THERMISTOR,    0,       0x07,    XCP_UNIPOLAR,  XCU_CELCIUS,   {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             0.0f,          XADC_ThPhyConv,   &DeviceTemperatureAry[DTS_ExternalThermistor],        XADC_ThUpdated},
   {XEC_COOLER_SENSE,      0,       0x08,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             144.7f / 4.7f, XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Cooler],                        NULL},
   {XEC_COOLER_CUR,        0,       0x09,    XCP_UNIPOLAR,  XCU_AMPERE,    {0},  0.0f,       1.0f / 65536.0f,  0.0F,    XADC_CUR_OFFSET,  XADC_CUR_GAIN, XADC_OGPhyConv,   &DeviceCurrentAry[DCS_Cooler],                        NULL},
   {XEC_24V_SENSE,         0,       0x0A,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             144.7f / 4.7f, XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Supply24V],                     NULL},
   {XEC_24V_CUR,           0,       0x0B,    XCP_UNIPOLAR,  XCU_AMPERE,    {0},  0.0f,       1.0f / 65536.0f,  0.0F,    XADC_CUR_OFFSET,  XADC_CUR_GAIN, XADC_OGPhyConv,   &DeviceCurrentAry[DCS_Supply24V],                     NULL},
   {XEC_USB_VBUS_SENSE,    0,       0x0C,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             5.7f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_USB_VBUS],                      NULL},
   {XEC_USB_1V8_SENSE,     0,       0x0D,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             2.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_USB1V8],                        NULL},
   {XEC_DDR3_VREF_SENSE,   0,       0x0E,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             1.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_DDR3_VREF],                     NULL},
   {XEC_VCC_10GigE_SENSE,  0,       0x0F,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             26.0f,         XADC_OGPhyConv,   &DeviceVoltageAry[DVS_VCC10GigE],                     NULL},
   {XEC_VCCAUX_IO_P_SENSE, 0,       0x10,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             5.7f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_VCCAUX_IO_P],                   NULL},
   {XEC_VCCAUX_IO_O_SENSE, 0,       0x11,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             5.7f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_VCCAUX_IO_O],                   NULL},
   {XEC_3V3_SENSE,         0,       0x12,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             5.7f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Supply3V3],                     NULL},
   {XEC_2V5_SENSE,         0,       0x13,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             5.7f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Supply2V5],                     NULL},
   {XEC_1V8_SENSE,         0,       0x14,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             2.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Supply1V8],                     NULL},
   {XEC_1V5_SENSE,         0,       0x15,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             2.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Supply1V5],                     NULL},
   {XEC_1V0MGT_SENSE,      0,       0x16,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             2.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_MGT1V0],                        NULL},
   {XEC_1V2MGT_SENSE,      0,       0x17,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             2.0f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_MGT1V2],                        NULL},
   {XEC_12V_SENSE,         0,       0x18,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             144.7f / 4.7f, XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Supply12V],                     NULL},
   {XEC_5V0_SENSE,         0,       0x19,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             5.7f,          XADC_OGPhyConv,   &DeviceVoltageAry[DVS_Supply5V],                      NULL},
   {XEC_ADC_REF_1,         0,       0x1A,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             1.0f,          XADC_OGPhyConv,   &DeviceVoltageCalibrationAry[DVCS_Ref0],              NULL},
   {XEC_ADC_REF_2,         0,       0x1B,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             1.0f,          XADC_OGPhyConv,   &DeviceVoltageCalibrationAry[DVCS_Ref1],              xadcCalibrationUpdate},
   {XEC_ADC_REF_3,         0,       0x1C,    XCP_UNIPOLAR,  XCU_VOLT,      {0},  0.0f,       1.0f / 65536.0f,  0.0F,    0.0f,             1.0f,          XADC_OGPhyConv,   &DeviceVoltageCalibrationAry[DVCS_Ref2],              NULL}
};


/*
 * XADC thermistor voltage value to physical unit value converter.
 *
 * @param xadcCh is the pointer to the XADC channel data structure to use for conversion.
 */
void XADC_ThPhyConv(xadcChannel_t *xadcCh)
{
   float Vth = xadcCh->voltage;
   float Rth_100K = 0;
   float Rth;
   int range;
   float partial_result;

   if (xadcCh->p_physical != NULL)
   {
      Rth_100K = (25000.0F * Vth) / ((DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] != 0 ? (DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] - DeviceVoltageAry[DVS_ProcessingFPGA_VREFN]) : 1.25F) - Vth);

      Rth = (Rth_100K * 100000.0F) / (100000.0F - Rth_100K);

      Rth = Rth / 10000.0F;              // Using 10K @ 25?C Thermistor
                                         // So Rt/R25 = 1.000 @ 25 ?C

      // Choice of range
      if((Rth <= 68.6F) && (Rth >= 3.274F))       // Select range
         range = 0;
      else if((Rth < 3.274F) && (Rth >= 0.36036F))
         range = 1;
      else if((Rth < 0.36036F) && (Rth >= 0.06831F))
         range = 2;
      else if((Rth < 0.06831F) && (Rth >= 0.01872F))
         range = 3;
      else
      {
         //TODO DEBUG XADC_ERR
         //XADC_ERR("ReadTemperature: Rth = %d mohms \n", (int32_t)(Rth * 1000.0F));
         Rth = 687000.0F;
         range = 0;
      }

      // a + b(Ln Rt/R25)
      partial_result =   Conv_Fact_MC65[TempCoeff_A][range] + (Conv_Fact_MC65[TempCoeff_B][range]*logf(Rth));

      // + c(Ln(Rt/R25))?
      partial_result += (Conv_Fact_MC65[TempCoeff_C][range]*powf(logf(Rth), 2));

      // + d(Ln(Rt/R25))?
      partial_result += (Conv_Fact_MC65[TempCoeff_D][range]*powf(logf(Rth), 3));

      *(xadcCh->p_physical) = K_TO_C(1.0F/partial_result);
   }
}

void XADC_ThPhyConv_USX3431(xadcChannel_t *xadcCh)
{
   float Vth = xadcCh->voltage;
   float Rth_100K = 0;
   float Rth;
   int range;
   float partial_result;

   if (xadcCh->p_physical != NULL)
   {
      Rth_100K = (25000.0F * Vth) / ((DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] != 0 ? (DeviceVoltageAry[DVS_ProcessingFPGA_VREFP] - DeviceVoltageAry[DVS_ProcessingFPGA_VREFN]) : 1.25F) - Vth);

      Rth = (Rth_100K * 100000.0F) / (100000.0F - Rth_100K);

      // Choice of range
      if(Rth <= 1751.73F)       // Select range
         range = 0;
      else if((Rth > 1751.73F) && (Rth <= 32650.00F))
         range = 1;
      else if(Rth > 32650.00F)
         range = 0;
      else
      {
         //TODO DEBUG XADC_ERR
         XADC_ERR("ReadTemperature: Rth = %d mohms \n", (int32_t)(Rth * 1000.0F));
         Rth = 687000.0F;
         range = 0;
      }

      // a + b(Ln Rt)
      partial_result =   Conv_Fact_USX3431[TempCoeff_A][range] +
                        (Conv_Fact_USX3431[TempCoeff_B][range]*logf(Rth));

      // + c(Ln(Rt))^3
      partial_result += (Conv_Fact_USX3431[TempCoeff_C][range]*powf(logf(Rth), 3));

      // + d(Ln(Rt))^5?
      partial_result += (Conv_Fact_USX3431[TempCoeff_D][range]*powf(logf(Rth), 5));

      *(xadcCh->p_physical) = K_TO_C(1.0F/partial_result);
   }
}

/*
 * Copy temperature feedback from motorized lens to physical value.
 * Voltage value from XADC is ignored.
 *
 * @param xadcCh is the pointer to the XADC channel data structure to use for conversion.
 */
void XADC_ThPhyConv_MotorLens(xadcChannel_t *xadcCh)
{
   extern rpCtrl_t theRpCtrl;

   if (xadcCh->p_physical != NULL)
   {
      *(xadcCh->p_physical) = (float)(theRpCtrl.currentResponseData.temperature);   // [°C]
   }
}

void XADC_ThUpdated(xadcChannel_t *xadcCh)
{
   extern t_HderInserter gHderInserter;
   extern t_calib gCal;

   if (xadcCh->isValid)
   {
      switch (xadcCh->id)
      {
         case XEC_INTERNAL_LENS:
            HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_InternalLens);
            CAL_UpdateDeltaF(&gCal);
            break;

         case XEC_EXTERNAL_LENS:
            HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_ExternalLens);
            break;

         case XEC_ICU:
            HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_InternalCalibrationUnit);
            break;

         case XEC_EXT_THERMISTOR:
            HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_ExternalThermistor);
            break;

         case XEC_SFW:
            HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_SpectralFilterWheel);
            break;

         case XEC_COMPRESSOR:
            HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_Compressor);
            break;

         case XEC_COLD_FINGER:
            HDER_UpdateTemperaturesHeader(&gHderInserter, DTS_ColdFinger);
            break;

         default:
            // Nothing to do for other external XADC channels
            return;
      }
   }
}


void xadcSetphyConverter(xadcChannel_t * xadcCh, thermistorModel_t ThermistorTypeId)
{
   switch( ThermistorTypeId)
   {
      case MC65F103A:
      default:
         xadcCh->phyConverter = XADC_ThPhyConv;
         break;
      case USX3431:
         xadcCh->phyConverter = XADC_ThPhyConv_USX3431;
         break;
      case MOTORLENS:
         xadcCh->phyConverter = XADC_ThPhyConv_MotorLens;
         break;
   }
}

void xadcCalibrationUpdate(xadcChannel_t *xadcCh)
{
   float gain = 0.0F;
   float offset = 0.0F;
   uint8_t i = 0;
   static bool firstpass = true;


   if (xadcCh->isValid)
   {
      //Check if the Flash setting reference value are available( not equal 0)
      // REf 1 should be 0.9765625Volt and Ref 2 = 0.099940 Volts
      if(flashSettings.XADCRefVoltage1 != 0.0f && flashSettings.XADCRefVoltage2 != 0.0f){
         //Process  the xadc gain offset calibration

         // m = (Ref1-Ref2) / (x1-x2)
         // b = Ref1 - (m * x1)
         gain = (flashSettings.XADCRefVoltage1 - flashSettings.XADCRefVoltage2 ) / (extAdcChannels[XEC_ADC_REF_1].raw.unipolar - extAdcChannels[XEC_ADC_REF_2].raw.unipolar);
         offset = flashSettings.XADCRefVoltage1 - (gain*extAdcChannels[XEC_ADC_REF_1].raw.unipolar);

         //Display new Gain offset
         if(firstpass)
         {
            firstpass = false;
            XADC_INF("Old Value   m = " _PCF(8) " Volt/count, b = "_PCF(8) " Volt", _FFMT(extAdcChannels[0].voltGain,8) , _FFMT(extAdcChannels[0].voltOffset,8));
            XADC_INF("New Value   m = " _PCF(8) " Volt/count, b = "_PCF(8) " Volt", _FFMT(gain,8) , _FFMT(offset,8) );
         }

         //Applied to all the external channel except the reference (XEC_ADC_REF_1 , 2 , 3)
         for (i=0; i < (XEC_COUNT - 3); i++){
            extAdcChannels[i].voltGain = gain;
            extAdcChannels[i].voltOffset = offset;
         }
      }
   }
}
