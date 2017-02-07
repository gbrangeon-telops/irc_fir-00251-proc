/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 12286 $
-- $Author: pdaraiche $
-- $LastChangedDate: 2013-01-25 14:24:16 -0500 (ven., 25 janv. 2013) $
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


// Periode minimale des xtratrigs (utilisé par le hw pour avoir le temps de programmer le détecteur entre les trigs. Commande operationnelle et syhthetique seulement)
#define XTRA_TRIG_FREQ_MAX_HZ             10        // soit une frequence de 10Hz         
  
// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_INT_END_TO_TRIG_START        0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR

// Gains definis par Indigo  
#define FPA_GAIN_0                        0x00      // High gain
#define FPA_GAIN_1                        0x01      // Low gain                               
 
// la structure Command_t a 4 bytes d'overhead(CmdID et CmdCharNum)

// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xE0      // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xE4      // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE              0xE8      // obligaoire pour les deteceteurs analogiques

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             (0x0FFC | AW_SERIAL_CFG_SWITCH_ADD)   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x12      // 0x12 -> 0207 . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL
#define FPA_INPUT_TYPE                    0x03      // 0x03 -> input LVTTL50 .provient du fichier fpa_common_pkg.vhd. La valeur 0x03 est celle de LVTTL50


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
#define VHD_CLK_80M_RATE_HZ                80000000
#define ADC_SAMPLING_RATE_HZ               40000000    // les ADC  roulent à 40MHz

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2             // le gain est de 2 sur VREF

#define TEST_PATTERN_LINE_DLY             12            // J'Estime que mon patron de test actuel a besoin de 12 clks de 10 ns entre chaque ligne.

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define ISC0207_REF_VOLTAGE_MIN_mV        1700
#define ISC0207_REF_VOLTAGE_MAX_mV        4500

#define ISC0207_VDETCOM_VOLTAGE_MIN_mV    1700
#define ISC0207_VDETCOM_VOLTAGE_MAX_mV    5300

#define ISC0207_REFOFS_VOLTAGE_MIN_mV     502
#define ISC0207_REFOFS_VOLTAGE_MAX_mV     2500


// structure interne pour les parametres du 0207
struct isc0207_param_s             // 
{					   
   float mlck_period_usec;                       
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_mclk;
   float tsh_min_usec;
   float trst_min_usec;
   float itr_tri_min_usec;
   float int_time_offset_usec;
   
   float readout_mclk;
   float readout_usec;
   float fpa_delay_usec;
   float vhd_delay_usec;
   float delay_usec;
   float fsync_high_min_usec;
   float fsync_low_usec;
   float tri_int_part_usec;
   float tri_window_part_usec;
   float tri_window_and_intmode_part_usec;
   float tri_min_usec;
   float frame_period_min_usec;
   float frame_rate_max_hz;       
};
typedef struct isc0207_param_s  isc0207_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);



void FPA_SpecificParams(isc0207_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   FPA_Reset(ptrA);
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
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
//pour configuer le bloc vhd FPA_interface et le lancer
//--------------------------------------------------------------------------
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs)
{ 
   isc0207_param_t hh;   
   uint32_t test_pattern_dly;
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t actualPolarizationVoltage = 700;      //  700 mV comme valeur par defaut pour GPOL
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   extern int32_t gFpaDebugRegA, gFpaDebugRegB, gFpaDebugRegC, gFpaDebugRegD;
   static float actualElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul 
   static float actualElectricalRefOffset = 0;      // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   uint8_t FPA_proxim_is_flegx;
   
   t_FpaStatus Stat;
	
  
   // on lit le statut 
   FPA_GetStatus(&Stat, ptrA);
	FPA_proxim_is_flegx = (uint8_t)(Stat.adc_brd_spare & 0x01);    // on sait quelle electronique de proximité est présente (FlegX eou Flex)
   
   
   
   // on bâtit les parametres specifiques du 0207
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul . Mais le VHD ajoutera le int_time pour avoir la vraie periode
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade) {               // mode diagnostique degradé lineaire
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
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_INT_END_TO_TRIG_START;  // permet de supporter le mode ITR et IWR et la pleine vitesse 
   ptrA->fpa_acq_trig_ctrl_dly     = 0;   // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculé dans le vhd à partir du temps d'integration
   ptrA->fpa_acq_trig_period_min   = 0;   // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculé dans le vhd à partir du temps d'integration
   ptrA->fpa_xtra_trig_period_min  = 0;   // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculé dans le vhd à partir du temps d'integration
   ptrA->fpa_xtra_trig_ctrl_dly    = 0;   // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculé dans le vhd à partir du temps d'integration
   
   // parametres envoyés au VHD pour calculer fpa_acq_trig_ctrl_dly, fpa_acq_trig_period_min, fpa_xtra_trig_period_min, fpa_xtra_trig_ctrl_dly
   ptrA->readout_plus_delay            =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * (hh.readout_usec + hh.delay_usec - hh.vhd_delay_usec)*1e-6F);  // (readout_time + delay -vhd_delay) converti en coups de 100MHz
   ptrA->tri_window_and_intmode_part   =  (int32_t)((float)VHD_CLK_100M_RATE_HZ * hh.tri_window_and_intmode_part_usec*1e-6F);        //   tri_window_and_intmode_part_usec converti en coups de 100MHz
   ptrA->int_time_offset               =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * hh.int_time_offset_usec*1e-6F);
   ptrA->tsh_min                       =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * hh.tsh_min_usec*1e-6F);
   ptrA->tsh_min_minus_int_time_offset =  (ptrA->tsh_min - ptrA->int_time_offset);
   
   // ENO 22 sept 2015 : patch temporaire pour tenir compte des delais du patron de tests.
   // Conséquence: le patron de tests sera plus lent que le detecteur mais il ne plantera plus la camera
   if (ptrA->fpa_diag_mode == 1)
   {   
      test_pattern_dly  = (uint32_t)pGCRegs->Height * (uint32_t)TEST_PATTERN_LINE_DLY;    // delay total en coups de 10 ns sur une image de patron de tests 
	   ptrA->readout_plus_delay         =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * (hh.readout_usec + hh.delay_usec - hh.vhd_delay_usec)*1e-6F) + test_pattern_dly;  // (readout_time + delay -vhd_delay) converti en coups de 100MHz + test_pattern_dly qui est deja en coups de 10 ns
   }   
   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
    
   //  gain 
   ptrA->gain = FPA_GAIN_1;	//Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_0;	//High gain
      
   // inversion image
   ptrA->invert = 0;
   ptrA->revert = 0;
   
   // onchip binning
   ptrA->onchip_bin_256 = 0;
   ptrA->onchip_bin_128 = 0;
   
   // sampling à l'interieur d'un pixel
   ptrA->pix_samp_num_per_ch =  (uint32_t)((float)ADC_SAMPLING_RATE_HZ/(hh.pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ));
   ptrA->good_samp_first_pos_per_ch = 3;
   ptrA->good_samp_last_pos_per_ch  = 4;
   ptrA->good_samp_sum_num  =  ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->good_samp_mean_div_bit_pos = 21; // ne pas changer meme si le detecteur change.
   ptrA->good_samp_mean_numerator   = (uint32_t)(powf(2.0F, (float)ptrA->good_samp_mean_div_bit_pos)/(float)ptrA->good_samp_sum_num);
    
   // image sampling
   ptrA->img_samp_num =   ptrA->xsize * ptrA->ysize * ptrA->pix_samp_num_per_ch;
   ptrA->img_samp_num_per_ch   = ptrA->img_samp_num/FPA_NUMTAPS;
   ptrA->sof_samp_pos_start_per_ch =  1;
   ptrA->sof_samp_pos_end_per_ch   =   ptrA->pix_samp_num_per_ch;
   ptrA->eof_samp_pos_start_per_ch =   ptrA->img_samp_num_per_ch - ptrA->pix_samp_num_per_ch + 1;
   ptrA->eof_samp_pos_end_per_ch   =   ptrA->img_samp_num_per_ch;
   
   // delai avant image (mode réel)
   ptrA->fpa_active_pixel_dly  = 59;         //  valeur pour le flex
   if (FPA_proxim_is_flegx == 1)
      ptrA->fpa_active_pixel_dly = 59;       // valeur pour le fleGX
      
   // delai avant image (mode diag)   
   ptrA->diag_active_pixel_dly = 2;  // à ajuster via simulation
   
   // calculs
   ptrA->ysize_div2_m1 = ptrA->ysize/2 - 1;
   ptrA->diag_tir = 2;
   ptrA->xsize_div_tapnum = ptrA->xsize/FPA_NUMTAPS;
   
   
   // ENO 03 novembre 2016: ADC_CLK_PHASE est introduit pour conserver la trace détecteur
   ptrA->quad1_clk_phase = 6;
   ptrA->quad2_clk_phase = 6;
   ptrA->quad3_clk_phase = 6;
   ptrA->quad4_clk_phase = 6;
   if (FPA_proxim_is_flegx == 1) // valeur pour le fleGX
   {
      ptrA->quad1_clk_phase = 10;
      ptrA->quad2_clk_phase = 10;
      ptrA->quad3_clk_phase = 10;
      ptrA->quad4_clk_phase = 10;
  }
   
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   // les DACs (1 à 8)  (utilisé par le FleGX mais envoyé quel que soit le proxim)
   ptrA->vdac_value[0]                     = FLEG_VccVoltage_To_DacWord(5500.0F, 1);           // DAC1 -> VPOS_OUT à 5.5V
   ptrA->vdac_value[1]                     = FLEG_VccVoltage_To_DacWord(5500.0F, 2);           // DAC2 -> VPOS     à 5.5V
   ptrA->vdac_value[2]                     = FLEG_VccVoltage_To_DacWord(5500.0F, 3);           // DAC3 -> VPOS_UC  à 5.5V
   ptrA->vdac_value[4]                     = FLEG_VccVoltage_To_DacWord(2000.0F, 5);           // DAC5 -> VOS      à 2.0V   (ajustable)
   ptrA->vdac_value[7]                     = FLEG_VccVoltage_To_DacWord(5500.0F, 8);           // DAC8 -> VPD      à 5.5V
   
   // Reference of the tap (VCC4)      
   if (gFpaDetectorElectricalTapsRef != actualElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)ISC0207_REF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)ISC0207_REF_VOLTAGE_MAX_mV))
         ptrA->vdac_value[3] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 4);  //
   }                                                                                                       
   actualElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ptrA->vdac_value[3], 4);          
   gFpaDetectorElectricalTapsRef = actualElectricalTapsRef;
   
   // VdetCom Voltage (VCC6)
   if (gFpaDetectorPolarizationVoltage != actualPolarizationVoltage)      // gFpaDetectorPolarizationVoltage est en milliVolt
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)ISC0207_VDETCOM_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)ISC0207_VDETCOM_VOLTAGE_MAX_mV))
         ptrA->vdac_value[5] = (int32_t) FLEG_VccVoltage_To_DacWord((float)gFpaDetectorPolarizationVoltage, 6);  // vdetCom change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
   }
   actualPolarizationVoltage = (int16_t)(FLEG_DacWord_To_VccVoltage(ptrA->vdac_value[5], 6));
   gFpaDetectorPolarizationVoltage = actualPolarizationVoltage;                    
   
   // offset of the tap_reference (VCC7)      
   if (gFpaDetectorElectricalRefOffset != actualElectricalRefOffset)
   {
      if ((gFpaDetectorElectricalRefOffset >= (float)ISC0207_REFOFS_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalRefOffset <= (float)ISC0207_REFOFS_VOLTAGE_MAX_mV))
         ptrA->vdac_value[6] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalRefOffset, 7);  // 
	}                                                                                                       
   actualElectricalRefOffset = (float) FLEG_DacWord_To_VccVoltage(ptrA->vdac_value[6], 7);            
   gFpaDetectorElectricalRefOffset = actualElectricalRefOffset;   
   
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

// courbe de conversion de Sofradir pour une polarisation de 100µA   
   temperature  =  -170.50F * powf(diode_voltage,4);
   temperature +=   173.45F * powf(diode_voltage,3);
   temperature +=   137.86F * powf(diode_voltage,2);
   temperature += (-667.07F * diode_voltage) + 623.1F;  // 625 remplacé par 623 en guise de calibration de la diode 

   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au ISc0207 avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(isc0207_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // parametres statiques
   ptrH->mlck_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 2.0F;
   ptrH->fpa_delay_mclk          = 6.0F;   // FPA: delai de sortie des pixels après integration
   ptrH->vhd_delay_mclk          = 2.55F;  // estimation des differerents delais accumulés par le vhd
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 0.0F;
   ptrH->fovh_mclk               = 0.0F;
   ptrH->tsh_min_usec            = 7.8F;
   ptrH->trst_min_usec           = 0.2F;
   ptrH->itr_tri_min_usec        = 2.0F; // limite inférieure de tri pour le mode ITR . Imposée par les tests de POFIMI
   ptrH->int_time_offset_usec    = 0.8F;  // offset du temps d'integration
   
   // readout time
   ptrH->readout_mclk         = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_mclk);
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mlck_period_usec;
   
   // delay
   ptrH->vhd_delay_usec           = ptrH->vhd_delay_mclk * ptrH->mlck_period_usec;
   ptrH->fpa_delay_usec           = ptrH->fpa_delay_mclk * ptrH->mlck_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mlck_period_usec; 
   
   // fsync_high_min
   ptrH->fsync_high_min_usec  = ptrH->trst_min_usec + 0.6F;
   
   // FsyncLow
   ptrH->fsync_low_usec       = exposureTime_usec + ptrH->int_time_offset_usec;
   
   // T_ri int part
   ptrH->tri_int_part_usec    = ptrH->tsh_min_usec - ptrH->fsync_low_usec;
   
   // T_ri window part
   ptrH->tri_window_part_usec = ptrH->fsync_high_min_usec - ptrH->delay_usec - ptrH->readout_usec;
   
   // T_ri window part couplé au mode ITR ou IWR
   //if (pGCRegs->IntegrationMode == 0) // ITR
   ptrH->tri_window_and_intmode_part_usec = MAX(ptrH->tri_window_part_usec, ptrH->itr_tri_min_usec);  // seulement ITR supporté pour le moment
   //else                               // IWR
   //   ptrH->tri_window_and_intmode_part_usec = ptrH->tri_window_part_usec;
   
   // T_ri
   ptrH->tri_min_usec = MAX(ptrH->tri_int_part_usec , ptrH->tri_window_and_intmode_part_usec); 
      
   // calcul de la periode minimale
   ptrH->frame_period_min_usec = ptrH->fsync_low_usec + ptrH->delay_usec + ptrH->readout_usec + ptrH->tri_min_usec;
   
   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_min_usec*1e-6);
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   isc0207_param_t hh;
   
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   MaxFrameRate = floorMultiple(hh.frame_rate_max_hz, 0.01);

   return MaxFrameRate;                          
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   isc0207_param_t hh;
   float tri_part1_usec, tri_min_usec;
   float max_fsync_low_usec__plus__tri_min_usec;
   float max_fsync_low_usec, max_exposure_usec, frame_period_usec;
   
   // cherchons les parametres specifiques
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   
   // cherchons la periode associée au frame rate donné
   frame_period_usec  =  1e6F/pGCRegs->AcquisitionFrameRate;
                                                       
   // calculons  max_fsync_low_usec + tri_min_usec pour la periode ainsi calculée                                                   
   max_fsync_low_usec__plus__tri_min_usec = frame_period_usec - (hh.readout_usec + hh.delay_usec);
   
   // determinons le tri induite par la fenetre  choisie et le mode
   tri_part1_usec = hh.tri_window_and_intmode_part_usec; 
   
   // rappel  : tri_min_usec = max(tri_window_and_intmode_part_usec, tri_int_part_usec)
   //d'où tri_min_usec = max(tri_part1_usec, tri_int_part_usec)
   
   // 1er cas : tri_min_usec = tri_part1_usec <=> tri_int_part_usec < tri_part1_usec  <=> fsync_low > tsh_min_usec - tri_part1_usec
   // dans ce cas, 
   tri_min_usec = tri_part1_usec;
   max_fsync_low_usec = max_fsync_low_usec__plus__tri_min_usec - tri_min_usec;
   
   // voyons si l'hypothese de debut est incorrecte (verification a posteriori)
   // le cas echeant, c'est le 2e cas qui prevaut
   // 2e cas : tri_min_usec = tri_int_part_usec <=> tri_int_part_usec > tri_part1_usec  <=> fsync_low < tsh_min_usec - tri_part1_usec
   // dans ce cas,
   if (max_fsync_low_usec <= hh.tsh_min_usec - tri_part1_usec)
     max_fsync_low_usec = hh.tsh_min_usec - tri_part1_usec;  // la valeur max de fync_low selon l'hypothese fsync_low < tsh_min_usec - tri_part1_usec
   
   // dans tous les cas         
   max_exposure_usec = max_fsync_low_usec - hh.int_time_offset_usec;
   
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
   Stat->fpa_init_done                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x80);
   Stat->fpa_init_success              = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x84);
   
   // verification des statuts en simulation
   #ifdef SIM
      PRINTF("Stat->adc_oper_freq_max_khz    = %d\n", Stat->adc_oper_freq_max_khz);
      PRINTF("Stat->adc_analog_channel_num   = %d\n", Stat->adc_analog_channel_num);
      PRINTF("Stat->adc_resolution           = %d\n", Stat->adc_resolution);
      PRINTF("Stat->adc_brd_spare            = %d\n", Stat->adc_brd_spare);
      PRINTF("Stat->ddc_fpa_roic             = %d\n", Stat->ddc_fpa_roic );
      PRINTF("Stat->ddc_brd_spare            = %d\n", Stat->ddc_brd_spare);
      PRINTF("Stat->flex_fpa_roic            = %d\n", Stat->flex_fpa_roic);
      PRINTF("Stat->flex_fpa_input           = %d\n", Stat->flex_fpa_input);
      PRINTF("Stat->flex_ch_diversity_num    = %d\n", Stat->flex_ch_diversity_num );
      PRINTF("Stat->cooler_volt_min_mV       = %d\n", Stat->cooler_volt_min_mV);
      PRINTF("Stat->cooler_volt_max_mV       = %d\n", Stat->cooler_volt_max_mV);
      PRINTF("Stat->fpa_temp_raw             = %d\n", Stat->fpa_temp_raw);
      PRINTF("Stat->global_done              = %d\n", Stat->global_done);
      PRINTF("Stat->fpa_powered              = %d\n", Stat->fpa_powered);
      PRINTF("Stat->cooler_powered           = %d\n", Stat->cooler_powered);
      PRINTF("Stat->errors_latchs            = %d\n", Stat->errors_latchs);
   #endif  
   
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

