/*-----------------------------------------------------------------------------
--
-- Title       : FPA_INTF header
-- Author      : Patrick Daraiche
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 22936 $
-- $Author: enofodjie $
-- $LastChangedDate: 2019-02-23 08:37:13 -0500 (sam., 23 févr. 2019) $
--
-------------------------------------------------------------------------------
--
-- Description : 
--
------------------------------------------------------------------------------*/
#ifndef __FPA_INTF_H__
#define __FPA_INTF_H__

#include <stdint.h>
#include "GC_Registers.h"
#include "IRC_status.h"

#ifndef SCD_PROXY
   #define SCD_PROXY
#endif

#define FPA_DEVICE_MODEL_NAME    "BLACKBIRDD"

#define FPA_WIDTH_MIN      132    // les tests ont prouv� qu'en medium, les donn�e ssont non corrompues jusqu'� 132. En 128, on releve des corruptions
#define FPA_WIDTH_MAX      1280
#define FPA_WIDTH_MULT     4
#define FPA_WIDTH_INC      FPA_WIDTH_MULT

#define FPA_HEIGHT_MIN     2
#define FPA_HEIGHT_MAX     1024
#define FPA_HEIGHT_MULT    2
#define FPA_HEIGHT_INC     lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT)

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   4
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX - FPA_WIDTH_MIN)

#define FPA_OFFSETY_MIN    0
#define FPA_OFFSETY_MULT   2
#define FPA_OFFSETY_MAX    (FPA_HEIGHT_MAX - FPA_HEIGHT_MIN)

#define FPA_FORCE_CENTER   1
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0
#define FPA_NUM_CH         3  // nombre de canaux de sorties  (2 ou 3)

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (BlackbirdDIsImplemented | ITRIsImplementedMask | IWRIsImplementedMask | ClFullIsImplementedMask)

#define FPA_EVEN_TO_ODD_DELAY 4     // CLK
#define FPA_ODD_TO_EVEN_DELAY 144   // CLK
#define FPA_IMAGE_DATA_DELAY  370*1E-6F   // [us]max
#define FPA_NB_PIX_CLK     1
#define FPA_TRI_MIN_US     50*1E-6F

#define FPA_MAX_GAIN       1
#define FPA_NUMTAPS        1  // [taps]
#define FPA_PX_TAP         1  // [pixel/clock/tap]
#define FPA_DELAY          11 // [clock cycles]
#define FPA_LOVH           1  // [clock cycles]
#define FPA_FOVH           0  // [clock cycles]
#define FPA_MIN_PER        0  // [clock cycles]

#define FPA_COOLER_TEMP_THRES    -19400
#ifdef SIM
   #define FPA_DEFAULT_EXPOSURE     5.0F //[us]
   #define FPA_DEFAULT_FRAME_RATE   1000.0F //[Hz]
#else
   #define FPA_DEFAULT_EXPOSURE     1000.0F //[us]
   #define FPA_DEFAULT_FRAME_RATE   20.0F //[Hz]
#endif

// TODO Update EHDRI default exposure times.
#define FPA_EHDRI_EXP_0    1000.0F  // Saturation � 395C
#define FPA_EHDRI_EXP_1     200.0F
#define FPA_EHDRI_EXP_2     500.0F
#define FPA_EHDRI_EXP_3    1000.0F  // Saturation � 28

#define FPA_CAL_MIN_EXPOSURE  1.0F
#define FPA_CAL_MAX_EXPOSURE  85000.0F

#define FPA_MIN_EXPOSURE               1.0F     // [us] min is not in the spec
#define FPA_MAX_EXPOSURE               80000.0F // [us] max is not in the spec

#define FPA_AECP_MIN_EXPOSURE          FPA_MIN_EXPOSURE // [us] Minimum exposure time when AEC+ is active.

#define FPA_VHD_INTF_CLK_RATE_HZ       100E+6F  // [Hz] fr�quence de l'horloge (interne) du contr�le du module FPA_Intf
#define FPA_MASTER_CLK_RATE_HZ         85E+6F   // [Hz] fr�quence de l'horloge (interne) des donn�es du module FPA_Intf
#define FPA_CLOCK_FREQ_HZ              70E+6F   // [Hz] fr�quence de l'horloge (externe) des donn�es venant du Proxy
#define FPA_SCD_HDER_EFF_LEN           128      // le nombre de pixels actifs/effectifs du header

#define FPA_DATA_RESOLUTION 13

#define FPA_INVALID_TEMP               -32768   // cC

// structure de config envoy�e au vhd 
// c'est la commande operationnelle de scd �tendue au vhd complet
struct s_FpaIntfConfig    // Remarquer la disparition du champ fpa_integration_time. le temps d'integration n'est plus d�fini par le module FPA_INTF
{
   uint32_t  SIZE;
   uint32_t  ADD;
   
   // partie commune (modules communs dans le vhd de fpa_interface. Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   uint32_t  fpa_diag_mode;              // utilis� par le trig_controller.vhd            
   uint32_t  fpa_diag_type;              // utilis� par le generateur de donn�es diag de Telops
   uint32_t  fpa_pwr_on;                 // utilis� par le fpa_intf_sequencer.vhd            
   uint32_t  fpa_trig_ctrl_mode;         // utilis� par le trig_controller.vhd    
   uint32_t  fpa_acq_trig_ctrl_dly;      // utilis� par le trig_controller.vhd  
   uint32_t  fpa_spare;                  // utilis� par le trig_controller.vhd
   uint32_t  fpa_xtra_trig_ctrl_dly;     // utilis� par le trig_controller.vhd  
   uint32_t  fpa_trig_ctrl_timeout_dly;   // utilis� par le trig_controller.vhd
   
   // partie scd cmd operationnelle (tout changement dans cette partie entraine la reprogrammation du d�tecteur)
   uint32_t  scd_xstart;                
   uint32_t  scd_ystart;                
   uint32_t  scd_xsize;                
   uint32_t  scd_ysize;                
   uint32_t  scd_gain;                 
   uint32_t  scd_out_chn;              
   uint32_t  scd_diode_bias;                           
   uint32_t  scd_int_mode;             
   uint32_t  scd_pix_res;              
   uint32_t  scd_frame_period_min;         
   
   // partie scd cmd diag (tout changement dans cette partie entraine la reprogrammation du d�tecteur)
   uint32_t  scd_bit_pattern;       
       
   // partie misc   (quelques parametres utilis�s en mode diag Telops pour simuler le detecteur et en extra_trig . Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   uint32_t  scd_fig1_or_fig2_t6_dly;        
   uint32_t  scd_fig4_t1_dly;               
   uint32_t  scd_fig4_t2_dly;               
   uint32_t  scd_fig4_t6_dly;               
   uint32_t  scd_fig4_t3_dly;               
   uint32_t  scd_fig4_t5_dly;               
   uint32_t  scd_fig4_t4_dly;        
   uint32_t  scd_fig1_or_fig2_t5_dly;
   uint32_t  scd_fig1_or_fig2_t4_dly;
   uint32_t  scd_xsize_div2;
   
   // partie commune (modules communs dans le vhd de fpa_interface. Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   uint32_t  fpa_stretch_acq_trig;     // utilis� par le trig_precontroller.vhd
   
      // specifie la partie de la structure � mettre � jour (pour eviter des bugs)
   uint32_t  proxy_cmd_to_update_id;
};
typedef struct s_FpaIntfConfig t_FpaIntf;

// statuts provenant du vhd
struct s_FpaStatus    // 
{
   // adc board (iddcas analogiques)
   uint32_t  adc_oper_freq_max_khz;    // frequence maximale d'operation des adcs soud�es sur la carte EFA-00253  (li� � l'ID)
   uint32_t  adc_analog_channel_num;   // nombre de canaux total disponible sur la carte (li� � l'ID)
   uint32_t  adc_resolution;           // statut du built_in test de la carte ADC
   uint32_t  adc_brd_spare;            // spare de statut pour la carte ADC
   
   // ddc board (iddcas num�riques)
   uint32_t  ddc_fpa_roic;             // type de detecteur pour lequel la carte DDC est con�ue (voir fpa_hardw_stat_type dans fichier fpa_common_pkg pour details )
   uint32_t  ddc_brd_spare;            // 
   
   // flex board
   uint32_t  flex_fpa_roic;            // type de detecteur pour lequel la carte FLEX est con�ue (voir fpa_hardw_stat_type dans fichier fpa_common_pkg pour details )
   uint32_t  flex_fpa_input;           // type d'entr�e de contr�le du ROIC du FPA (LVTTL5, LVCMOS etc... voir fpa_hardw_stat_type dans fichier fpa_common_pkg pour details )
   uint32_t  flex_ch_diversity_num;    // permet de savoir, pour la carte flex, le nombre de canaux de diversit� par tap detecteur
   
   // cooler
   uint32_t  cooler_volt_min_mV;       // Tension Minimale en millivolts au-dessus duquel allumer Cooler (valeur en milliVolts)
   uint32_t  cooler_volt_max_mV;       // Tension Maximale millivolts en-dessous duquel allumer Cooler (valeur en milliVolts)     
   uint32_t  fpa_temp_raw;             // Temperature brute (non convertie en degr�s) du fpa en digital level       
   
   // power on feedback
   uint32_t  global_done;              // done global du module vhd fpa_intf
   uint32_t  fpa_powered;              // Feedback. � '1' si le fpa ou le proxy est allum�. attention, Proxy allum� ne veut pas dire forc�ment fpa allum�
   uint32_t  cooler_powered;           // Feedback. � '1' si le cooler est allum�. � 0xFFFF si statut inconnu. Statut peut �tre inconnu dans le cas des coolers non allum�s par les module fpa_intf
   
   // errors lacths
   uint32_t  errors_latchs;            // erreurs latch�es. S'effacent avec la fonction FPA_ClearErr. D�finition dans le fichier fpa_status_gen.vhd

   // pour le power management
   uint32_t  adc_ddc_detect_process_done; // dit si le  processus de d�tection de la carte ADC/ DDC est achev�
   uint32_t  adc_ddc_present;             // dit si une carte valide est d�tect�e
   uint32_t  flex_flegx_detect_process_done; // dit si le  processus de d�tection du flex est achev�
   uint32_t  flex_flegx_present;             // dit si une carte valide est d�tect�e
   uint32_t  flegx_present;               // '1' dit si l'�lectronique de proximit� est un flegX, sinon, c'est un flex

   uint32_t  id_cmd_in_error;             // donne la commande en erreur pour les detecteurs numeriques. 0xFF -> aucune cmd en erreur

   // fpa serdes
   uint32_t  fpa_serdes_done;             // donne l'�tat de la calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_success;          // donne le r�sultat de la calibration des serdes pour chaque canal
   uint8_t   fpa_serdes_delay[4];         // donne le d�lai de calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_edges[4];         // donne les edges trouv�s lors de la calibration des serdes pour chaque canal

   // fpa init status
   uint32_t  fpa_init_done;               // donne l'�tat de l'initialisation du FPA
   uint32_t  fpa_init_success;            // donne le r�sultat de l'initialisation du FPA
   uint32_t  prog_init_done;              // -- monte � '1' lorsque la config d'initialisation est programm�e dans le ROIC. Ce qui est int�ressant pour les ROIC necessitant une config d'initialisation
   
   // cooler
   uint32_t  cooler_on_curr_min_mA;       // seuil au dessus duquel consid�rer que le refroidisseur est allum�
   uint32_t  cooler_off_curr_max_mA;      // seuil en dessous duquel consid�rer que le refroidisseur est eteint  
   
   // watchdog
   uint32_t  acq_trig_cnt;    
   uint32_t  acq_int_cnt;     
   uint32_t  fpa_readout_cnt; 
   uint32_t  acq_readout_cnt; 
   uint32_t  out_pix_cnt_min; 
   uint32_t  out_pix_cnt_max;
};
typedef struct s_FpaStatus t_FpaStatus;
																						  
// Function prototypes

#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}


// pour initialiser le module vhd avec les bons parametres de d�part
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs);

//pour effacer les bits d'erreurs du bloc FPA_interface
void FPA_ClearErr(const t_FpaIntf *ptrA);

//pour configurer le bloc FPA_interface et le lancer
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs); 

//pour calculer le frame rate max se rappportant � une configuration donn�e
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs);

//pour calculer le temps d'exposition max se rappportant � une configuration donn�e
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs);

// pour avoir la temp�rature du d�tecteur
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA);

// pour avoir les statuts complets
void FPA_GetStatus(t_FpaStatus *Stat, const t_FpaIntf *ptrA);

// pour mttre les io en 'Z' avant d'�teindre la carte DDC
void  FPA_PowerDown(const t_FpaIntf *ptrA);

#endif // __FPA_INTF_H__
