/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
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
-- Description : 
--
------------------------------------------------------------------------------*/

#include "GeniCam.h"
#include "fpa_intf.h"
#include "utils.h"
#include "IRC_status.h"
#include "CRC.h"
#include <math.h>
#include <string.h>

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

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_INT_END_TO_TRIG_START        0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR
 
#define FPA_XTRA_TRIG_FREQ_MAX_HZ         50        // en extra trig, rouler à au max 50 fps afin que meme en changemet de fenetre, le delai tri soit toujours respecté pour le détecteur 

// Gains  
#define FPA_GAIN_0                        0x00      // lowest gain
                               
 
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xE0      // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xE4      // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE              0xE8      // obligaoire pour les deteceteurs analogiques

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x18      // 0x18 -> FPA_ROIC_SCORPIO_MW . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33 .provient du fichier fpa_common_pkg.vhd


// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                      0xEC

// adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                   0xF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)  

#define VHD_INVALID_TEMP                  0xFFFFFFFF                                                  

// horloges du module FPA
#define VHD_CLK_100M_RATE_HZ              100000000

// horloge des ADCs
#define ADC_SAMPLING_RATE_HZ              18000000    // les ADC roulent à 18MHz

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2             // le gain est de 2 sur VREF

#define VHD_PIXEL_PIPE_DLY_SEC            500E-9        // delai max du pipe des pixels

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define SCORPIOMW_DET_BIAS_VOLTAGE_MIN_mV 500
#define SCORPIOMW_DET_BIAS_VOLTAGE_MAX_mV 1000

#define SCORPIOMWA_TAPREF_VOLTAGE_MIN_mV  510
#define SCORPIOMWA_TAPREF_VOLTAGE_MAX_mV  5310

#define SCORPIOMWA_REFOFS_VOLTAGE_MIN_mV  3000 
#define SCORPIOMWA_REFOFS_VOLTAGE_MAX_mV  6200  


  
// structure interne pour les parametres du scorpiomw
struct scorpiomw_param_s             //
{					   
   // parametres à rentrer
   float mlck_period_usec;
   float pclk_rate_hz;
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float fpa_reset_time_mclk;   
   
   // parametres calculés
   float readout_mclk;   
   float readout_usec;
   float fpa_delay_usec;
   float vhd_delay_usec;
   float delay_usec;
   float lovh_usec;
   float fovh_usec;
   float fpa_reset_time_usec;
   float int_signal_high_time_usec;
   float tri_min_usec;
   float frame_period_usec;
   float frame_rate_max_hz;
   float mode_int_end_to_trig_start_dly_usec;
   float mode_readout_end_to_trig_start_dly_usec;
};
typedef struct scorpiomw_param_s  scorpiomw_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);


void FPA_SpecificParams(scorpiomw_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);


// configuration à l'allumage du détecteur
gcRegistersData_t InitGCRegs;           // structure comportant la config d'initialisation du détecteur
uint8_t init_cfg_in_progress = 0;           // permet de signaler la configuration d'initialisation du détecteur


//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   init_cfg_in_progress = 1;                                                // la config qui s'en vient en est une d'initialisation du détecteur. Le VHD la stocke et programmera le dtecteur avec à l'allumage avant de faire quoi que ce soit
   InitGCRegs = *pGCRegs;
   InitGCRegs.TestImageSelector = 0;
   InitGCRegs.OffsetX = 0;
   InitGCRegs.OffsetY = 0;
   InitGCRegs.Width   = 640;
   InitGCRegs.Height  = 512;
   FPA_Reset(ptrA);
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, &InitGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour. placé en dernier lieu afin que la config d'initialisation soit latchée avant allumage du détecteur
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   init_cfg_in_progress = 0;                                                // fin de l'initialisation
}
 
//--------------------------------------------------------------------------
// pour reset des registres d'erreurs
//--------------------------------------------------------------------------
void  FPA_ClearErr(const t_FpaIntf *ptrA)
{
   AXI4L_write32(1, ptrA->ADD + AW_RESET_ERR);           //on active l'effacement
   AXI4L_write32(0, ptrA->ADD + AW_RESET_ERR);		      //on desactive l'effacement
}

//--------------------------------------------------------------------------
// pour reset du module
//--------------------------------------------------------------------------
// retenir qu'après reset, les IO sont en 'Z' après cela puisqu'on desactive le SoftwType dans le vhd. (voir vhd pour plus de details)
void  FPA_Reset(const t_FpaIntf *ptrA)
{
   uint8_t ii;
   for(ii = 0; ii <= 10 ; ii++)
   { 
      AXI4L_write32(1, ptrA->ADD + AW_CTRLED_RESET);             //on active le reset
   }
   for(ii = 0; ii <= 10 ; ii++)
   { 
      AXI4L_write32(0, ptrA->ADD + AW_CTRLED_RESET);             //on active l'effacement
   }
}
 
//--------------------------------------------------------------------------
// pour power down (power management)
//--------------------------------------------------------------------------
void  FPA_PowerDown(const t_FpaIntf *ptrA)
{
  FPA_Reset(ptrA);   
}
 
//--------------------------------------------------------------------------                                                                            
// pour configuer le bloc vhd FPA_interface et le lancer
//--------------------------------------------------------------------------
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{ 
   scorpiomw_param_t hh;
   //gcRegistersData_t localGCRegs;
   
   uint32_t Cmin, Cmax, Rmin, Rmax;
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t actualPolarizationVoltage = 700;      //  700 mV comme valeur par defaut pour GPOL
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   static float actualElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul 
   static float actualElectricalRefOffset = 0;      // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   extern int32_t gFpaDebugRegA, gFpaDebugRegB, gFpaDebugRegC, gFpaDebugRegD;
   
   // on bâtit les parametres specifiques du scorpiomw
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade) {              // mode diagnostique degradé lineaire
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR;
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsConstantValue1) {      // mode diagnostique avec valeur constante
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_CNST;
   }
   else if (pGCRegs->TestImageSelector == TIS_TelopsDynamicShade) {
      ptrA->fpa_diag_mode = 1;
      ptrA->fpa_diag_type = TELOPS_DIAG_DEGR_DYN;
   }
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on   = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config d'initialisation du détecteur ou non
   ptrA->fpa_init_cfg =  init_cfg_in_progress;
   ptrA->fpa_init_cfg_received =  0;     // ENO 15 oct. 2016: valeur sans importance. Le module  mb_intf.vhd génère convenablement cette valeur.
   
   // config du contrôleur de trigs
   ptrA->fpa_trig_ctrl_mode     = (uint32_t)MODE_INT_END_TO_TRIG_START;
   ptrA->fpa_acq_trig_ctrl_dly  = (uint32_t)((hh.mode_int_end_to_trig_start_dly_usec*1e-6F - (float)VHD_PIXEL_PIPE_DLY_SEC) * (float)VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_acq_trig_period_min   = (uint32_t)(0.5F*(hh.mode_int_end_to_trig_start_dly_usec*1e-6F)* (float)VHD_CLK_100M_RATE_HZ);   // periode min avec int_time = 0. Le Vhd y ajoutera le int_time reel
   ptrA->fpa_xtra_trig_ctrl_dly    = (uint32_t)((float)VHD_CLK_100M_RATE_HZ/(float)FPA_XTRA_TRIG_FREQ_MAX_HZ);
   ptrA->fpa_xtra_trig_period_min  = ptrA->fpa_acq_trig_period_min;
   
   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
   
   // direction de lecture
   ptrA->uprow_upcol = 1;      //  (uprow_upcol = 1 => uprow = 1 and upcol = 1) or (uprow_upcol = 0 => uprow = 0 and upcol = 0)
   if (init_cfg_in_progress == 1)
        ptrA->uprow_upcol = 1;
   
   // calculé specialement pour le ScorpioMW
   Cmin  = (uint32_t)pGCRegs->OffsetX/4;
   Cmax  = (uint32_t)pGCRegs->OffsetX/4 + (uint32_t)pGCRegs->Width/4 - 1;
   Rmin  = (uint32_t)pGCRegs->OffsetY;
   Rmax  = (uint32_t)pGCRegs->OffsetY + (uint32_t)pGCRegs->Height - 1;
    
   // config détecteur 
   if (ptrA->uprow_upcol == 1){   
      ptrA->windcfg_part1 = Rmin;
      ptrA->windcfg_part2 = Rmax;
      ptrA->windcfg_part3 = Cmin;
      ptrA->windcfg_part4 = Cmax;
   }
   else{   
      ptrA->windcfg_part1 = Rmax;
      ptrA->windcfg_part2 = Rmin;
      ptrA->windcfg_part3 = Cmax;
      ptrA->windcfg_part4 = Cmin;
   }
   
   //  windowing
   ptrA->sizea_sizeb = 0;           // 0 --> toujours en mode windowing
   if (((uint32_t)pGCRegs->Width == (uint32_t)FPA_WIDTH_MAX) && ((uint32_t)pGCRegs->Height == (uint32_t)FPA_HEIGHT_MAX))
      ptrA->sizea_sizeb = 1;        // mode pleine fenetre à l'initialisation

   //  itr
   ptrA->itr = 1;     // toujours en mode itr 
   if (init_cfg_in_progress == 1)
      ptrA->itr = 1;     // toujours en mode itr
       
   //  gain 
   ptrA->gain = FPA_GAIN_0;   	//Low gain only
      
    // GPOL voltage 
   if (gFpaDetectorPolarizationVoltage != actualPolarizationVoltage)      // gFpaDetectorPolarizationVoltage est en milliVolt
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)SCORPIOMW_DET_BIAS_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)SCORPIOMW_DET_BIAS_VOLTAGE_MAX_mV))
         ptrA->gpol_code = (int32_t) FLEG_VccVoltage_To_DacWord((float)gFpaDetectorPolarizationVoltage, 6);  // gpol_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
   }
   actualPolarizationVoltage = (int16_t)(FLEG_DacWord_To_VccVoltage((uint32_t)ptrA->gpol_code, 6));
   gFpaDetectorPolarizationVoltage = actualPolarizationVoltage;                        
   
   // ajustement de delais de la chaine
   ptrA->real_mode_active_pixel_dly = 4;                             //3
   
   // quad2
   ptrA->adc_quad2_en = 0;   //

   ptrA->chn_diversity_en = ptrA->adc_quad2_en;                      // 
   
   //
   ptrA->line_period_pclk                  = (ptrA->xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)+ hh.lovh_mclk) *  hh.pixnum_per_tap_per_mclk;
   ptrA->readout_pclk_cnt_max              = ptrA->line_period_pclk * (ptrA->ysize + hh.fovh_line) + 1;                    //
   
   ptrA->active_line_start_num             = 1;                    // pour le scorpiomw, numero de la première ligne active
   ptrA->active_line_end_num               = ptrA->ysize + ptrA->active_line_start_num - 1;          // pour le scorpiomw, numero de la derniere ligne active
   
   // nombre d'échantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch               = (uint32_t)((float)ADC_SAMPLING_RATE_HZ/(hh.pclk_rate_hz));
   
   // identificateurs de trames
   ptrA->sof_posf_pclk                     = ptrA->line_period_pclk * (ptrA->active_line_start_num - 1) + 1;
   ptrA->eof_posf_pclk                     = ptrA->active_line_end_num * ptrA->line_period_pclk - hh.lovh_mclk*hh.pixnum_per_tap_per_mclk;
   ptrA->sol_posl_pclk                     = 1;
   ptrA->eol_posl_pclk                     = (ptrA->xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk;
   ptrA->eol_posl_pclk_p1                  = ptrA->eol_posl_pclk + 1;

   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch        = ptrA->pix_samp_num_per_ch;     // position premier echantillon
   ptrA->good_samp_last_pos_per_ch         = ptrA->pix_samp_num_per_ch;     // position dernier echantillon
   ptrA->hgood_samp_sum_num                = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num                = ptrA->adc_quad2_en + 1;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
      
   // calculs
   ptrA->xsize_div_tapnum                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS;                                        
   
   // les DACs (1 à 8)
   ptrA->vdac_value[0]                     = FLEG_VccVoltage_To_DacWord(3300.0F, 1);      // VCC1 -> VDDA = 3300 mV
   ptrA->vdac_value[1]                     = FLEG_VccVoltage_To_DacWord(3600.0F, 2);      // VCC2 -> VDDO = 3600 mV
   ptrA->vdac_value[2]                     = FLEG_VccVoltage_To_DacWord(3400.0F, 3);      // VCC3 -> VLED = 3400 mV  // pour allumer la LED
   ptrA->vdac_value[3]                     = FLEG_VccVoltage_To_DacWord(3300.0F, 4);      // VCC4 -> VDD  = 3300 mV
   ptrA->vdac_value[4]                     = FLEG_VccVoltage_To_DacWord(3000.0F, 5);      // VCC5 -> VR   = 3000 mV
   ptrA->vdac_value[5]                     = ptrA->gpol_code;                             // VCC6 -> GPOL

   
   // Reference of the tap (VCC7 ou DAC6)      
   if (gFpaDetectorElectricalTapsRef != actualElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)SCORPIOMWA_TAPREF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)SCORPIOMWA_TAPREF_VOLTAGE_MAX_mV))
         ptrA->vdac_value[6] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 7);  // 
	}                                                                                                       
   actualElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ptrA->vdac_value[6], 7);            
   gFpaDetectorElectricalTapsRef = actualElectricalTapsRef;   
   
   // offset of the tap_reference (VCC8 ou DAC7)      
   if (gFpaDetectorElectricalRefOffset != actualElectricalRefOffset)
   {
      if ((gFpaDetectorElectricalRefOffset >= (float)SCORPIOMWA_REFOFS_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalRefOffset <= (float)SCORPIOMWA_REFOFS_VOLTAGE_MAX_mV))
         ptrA->vdac_value[7] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalRefOffset, 8);  // 
	}                                                                                                       
   actualElectricalRefOffset = (float) FLEG_DacWord_To_VccVoltage(ptrA->vdac_value[7], 8);            
   gFpaDetectorElectricalRefOffset = actualElectricalRefOffset;
   
   // adc_clk_phase
   ptrA->adc_clk_phase[0] = 11;
   ptrA->adc_clk_phase[1] = 11;
   
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   // reorder column
   ptrA->reorder_column = 0;
   if ((ptrA->fpa_diag_mode == 0)&&(ptrA->uprow_upcol == 0))  // en mode détecteur et avec uprow_upcol=0 le scorpioMW inverse les colonnes
      ptrA->reorder_column = 1;
      
   WriteStruct(ptrA);
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage;
   float temperature;
   
   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le présent mais le passé) 
   raw_temp = (raw_temp & 0x0000FFFF);

   diode_voltage = (float)raw_temp*((float)FPA_TEMP_READER_FULL_SCALE_mV/1000.0F)/(powf(2.0F, FPA_TEMP_READER_ADC_DATA_RES)*(float)FPA_TEMP_READER_GAIN);

// courbe de conversion de Sofradir pour une polarisation de 25µA   
   temperature  =  -302.64F * powf(diode_voltage,4);
   temperature +=   687.45F * powf(diode_voltage,3);
   temperature +=  -595.36F * powf(diode_voltage,2);
   temperature += (-188.47F * diode_voltage) + 490.33F;

   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au scorpiomw avec une config
//--------------------------------------------------------------------------
void FPA_SpecificParams(scorpiomw_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // parametres statiques
   ptrH->mlck_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 1.0F;
   ptrH->fpa_reset_time_mclk     = 3076.0F;
   ptrH->fpa_delay_mclk          = 4.0F + pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->fpa_reset_time_mclk;   // FPA: estimation delai max de sortie des pixels après integration + delai après readout
   ptrH->vhd_delay_mclk          = (float)VHD_PIXEL_PIPE_DLY_SEC * (float)FPA_MCLK_RATE_HZ;   // estimation des differerents delais accumulés par le vhd
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 0.0F;
   ptrH->fovh_line               = 0.0F;   
   ptrH->pclk_rate_hz            = ptrH->pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ;
      
   // readout time
   ptrH->readout_mclk         = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mlck_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mlck_period_usec;
   ptrH->fpa_delay_usec       = ptrH->fpa_delay_mclk * ptrH->mlck_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mlck_period_usec; 
   
   // integration time/signal
   ptrH->fpa_reset_time_usec  = ptrH->fpa_reset_time_mclk * ptrH->mlck_period_usec;
   ptrH->int_signal_high_time_usec = exposureTime_usec + ptrH->fpa_reset_time_usec;
      
   // calcul de la periode minimale
   ptrH->frame_period_usec = exposureTime_usec + ptrH->delay_usec + ptrH->readout_usec;  

   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);

   //autres calculs
   ptrH->mode_int_end_to_trig_start_dly_usec = ptrH->frame_period_usec - ptrH->int_signal_high_time_usec;  // utilisé en mode int_end_trig_start. // pour le scorpiomW, ptrH->fpa_reset_time_usec est vu dans le vhd comme un prolongement du temps d'integration
   ptrH->mode_readout_end_to_trig_start_dly_usec = 0.0F;                                                   // utilisé en mode readout_end_trig_start
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   scorpiomw_param_t hh;
   
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   
   // ENO: 10 sept 2016: Apply margin 
   MaxFrameRate = hh.frame_rate_max_hz * (1.0F - gFpaPeriodMinMargin);
   
   // Round maximum frame rate
   MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

   return MaxFrameRate;                          
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   scorpiomw_param_t hh;
   float periodMinWithNullExposure_usec;
   float actualPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;
   
   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);
   
   // ENO: 10 sept 2016: tout reste inchangé
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   periodMinWithNullExposure_usec = hh.frame_period_usec;
   actualPeriod_sec = 1.0F/fpaAcquisitionFrameRate; // periode avec le frame rate actuel.
   
   max_exposure_usec = (actualPeriod_sec*1e6F - periodMinWithNullExposure_usec);

   // Round exposure time
   max_exposure_usec = floorMultiple(max_exposure_usec, 0.1);
     
   // Limit exposure time
   max_exposure_usec = MIN(MAX(max_exposure_usec, pGCRegs->ExposureTimeMin), FPA_MAX_EXPOSURE);
   
   return max_exposure_usec;
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir les statuts au complet
//--------------------------------------------------------------------------
void FPA_GetStatus(t_FpaStatus *Stat, const t_FpaIntf *ptrA)
{ 
   uint32_t temp_32b;
   uint32_t temp_init_done;
   
   Stat->adc_oper_freq_max_khz   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x00);    
   Stat->adc_analog_channel_num  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x04);   
   Stat->adc_resolution          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x08);   
   Stat->adc_brd_spare           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x0C);  
   Stat->ddc_fpa_roic            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x10);    
   Stat->ddc_brd_spare           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x14);  
   Stat->flex_fpa_roic           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x18);   
   Stat->flex_fpa_input          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x1C);        
   Stat->flex_ch_diversity_num   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x20);                        
   Stat->cooler_volt_min_mV      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x24); 
   Stat->cooler_volt_max_mV      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x28); 
   Stat->fpa_temp_raw            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x2C);                                
   Stat->global_done             = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x30);        
   Stat->fpa_powered             = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x34);        
   Stat->cooler_powered          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x38);                                     
   Stat->errors_latchs           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x3C);
   Stat->adc_ddc_detect_process_done   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x50);
   Stat->adc_ddc_present               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x54);
   Stat->flex_detect_process_done      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x58);
   Stat->flex_present                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x5C);
   Stat->id_cmd_in_error               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x60);
   Stat->fpa_serdes_done               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x64);
   Stat->fpa_serdes_success            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x68);
   temp_32b                            = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x6C);
   memcpy(Stat->fpa_serdes_delay, (uint8_t *)&temp_32b, sizeof(Stat->fpa_serdes_delay));
   Stat->fpa_serdes_edges[0]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x70);
   Stat->fpa_serdes_edges[1]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x74);
   Stat->fpa_serdes_edges[2]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x78);
   Stat->fpa_serdes_edges[3]           = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x7C);
   temp_init_done                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->fpa_init_success              = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
   
   Stat->prog_init_done                = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x88);
   Stat->fpa_init_done                 = temp_init_done & Stat->prog_init_done;     // pour le scorpiomwA, la programmation de la configuration d'initialisation est un prérequis avant de faire quoi que ce soit.

   Stat->cooler_on_curr_min_mA         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x8C);
   Stat->cooler_off_curr_max_mA        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x90);
}


//////////////////////////////////////////////////////////////////////////////                                                                          
//  I N T E R N A L    F U N C T I O N S 
////////////////////////////////////////////////////////////////////////////// 

//--------------------------------------------------------------------------
// Informations sur les drivers C utilisés. 
//--------------------------------------------------------------------------
void  FPA_SoftwType(const t_FpaIntf *ptrA)
{
   AXI4L_write32(FPA_ROIC, ptrA->ADD + AW_FPA_ROIC_SW_TYPE);          
   AXI4L_write32(FPA_OUTPUT_TYPE, ptrA->ADD + AW_FPA_OUTPUT_SW_TYPE);
   AXI4L_write32(FPA_INPUT_TYPE, ptrA->ADD + AW_FPA_INPUT_SW_TYPE);
}

//--------------------------------------------------------------------------
// Conversion de VccVoltage_mV en DAC Word 
//-------------------------------------------------------------------------- 
// VccVoltage_mV : en milliVolt, tension de sortie des LDO du FLeG 
// VccPosition   : position du LDO . Attention! VccPosition = FLEG_VCC_POSITION où FLEG_VCC_POSITION est la position sur le FLEG (il va de 1 à 8) 
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition)
{  
  float Rs, Rd, RL, Is, DacVoltage_Volt;
  uint32_t DacWord;
   
   if ((VccPosition == 1) || (VccPosition == 2) || (VccPosition == 3) || (VccPosition == 8)){   // les canaux VCC1, VCC2, VCC3 et VCC8 sont identiques à VCC1
      Rs = 24.9e3F;    // sur EFA-00266-001, vaut R42
      Rd = 1000.0F;    // sur EFA-00266-001, vaut R41
      RL = 3.01e3F;    // sur EFA-00266-001, vaut R35
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   else{                                                   // les canaux VCC4, VCC5, VCC6, et VCC7 sont identiques à VCC4
      Rs = 4.99e3F;    // sur EFA-00266-001, vaut R30
      Rd = 24.9F;      // sur EFA-00266-001, vaut R29
      RL = 806.0F;     // sur EFA-00266-001, vaut R28
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   // calculs de la tension du dac en volt
   DacVoltage_Volt =  ((1.0F + RL/Rd)*VccVoltage_mV/1000.0F - (Rs + RL + RL/Rd*Rs)*Is)/(RL/Rd);
            
   // deduction du bitstream du DAC
   DacWord = (uint32_t)(powf(2.0F, (float)FLEG_DAC_RESOLUTION_BITS)*DacVoltage_Volt/((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN));
   DacWord = (uint32_t) MAX(MIN(DacWord, 16383), 0);
   
   return DacWord;
}

//--------------------------------------------------------------------------
// Conversion de DAC Word  en VccVoltage_mV
//-------------------------------------------------------------------------- 
// VccVoltage_mV : en milliVolt, tension de sortie des LDO du FLeG 
// VccPosition   : position du LDO . Attention! VccPosition = FLEG_VCC_POSITION où FLEG_VCC_POSITION est la position sur le FLEG (il va de 1 à 8) 
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition)
{  
   float Rs, Rd, RL, Is, DacVoltage_Volt, VccVoltage_mV;
   uint32_t DacWordTemp;
   
   if ((VccPosition == 1) || (VccPosition == 2) || (VccPosition == 3) || (VccPosition == 8)){   // les canaux VCC1, VCC2, VCC3 et VCC8 sont identiques à VCC1
      Rs = 24.9e3F;    // sur EFA-00266-001, vaut R42
      Rd = 1000.0F;    // sur EFA-00266-001, vaut R41
      RL = 3.01e3F;    // sur EFA-00266-001, vaut R35
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   else{                                                   // les canaux VCC4, VCC5, VCC6, et VCC7 sont identiques à VCC4
      Rs = 4.99e3F;    // sur EFA-00266-001, vaut R30
      Rd = 24.9F;      // sur EFA-00266-001, vaut R29
      RL = 806.0F;     // sur EFA-00266-001, vaut R28
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   
   // deduction de la tension du DAC 
   DacWordTemp =  (uint32_t) MAX(MIN(DacWord, 16383), 0);   
   DacVoltage_Volt = (float)DacWordTemp * ((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN)/powf(2.0F, (float)FLEG_DAC_RESOLUTION_BITS);
   
   //calculs de la tension du LDO en volt
   VccVoltage_mV = 1000.0F * (DacVoltage_Volt * (RL/Rd) + (Rs + RL + RL/Rd*Rs)*Is)/(1.0F + RL/Rd);
   
   return VccVoltage_mV;
}
