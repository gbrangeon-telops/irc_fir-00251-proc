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

// Mode d'operation choisi pour le contr�leur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_INT_END_TO_TRIG_START        0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR

// Gains definis par Indigo  
#define FPA_GAIN_0                        0x00      // lowest gain
#define FPA_GAIN_1                        0x01      // 
#define FPA_GAIN_2                        0x02      // 
#define FPA_GAIN_3                        0x03      // highest gain                               
 
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature

// adresse d'�criture du r�gistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xAE0      // adresse � lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est con�u pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xAE4      // adresse � lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est con�u pour.
#define AW_FPA_INPUT_SW_TYPE              0xAE8      // obligaoire pour les deteceteurs analogiques

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x11      // 0x11 -> isc0209A . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x03      // 0x03 -> input LVTTL50 .provient du fichier fpa_common_pkg.vhd


// adresse d'�criture du r�gistre du reset des erreurs
#define AW_RESET_ERR                      0xAEC

 // adresse d'�criture du r�gistre du reset du module FPA
#define AW_CTRLED_RESET                   0xAF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test gener� par la carte d'acquisition : tous les pixels � la m�me valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag d�grad� lin�aire(patron de test d�grad� lin�airement et g�n�r� par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag d�grad� lin�aire dynamique(patron de test d�grad� lin�airement et variant d'image en image et g�n�r� par la carte d'acquisition)  

#define VHD_INVALID_TEMP                  0xFFFFFFFF                                                  

// horloges du module FPA
#define VHD_CLK_100M_RATE_HZ              100000000
#define VHD_CLK_80M_RATE_HZ                80000000
#define ADC_SAMPLING_RATE_HZ              (2*FPA_MCLK_RATE_HZ)    // les ADC  roulent � 10 MHz

// lecture de temp�rature FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donn�e de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// les DAcs de la carte Fleg
#define ISC0209_VPOS_VOLTAGE_V            5.5           // VPOS en volts
#define ISC0209_VPOSOUT_VOLTAGE_V         5.5           // VPOSOUT en volts
#define ISC0209_VPD_VOLTAGE_V             5.5           // VPD en volts
#define ISC0209_VOUTREF_VOLTAGE_V         1.6           // VOUTREF en volts
#define ISC0209_VREF_VOLTAGE_V            1.6           // VREF en volts

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est � 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2.0           // gain de r�f�rence du DAC


#define VHD_PIXEL_PIPE_DLY_SEC            360E-9        // delai max du pipe des pixels

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define ISC0209_DET_BIAS_VOLTAGE_MIN_mV   100           // voltage minimale de 100 mV pour detBias (selon rapport Qmagiq)
#define ISC0209_DET_BIAS_VOLTAGE_MAX_mV   518           // voltage maximale de 518 mV pour detBias (on ne peut atteindre les 700 mV du rapport Q magiq en mode commande)

#define ISC0209_REFOFS_VOLTAGE_MIN_mV     2810           // valeur en provenance du fichier fpa_define
#define ISC0209_REFOFS_VOLTAGE_MAX_mV     6200           // valeur en provenance du fichier fpa_define
#define ISC0209_CONST_ELEC_OFFSET_VALUE   340            // aussi pour ne pas provoquer saturation au dela de (2^14 - 1) soit 16383

// structure interne pour les parametres du isc0209
struct isc0209_param_s             //
{					   
   // parametres � rentrer
   float mclk_period_usec;
   float pclk_rate_hz;
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float int_time_offset_mclk;   
   
   // parametres calcul�s
   float readout_mclk;   
   float readout_usec;
   float fpa_delay_usec;
   float vhd_delay_usec;
   float delay_usec;
   float lovh_usec;
   float fovh_usec;
   float int_time_offset_usec;
   float int_signal_high_time_usec;
   float tri_min_usec;
   float frame_period_usec;
   float frame_rate_max_hz;
   float mode_int_end_to_trig_start_dly_usec;
   float mode_readout_end_to_trig_start_dly_usec;
};
typedef struct isc0209_param_s  isc0209_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint8_t init_done = 0;

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);


void FPA_SpecificParams(isc0209_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de d�part
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   init_done = 0;
   FPA_Reset(ptrA);
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est con�u pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoy�e au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
   FPA_GetStatus(Stat, ptrA);                                               // statut global du vhd.
   init_done = 1;
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
// retenir qu'apr�s reset, les IO sont en 'Z' apr�s cela puisqu'on desactive le SoftwType dans le vhd. (voir vhd pour plus de details)
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
    isc0209_param_t hh;
    extern int16_t gFpaDetectorPolarizationVoltage;
    static int16_t actualPolarizationVoltage = 150;
    uint32_t elec_ofs_enabled = 1;
    uint32_t elec_ofs_map_image_enabled = 0;
    //extern float gFpaDetectorElectricalTapsRef;
    extern float gFpaDetectorElectricalRefOffset;
    //static float actualElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calcul�e apres passage dans la fonction de calcul 
    static float actualElectricalRefOffset = 0;      // valeur arbitraire d'initialisation. La bonne valeur sera calcul�e apres passage dans la fonction de calcul
    extern int32_t gFpaDebugRegA, gFpaDebugRegB, gFpaDebugRegC, gFpaDebugRegD;

   // on b�tit les parametres specifiques du isc0209
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //
   
   // diag mode and diagType
   ptrA->fpa_diag_mode = 0;                 // par defaut
   ptrA->fpa_diag_type = 0;                 // par defaut   
   if (pGCRegs->TestImageSelector == TIS_TelopsStaticShade) {              // mode diagnostique degrad� lineaire
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
   
   // allumage du d�tecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas r�unies
   
   // config du contr�leur de trigs
   ptrA->fpa_trig_ctrl_mode     = (uint32_t)MODE_INT_END_TO_TRIG_START;
   ptrA->fpa_acq_trig_ctrl_dly  = (uint32_t)((hh.mode_int_end_to_trig_start_dly_usec*1e-6F - (float)VHD_PIXEL_PIPE_DLY_SEC) * (float)VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_acq_trig_period_min   = (uint32_t)(0.8F*(hh.mode_int_end_to_trig_start_dly_usec*1e-6F)* (float)VHD_CLK_100M_RATE_HZ);   // periode min avec int_time = 0. Le Vhd y ajoutera le int_time reel
   ptrA->fpa_xtra_trig_period_min  = (uint32_t)(0.8F*(hh.mode_int_end_to_trig_start_dly_usec*1e-6F)* (float)VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_xtra_trig_period_min;                          // je n'ai pas enlev� le int_time, ni le readout_time mais pas grave car c'est en xtra_trig

   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
    
   //  gain 
   ptrA->gain = FPA_GAIN_0;   	//Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_3;	//High gain
      
   // direction de readout
   ptrA->invert = 0;
   ptrA->revert = 0;
   
   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
      
    // DIG voltage 
   if (gFpaDetectorPolarizationVoltage != actualPolarizationVoltage)
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)ISC0209_DET_BIAS_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)ISC0209_DET_BIAS_VOLTAGE_MAX_mV))
         ptrA->detpol_code = (uint32_t)(127.0F * ((float)gFpaDetectorPolarizationVoltage/1000.0F + 0.1F)/0.62F);  // dig_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conserv�e. (voir FpaIntf_Ctor) pour la valeur d'initialisation
   }
   actualPolarizationVoltage = (int16_t)roundf(1000.0F * (0.62F * (float)ptrA->detpol_code/127.0F - 0.1F));
   gFpaDetectorPolarizationVoltage = actualPolarizationVoltage;
   
   // skimming                     
   ptrA->skimming_en = 0;                          
   
   // ajustement de delais de la chaine
   ptrA->real_mode_active_pixel_dly = 13;                             // ajuster via chipscope
   
   // quad2    
   ptrA->adc_quad2_en = 0;                                            // ENO : 14 aout 2017 : plus besoin de la diversit� de canal dans un iSC0209
   ptrA->chn_diversity_en = 0;                                        // ENO : 14 aout 2017 : plus besoin de la diversit� de canal dans un iSC0209
   
   //
   ptrA->line_period_pclk                  = (ptrA->xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)+ hh.lovh_mclk) *  hh.pixnum_per_tap_per_mclk;
   ptrA->readout_pclk_cnt_max              = ptrA->line_period_pclk*(ptrA->ysize + hh.fovh_line) + 1;                    // ligne de reset du isc0209 prise en compte
   
   ptrA->active_line_start_num             = 3;                    // pour le isc0209, numero de la premi�re ligne active
   ptrA->active_line_end_num               = ptrA->ysize + ptrA->active_line_start_num - 1;          // pour le isc0209, numero de la derniere ligne active
   ptrA->window_lsync_num                  = ptrA->ysize + ptrA->active_line_start_num - 1;
   
   // nombre d'�chantillons par canal  de carte ADC
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
   ptrA->vgood_samp_sum_num                =  1 + ptrA->chn_diversity_en;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
      
   // calculs
   ptrA->xsize_div_tapnum                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS;                                        
   
   // les DACs (1 � 8)
   ptrA->vdac_value[0]                     = 12812;          // DAC1 -> VPD � 5.5V
   ptrA->vdac_value[1]                     = 12812;          // DAC2 -> VPOSOUT � 5.5V
   ptrA->vdac_value[2]                     = 12812;          // DAC3 -> VPOS � 5.5V
   ptrA->vdac_value[3]                     = 3711;           // DAC4 -> Vref � 1.6V  
   ptrA->vdac_value[4]                     = 3711;           // DAC5 -> Voutref � 1.6V
   ptrA->vdac_value[5]                     = 3711;           // DAC6 -> VOS � 1.6V 
   ptrA->vdac_value[6]                     = 0;              // DAC7 -> non utilis�, � 501 mV
   //ptrA->vdac_value[7]                     = 5300;           // DAC8 -> � 3.779V
   
   // offset of the tap_reference (VCC8)      
   if (gFpaDetectorElectricalRefOffset != actualElectricalRefOffset)
   {
      if ((gFpaDetectorElectricalRefOffset >= (float)ISC0209_REFOFS_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalRefOffset <= (float)ISC0209_REFOFS_VOLTAGE_MAX_mV))
         ptrA->vdac_value[7] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalRefOffset, 8);  // 
	}                                                                                                       
   actualElectricalRefOffset = (float) FLEG_DacWord_To_VccVoltage(ptrA->vdac_value[7], 8);            
   gFpaDetectorElectricalRefOffset = actualElectricalRefOffset;    
    
   // pour securiser les livraisons d'avant l'entr�e en vigueur des offsets dans les flash settings 
   if (pGCRegs->DeviceSerialNumber == 4302)                  // pour IRC1505 
      ptrA->vdac_value[7]                   = 5300;          // DAC8 -> � 3.779V
   
   
   // adc_clk_phase
   if ((gFpaDebugRegD != (int32_t) ptrA->adc_clk_phase) && (init_done == 1))
      ptrA->adc_clk_phase = (uint32_t)gFpaDebugRegD;            // on dephase l'horloge des ADC
   gFpaDebugRegD = (int32_t)ptrA->adc_clk_phase;
   
   // �largit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   /* offset electronique
    sans correction offset, on a : signal_elec =  gain_elec * signal_fpa + offset_elec;
    avec correction,               signal_elec =  gain_elec * signal_fpa + offset_elec - estim�_offset_elec +  constante;   la constante permet de compenser la plage dynamique suite � la disparition de l'offset
   */
                
   // registreA : contr�le l'activation du correcteur de l'offset electronique              
   if (((uint32_t)gFpaDebugRegA != elec_ofs_enabled) && (init_done == 1))   
      elec_ofs_enabled  = (uint32_t) gFpaDebugRegA;
   gFpaDebugRegA = (int32_t)elec_ofs_enabled;

   // registreB : contr�le la sortie ou non de l'image du map d'offset 
   if (((uint32_t)gFpaDebugRegB != elec_ofs_map_image_enabled) && (init_done == 1))   
     elec_ofs_map_image_enabled  = (uint32_t) gFpaDebugRegB;
   gFpaDebugRegB = (int32_t)elec_ofs_map_image_enabled;
   
   // registreC : contr�le le delai avant calcul d'offset
   if (((uint32_t)gFpaDebugRegC != ptrA->elec_ofs_start_dly) && (init_done == 1))   
     ptrA->elec_ofs_start_dly  = (uint32_t) gFpaDebugRegC;
   gFpaDebugRegC = (int32_t)ptrA->elec_ofs_start_dly;
   
   // valeurs par defaut
   ptrA->elec_ofs_samp_num_per_ch         = (uint32_t) ((hh.pixnum_per_tap_per_mclk * hh.tap_number) * (hh.lovh_mclk) / (2.0F * hh.tap_number)); // 16 echantillons � la fin de l'image
   ptrA->elec_ofs_samp_num_per_ch         = (uint32_t) (2.0F*floorf((float)ptrA->elec_ofs_samp_num_per_ch/2.0F)); // doit �tre un nombre pair absol�ment pour �viter que les zones (1:Ntaps) et (Ntaps+1: 2*Natps) se superposent
   ptrA->elec_ofs_samp_mean_numerator     = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elec_ofs_samp_num_per_ch);  
   ptrA->elec_ofs_add_const               = (uint32_t) ISC0209_CONST_ELEC_OFFSET_VALUE;         // vaut "constante" dans le mod�le d�crit plus haut
   ptrA->elec_ofs_pix_faked_value         =  0; 
   ptrA->elec_ofs_pix_faked_value_forced  =  0;
   ptrA->elec_ofs_offset_minus_pix_value  =  0;
   ptrA->elec_ofs_offset_null_forced      =  0;
    
  // sortie de la map d'offset
  if (elec_ofs_map_image_enabled == 1){       // pour sortir le map d'offset en image. Soit obtenir "signal_elec = estim�_offset_elec" � partir de "signal_elec =  gain_elec * signal_fpa + offset_elec - estim�_offset_elec + constante"
      ptrA->elec_ofs_pix_faked_value_forced  =  1;       //      etape 1: on permet de forcer la valeur des pixels � une valeur fixe. 
      ptrA->elec_ofs_pix_faked_value         =  0;       //               soit "gain_elec * signal_fpa" vaut 0
      ptrA->elec_ofs_add_const               =  0;       //      etape 2: la quanit� "constante"  vaut aussi 0
      ptrA->elec_ofs_offset_minus_pix_value  =  1;       //      etape 3: le soustracteur inverse l'ordre de la soustraction. Au final on a bien l'offset_electrique en image
   }
  
  // desactivation de la correction de l'offset dynamique
  if ((elec_ofs_enabled == 0) || (ptrA->fpa_diag_mode == 1)) {  // desactivation de la correction d'offset dynamique. Soit obtenir signal_elec =  gain_elec * signal_fpa + offset_elec " � partir de "signal_elec =  gain_elec * signal_fpa + offset_elec - estim�_offset_elec + constante"
      ptrA->elec_ofs_offset_null_forced      =  1;                   //     etape 1: on force "estim�_offset_elec" � 0.
      ptrA->elec_ofs_add_const               =  0;                   //     etape 2: la quanit� "constante"  vaut aussi 0. Au final on a bien ce qui est voulu.
  } 
       
   WriteStruct(ptrA);
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la temp�rature du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage;
   float temperature;
   
   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le pr�sent mais le pass�) 
   raw_temp = (raw_temp & 0x0000FFFF);

   diode_voltage = (float)raw_temp*((float)FPA_TEMP_READER_FULL_SCALE_mV/1000.0F)/(powf(2.0F, FPA_TEMP_READER_ADC_DATA_RES)*(float)FPA_TEMP_READER_GAIN);

// courbe de conversion de Sofradir pour une polarisation de 100�A   
   temperature  =  -170.50F * powf(diode_voltage,4);
   temperature +=   173.45F * powf(diode_voltage,3);
   temperature +=   137.86F * powf(diode_voltage,2);
   temperature += (-667.07F * diode_voltage) + 623.1F;  // 625 remplac� par 623 en guise de calibration de la diode

   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au isc0209 avec une config
//--------------------------------------------------------------------------
void FPA_SpecificParams(isc0209_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 2.0F;
   ptrH->fpa_delay_mclk          = 5.0F;   // FPA: estimation delai max de sortie des pixels apr�s integration
   ptrH->vhd_delay_mclk          = 3.5F;   // estimation des differerents delais accumul�s par le vhd
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 16.0F;
   ptrH->fovh_line               = 2.0F;
   ptrH->int_time_offset_mclk    = (5.0E-6F) * (float)FPA_MCLK_RATE_HZ;
   ptrH->pclk_rate_hz            = ptrH->pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ;
      
   // readout time
   ptrH->readout_mclk         = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec       = ptrH->fpa_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mclk_period_usec; 
   
   // 
   ptrH->int_time_offset_usec  = ptrH->int_time_offset_mclk * ptrH->mclk_period_usec;
   ptrH->int_signal_high_time_usec = MAX(exposureTime_usec - ptrH->int_time_offset_usec, 0.0F);
      
   // calcul de la periode minimale
   ptrH->frame_period_usec = exposureTime_usec + ptrH->delay_usec + ptrH->readout_usec;

   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);

   //autres calculs
   ptrH->mode_int_end_to_trig_start_dly_usec = ptrH->frame_period_usec - ptrH->int_signal_high_time_usec;   
   ptrH->mode_readout_end_to_trig_start_dly_usec = 1.0F;                                                   // utilis� en mode readout_end_trig_start
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donn�e
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   isc0209_param_t hh;
   
   FPA_SpecificParams(&hh,(float)pGCRegs->ExposureTime, pGCRegs);
   
   // ENO: 10 sept 2016: Apply margin 
   MaxFrameRate = hh.frame_rate_max_hz * (1.0F - gFpaPeriodMinMargin);
   
   // Round maximum frame rate
   MaxFrameRate = floorMultiple(MaxFrameRate, 0.01);

   return MaxFrameRate;                          
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir le ExposureMax avec une config donn�e
//--------------------------------------------------------------------------
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs)
{
   isc0209_param_t hh;
   float periodMinWithNullExposure_usec;
   float actualPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;
   
   // ENO: 10 sept 2016: d'entr�e de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);
   
   // ENO: 10 sept 2016: tout reste inchang�
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition �tait nulle
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
// Informations sur les drivers C utilis�s. 
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
// VccPosition   : position du LDO . Attention! VccPosition = FLEG_VCC_POSITION o� FLEG_VCC_POSITION est la position sur le FLEG (il va de 1 � 8)
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition)
{
  float Rs, Rd, RL, Is, DacVoltage_Volt;
  uint32_t DacWord;

   if ((VccPosition == 1) || (VccPosition == 2) || (VccPosition == 3) || (VccPosition == 8)){   // les canaux VCC1, VCC2, VCC3 et VCC8 sont identiques � VCC1
      Rs = 24.9e3F;    // sur EFA-00266-001, vaut R42
      Rd = 1000.0F;    // sur EFA-00266-001, vaut R41
      RL = 3.01e3F;    // sur EFA-00266-001, vaut R35
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   else{                                                   // les canaux VCC4, VCC5, VCC6, et VCC7 sont identiques � VCC4
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
// VccPosition   : position du LDO . Attention! VccPosition = FLEG_VCC_POSITION o� FLEG_VCC_POSITION est la position sur le FLEG (il va de 1 � 8)
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition)
{
   float Rs, Rd, RL, Is, DacVoltage_Volt, VccVoltage_mV;
   uint32_t DacWordTemp;

   if ((VccPosition == 1) || (VccPosition == 2) || (VccPosition == 3) || (VccPosition == 8)){   // les canaux VCC1, VCC2, VCC3 et VCC8 sont identiques � VCC1
      Rs = 24.9e3F;    // sur EFA-00266-001, vaut R42
      Rd = 1000.0F;    // sur EFA-00266-001, vaut R41
      RL = 3.01e3F;    // sur EFA-00266-001, vaut R35
      Is = 100e-6F;    // sur EFA-00266-001, vaut le courant du LT3042
   }
   else{                                                   // les canaux VCC4, VCC5, VCC6, et VCC7 sont identiques � VCC4
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
