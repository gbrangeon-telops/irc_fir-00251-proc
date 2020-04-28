/*-----------------------------------------------------------------------------
--
-- Title       : FPA Driver
-- Author      : Edem Nofodjie
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 22281 $
-- $Author: enofodjie $
-- $LastChangedDate: 2018-09-27 21:10:58 -0400 (jeu., 27 sept. 2018) $
--
-------------------------------------------------------------------------------
--
-- Description : 
--
------------------------------------------------------------------------------*/

#include "GeniCam.h"
#include "fpa_intf.h"
#include "flashSettings.h"
#include "utils.h"
#include "IRC_status.h"
#include "CRC.h"
#include <math.h>
#include <string.h>
#include "exposure_time_ctrl.h"

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
#define AW_FPA_ROIC_SW_TYPE               0xAE0      // adresse à lauquelle on dit au VHD quel type de roiC de fpa le pilote en C est conçu pour.
#define AW_FPA_OUTPUT_SW_TYPE             0xAE4      // adresse à lauquelle on dit au VHD quel type de sortie de fpa e pilote en C est conçu pour.
#define AW_FPA_INPUT_SW_TYPE              0xAE8      // obligaoire pour les deteceteurs analogiques

// adresse d'ecriture de la cfg des Dacs
#define AW_DAC_CFG_BASE_ADD               0x0D00

// adresse d'ecriture signifiant la fin de la commande serielle pour le vhd
#define AW_SERIAL_CFG_END_ADD             (0x0FFC | AW_SERIAL_CFG_SWITCH_ADD)   

//informations sur le pilote C. Le vhd s'en sert pour compatibility check
#define FPA_ROIC                          0x12      // 0x12 -> 0207 . Provient du fichier fpa_common_pkg.vhd.
#define FPA_OUTPUT_TYPE                   0x01      // 0x01 -> output analogique .provient du fichier fpa_common_pkg.vhd. La valeur 0x02 est celle de OUTPUT_DIGITAL
#define FPA_INPUT_TYPE                    0x03      // 0x03 -> input LVTTL50 .provient du fichier fpa_common_pkg.vhd. La valeur 0x03 est celle de LVTTL50

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

// horloge des ADCs
#define ADC_SAMPLING_RATE_HZ  (2*FPA_MCLK_RATE_HZ)

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
#define ISC0207_REFOFS_VOLTAGE_MAX_mV     5300

#define TOTAL_DAC_NUM                     8            // 8 dac au total
#define ISC0207_FASTWINDOW_STRECTHING_AREA_MCLK  0     // largeur de la zone d'exclusion/etirement du fast windowing 
#define ROIC_UNUSED_AREA_CLK_RATE_HZ     (2*FPA_MCLK_RATE_HZ)

// Electrical correction : references
#define ELCORR_REF0_VALUE_mV              1800        
#define ELCORR_REF1_VALUE_mV              4100
#define ELCORR_REF_DAC_ID                 4                   // position (entre 1 et 8) du dac dédié aux references 
#define ELCORR_REF_MAXIMUM_SAMP           120                 // le nombre de sample au max supporté par le vhd

// Electrical correction : embedded switches control
#define ELCORR_SW_TO_PATH1                0x01
#define ELCORR_SW_TO_PATH2                0x02
#define ELCORR_SW_TO_NORMAL_OP            0x03 

#define ELCORR_CONT_MODE_OFFSETX_MIN      FPA_WIDTH_MAX // pour le ISC0207, cela revient à ne jamais etre en mode continuel pour le gain électronique puisque le flex comprend toujours la pin OUTR reliée au detecteur. Ce qui n'Est pas le cas du 0804

// Electrical correction : valeurs mesurées avant correction 
#define ELCORR_MEASURED_ADCCNT_AT_STARVATION     425          // @ centered pix (320, 256)
#define ELCORR_MEASURED_ADCCNT_AT_SATURATION     16210        // @ centered pix (320, 256)
#define ELCORR_MEASURED_ADCCNT_FOR_REF0          12200        // @ centered pix (320, 256)
#define ELCORR_MEASURED_ADCCNT_FOR_REF1          458          // @ centered pix (320, 256)

// Electrical correction : valeurs cibles (desirées) apres correction
#define ELCORR_TARGET_ADCCNT_AT_STARVATION       500
#define ELCORR_TARGET_ADCCNT_AT_SATURATION       16000 


struct s_ProximCfgConfig 
{   
   uint32_t  vdac_value[(uint8_t)TOTAL_DAC_NUM];
   uint32_t  spare1;                       
   uint32_t  spare2;   
};                                  
typedef struct s_ProximCfgConfig ProximCfg_t;

// structure interne pour les parametres du 0207
struct isc0207_param_s             // 
{					   
   float mclk_period_usec;
   float tap_number;
   float pixnum_per_tap_per_mclk;
   float fpa_delay_mclk;
   float vhd_delay_mclk;
   float delay_mclk;
   float lovh_mclk;
   float fovh_line;
   float tsh_min_usec;
   float trst_min_usec;
   float itr_tri_min_usec;
   float int_time_offset_usec;
   
   float roic_xsize; 
   float roic_ysize; 
   float roic_xstart;
   float roic_ystart;
   
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
   float unused_area_clock_factor;
   float adc_sync_dly_mclk;
   float line_stretch_mclk;

   float pclk_rate_hz;
};
typedef struct isc0207_param_s  isc0207_param_t;

// Global variables
uint8_t FPA_StretchAcqTrig = 0;
float gFpaPeriodMinMargin = 0.0F;
//uint32_t accelerationReg = 1;
uint32_t speedup_unused_area = 0;        // les speed_up n'ont que deux valeurs : 0 ou 1
uint8_t init_done = 0;
ProximCfg_t ProximCfg = {{12812, 12812, 12812, 8271, 8440, 12663, 5062, 12812}, 0, 0};   // les valeurs d'initisalisation des dacs sont les 8 premiers chiffres

// Prototypes fonctions internes
void FPA_SoftwType(const t_FpaIntf *ptrA);
void FPA_Reset(const t_FpaIntf *ptrA);
float FLEG_DacWord_To_VccVoltage(const uint32_t DacWord, const int8_t VccPosition);
uint32_t FLEG_VccVoltage_To_DacWord(const float VccVoltage_mV, const int8_t VccPosition);
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA);
void FPA_SpecificParams(isc0207_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs);

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
   isc0207_param_t hh;   
   uint32_t test_pattern_dly;
   extern int16_t gFpaDetectorPolarizationVoltage;
   static int16_t presentPolarizationVoltage = 700;      //  700 mV comme valeur par defaut pour GPOL
   extern float gFpaDetectorElectricalTapsRef;
   extern float gFpaDetectorElectricalRefOffset;
   extern int32_t gFpaDebugRegA;                         // reservé ELCORR pour correction électronique (gain et/ou offset)
   extern int32_t gFpaDebugRegB;                         // reservé ROIC Bistream après validation du mot de passe 
   extern int32_t gFpaDebugRegC;                         // reservé adc_clk_pipe_sel pour ajustemnt grossier phase adc_clk
   extern int32_t gFpaDebugRegD;                         // reservé adc_clk_source_phase pour ajustement fin phase adc_clk
   extern int32_t gFpaDebugRegE;                         // reservé fpa_intf_data_source pour sortir les données des ADCs même lorsque le détecteur/flegX est absent
   extern int32_t gFpaDebugRegF;                         // reservé real_mode_active_pixel_dly pour ajustement du début AOI
   static float presentElectricalTapsRef = 10;       // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul 
   static float presentElectricalRefOffset = 0;      // valeur arbitraire d'initialisation. La bonne valeur sera calculée apres passage dans la fonction de calcul
   uint32_t elcorr_reg;
   t_FpaStatus Stat;
   static uint8_t cfg_num = 0;
   uint32_t elcorr_enabled = 1;
   uint32_t elcorr_gain_corr_enabled = 0;
   float elcorr_comp_duration_usec;                 // la duree en usec disponible pour la prise des references
   float elcorr_atemp_gain;
   float elcorr_atemp_ofs;
   extern int32_t gFpaExposureTimeOffset;

	
   FPA_GetStatus(&Stat, ptrA);

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
    
   // Élargit le pulse de trig au besoin
   ptrA->fpa_stretch_acq_trig = (uint32_t)FPA_StretchAcqTrig;
   
   // mode diag vrai et faked
   ptrA->fpa_intf_data_source = DATA_SOURCE_INSIDE_FPGA;     // fpa_intf_data_source n'est utilisé/regardé par le vhd que lorsque fpa_diag_mode = 1
   if (ptrA->fpa_diag_mode == 1){
      if ((int32_t)gFpaDebugRegE != 0)
         ptrA->fpa_intf_data_source = DATA_SOURCE_OUTSIDE_FPGA;
   }
    
   // allumage du détecteur 
   ptrA->fpa_pwr_on  = 1;    // le vhd a le dernier mot. Il peut refuser l'allumage si les conditions ne sont pas réunies
   
   // config du contrôleur de trigs
   ptrA->fpa_trig_ctrl_mode        = (uint32_t)MODE_INT_END_TO_TRIG_START;  // permet de supporter le mode ITR et IWR et la pleine vitesse 
   ptrA->fpa_acq_trig_ctrl_dly     = 0;   // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculée dans le vhd à partir du temps d'integration
   ptrA->fpa_spare                 = 0;   // 
   ptrA->fpa_trig_ctrl_timeout_dly = 0;   // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculée dans le vhd à partir du temps d'integration
   ptrA->fpa_xtra_trig_ctrl_dly    = 0;   // ENO: 20 août 2015: pour isc0207, valeur arbitraire car valeur reelle sera calculée dans le vhd à partir du temps d'integration
   
   // parametres envoyés au VHD pour calculer fpa_acq_trig_ctrl_dly, fpa_trig_ctrl_timeout_dly, fpa_xtra_trig_ctrl_dly
   ptrA->readout_plus_delay            =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * (hh.readout_usec + hh.delay_usec - hh.vhd_delay_usec)*1e-6F);  // (readout_time + delay -vhd_delay) converti en coups de 100MHz
   ptrA->tri_window_and_intmode_part   =  (uint32_t)((float)VHD_CLK_100M_RATE_HZ * hh.tri_window_and_intmode_part_usec*1e-6F);        //   tri_window_and_intmode_part_usec converti en coups de 100MHz
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
      
   // configuration envoyée donc au ROIC du FPA
   ptrA->roic_xsize   = (uint32_t)hh.roic_xsize;
   ptrA->roic_xstart  = (uint32_t)hh.roic_xstart;
   ptrA->roic_ystart  = (uint32_t)hh.roic_ystart;
   ptrA->roic_ysize_div2_m1 = (uint32_t)hh.roic_ysize/2 - 1;
   
   // diag window param   
   ptrA->diag_ysize             = (uint32_t)pGCRegs->Height;
   ptrA->diag_xsize_div_tapnum  = (uint32_t)pGCRegs->Width/(uint32_t)FPA_NUMTAPS;
   
   //  gain 
   ptrA->gain = FPA_GAIN_1;	//Low gain
   if (pGCRegs->SensorWellDepth == SWD_HighGain)
      ptrA->gain = FPA_GAIN_0;	//High gain
      
   // misc
   ptrA->internal_outr = 0;
   ptrA->boost_mode = 0;
   
   // delai LsyDel
   ptrA->lsydel_mclk = 2;           // LSYDEL en MCLK, obtenu par test live de dissimulation des bandes en sous-fenetrage sur M3K
   
   // ajustement de delais de la chaine
   if (init_done == 0)
     gFpaDebugRegF  = 13;         // ENO: 05 nov 2019: valeur ajustée sur M2K avec fleGX
   ptrA->real_mode_active_pixel_dly  = (uint32_t)gFpaDebugRegF;
      
   // accélerateurs 
   ptrA->speedup_lsydel          = 0;
   ptrA->speedup_sample_row      = 0;
   ptrA->speedup_lsync           = 0;
   ptrA->speedup_unused_area     = speedup_unused_area;
  
   // raw area
   ptrA->raw_area_line_start_num       = 1;
   ptrA->raw_area_line_end_num         = (uint32_t)hh.roic_ysize + ptrA->raw_area_line_start_num - 1;
   ptrA->raw_area_line_period_pclk     = ((uint32_t)hh.roic_xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)+ hh.lovh_mclk) *  hh.pixnum_per_tap_per_mclk; 
   ptrA->raw_area_sof_posf_pclk        = ptrA->raw_area_line_period_pclk * (ptrA->raw_area_line_start_num - 1) + 1;                 
   ptrA->raw_area_eof_posf_pclk        = ptrA->raw_area_line_end_num * ptrA->raw_area_line_period_pclk - hh.lovh_mclk*hh.pixnum_per_tap_per_mclk;                 
   ptrA->raw_area_sol_posl_pclk        = 1;                 
   ptrA->raw_area_eol_posl_pclk        = ((uint32_t)hh.roic_xsize/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk;                 
   ptrA->raw_area_eol_posl_pclk_p1     = ptrA->raw_area_eol_posl_pclk + 1;
   ptrA->raw_area_readout_pclk_cnt_max = ptrA->raw_area_line_period_pclk * ((uint32_t)hh.roic_ysize + hh.fovh_line + ptrA->raw_area_line_start_num - 1) + 1;
   ptrA->raw_area_window_lsync_num     = (uint32_t)hh.roic_ysize;     // même si pas LSYNC pas envoyé au ROIC en mode ZDT, Le VHD le genere

   // user area
   ptrA->user_area_line_start_num      = ptrA->raw_area_line_start_num; 
   ptrA->user_area_line_end_num        = (uint32_t)pGCRegs->Height + ptrA->user_area_line_start_num - 1;     
   ptrA->user_area_sol_posl_pclk       = (((uint32_t)hh.roic_xsize - (uint32_t)pGCRegs->Width)/2)/FPA_NUMTAPS + 1;
   ptrA->user_area_eol_posl_pclk       = ptrA->user_area_sol_posl_pclk + ((uint32_t)pGCRegs->Width/((uint32_t)FPA_NUMTAPS * hh.pixnum_per_tap_per_mclk)) * hh.pixnum_per_tap_per_mclk - 1;         
   ptrA->user_area_eol_posl_pclk_p1    = ptrA->user_area_eol_posl_pclk + 1;
   
   // stretching area
   ptrA->stretch_area_sol_posl_pclk    = ptrA->user_area_eol_posl_pclk_p1;
   ptrA->stretch_area_eol_posl_pclk    = ptrA->stretch_area_sol_posl_pclk + hh.pixnum_per_tap_per_mclk *(uint32_t)hh.line_stretch_mclk - 1;

   // si ptrA->stretch_area_eol_posl_pclk < ptrA->stretch_area_sol_posl_pclk (ie largeur de zone nulle) alors le vhd comprend qu'il n'y a pas de zone d'étirement


   // nombre d'échantillons par canal  de carte ADC
   ptrA->pix_samp_num_per_ch           = (uint32_t)((float)ADC_SAMPLING_RATE_HZ/(hh.pclk_rate_hz));
   
   // echantillons choisis
   ptrA->good_samp_first_pos_per_ch    = ptrA->pix_samp_num_per_ch;     // position premier echantillon
   ptrA->good_samp_last_pos_per_ch     = ptrA->pix_samp_num_per_ch;     // position dernier echantillon
   ptrA->hgood_samp_sum_num            = ptrA->good_samp_last_pos_per_ch - ptrA->good_samp_first_pos_per_ch + 1;
   ptrA->hgood_samp_mean_numerator     = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->hgood_samp_sum_num);                            
   ptrA->vgood_samp_sum_num            = 1;
   ptrA->vgood_samp_mean_numerator     = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->vgood_samp_sum_num);                              
   
   // les DACs (1 à 8)
   ProximCfg.vdac_value[0]             = FLEG_VccVoltage_To_DacWord(5500.0F, 1);           // DAC1 -> VPOS_OUT à 5.5V
   ProximCfg.vdac_value[1]             = FLEG_VccVoltage_To_DacWord(5500.0F, 2);           // DAC2 -> VPOS     à 5.5V
   ProximCfg.vdac_value[2]             = FLEG_VccVoltage_To_DacWord(5500.0F, 3);           // DAC3 -> VPOS_UC  à 5.5V
   ProximCfg.vdac_value[4]             = FLEG_VccVoltage_To_DacWord(2050.0F, 5);           // DAC5 -> VOS      à 2.05V   (ajustable)
   ProximCfg.vdac_value[7]             = FLEG_VccVoltage_To_DacWord(5500.0F, 8);           // DAC8 -> VPD      à 5.5V
   
   // Reference of the tap (VCC4)      
   if (gFpaDetectorElectricalTapsRef != presentElectricalTapsRef)
   {
      if ((gFpaDetectorElectricalTapsRef >= (float)ISC0207_REF_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalTapsRef <= (float)ISC0207_REF_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[3] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalTapsRef, 4);  //
   }                                                                                                       
   presentElectricalTapsRef = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[3], 4);          
   gFpaDetectorElectricalTapsRef = presentElectricalTapsRef;
   
   // VdetCom Voltage (VCC6)
   if (gFpaDetectorPolarizationVoltage != presentPolarizationVoltage)      // gFpaDetectorPolarizationVoltage est en milliVolt
   {
      if ((gFpaDetectorPolarizationVoltage >= (int16_t)ISC0207_VDETCOM_VOLTAGE_MIN_mV) && (gFpaDetectorPolarizationVoltage <= (int16_t)ISC0207_VDETCOM_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[5] = (int32_t) FLEG_VccVoltage_To_DacWord((float)gFpaDetectorPolarizationVoltage, 6);  // vdetCom change si la nouvelle valeur est conforme. Sinon la valeur precedente est conservée. (voir FpaIntf_Ctor) pour la valeur d'initialisation
   }
   presentPolarizationVoltage = (int16_t)(FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[5], 6));
   gFpaDetectorPolarizationVoltage = presentPolarizationVoltage;                    
   
   // offset of the tap_reference (VCC7)      
   if (gFpaDetectorElectricalRefOffset != presentElectricalRefOffset)
   {
      if ((gFpaDetectorElectricalRefOffset >= (float)ISC0207_REFOFS_VOLTAGE_MIN_mV) && (gFpaDetectorElectricalRefOffset <= (float)ISC0207_REFOFS_VOLTAGE_MAX_mV))
         ProximCfg.vdac_value[6] = (uint32_t) FLEG_VccVoltage_To_DacWord(gFpaDetectorElectricalRefOffset, 7);  // 
	}                                                                                                       
   presentElectricalRefOffset = (float) FLEG_DacWord_To_VccVoltage(ProximCfg.vdac_value[6], 7);            
   gFpaDetectorElectricalRefOffset = presentElectricalRefOffset;
   
   if (init_done == 0)
      gFpaDebugRegC = 3;
   ptrA->adc_clk_pipe_sel = (uint32_t)gFpaDebugRegC;      // ENO: 05 nov 2019: valeur ajustée sur M2K avec fleGX

   if (init_done == 0)
      gFpaDebugRegD = 200;
   ptrA->adc_clk_source_phase = (uint32_t)gFpaDebugRegD;   // ENO: 05 nov 2019: valeur ajustée sur M2K avec fleGX
   
   // autres    
   ptrA->boost_mode              = 0;   // n'est plus utilisé                
   ptrA->adc_clk_pipe_sync_pos   = 2;   // n'est plus utilisé
   
   // correction electronique // registreA : // pour le ISC0207, on ne peut corriger que l'offset électronique puisque le flex/flegx comprend toujours la pin OUTR reliée au detecteur. Ce qui n'Est pas le cas du 0804
   if (init_done == 0){
      if (Stat.flegx_present == 1)
         gFpaDebugRegA = 0;
      else
         gFpaDebugRegA = 0;
   }
   
   elcorr_reg = (uint32_t)gFpaDebugRegA;
   
   if (ptrA->fpa_diag_mode == 1)
      elcorr_reg = 0;
	  
   if ((elcorr_reg == 7) && (Stat.flegx_present == 1)){         // pixeldata avec correction du gain et offset electroniques
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
    
   else if ((elcorr_reg == 6) && (Stat.flegx_present == 1)){    // voutref data avec correction du gain et offset electroniques
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
   
   else if (elcorr_reg == 5){    // pixeldata avec correction de l'offset électronique seulement
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
 
   else if ((elcorr_reg == 3) && (Stat.flegx_present == 1)){    // image map de la difference des references
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
    
   else if ((elcorr_reg == 2)&& (Stat.flegx_present == 1)){   // image map de la reference 2 (1 dans le vhd)
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
   elcorr_comp_duration_usec                  = hh.itr_tri_min_usec;
   
   ptrA->elcorr_enabled                       = elcorr_enabled;
   ptrA->elcorr_spare1                        = 0;              
   ptrA->elcorr_spare2                        = 0;                        
   
   // reference 0:                                              
   ptrA->elcorr_ref_cfg_0_ref_enabled         = 1;               
   ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_0_start_dly_sampclk   = 2;        
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'échantillons par tap 
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_0_samp_num_per_ch - (ptrA->elcorr_ref_cfg_0_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_0_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_0_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_0_samp_mean_numerator = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_0_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_0_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF0_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //      
    
   // reference 1: 
   ptrA->elcorr_ref_cfg_1_ref_enabled         = Stat.flegx_present;  // on active la reference 2 ssi on est rn présence d'un fleG            
   ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode  = 0;              
   ptrA->elcorr_ref_cfg_1_start_dly_sampclk   = 2;        
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)(hh.pixnum_per_tap_per_mclk * elcorr_comp_duration_usec / hh.mclk_period_usec); // nombre brut d'échantillons par tap 
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     =  ptrA->elcorr_ref_cfg_1_samp_num_per_ch - (ptrA->elcorr_ref_cfg_1_start_dly_sampclk + 2.0F); // on eneleve le delai de ce chiffre et aussi 2.0 pour avoir de la marge
   ptrA->elcorr_ref_cfg_1_samp_num_per_ch     = (uint32_t)MIN(ptrA->elcorr_ref_cfg_1_samp_num_per_ch, ELCORR_REF_MAXIMUM_SAMP);
   ptrA->elcorr_ref_cfg_1_samp_mean_numerator = (uint32_t)(powf(2.0F, (float)GOOD_SAMP_MEAN_DIV_BIT_POS)/ptrA->elcorr_ref_cfg_1_samp_num_per_ch);     
   ptrA->elcorr_ref_cfg_1_ref_value           = (uint32_t) FLEG_VccVoltage_To_DacWord((float)ELCORR_REF1_VALUE_mV, (int8_t)ELCORR_REF_DAC_ID);  //
   
   ptrA->elcorr_ref_dac_id                    = (uint32_t)ELCORR_REF_DAC_ID;  //       
   ptrA->elcorr_atemp_gain                    = (int32_t)elcorr_atemp_gain;      
   ptrA->elcorr_atemp_ofs                     = (int32_t)elcorr_atemp_ofs;
   
   // changement de cfg_num des qu'une nouvelle cfg est envoyée au vhd. Il s'en sert pour detecter le mode hors acquisition et ainsi en profite pour calculer le gain electronique
   if (cfg_num == 255)  // protection contre depassement
      cfg_num = 0;   
   cfg_num++;
   
   ptrA->cfg_num  = (uint32_t)cfg_num;
   
   if ((((uint32_t)hh.roic_xsize - (uint32_t)pGCRegs->Width)/2 >= (uint32_t)ELCORR_CONT_MODE_OFFSETX_MIN)  // en fenetrage centré (à réviser si decentrage), on s'assure que le AOI commence au min à ELCORR_CONT_MODE_OFFSETX_MIN pour ne pas souffrir des 64 premieres colonnes bads provenanant du changement de reference
      ||((elcorr_gain_corr_enabled == 1) && (ptrA->roic_cst_output_mode == 1)))
      ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode = 1;
   
   // desactivation en mode patron de tests
   if (ptrA->fpa_diag_mode == 1){
      ptrA->elcorr_enabled = 0;
	   ptrA->elcorr_ref_cfg_0_ref_enabled = 0;
	   ptrA->elcorr_ref_cfg_1_ref_enabled = 0;	  
   }
   
   // additional exposure time offset coming from flash 
   ptrA->additional_fpa_int_time_offset = (int32_t)((float)gFpaExposureTimeOffset*(float)FPA_MCLK_RATE_HZ/(float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ);
 
   // envoi de la configuration de l'électronique de proximité (les DACs en l'occurrence) par un autre canal 
   FPA_SendProximCfg(&ProximCfg, ptrA);
   
   WriteStruct(ptrA);
   
   // FPA_PRINTF("init_done                              = %d", (uint32_t)init_done);
   // FPA_PRINTF("gFpaDebugRegA                          = %d", (uint32_t)gFpaDebugRegA);
   // FPA_PRINTF("gFpaDebugRegB                          = %d", (uint32_t)gFpaDebugRegB);
   // FPA_PRINTF("gFpaDebugRegC                          = %d", (uint32_t)gFpaDebugRegC);
   // FPA_PRINTF("gFpaDebugRegD                          = %d", (uint32_t)gFpaDebugRegD);
   // FPA_PRINTF("gFpaDebugRegE                          = %d", (uint32_t)gFpaDebugRegE);
   // FPA_PRINTF("gFpaDebugRegF                          = %d", (uint32_t)gFpaDebugRegF);  
   // 
   // FPA_PRINTF(" fpa_diag_mode                         =  %d", (uint32_t)ptrA->fpa_diag_mode                        );  
   // FPA_PRINTF(" fpa_diag_type                         =  %d", (uint32_t)ptrA->fpa_diag_type                        );  
   // FPA_PRINTF(" fpa_pwr_on                            =  %d", (uint32_t)ptrA->fpa_pwr_on                           );  
   // FPA_PRINTF(" fpa_trig_ctrl_mode                    =  %d", (uint32_t)ptrA->fpa_trig_ctrl_mode                   );  
   // FPA_PRINTF(" fpa_acq_trig_ctrl_dly                 =  %d", (uint32_t)ptrA->fpa_acq_trig_ctrl_dly                );  
   // FPA_PRINTF(" fpa_spare                             =  %d", (uint32_t)ptrA->fpa_spare                            );  
   // FPA_PRINTF(" fpa_xtra_trig_ctrl_dly                =  %d", (uint32_t)ptrA->fpa_xtra_trig_ctrl_dly               );  
   // FPA_PRINTF(" fpa_trig_ctrl_timeout_dly             =  %d", (uint32_t)ptrA->fpa_trig_ctrl_timeout_dly            );                                      
   // FPA_PRINTF(" fpa_stretch_acq_trig                  =  %d", (uint32_t)ptrA->fpa_stretch_acq_trig                 );  
   // FPA_PRINTF(" diag_ysize                            =  %d", (uint32_t)ptrA->diag_ysize                           );  
   // FPA_PRINTF(" diag_xsize_div_tapnum                 =  %d", (uint32_t)ptrA->diag_xsize_div_tapnum                );  
   // FPA_PRINTF(" roic_xstart                           =  %d", (uint32_t)ptrA->roic_xstart                          );  
   // FPA_PRINTF(" roic_ystart                           =  %d", (uint32_t)ptrA->roic_ystart                          );  
   // FPA_PRINTF(" roic_xsize                            =  %d", (uint32_t)ptrA->roic_xsize                           );  
   // FPA_PRINTF(" roic_ysize_div2_m1                    =  %d", (uint32_t)ptrA->roic_ysize_div2_m1                   );  
   // FPA_PRINTF(" gain                                  =  %d", (uint32_t)ptrA->gain                                 );  
   // FPA_PRINTF(" internal_outr                         =  %d", (uint32_t)ptrA->internal_outr                        );  
   // FPA_PRINTF(" real_mode_active_pixel_dly            =  %d", (uint32_t)ptrA->real_mode_active_pixel_dly           );  
   // FPA_PRINTF(" speedup_lsync                         =  %d", (uint32_t)ptrA->speedup_lsync                        );  
   // FPA_PRINTF(" speedup_sample_row                    =  %d", (uint32_t)ptrA->speedup_sample_row                   );  
   // FPA_PRINTF(" speedup_unused_area                   =  %d", (uint32_t)ptrA->speedup_unused_area                  );  
   // FPA_PRINTF(" raw_area_line_start_num               =  %d", (uint32_t)ptrA->raw_area_line_start_num              );  
   // FPA_PRINTF(" raw_area_line_end_num                 =  %d", (uint32_t)ptrA->raw_area_line_end_num                );  
   // FPA_PRINTF(" raw_area_sof_posf_pclk                =  %d", (uint32_t)ptrA->raw_area_sof_posf_pclk               );  
   // FPA_PRINTF(" raw_area_eof_posf_pclk                =  %d", (uint32_t)ptrA->raw_area_eof_posf_pclk               );  
   // FPA_PRINTF(" raw_area_sol_posl_pclk                =  %d", (uint32_t)ptrA->raw_area_sol_posl_pclk               );  
   // FPA_PRINTF(" raw_area_eol_posl_pclk                =  %d", (uint32_t)ptrA->raw_area_eol_posl_pclk               );  
   // FPA_PRINTF(" raw_area_eol_posl_pclk_p1             =  %d", (uint32_t)ptrA->raw_area_eol_posl_pclk_p1            );  
   // FPA_PRINTF(" raw_area_window_lsync_num             =  %d", (uint32_t)ptrA->raw_area_window_lsync_num            );  
   // FPA_PRINTF(" raw_area_line_period_pclk             =  %d", (uint32_t)ptrA->raw_area_line_period_pclk            );  
   // FPA_PRINTF(" raw_area_readout_pclk_cnt_max         =  %d", (uint32_t)ptrA->raw_area_readout_pclk_cnt_max        );  
   // FPA_PRINTF(" user_area_line_start_num              =  %d", (uint32_t)ptrA->user_area_line_start_num             );  
   // FPA_PRINTF(" user_area_line_end_num                =  %d", (uint32_t)ptrA->user_area_line_end_num               );  
   // FPA_PRINTF(" user_area_sol_posl_pclk               =  %d", (uint32_t)ptrA->user_area_sol_posl_pclk              );  
   // FPA_PRINTF(" user_area_eol_posl_pclk               =  %d", (uint32_t)ptrA->user_area_eol_posl_pclk              );  
   // FPA_PRINTF(" user_area_eol_posl_pclk_p1            =  %d", (uint32_t)ptrA->user_area_eol_posl_pclk_p1           );  
   // FPA_PRINTF(" stretch_area_sol_posl_pclk            =  %d", (uint32_t)ptrA->stretch_area_sol_posl_pclk           );  
   // FPA_PRINTF(" stretch_area_eol_posl_pclk            =  %d", (uint32_t)ptrA->stretch_area_eol_posl_pclk           );  
   // FPA_PRINTF(" pix_samp_num_per_ch                   =  %d", (uint32_t)ptrA->pix_samp_num_per_ch                  );  
   // FPA_PRINTF(" hgood_samp_sum_num                    =  %d", (uint32_t)ptrA->hgood_samp_sum_num                   );  
   // FPA_PRINTF(" hgood_samp_mean_numerator             =  %d", (uint32_t)ptrA->hgood_samp_mean_numerator            );  
   // FPA_PRINTF(" vgood_samp_sum_num                    =  %d", (uint32_t)ptrA->vgood_samp_sum_num                   );  
   // FPA_PRINTF(" vgood_samp_mean_numerator             =  %d", (uint32_t)ptrA->vgood_samp_mean_numerator            );                 
   // FPA_PRINTF(" good_samp_first_pos_per_ch            =  %d", (uint32_t)ptrA->good_samp_first_pos_per_ch           );  
   // FPA_PRINTF(" good_samp_last_pos_per_ch             =  %d", (uint32_t)ptrA->good_samp_last_pos_per_ch            );  
   // FPA_PRINTF(" adc_clk_source_phase                  =  %d", (uint32_t)ptrA->adc_clk_source_phase                 );  
   // FPA_PRINTF(" adc_clk_pipe_sel                      =  %d", (uint32_t)ptrA->adc_clk_pipe_sel                     );  
   // FPA_PRINTF(" spare1                                =  %d", (uint32_t)ptrA->spare1                               );
   // FPA_PRINTF(" lsydel_mclk                           =  %d", (uint32_t)ptrA->lsydel_mclk                          ); 
   // FPA_PRINTF(" boost_mode                            =  %d", (uint32_t)ptrA->boost_mode                           ); 
   // FPA_PRINTF(" speedup_lsydel                        =  %d", (uint32_t)ptrA->speedup_lsydel                       ); 
   // FPA_PRINTF(" adc_clk_pipe_sync_pos                 =  %d", (uint32_t)ptrA->adc_clk_pipe_sync_pos                ); 
   // FPA_PRINTF(" readout_plus_delay                    =  %d", (uint32_t)ptrA->readout_plus_delay                   ); 
   // FPA_PRINTF(" tri_window_and_intmode_part           =  %d", (uint32_t)ptrA->tri_window_and_intmode_part          ); 
   // FPA_PRINTF(" int_time_offset                       =  %d", (uint32_t)ptrA->int_time_offset                      ); 
   // FPA_PRINTF(" tsh_min                               =  %d", (uint32_t)ptrA->tsh_min                              ); 
   // FPA_PRINTF(" tsh_min_minus_int_time_offset         =  %d", (uint32_t)ptrA->tsh_min_minus_int_time_offset        ); 
   // FPA_PRINTF(" elcorr_enabled                        =  %d", (uint32_t)ptrA->elcorr_enabled                       ); 
   // FPA_PRINTF(" elcorr_spare1                         =  %d", (uint32_t)ptrA->elcorr_spare1                        ); 
   // FPA_PRINTF(" elcorr_spare2                         =  %d", (uint32_t)ptrA->elcorr_spare2                        ); 
   // FPA_PRINTF(" elcorr_ref_cfg_0_ref_enabled          =  %d", (uint32_t)ptrA->elcorr_ref_cfg_0_ref_enabled         ); 
   // FPA_PRINTF(" elcorr_ref_cfg_0_ref_cont_meas_mode   =  %d", (uint32_t)ptrA->elcorr_ref_cfg_0_ref_cont_meas_mode  ); 
   // FPA_PRINTF(" elcorr_ref_cfg_0_start_dly_sampclk    =  %d", (uint32_t)ptrA->elcorr_ref_cfg_0_start_dly_sampclk   ); 
   // FPA_PRINTF(" elcorr_ref_cfg_0_samp_num_per_ch      =  %d", (uint32_t)ptrA->elcorr_ref_cfg_0_samp_num_per_ch     ); 
   // FPA_PRINTF(" elcorr_ref_cfg_0_samp_mean_numerator  =  %d", (uint32_t)ptrA->elcorr_ref_cfg_0_samp_mean_numerator ); 
   // FPA_PRINTF(" elcorr_ref_cfg_0_ref_value            =  %d", (uint32_t)ptrA->elcorr_ref_cfg_0_ref_value           ); 
   // FPA_PRINTF(" elcorr_ref_cfg_1_ref_enabled          =  %d", (uint32_t)ptrA->elcorr_ref_cfg_1_ref_enabled         ); 
   // FPA_PRINTF(" elcorr_ref_cfg_1_ref_cont_meas_mode   =  %d", (uint32_t)ptrA->elcorr_ref_cfg_1_ref_cont_meas_mode  ); 
   // FPA_PRINTF(" elcorr_ref_cfg_1_start_dly_sampclk    =  %d", (uint32_t)ptrA->elcorr_ref_cfg_1_start_dly_sampclk   ); 
   // FPA_PRINTF(" elcorr_ref_cfg_1_samp_num_per_ch      =  %d", (uint32_t)ptrA->elcorr_ref_cfg_1_samp_num_per_ch     ); 
   // FPA_PRINTF(" elcorr_ref_cfg_1_samp_mean_numerator  =  %d", (uint32_t)ptrA->elcorr_ref_cfg_1_samp_mean_numerator ); 
   // FPA_PRINTF(" elcorr_ref_cfg_1_ref_value            =  %d", (uint32_t)ptrA->elcorr_ref_cfg_1_ref_value           ); 
   // FPA_PRINTF(" elcorr_ref_dac_id                     =  %d", (uint32_t)ptrA->elcorr_ref_dac_id                    ); 
   // FPA_PRINTF(" elcorr_atemp_gain                     =  %d", (uint32_t)ptrA->elcorr_atemp_gain                    ); 
   // FPA_PRINTF(" elcorr_atemp_ofs                      =  %d", (uint32_t)ptrA->elcorr_atemp_ofs                     ); 
   // FPA_PRINTF(" elcorr_ref0_op_sel                    =  %d", (uint32_t)ptrA->elcorr_ref0_op_sel                   ); 
   // FPA_PRINTF(" elcorr_ref1_op_sel                    =  %d", (uint32_t)ptrA->elcorr_ref1_op_sel                   ); 
   // FPA_PRINTF(" elcorr_mult_op_sel                    =  %d", (uint32_t)ptrA->elcorr_mult_op_sel                   ); 
   // FPA_PRINTF(" elcorr_div_op_sel                     =  %d", (uint32_t)ptrA->elcorr_div_op_sel                    ); 
   // FPA_PRINTF(" elcorr_add_op_sel                     =  %d", (uint32_t)ptrA->elcorr_add_op_sel                    ); 
   // FPA_PRINTF(" elcorr_spare3                         =  %d", (uint32_t)ptrA->elcorr_spare3                        ); 
   // FPA_PRINTF(" sat_ctrl_en                           =  %d", (uint32_t)ptrA->sat_ctrl_en                          ); 
   // FPA_PRINTF(" cfg_num                               =  %d", (uint32_t)ptrA->cfg_num                              ); 
   // FPA_PRINTF(" elcorr_spare4                         =  %d", (uint32_t)ptrA->elcorr_spare4                        ); 
   // FPA_PRINTF(" roic_cst_output_mode                  =  %d", (uint32_t)ptrA->roic_cst_output_mode                 ); 
   // FPA_PRINTF(" additional_fpa_int_time_offset        =  %d", (uint32_t)ptrA->additional_fpa_int_time_offset       ); 
   // FPA_PRINTF(" fpa_intf_data_source                  =  %d", (uint32_t)ptrA->fpa_intf_data_source                 ); 
  
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

 // utilisation  des valeurs de flashsettings
   temperature  = flashSettings.FPATemperatureConversionCoef4 * powf(diode_voltage,4);
   temperature += flashSettings.FPATemperatureConversionCoef3 * powf(diode_voltage,3);
   temperature += flashSettings.FPATemperatureConversionCoef2 * powf(diode_voltage,2);
   temperature += flashSettings.FPATemperatureConversionCoef1 * diode_voltage;
   temperature += flashSettings.FPATemperatureConversionCoef0;  
 
 // Si flashsettings non programmés alors on utilise les valeurs par defaut  
  if ((flashSettings.FPATemperatureConversionCoef4 == 0) && (flashSettings.FPATemperatureConversionCoef3 == 0) && 
      (flashSettings.FPATemperatureConversionCoef2 == 0) && (flashSettings.FPATemperatureConversionCoef1 == 0) &&
	  (flashSettings.FPATemperatureConversionCoef0 == 0)) {
	// courbe de conversion de Sofradir pour une polarisation de 100µA   
     temperature  =  -170.50F * powf(diode_voltage,4);
     temperature +=   173.45F * powf(diode_voltage,3);
     temperature +=   137.86F * powf(diode_voltage,2);
     temperature += (-667.07F * diode_voltage) + 623.1F;  // 625 remplacé par 623 en guise de calibration de la diode
  }	
  
   return (int16_t)((int32_t)(100.0F * temperature) - 27315) ; // Centi celsius
}       

//--------------------------------------------------------------------------                                                                            
// Pour avoir les parametres propres au ISc0207 avec une config 
//--------------------------------------------------------------------------
void FPA_SpecificParams(isc0207_param_t *ptrH, float exposureTime_usec, const gcRegistersData_t *pGCRegs)
{
   
   extern int32_t gFpaExposureTimeOffset;


   // on ne fait jamais de fast windowing avec le M2K
   speedup_unused_area           = 0;
   
   // parametres statiques
   ptrH->mclk_period_usec        = 1e6F/(float)FPA_MCLK_RATE_HZ;
   ptrH->tap_number              = (float)FPA_NUMTAPS;
   ptrH->pixnum_per_tap_per_mclk = 2.0F;
   ptrH->fpa_delay_mclk          = 6.0F;   // FPA: delai de sortie des pixels après integration
   
   ptrH->vhd_delay_mclk          = 2.55F;
      
   ptrH->delay_mclk              = ptrH->fpa_delay_mclk + ptrH->vhd_delay_mclk;   //
   ptrH->lovh_mclk               = 0.0F;
   ptrH->fovh_line               = 0.0F;
  
   ptrH->tsh_min_usec            = 7.8F;
   ptrH->trst_min_usec           = 0.2F;
   
   ptrH->line_stretch_mclk       = (float)ISC0207_FASTWINDOW_STRECTHING_AREA_MCLK;
   if ((uint32_t)pGCRegs->Width == (uint32_t)FPA_WIDTH_MAX)
    ptrH->line_stretch_mclk      = 0.0;

   ptrH->itr_tri_min_usec        = 2.0F; // limite inférieure de tri pour le mode ITR . Imposée par les tests de POFIMI
   ptrH->int_time_offset_usec    = 0.8F + (float)gFpaExposureTimeOffset*(1E+6F/(float)EXPOSURE_TIME_BASE_CLOCK_FREQ_HZ);  // offset du temps d'integration
   
   ptrH->adc_sync_dly_mclk       = 0.0F;
   
   ptrH->pclk_rate_hz            = ptrH->pixnum_per_tap_per_mclk * (float)FPA_MCLK_RATE_HZ;
    
   
   /*--------------------- CALCULS-------------------------------------------------------------
      Attention aux modifs en dessous de cette ligne! Y bien réfléchir avant de les faire
   -----------------------------------------------------------------------------------------  */
   
   // fast windowing
   ptrH->unused_area_clock_factor =  MAX(1.0F, ((float)ROIC_UNUSED_AREA_CLK_RATE_HZ/(float)FPA_MCLK_RATE_HZ)*(float)speedup_unused_area);
   
   // fenetre qui sera demandée au ROIC du FPA
   ptrH->roic_xsize     = (float)pGCRegs->Width;
   ptrH->roic_ysize     = (float)pGCRegs->Height;
   ptrH->roic_xstart    = ((float)FPA_WIDTH_MAX - ptrH->roic_xsize)/2.0F;          // à cause du centrage
   ptrH->roic_ystart    = ((float)FPA_HEIGHT_MAX - ptrH->roic_ysize)/2.0F;         // à cause du centrage
      
   // readout time
   //readout part1 (zone en slow_clock)
   ptrH->readout_mclk         = ((float)pGCRegs->Width /(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) +  ptrH->line_stretch_mclk)*(float)pGCRegs->Height;
   
   //readout part2 (zone à rejeter en fast clock)
   ptrH->readout_mclk         = ptrH->readout_mclk + (1.0F/ptrH->unused_area_clock_factor)*((ptrH->roic_xsize - (float)pGCRegs->Width)/(ptrH->pixnum_per_tap_per_mclk*ptrH->tap_number) -  ptrH->line_stretch_mclk)*(float)pGCRegs->Height;

   //readout part5 (coût du synchronisateur)
   ptrH->readout_mclk         = ptrH->readout_mclk + ptrH->adc_sync_dly_mclk*(float)pGCRegs->Height;
   ptrH->readout_usec         = ptrH->readout_mclk * ptrH->mclk_period_usec;
   
   // delay
   ptrH->vhd_delay_usec       = ptrH->vhd_delay_mclk * ptrH->mclk_period_usec;
   ptrH->fpa_delay_usec       = ptrH->fpa_delay_mclk * ptrH->mclk_period_usec;
   ptrH->delay_usec           = ptrH->delay_mclk * ptrH->mclk_period_usec;
   
   // fsync_high_min
   ptrH->fsync_high_min_usec  = ptrH->trst_min_usec + 0.6F;
   
   // FsyncLow
   ptrH->fsync_low_usec       = exposureTime_usec + ptrH->int_time_offset_usec;
   
   // T_ri int part
   ptrH->tri_int_part_usec    = ptrH->tsh_min_usec - ptrH->fsync_low_usec;
   
   // T_ri window part
   ptrH->tri_window_part_usec = ptrH->fsync_high_min_usec - ptrH->delay_usec - ptrH->readout_usec;
   
   // T_ri window part couplé au mode ITR ou IWR
   // if (pGCRegs->IntegrationMode == IM_IntegrateThenRead) // ITR
      ptrH->tri_window_and_intmode_part_usec = MAX(ptrH->tri_window_part_usec, ptrH->itr_tri_min_usec);  // seulement ITR supporté pour le moment
   // else                                                  // IWR
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

//------------------------------------------------
// Envoi de la config des dacs et autres
//-----------------------------------------------
void FPA_SendProximCfg(const ProximCfg_t *ptrD, const t_FpaIntf *ptrA)
{
   uint8_t ii = 0;

   // envoi comfig des Dacs
   while(ii < TOTAL_DAC_NUM)
   {
      AXI4L_write32(ptrD->vdac_value[ii], ptrA->ADD + AW_DAC_CFG_BASE_ADD + 4*ii);  
      ii++;
   }
}
