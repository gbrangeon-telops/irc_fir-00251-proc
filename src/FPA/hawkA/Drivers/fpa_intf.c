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

// Mode d'operation choisi pour le contrôleur de trig 
#define MODE_READOUT_END_TO_TRIG_START    0x00      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du ITR uniquement
#define MODE_INT_END_TO_TRIG_START        0x02      // provient du fichier fpa_common_pkg.vhd. Ce mode est celui du IWR et ITR

// Gains definis par Indigo  
#define FPA_GAIN_0                        0x00      // petit puits
#define FPA_GAIN_1                        0x01      // 
#define FPA_GAIN_2                        0x02      // 
#define FPA_GAIN_3                        0x03      // gros puits
 
// adresse la lecture des statuts VHD
#define AR_STATUS_BASE_ADD                0x0400    // adresse de base 
#define AR_FPA_TEMPERATURE                0x002C    // adresse temperature

// adresse d'écriture du régistre du type du pilote C 
#define AW_FPA_ROIC_SW_TYPE               0xAE0      // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xAE4      // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE              0xAE8      // obligaoire pour les deteceteurs analogiques

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD               0x0D00   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x13      // 0x13 -> hawkA . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x01 est celle de OUTPUT_ANALOG
#define FPA_INPUT_TYPE                    0x04      // 0x04 -> input LVCMOS33 .provient du fichier fpa_common_pkg.vhd. La valeur 0x04 est celle de LVCMOS33

// identification des sources de données
#define DATA_SOURCE_INSIDE_FPGA           0         // Provient du fichier fpa_common_pkg.vhd.
#define DATA_SOURCE_OUTSIDE_FPGA          1         // Provient du fichier fpa_common_pkg.vhd.

// adresse d'écriture du régistre du reset des erreurs
#define AW_RESET_ERR                      0xAEC

 // adresse d'écriture du régistre du reset du module FPA
#define AW_CTRLED_RESET                   0xAF0

// Differents types de mode diagnostic (vient du fichier fpa_define.vhd et de la doc de Mglk)
#define TELOPS_DIAG_CNST                  0xD1      // mode diag constant (patron de test generé par la carte d'acquisition : tous les pixels à la même valeur) 
#define TELOPS_DIAG_DEGR                  0xD2      // mode diag dégradé linéaire(patron de test dégradé linéairement et généré par la carte d'acquisition).Requis en production
#define TELOPS_DIAG_DEGR_DYN              0xD3      // mode diag dégradé linéaire dynamique(patron de test dégradé linéairement et variant d'image en image et généré par la carte d'acquisition)  

#define VHD_INVALID_TEMP                  0xFFFFFFFF                                                  

// horloges du module FPA
#define VHD_CLK_100M_RATE_HZ              100000000
#define VHD_CLK_80M_RATE_HZ                80000000
#define ADC_SAMPLING_RATE_HZ              FPA_MCLK_RATE_HZ    // les ADC  roulent à FPA_MCLK_RATE_HZ

// lecture de température FPA
#define FPA_TEMP_READER_ADC_DATA_RES      16            // la donnée de temperature est sur 16 bits
#define FPA_TEMP_READER_FULL_SCALE_mV     2048          // plage dynamnique de l'ADC
#define FPA_TEMP_READER_GAIN              1             // gain du canal de lecture de temperature sur la carte ADC

// les DAcs de la carte Fleg
#define HAWK_VDD_VOLTAGE_V                6             // VDD en volts
#define HAWK_PRV_VOLTAGE_V                5.8           // PRV en volts

// fleg
#define FLEG_DAC_RESOLUTION_BITS          14            // le DAC est à 14 bits
#define FLEG_DAC_REF_VOLTAGE_V            2.5           // on utilise la reference interne de 2.5V du DAC 
#define FLEG_DAC_REF_GAIN                 2.0           // gain de référence du DAC


#define VHD_PIXEL_PIPE_DLY_SEC            300E-9        // delai max du pipe des pixels

#define GOOD_SAMP_MEAN_DIV_BIT_POS        21            // ne pas changer meme si le detecteur change.

#define HAWK_DIG_VOLTAGE_MIN_mV           400           // 400 mV
#define HAWK_DIG_VOLTAGE_MAX_mV           2810          // 2810 mV
 
#define FPA_XTRA_TRIG_FREQ_MAX_HZ         100           // ENO: 25 janv 2016: la programmation du dtecteur se fera à cette vitesse au max. Cela donnera assez de coups d'horloges pour les resets quelle que soit la config de fenetre

#define HAWK_TAPREF_VOLTAGE_MIN_mV        2600           // valeur en provenance du fichier fpa_define
#define HAWK_TAPREF_VOLTAGE_MAX_mV        6100           // valeur en provenance du fichier fpa_define

#define HAWK_CONST_ELEC_OFFSET_VALUE      340            //correction d'offset non implantée sur Hawk

#define TOTAL_DAC_NUM                     8

# define HAWK_CBIT_LEN                    48             // CBIT a une longueur de 48 bits




struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du hawk
struct hawk_param_s             // 
{					   
   // parametres à rentrer
   float mclk_period_usec;                       
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;   
   float int_time_offset_mclk;   
   
   // parametres calculés
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
typedef struct hawk_param_s  hawk_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
uint8_t init_done = 0;
ProximCfg_t ProximCfg = {{0, 0, 0, 0,  0, 0, 0, 2200}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);

void FPA_SpecificParams(hawk_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);

//--------------------------------------------------------------------------
// pour initialiser le module vhd avec les bons parametres de départ
//--------------------------------------------------------------------------
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs)
{   
   init_done = 0;
   FPA_Reset(ptrA);
   FPA_SoftwType(ptrA);                                                     // dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
   FPA_ClearErr(ptrA);                                                      // effacement des erreurs non valides Mglk Detector
   FPA_GetTemperature(ptrA);                                                // demande de lecture
   FPA_SendConfigGC(ptrA, pGCRegs);                                         // commande par defaut envoyée au vhd qui le stock dans une RAM. Il attendra l'allumage du proxy pour le programmer
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
   hawk_param_t hh;
   extern int16_t gFpaDetectorPolarizationVoltage;
   extern float gFpaDetectorElectricalTapsRef;
   static int16_t presentPolarizationVoltage = 10;   // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   static float presentElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul 
   //extern int32_t gFpaDebugRegA;                         // reservé ELCORR pour correction électronique (gain et/ou offset)
   //extern int32_t gFpaDebugRegB;                         // reservé
   extern int32_t gFpaDebugRegC;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                         // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                         // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   extern int32_t gFpaDebugRegG;                         // non utilisé
   float Nr, Nc, No, R, H, C, W;
   static uint8_t cfg_num = 0; 
   
   
   // on bâtit les parametres specifiques du hawk
   FPA_SpecificParams(&hh, 0.0F, pGCRegs);               //le temps d'integration est nul . Mais le VHD ajoutera le int_time pour avoir la vraie periode
   
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
   
   // gFpaDebugRegE: mode diag vrai et faked
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
   
   // allumage du détecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   ptrA->fpa_acq_trig_mode         = (uint32_t)MODE_INT_END_TO_TRIG_START;    
   ptrA->fpa_acq_trig_ctrl_dly     = (uint32_t)((hh.frame_period_usec*1e-6F - (float)VHD_PIXEL_PIPE_DLY_SEC) * (float)VHD_CLK_100M_RATE_HZ);
   ptrA->fpa_xtra_trig_mode        = (uint32_t)MODE_READOUT_END_TO_TRIG_START;
   ptrA->fpa_xtra_trig_ctrl_dly    = ptrA->fpa_acq_trig_ctrl_dly;
   ptrA->fpa_trig_ctrl_timeout_dly = (uint32_t)((float)VHD_CLK_100M_RATE_HZ / (float)FPA_XTRA_TRIG_FREQ_MAX_HZ); //(uint32_t)(0.8F*(hh.frame_period_usec*1e-6F)* (float)VHD_CLK_100M_RATE_HZ);                    

   // fenetrage
   ptrA->xstart    = (uint32_t)pGCRegs->OffsetX;
   ptrA->ystart    = (uint32_t)pGCRegs->OffsetY;
   ptrA->xsize     = (uint32_t)pGCRegs->Width;
   ptrA->ysize     = (uint32_t)pGCRegs->Height;
    
   //  gain 
   ptrA->gain = FPA_GAIN_3;   	//Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_0;	//High gain
      
   // direction de readout
   ptrA->invert = 0;//(uint32_t)FPA_HAWK_VERTICAL_FLIP;
   ptrA->revert = 0; 
   
   // formule implantée pour le mode normal (revert = 0, Invert = 0)
   Nr = (float)FPA_HEIGHT_MAX;
   Nc = (float)FPA_WIDTH_MAX;
   No = (float)FPA_NUMTAPS;
   
   // ENO   20 avril 2016 : la formule de Selex semble ne pas marcher. Celle ci-dessous a été établie par moi-meme et marche très bien.
   // à la formule de la doc qui est 
   R = (float)pGCRegs->OffsetY + 1.0F;        //  frame pixel row start index  
   H = (float)pGCRegs->Height;                //  frame height in pixels 
   C = (float)pGCRegs->OffsetX + 1.0F;        //  frame pixel column start index 
   W = (float)pGCRegs->Width;                 //  frame width in pixels                 
   
   // nous avons fait un ajustement (patch de soustraction de 1 et 4 sur la formule de R et C)pour tenir compte des decalages de sous-fenetres observés par PTR lors des tests du Hawk.
   // Toutefois, cela crée un autre problème sur les fenetres pleines. Nous avons donc effectué un second patch qui se matérialise par les IF qu'on retrouve sur a->FPA_Mpos et a->FPA_Kpos
   if ((uint32_t)pGCRegs->Height != (uint32_t)FPA_HEIGHT_MAX)   
      R = (float)pGCRegs->OffsetY;            // sub frame pixel row start index  
   if ((uint32_t)pGCRegs->Width != (uint32_t)FPA_WIDTH_MAX)
      C = (float)pGCRegs->OffsetX - 3;        // sub frame pixel column start index 
      
   ptrA->jpos = (uint32_t)(2.0F * Nr + Nc/No + floorf((C - 1.0F)/No) + 1.0F); 
   ptrA->kpos = (uint32_t)(2.0F * Nr + floorf((C + W - 2.0F)/No) + 1.0F);
   ptrA->lpos = (uint32_t)(Nr + R);
   ptrA->mpos = (uint32_t)(R + H - 1.0F);
     
   // CBIT  
   ptrA->cbit_en = 1;                    
   if ((uint32_t)pGCRegs->Width <= ((uint32_t)HAWK_CBIT_LEN * (uint32_t)FPA_NUMTAPS))  // CBIT descativé dès que la taille de fenetre le le permet pas
      ptrA->cbit_en = 0;
   
   // longueur du registre wdr
   ptrA->wdr_len = (uint32_t)(2.0F * (float)FPA_HEIGHT_MAX	+ (float)FPA_WIDTH_MAX/2.0F);
   
   // mode windowing ou non
   if (((uint32_t)pGCRegs->Width == (uint32_t)FPA_WIDTH_MAX) && ((uint32_t)pGCRegs->Height == (uint32_t)FPA_HEIGHT_MAX))
      ptrA->full_window = 1;
   else
      ptrA->full_window = 0;
      
   // DIG voltage
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage)
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)HAWK_DIG_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)HAWK_DIG_VOLTAGE_MAX_mV))
         ptrA->dig_code = (uint32_t)MAX((2.8183F - (float)gFpaDetectorPolarizationVoltage/1000.0F)/0.0055F, 1.0F);  // dig_code change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
	}                                                                                                       // ENO 28 janv 2016 le else est important pour eviter des erreurs de detPOl
   presentPolarizationVoltage = (int16_t)roundf(1000.0F*(-0.0055F*(float)ptrA->dig_code +  2.8183F));             // DIGREF = -0.0055 x DDR + 2.8183   converti en mV
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage;
   
   // Registre F : ajustement des delais de la chaine
   if (init_done == 0)
      gFpaDebugRegF = 4; 
   ptrA->real_mode_active_pixel_dly = (uint32_t)gFpaDebugRegF;   
   
   // quad2    
   ptrA->adc_quad2_en = 0;                          // ENO : 07 nov 2017 : plus besoin de la diversité de canal dans un Hawk
   ptrA->chn_diversity_en = 0;                      // ENO : 07 nov 2017 : plus besoin de la diversité de canal dans un Hawk
   
   //
   ptrA->line_period_pclk                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS + hh.lovh_mclk;
   ptrA->readout_pclk_cnt_max              = ptrA->line_period_pclk*(ptrA->ysize + hh.fovh_line) + 3;                              // ligne de reset du hawk prise en compte
   
   ptrA->active_line_start_num             = 1;                    // pour le hawk, numero de la première ligne active
   ptrA->active_line_end_num               = ptrA->ysize;          // pour le hawk, numero de la derniere ligne active
   
   // nombre d'échantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch               = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ; 
   
   // identificateurs de trames
   ptrA->sof_posf_pclk                     = hh.lovh_mclk;
   ptrA->eof_posf_pclk                     = ptrA->active_line_end_num * ptrA->line_period_pclk - 1;
   ptrA->sol_posl_pclk                     = hh.lovh_mclk;
   ptrA->eol_posl_pclk                     = ptrA->line_period_pclk - 1;
   ptrA->eol_posl_pclk_p1                  = ptrA->eol_posl_pclk + 1;

   // echantillons choisis
   ptrA->hgood_samp_first_pos_per_ch       = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ;     // position premier echantillon
   ptrA->hgood_samp_last_pos_per_ch        = (uint32_t)ADC_SAMPLING_RATE_HZ/(uint32_t)FPA_MCLK_RATE_HZ;     // position dernier echantillon    ENO: 05 avril 2017: on prend juste un echantillon par canal pour reduire le Ghost. Le bruit augmentera à 6 cnts max sur 16 bits
   ptrA->hgood_samp_sum_num                = ptrA->hgood_samp_last_pos_per_ch - ptrA->hgood_samp_first_pos_per_ch + 1;         
   ptrA->hgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num                = 1 + ptrA->chn_diversity_en;
   ptrA->vgood_samp_mean_numerator         = (uint32_t)(exp2f((float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
      
   // calculs
   ptrA->xsize_div_tapnum                  = ptrA->xsize/(uint32_t)FPA_NUMTAPS;                                        
   
   // les DACs (1 à 8)
   ProximCfg.vdac_value[0]                 = FLEG_VccVoltage_To_DacWord(6000.0F, 1);          // DAC1 -> VDD à 6V
   ProximCfg.vdac_value[1]                 = 0;
   ProximCfg.vdac_value[2]                 = FLEG_VccVoltage_To_DacWord(5800.0F, 3);          // DAC2 -> PRV à 5.8V
   ProximCfg.vdac_value[3]                 = 0;
   ProximCfg.vdac_value[4]                 = 0;
   ProximCfg.vdac_value[5]                 = 0;
   ProximCfg.vdac_value[6]                 = 0;                                               //  VCC7 -> offset1  non tulisé sur le fleg        
 
   // VCC8 ou DAC8
   if (gFpaDetectorElectricalTapsRef != presentElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)HAWK_TAPREF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)HAWK_TAPREF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[7] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 8);  // 
	}                                                                                                       
   presentElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[7], 8);            
   gFpaDetectorElectricalTapsRef = presentElectricalTapsRef;
    
   // gFpaDebugRegC dephasage grossier des adc_clk 
   if (init_done == 0)
      gFpaDebugRegC = 3;
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;                                              
 
   // gFpaDebugRegD dephasage fin des adc_clk 
   if (init_done == 0)         
      gFpaDebugRegD = 450;
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD;    
          
   // Élargit le pulse de trig
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
    // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   if (cfg_num == 255)  // protection contre depassement
      cfg_num = 0;   
   cfg_num++;
   
   ptrA->cfg_num  = (uint32_t)cfg_num;
   
   if (init_done == 0)
      gFpaDebugRegG = 0;
   ptrA->cbit_pipe_dly = (uint32_t)gFpaDebugRegG;   
   
   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
   
   // envoi du reste de la config 
   WriteStruct(ptrA);
   
   //   FPA_PRINTF("pGCRegs->OffsetX = %d", (uint32_t)pGCRegs->OffsetX);
   //   FPA_PRINTF("pGCRegs->OffsetY = %d", (uint32_t)pGCRegs->OffsetY);
   //   FPA_PRINTF("pGCRegs->Width = %d", (uint32_t)pGCRegs->Width);
   //   FPA_PRINTF("pGCRegs->Height = %d", (uint32_t)pGCRegs->Height);
   //   
   //   FPA_PRINTF(" fpa_diag_mode                  =  %d", (uint32_t)ptrA->fpa_diag_mode                );  
   //   FPA_PRINTF(" fpa_diag_type                  =  %d", (uint32_t)ptrA->fpa_diag_type                );  
   //   FPA_PRINTF(" fpa_pwr_on                     =  %d", (uint32_t)ptrA->fpa_pwr_on                   );  
   //   FPA_PRINTF(" fpa_acq_trig_mode             =  %d", (uint32_t)ptrA->fpa_acq_trig_mode           );  
   //   FPA_PRINTF(" fpa_acq_trig_ctrl_dly          =  %d", (uint32_t)ptrA->fpa_acq_trig_ctrl_dly        );  
   //   FPA_PRINTF(" fpa_xtra_trig_mode                      =  %d", (uint32_t)ptrA->fpa_xtra_trig_mode                    );  
   //   FPA_PRINTF(" fpa_xtra_trig_ctrl_dly         =  %d", (uint32_t)ptrA->fpa_xtra_trig_ctrl_dly       );  
   //   FPA_PRINTF(" fpa_trig_ctrl_timeout_dly      =  %d", (uint32_t)ptrA->fpa_trig_ctrl_timeout_dly    );                                      
   //   FPA_PRINTF(" xstart                         =  %d", (uint32_t)ptrA->xstart                       );  
   //   FPA_PRINTF(" ystart                         =  %d", (uint32_t)ptrA->ystart                       );  
   //   FPA_PRINTF(" xsize                          =  %d", (uint32_t)ptrA->xsize                        );  
   //   FPA_PRINTF(" ysize                          =  %d", (uint32_t)ptrA->ysize                        );  
   //   FPA_PRINTF(" gain                           =  %d", (uint32_t)ptrA->gain                         );  
   //   FPA_PRINTF(" invert                         =  %d", (uint32_t)ptrA->invert                       );  
   //   FPA_PRINTF(" revert                         =  %d", (uint32_t)ptrA->revert                       );  
   //   FPA_PRINTF(" cbit_en                        =  %d", (uint32_t)ptrA->cbit_en                      );  
   //   FPA_PRINTF(" dig_code                       =  %d", (uint32_t)ptrA->dig_code                     );  
   //   FPA_PRINTF(" jpos                           =  %d", (uint32_t)ptrA->jpos                         );  
   //   FPA_PRINTF(" kpos                           =  %d", (uint32_t)ptrA->kpos                         );  
   //   FPA_PRINTF(" lpos                           =  %d", (uint32_t)ptrA->lpos                         );  
   //   FPA_PRINTF(" mpos                           =  %d", (uint32_t)ptrA->mpos                         );  
   //   FPA_PRINTF(" wdr_len                        =  %d", (uint32_t)ptrA->wdr_len                      );  
   //   FPA_PRINTF(" full_window                    =  %d", (uint32_t)ptrA->full_window                  );  
   //   FPA_PRINTF(" real_mode_active_pixel_dly     =  %d", (uint32_t)ptrA->real_mode_active_pixel_dly   );  
   //   FPA_PRINTF(" adc_quad2_en                   =  %d", (uint32_t)ptrA->adc_quad2_en                 );  
   //   FPA_PRINTF(" chn_diversity_en               =  %d", (uint32_t)ptrA->chn_diversity_en             );  
   //   FPA_PRINTF(" readout_pclk_cnt_max           =  %d", (uint32_t)ptrA->readout_pclk_cnt_max         );  
   //   FPA_PRINTF(" line_period_pclk               =  %d", (uint32_t)ptrA->line_period_pclk             );  
   //   FPA_PRINTF(" active_line_start_num          =  %d", (uint32_t)ptrA->active_line_start_num        );  
   //   FPA_PRINTF(" active_line_end_num            =  %d", (uint32_t)ptrA->active_line_end_num          );  
   //   FPA_PRINTF(" pix_samp_num_per_ch            =  %d", (uint32_t)ptrA->pix_samp_num_per_ch          );  
   //   FPA_PRINTF(" sof_posf_pclk                  =  %d", (uint32_t)ptrA->sof_posf_pclk                );  
   //   FPA_PRINTF(" eof_posf_pclk                  =  %d", (uint32_t)ptrA->eof_posf_pclk                );  
   //   FPA_PRINTF(" sol_posl_pclk                  =  %d", (uint32_t)ptrA->sol_posl_pclk                );  
   //   FPA_PRINTF(" eol_posl_pclk                  =  %d", (uint32_t)ptrA->eol_posl_pclk                );  
   //   FPA_PRINTF(" eol_posl_pclk_p1               =  %d", (uint32_t)ptrA->eol_posl_pclk_p1             );  
   //   FPA_PRINTF(" hgood_samp_sum_num             =  %d", (uint32_t)ptrA->hgood_samp_sum_num           );  
   //   FPA_PRINTF(" hgood_samp_mean_numerator      =  %d", (uint32_t)ptrA->hgood_samp_mean_numerator    );  
   //   FPA_PRINTF(" vgood_samp_sum_num             =  %d", (uint32_t)ptrA->vgood_samp_sum_num           );  
   //   FPA_PRINTF(" vgood_samp_mean_numerator      =  %d", (uint32_t)ptrA->vgood_samp_mean_numerator    );  
   //   FPA_PRINTF(" hgood_samp_first_pos_per_ch    =  %d", (uint32_t)ptrA->hgood_samp_first_pos_per_ch  );  
   //   FPA_PRINTF(" hgood_samp_last_pos_per_ch     =  %d", (uint32_t)ptrA->hgood_samp_last_pos_per_ch   );  
   //   FPA_PRINTF(" xsize_div_tapnum               =  %d", (uint32_t)ptrA->xsize_div_tapnum             );                 
   //   FPA_PRINTF(" adc_clk_source_phase           =  %d", (uint32_t)ptrA->adc_clk_source_phase         );  
   //   FPA_PRINTF(" adc_clk_pipe_sel               =  %d", (uint32_t)ptrA->adc_clk_pipe_sel             );  
   //   FPA_PRINTF(" cfg_num                        =  %d", (uint32_t)ptrA->cfg_num                      );  
   //   FPA_PRINTF(" fpa_stretch_acq_trig           =  %d", (uint32_t)ptrA->fpa_stretch_acq_trig         );  
   //   FPA_PRINTF(" fpa_intf_data_source           =  %d", (uint32_t)ptrA->fpa_intf_data_source         ); 
}

//--------------------------------------------------------------------------                                                                            
// Pour avoir la température du FPA
//--------------------------------------------------------------------------
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA)
{
   uint32_t raw_temp;
   float diode_voltage;
   float temperature;
   float TempCoeff[2];
   
   raw_temp = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + AR_FPA_TEMPERATURE);  // lit le registre de temperature (fort probablement pas le présent mais le passé) 
   raw_temp = (raw_temp & 0x0000FFFF);

   diode_voltage = (float)raw_temp*((float)FPA_TEMP_READER_FULL_SCALE_mV/1000.0F)/(exp2f(FPA_TEMP_READER_ADC_DATA_RES)*(float)FPA_TEMP_READER_GAIN);
  
   if (diode_voltage >= 1.056) {
      TempCoeff[0] = 676.9270F;                                                     
      TempCoeff[1] = -573.9683F; 
   }
   else if ((diode_voltage >= 1.049)&&(diode_voltage < 1.056)) {
      TempCoeff[0] =  964.8404F;                                                     
      TempCoeff[1] = -846.6000F;
   }
   else if ((diode_voltage >= 1.020)&&(diode_voltage < 1.049)) {
      TempCoeff[0] = 540.7409F;                                                     
      TempCoeff[1] = -442.2857F;
   }
   else if ((diode_voltage >= 0.860)&&(diode_voltage < 1.020)) { 
      TempCoeff[0] = 587.7490F;                                                   
      TempCoeff[1] = -488.3721F; 
   }
   else { 
      TempCoeff[0] = 651.4990F;                                                     
      TempCoeff[1] = -562.5000F;  
   }
   
   temperature = TempCoeff[0] + (diode_voltage*TempCoeff[1]);  
   
   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius  
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au hawk avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(hawk_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 1.0F;
   ptrH->fpa_delay_mclk          = 7.33F;   // FPA: delai de sortie des pixels après integration   ENO: 08 fev 2016: aucune justification dans le doc du Hawk pour maintenauir ce delai à 9. Je le fais passer à 9.33 pour avoir 120Kfps en 64x2
   ptrH->vhd_delay_mclk          = 2.0F;   // estimation des differerents delais accumulés par le vhd
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 8.0F;
   ptrH->fovh_line               = 1.0F;
   ptrH->int_time_offset_mclk    = 0.0F;   // aucun offset sur le temps d'integration
      
   // readout time
   ptrH->readout_mclk         = (pGCRegs->Width/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) + ptrH->lovh_mclk)*(pGCRegs->Height + ptrH->fovh_line);
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec       = ptrH->fpa_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mclk_period_usec; 
   
   // 
   ptrH->int_time_offset_usec  = ptrH->int_time_offset_mclk * ptrH->mclk_period_usec; 
      
   // calcul de la periode minimale
   ptrH->frame_period_usec = (exposureTime_usec + ptrH->int_time_offset_usec) + ptrH->delay_usec + ptrH->readout_usec;
   
   //calcul du frame rate maximal
   ptrH->frame_rate_max_hz = 1.0F/(ptrH->frame_period_usec*1e-6F);
}
 
//--------------------------------------------------------------------------                                                                            
// Pour avoir le frameRateMax avec une config donnée
//--------------------------------------------------------------------------
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs)
{
   float MaxFrameRate; 
   hawk_param_t hh;
   
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
   hawk_param_t hh;
   float periodMinWithNullExposure_usec;
   float presentPeriod_sec;
   float max_exposure_usec;
   float fpaAcquisitionFrameRate;
   
   // ENO: 10 sept 2016: d'entrée de jeu, on enleve la marge artificielle pour retrouver la vitesse reelle du detecteur   
   fpaAcquisitionFrameRate = pGCRegs->AcquisitionFrameRate/(1.0F - gFpaPeriodMinMargin);
   
   // ENO: 10 sept 2016: tout reste inchangé
   FPA_SpecificParams(&hh, 0.0F, pGCRegs); // periode minimale admissible si le temps d'exposition était nulle
   periodMinWithNullExposure_usec = hh.frame_period_usec;
   presentPeriod_sec = 1.0F/fpaAcquisitionFrameRate; // periode avec le frame rate actuel.
   
   max_exposure_usec = (presentPeriod_sec*1e6F - periodMinWithNullExposure_usec);

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
   Stat->intf_seq_stat                       = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x40);
   Stat->data_path_stat                      = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x44);
   Stat->trig_ctler_stat                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x48);
   Stat->fpa_driver_stat                     = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x4C);
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
   
   Stat->acq_trig_cnt                  = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x94);
   Stat->acq_int_cnt                   = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x98);
   Stat->fpa_readout_cnt               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0x9C);        
   Stat->acq_readout_cnt               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA0);  
   Stat->out_pix_cnt_min               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA4);  
   Stat->out_pix_cnt_max               = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xA8);
   Stat->trig_to_int_delay_min         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xAC);
   Stat->trig_to_int_delay_max         = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB0);
   Stat->int_to_int_delay_min          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB4);
   Stat->int_to_int_delay_max          = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xB8);    
   Stat->fast_hder_cnt                 = AXI4L_read32(ptrA->ADD + AR_STATUS_BASE_ADD + 0xBC);
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
   float Rs, Rd, RL, Is, DacVoltage_Volt, DacWordTemp;
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
   DacWordTemp = exp2f((float)FLEG_DAC_RESOLUTION_BITS) * DacVoltage_Volt/((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN);
   DacWord = (uint32_t) MAX(MIN(roundf(DacWordTemp), 16383.0F), 0.0F);
   
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
   DacVoltage_Volt = (float)DacWordTemp * ((float)FLEG_DAC_REF_VOLTAGE_V*(float)FLEG_DAC_REF_GAIN)/exp2f((float)FLEG_DAC_RESOLUTION_BITS);
   
   //calculs de la tension du LDO en volt
   VccVoltage_mV = 1000.0F * (DacVoltage_Volt * (RL/Rd) + (Rs + RL + RL/Rd*Rs)*Is)/(1.0F + RL/Rd);
   
   return roundf(VccVoltage_mV);
}

//------------------------------------------------
// Envoi de la config des dacs
//-----------------------------------------------
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA)
{
   uint8_t ii = 0;
   
   // envoi config des Dacs
   while(ii < TOTAL_DAC_NUM)
   {
      AXI4L_write32(ptrD->vdac_value[ii], ptrA->ADD + AW_DAC_CFG_BASE_ADD + 4*ii);  // dans le vhd, division par 4 avant entrée dans ram
      ii++;
   }
}
