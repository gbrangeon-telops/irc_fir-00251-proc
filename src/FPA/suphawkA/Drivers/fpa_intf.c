/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 23278 $
-- $Author: elarouche $
-- $LastChangedDate: 2019-04-12 16:50:50 -0400 (ven., 12 avr. 2019) $
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

// Gains definis par Selex  
#define FPA_GAIN_0                        0x00      // gros puits
#define FPA_GAIN_1                        0x01      // petit puits
 
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature

// adresse d'�criture du r�gistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xAE0      // adresse � lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est con�u pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xAE4      // adresse � lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est con�u pour.
#define AW_FPA_INPUT_SW_TYPE              0xAE8      // obligaoire pour les deteceteurs analogiques

// identification des sources de donn�es
#define DATA_SOURCE_INSIDE_FPGA           0         // Provient du fichier fpa_common_pkg.vhd.
#define DATA_SOURCE_OUTSIDE_FPGA          1         // Provient du fichier fpa_common_pkg.vhd.

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD               0x0D00   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x20      // 0x20 -> suphawkA . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33 .provient du fichier fpa_common_pkg.vhd. La valeur 0x04 est celle de LVCMOS33


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
#define ADC_SAMPLING_RATE_HZ              FPA_MCLK_RATE_HZ    // les ADC  roulent � FPA_MCLK_RATE_HZ

// lecture de temp�rature FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donn�e de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est � 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2.0           // gain de r�f�rence du DAC


#define VHD_PIXEL_PIPE_DLY_SEC            300E-9        // delai max du pipe des pixels

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define SUPHAWK_DIG_VOLTAGE_MIN_mV        50            // 50 mV
#define SUPHAWK_DIG_VOLTAGE_MAX_mV        2750          // 2750 mV
 
#define FPA_XTRA_TRIG_FREQ_MAX_HZ         30           // ENO: 25 janv 2016: la programmation du dtecteur se fera � cette vitesse au max. Cela donnera assez de coups d'horloges pour les resets quelle que soit la config de fenetre

#define SUPHAWK_TAPREF_VOLTAGE_MIN_mV     500          // valeur en provenance du fichier fpa_define
#define SUPHAWK_TAPREF_VOLTAGE_MAX_mV     5300         // valeur en provenance du fichier fpa_define

#define TOTAL_DAC_NUM                     8

// Electrical correction : references
#define ELCORR_REF0_VALUE_mV              2227                // ref0 au milieu de la plage dynamique
#define ELCORR_REF1_VALUE_mV              1200
#define ELCORR_REF_DAC_ID                 6                   // position (entre 1 et 8) du dac d�di� aux references 
#define ELCORR_REF_MAXIMUM_SAMP           120                 // le nombre de sample au max support� par le vhd

// Electrical correction : embedded switches control
#define ELCORR_SW_TO_PATH1                0x01
#define ELCORR_SW_TO_PATH2                0x02
#define ELCORR_SW_TO_NORMAL_OP            0x03 

// Electrical correction : valeurs mesur�es avant correction 
#define ELCORR_MEASURED_ADCCNT_AT_STARVATION     1300         // @ centered pix (640, 512)
#define ELCORR_MEASURED_ADCCNT_AT_SATURATION     15500        // @ centered pix (640, 512)
#define ELCORR_MEASURED_ADCCNT_FOR_REF0          8000         // @ centered pix (640, 512)
#define ELCORR_MEASURED_ADCCNT_FOR_REF1          475          // @ centered pix (640, 512)

// Electrical correction : valeurs cibles (desir�es) apres correction
#define ELCORR_TARGET_ADCCNT_AT_STARVATION       500
#define ELCORR_TARGET_ADCCNT_AT_SATURATION       15200


struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du suphawk
struct suphawk_param_s             // 
{					   
   // parametres � rentrer
   float mclk_period_usec;                       
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
   float tri_min_usec;
   float frame_period_usec;
   float frame_rate_max_hz;       
};
typedef struct suphawk_param_s  suphawk_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint8_t init_done = 0;
ProximCfg_t ProximCfg = {{ 7137, 0, 7137, 4387,  0,  10129, 0, 0}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);
void FPA_SpecificParams(suphawk_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);

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
   suphawk_param_t hh;
   extern int16_t gFpaDetectorPolarizationVoltage;
   extern float gFpaDetectorElectricalTapsRef;
   static int16_t actualPolarizationVoltage = 10;   // valeur arbitraire d'initialisation. La bonne valeur sera calcul�e apres passage dans la fonction de calcul
   static float actualElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calcul�e apres passage dans la fonction de calcul 
   extern int32_t gFpaDebugRegA, gFpaDebugRegB, gFpaDebugRegC, gFpaDebugRegD;
   extern int32_t gFpaDebugRegE;
   static uint8_t cfg_num = 0;
   uint32_t elcorr_reg;
   uint32_t elcorr_enabled = 1;
   uint32_t elcorr_gain_corr_enabled = 0;
   float elcorr_comp_duration_usec;                 // la duree en usec disponible pour la prise des references
   float elcorr_atemp_gain;
   float elcorr_atemp_ofs;
   
   
   // on b�tit les parametres specifiques du suphawk
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul . Mais le VHD ajoutera le int_time pour avoir la vraie periode
   
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
   
   // mode diag vrai et faked
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilis�/regard� par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
   
   // allumage du d�tecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas r�unies
   
   // config du contr�leur de trigs
   ptrA->fpa_trig_ctrl_mode     = (uint32_t)MODE_INT_END_TO_TRIG_START;
   if (ptrA->fpa_diag_mode == 1) 
      ptrA->fpa_trig_ctrl_mode  = (uint32_t)MODE_ITR_INT_END_TO_TRIG_START;
      
   ptrA->fpa_acq_trig_ctrl_dly  = (uint32_t)((hh.frame_period_usec*1e-6F - (float)VHD_PIXEL_PIPE_DLY_SEC) * (float)VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_spare              = 0;
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)VHD_CLK_100M_RATE_HZ / (float)FPA_XTRA_TRIG_FREQ_MAX_HZ); //(uint32_t)(0.8F*(hh.frame_period_usec*1e-6F)* (float)VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_trig_ctrl_timeout_dly;                         // je n'ai pas enlev� le int_time, ni le readout_time mais pas grave car c'est en xtra_trig

   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
    
   //  gain 
   ptrA->gain = FPA_GAIN_0;   	//Low gain        -- TODO SUPHAWK : � valider !!
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_1;	//High gain
      
   // direction de readout
   ptrA->invert = 0;
   ptrA->revert = 0; 
   
   // formule implant�e pour le mode normal (revert = 0, Invert = 0)  -- TODO SUPHAWK : � valider !!
   ptrA->colstart = (uint32_t)pGCRegs->OffsetX / (uint32_t)FPA_NUMTAPS;
   ptrA->colstop  =  ptrA->colstart  + (uint32_t)pGCRegs->Width / (uint32_t)FPA_NUMTAPS - 1;
   ptrA->rowstart = (uint32_t)pGCRegs->OffsetY;
   ptrA->rowstop  =  ptrA->rowstart  + (uint32_t)pGCRegs->Height - 1;
   
   // CBIT 
   ptrA->cbit_en = 1;                    
   
   // mode windowing ou non
   if (((uint32_t)pGCRegs->Width == (uint32_t)FPA_WIDTH_MAX) && ((uint32_t)pGCRegs->Height == (uint32_t)FPA_HEIGHT_MAX))
      ptrA->active_subwindow = 0;
   else
      ptrA->active_subwindow = 1;
      
   // DIG voltage
   if (init_done == 0)
      ptrA->dig_code = 0x00D0;
   
   if (gFpaDetectorPolarizationVoltage != actualPolarizationVoltage)
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)SUPHAWK_DIG_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)SUPHAWK_DIG_VOLTAGE_MAX_mV))
         ptrA->dig_code = (uint32_t)MAX((0.000639F + (float)gFpaDetectorPolarizationVoltage/1000.0F)/0.005344F, 1.0F);  // dig_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conserv�e. (voir FpaIntf_Ctor) pour la valeur d'initialisation
	}                                                                                                       
   actualPolarizationVoltage = (int16_t)roundf(1000.0F*(0.005344F*(float)ptrA->dig_code -  0.000639F));             // DIGREF = -0.0055 x DDR + 2.8183   converti en mV
   gFpaDetectorPolarizationVoltage = actualPolarizationVoltage;
    
   // ajustement de delais de la chaine
   if (((uint32_t)gFpaDebugRegB != ptrA->real_mode_active_pixel_dly) && (init_done == 1))   
      ptrA->real_mode_active_pixel_dly  = (uint32_t) gFpaDebugRegB;
   gFpaDebugRegB = (int32_t)ptrA->real_mode_active_pixel_dly;
   
   // quad2    
   ptrA->adc_quad2_en = 1;                          
   ptrA->chn_diversity_en = 0;             // ENO : 07 nov 2017 : pas besoin de la diversit� de canal dans un suphawk
   
   //
   ptrA->line_period_pclk                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS + hh.lovh_mclk;
   ptrA->readout_pclk_cnt_max              = ptrA->line_period_pclk*(ptrA->ysize + hh.fovh_line) + 3;                              // ligne de reset du suphawk prise en compte
   
   ptrA->active_line_start_num             = 1;                    // pour le suphawk, numero de la premi�re ligne active
   ptrA->active_line_end_num               = ptrA->ysize;          // pour le suphawk, numero de la derniere ligne active
   
   // nombre d'�chantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch               = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ; 
   
   // identificateurs de trames
   ptrA->sof_posf_pclk                     = hh.lovh_mclk;
   ptrA->eof_posf_pclk                     = ptrA->active_line_end_num * ptrA->line_period_pclk - 1;
   ptrA->sol_posl_pclk                     = hh.lovh_mclk;
   ptrA->eol_posl_pclk                     = ptrA->line_period_pclk - 1;
   ptrA->eol_posl_pclk_p1                  = ptrA->eol_posl_pclk + 1;

   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch       = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ;     // position premier echantillon
   ptrA->good_samp_last_pos_per_ch        = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ;     // position dernier echantillon    ENO: 05 avril 2017: on prend juste un echantillon par canal pour reduire le Ghost. Le bruit augmentera � 6 cnts max sur 16 bits
   ptrA->hgood_samp_sum_num                = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num                = 1 + ptrA->chn_diversity_en;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
      
   // calculs
   ptrA->xsize_div_tapnum                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS;                                        
   
   // les DACs (1 � 8)
   ProximCfg.vdac_value[0]                 = FLEG_VccVoltage_To_DacWord(4200.0F, 1);   // VDDOP
   ProximCfg.vdac_value[1]                 = 0;
   ProximCfg.vdac_value[2]                 = FLEG_VccVoltage_To_DacWord(4200.0F, 3);   // VDDPIX
   ProximCfg.vdac_value[3]                 = FLEG_VccVoltage_To_DacWord(1800.0F, 4);   // VDD
   ProximCfg.vdac_value[4]                 = 0;
   ProximCfg.vdac_value[5]                 = FLEG_VccVoltage_To_DacWord(3500.0F, 6);   // PRV
   ProximCfg.vdac_value[7]                 = 0;                                                      
   
   ptrA->prv_dac_nominal_value = ProximCfg.vdac_value[5];
   
   // TAPREF : VCC7 ou DAC7
   if (init_done == 0)
      ProximCfg.vdac_value[6] = FLEG_VccVoltage_To_DacWord(1550.0F, 7);
      
   if (gFpaDetectorElectricalTapsRef != actualElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)SUPHAWK_TAPREF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)SUPHAWK_TAPREF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[6] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 7);  // 
	}                                                                                                       
   actualElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[6], 7);            
   gFpaDetectorElectricalTapsRef = actualElectricalTapsRef;
    
   // dephasage des adc_clk avec gFpaDebugRegC et gFpaDebugRegD
   // adc clk source phase
   if (init_done == 0){
      ptrA->adc_clk_pipe_sel = 0;
   }       
   if ((gFpaDebugRegC != (int32_t) ptrA->adc_clk_pipe_sel) && (init_done == 1)){
      ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;                         
      //need_rst_fpa_module = 1;
   }
   gFpaDebugRegC= (int32_t)ptrA->adc_clk_pipe_sel;                                              
   
   // adc clk source phase
   if (init_done == 0){         
      ptrA->adc_clk_source_phase = 1000;
   }
   
   if ((gFpaDebugRegD != (int32_t) ptrA->adc_clk_source_phase) && (init_done == 1)){
      ptrA->adc_clk_source_phase = (int32_t)gFpaDebugRegD;
      //need_rst_fpa_module = 1;
   }
    gFpaDebugRegD = (int32_t)ptrA->adc_clk_source_phase;
       
   // �largit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   // changement de cfg_num des qu'une nouvelle cfg est envoy�e au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   if (cfg_num == 255)  // protection contre depassement
      cfg_num = 0;   
   cfg_num++;
   
   ptrA->cfg_num  = (uint32_t)cfg_num;
   
   // correction electronique // registreA :
   if (init_done == 0)
      gFpaDebugRegA = 7;
   elcorr_reg = (uint32_t)gFpaDebugRegA;
   
   if (ptrA->fpa_diag_mode == 1)
      elcorr_reg = 0;
  
   if (elcorr_reg == 7){         // pixeldata avec correction du gain et offset electroniques
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 0;
        
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;  // pas necessaire
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;
      ptrA->sat_ctrl_en             = 1;
   }
    
   else if (elcorr_reg == 6){    // PRV data avec correction du gain et offset electroniques
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 1;
      ptrA->roic_cst_output_mode    = 1;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP; 
      ptrA->sat_ctrl_en             = 1;                      
   }
   
   else if (elcorr_reg == 5){    // pixeldata avec correction de l'offset �lectronique seulement
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;         
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_NORMAL_OP;     
      ptrA->sat_ctrl_en             = 1;                            
   }
 
   else if (elcorr_reg == 3){    // image map de la difference des references
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1;    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_NORMAL_OP;
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH2;    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;    
      ptrA->sat_ctrl_en             = 0;                       
   }                                                         
    
   else if (elcorr_reg == 2){   // image map de la reference 2 (1 dans le vhd)
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1; // pas necessaire
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH2;                  
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                  
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH2;                  
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                  
      ptrA->sat_ctrl_en             = 0;                                     
   }
    
   else if (elcorr_reg == 1){    // image map de la reference 1 (0 dans le vhd)
      elcorr_enabled                = 1;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH2;                    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH1;  // pas necessaire 
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->sat_ctrl_en             = 0;                                     
   }

   else if (elcorr_reg == 0){    // desactivation de toute correction electronique
      elcorr_enabled                = 0;
      elcorr_gain_corr_enabled      = 0;
      ptrA->roic_cst_output_mode    = 0;
      
      ptrA->elcorr_ref0_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_ref1_op_sel      = ELCORR_SW_TO_PATH2; // pas necessaire  
      ptrA->elcorr_mult_op_sel      = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_div_op_sel       = ELCORR_SW_TO_PATH1;                    
      ptrA->elcorr_add_op_sel       = ELCORR_SW_TO_PATH1;                        
      ptrA->sat_ctrl_en             = 0;                                             
   } 
  
   // Electronic chain correction parameters
   if (elcorr_gain_corr_enabled == 1){
      elcorr_atemp_gain = (((float)ELCORR_TARGET_ADCCNT_AT_SATURATION - (float)ELCORR_TARGET_ADCCNT_AT_STARVATION) * ((float)ELCORR_MEASURED_ADCCNT_FOR_REF0 - (float)ELCORR_MEASURED_ADCCNT_FOR_REF1)/((float)ELCORR_MEASURED_ADCCNT_AT_SATURATION - (float)ELCORR_MEASURED_ADCCNT_AT_STARVATION));
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_ADCCNT_AT_SATURATION - elcorr_atemp_gain * ((float)ELCORR_MEASURED_ADCCNT_AT_SATURATION - (float)ELCORR_MEASURED_ADCCNT_FOR_REF0)/((float)ELCORR_MEASURED_ADCCNT_FOR_REF0 - (float)ELCORR_MEASURED_ADCCNT_FOR_REF1);
   }
   else {
      elcorr_atemp_gain = 1.0F;
      elcorr_atemp_ofs  = (float)ELCORR_TARGET_ADCCNT_AT_STARVATION -  ((float)ELCORR_MEASURED_ADCCNT_AT_STARVATION - (float)ELCORR_MEASURED_ADCCNT_FOR_REF0);
   }  
  
   // valeurs par defaut (mode normal)                                                                                                                                               
   elcorr_comp_duration_usec                  = ((float)FPA_WIDTH_MAX/(hh.pixnum_per_tap_per_mclk*hh.tap_number) + hh.lovh_mclk)*hh.mclk_period_usec;  // le calcul se fait sur laligne de reset                          
   
   ptrA->elcorr_enabled                       = elcorr_enabled;
   ptrA->elcorr_spare1                        = 0;              
   ptrA->elcorr_spare2                        = 0;                     
                                                  
   // reference 0:                                              
   ptrA->elcorr_ref_cfg_0_ref_enabled         = 1;               
   ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_0_start_dly_sampclk   = 6; //2;        
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'�chantillons par tap 
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_0_samp_num_per_ch - (ptrA->elcorr_ref_cfg_0_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_0_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_0_samp_mean_numerator = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_0_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_0_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF0_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //      
    
   // reference 1: 
   ptrA->elcorr_ref_cfg_1_ref_enabled         = 1;              
   ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_1_start_dly_sampclk   = 6; //2;        
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'�chantillons par tap 
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_1_samp_num_per_ch - (ptrA->elcorr_ref_cfg_1_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_1_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_1_samp_mean_numerator = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_1_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_1_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF1_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //
   
   ptrA->elcorr_ref_dac_id                    = (uint32_t)ELCORR_REF_DAC_ID;  //       
   ptrA->elcorr_atemp_gain                    = (int32_t)elcorr_atemp_gain;      
   ptrA->elcorr_atemp_ofs                     = (int32_t)elcorr_atemp_ofs;
   
   ptrA->elcorr_cont_calc_mode = 0;
   if (ptrA->roic_cst_output_mode == 1)
      ptrA->elcorr_cont_calc_mode = 1;
   
   
   // desactivation en mode patron de tests
   if (ptrA->fpa_diag_mode == 1){
      ptrA->elcorr_enabled = 0;
      ptrA->elcorr_cont_calc_mode = 0;
	   ptrA->elcorr_ref_cfg_0_ref_enabled = 0;
	   ptrA->elcorr_ref_cfg_1_ref_enabled = 0;	  
   }

   // envoi de la configuration de l'�lectronique de proximit� (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
   
   // envoi du reste de la config 
   WriteStruct(ptrA);
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la temp�rature du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage_mV;
   float temperature;
   //float TempCoeff[2];
   
   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le pr�sent mais le pass�) 
   raw_temp = (raw_temp & 0x0000FFFF);

   diode_voltage_mV = (float)raw_temp*((float)FPA_TEMP_READER_FULL_SCALE_mV)/(powf(2.0F, FPA_TEMP_READER_ADC_DATA_RES)*(float)FPA_TEMP_READER_GAIN);
   
   // courbe de conversion selon Selex 
   temperature  =  -0.00014440F * powf(diode_voltage_mV,2) - 0.27652F * diode_voltage_mV + 524.0F;
  
   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius  
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au suphawk avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(suphawk_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 1.0F;
   ptrH->fpa_delay_mclk          = 165.0F;   // FPA: delai regl�mentaire de 165 MCLK � la fin d'une image en ITR + 1 MCL en debut d'image
   ptrH->vhd_delay_mclk          = 2.0F;     // estimation des differerents delais accumul�s par le vhd
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 3.0F;
   ptrH->fovh_line               = 0.0F;
   ptrH->int_time_offset_mclk    = 0.0F;   // aucun offset sur le temps d'integration
      
   // readout time
   ptrH->readout_mclk         = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec       = ptrH->fpa_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mclk_period_usec; 
   
   // 
   ptrH->int_time_offset_usec  = ptrH->int_time_offset_mclk * ptrH->mclk_period_usec; ; 
      
   // calcul de la periode minimale
   ptrH->frame_period_usec = (exposureTime_usec + ptrH->int_time_offset_usec) + ptrH->delay_usec + ptrH->readout_usec;
   
   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donn�e
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   suphawk_param_t hh;
   
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
   suphawk_param_t hh;
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
   Stat->flex_flegx_detect_process_done      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x58);
   Stat->flex_flegx_present                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x5C);
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
   Stat->flegx_present                 =(Stat->flex_flegx_present & Stat->adc_brd_spare);

   Stat->prog_init_done                = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x88);
   Stat->cooler_on_curr_min_mA         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x8C);
   Stat->cooler_off_curr_max_mA        = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x90);
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

//------------------------------------------------
// Envoi de la config des dacs et autres
//-----------------------------------------------
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA)
{
   uint8_t ii = 0;
   
   // envoi comfig des Dacs
   while(ii < TOTAL_DAC_NUM)
   {
      AXI4L_write32(ptrD->vdac_value[ii], ptrA->ADD + AW_DAC_CFG_BASE_ADD + 4*ii);  // dans le vhd, division par 4 avant entr�e dans ram
      ii++;
   }
}
