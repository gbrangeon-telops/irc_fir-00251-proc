/*-----------------------------------------------------------------------------
--
-- Title       : 
-- Author      : 
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
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
#include "FPABinningConfig.h"

#ifdef FPA_VERBOSE
   #define FPA_PRINTF(fmt, ...)    FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#else
   #define FPA_PRINTF(fmt, ...)    DUMMY_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#endif

#define FPA_ERR(fmt, ...)        FPGA_PRINTF("FPA: Error: " fmt "\n", ##__VA_ARGS__)
#define FPA_INF(fmt, ...)        FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)

#define FPA_DEVICE_MODEL_NAME    "HAWKA SVN TRUNK"

#define FPA_HAWK_VERTICAL_FLIP   1        // 1 pour une inversion verticale de l'image (Line 512 to 1)

#define FPA_WIDTH_MIN      64    //
#define FPA_WIDTH_MAX      640
#define FPA_WIDTH_MULT     4
#define FPA_WIDTH_INC      FPA_WIDTH_MULT
#define FPA_SUBWINDOW_WIDTH_MAX (FPA_WIDTH_MAX - FPA_WIDTH_MULT)

#define FPA_HEIGHT_MIN     1
#define FPA_HEIGHT_MAX     512
#define FPA_HEIGHT_MULT    1
#define FPA_HEIGHT_INC     2//lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT)
#define FPA_SUBWINDOW_HEIGHT_MAX (FPA_HEIGHT_MAX - FPA_HEIGHT_MULT)

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   4
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX-FPA_WIDTH_MIN)
#define FPA_OFFSETY_MIN    0
#define FPA_OFFSETY_MULT   1
#define FPA_OFFSETY_MAX    (FPA_HEIGHT_MAX-FPA_HEIGHT_MIN)

#define FPA_MAX_NUMBER_CONFIG_MODE 1U

#define FPA_FORCE_CENTER   0
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (HawkAIsImplemented | ITRIsImplementedMask | HighGainSWDIsImplementedMask)
#define FPA_TDC_FLAGS2           (AECIsImplementedMask | CalibrationFileStorageIsImplementedMask)

#define FPA_MAX_GAIN       3
#define FPA_NUMTAPS        4  // [taps]

#define FPA_COOLER_TEMP_THRES    -17300   //[cC]
#define FPA_COOLER_TEMP_TOL      1000     //[cC]
#define FPA_DEFAULT_EXPOSURE     100.0F   //[us]
#define FPA_DEFAULT_FRAME_RATE   50.0F    //[Hz]

// TODO Update EHDRI default exposure times.
#define FPA_EHDRI_EXP_0    6.0F 
#define FPA_EHDRI_EXP_1    380.0F
#define FPA_EHDRI_EXP_2    2250.0F
#define FPA_EHDRI_EXP_3    11000.0F 

#define FPA_CAL_MIN_EXPOSURE  0.2F
#define FPA_CAL_MAX_EXPOSURE  1000000.0F

#define FPA_MIN_EXPOSURE               0.2F     // [us]
#define FPA_MAX_EXPOSURE               1000000.0F // [us]  ne pas depasser 2 secondes pour les détyecteurs analogiques car le convertisseur vhd de temps d'exposition en depend 

#define FPA_AECP_MIN_EXPOSURE          FPA_MIN_EXPOSURE // [us] Minimum exposure time when AEC+ is active.

#define FPA_DATA_RESOLUTION 14
#define FPA_PIXEL_PITCH                16E-6F

#define FPA_INVALID_TEMP               -32768   // cC

#define FPA_MCLK_RATE_HZ               10E+6F    // le master clock du FPA
#define FPA_EXPOSURE_TIME_RESOLUTION   (1E6F/FPA_MCLK_RATE_HZ)

#define FPA_PIX_THROUGHPUT_PEAK        (FPA_NUMTAPS * FPA_MCLK_RATE_HZ)  // [pix/sec]


#define FPA_AVAILABLE_BINNING_MODE (BM_NormalMode )

// structure de config envoyée au vhd 
struct s_FpaIntfConfig    // Remarquer la disparition du champ fpa_integration_time. le temps d'integration n'est plus défini par le module FPA_INTF
{					   
   uint32_t  SIZE;                       
   uint32_t  ADD;
   
   // partie commune (modules communs dans le vhd de fpa_interface. Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   uint32_t  fpa_diag_mode;              // utilisé par le trig_controller.vhd            
   uint32_t  fpa_diag_type;              // utilisé par le generateur de données diag de Telops
   uint32_t  fpa_pwr_on;                 // utilisé par le fpa_intf_sequencer.vhd            
   uint32_t  fpa_acq_trig_mode;         // utilisé par le trig_controller.vhd    
   uint32_t  fpa_acq_trig_ctrl_dly;      // utilisé par le trig_controller.vhd  
   uint32_t  fpa_xtra_trig_mode;                  // utilisé par le trig_controller.vhd
   uint32_t  fpa_xtra_trig_ctrl_dly;     // utilisé par le trig_controller.vhd  
   uint32_t  fpa_trig_ctrl_timeout_dly;   // utilisé par le trig_controller.vhd
   
   // partie propre au hawk
   uint32_t  xstart;             
   uint32_t  ystart;             
   uint32_t  xsize;            
   uint32_t  ysize;            
   uint32_t  gain;            
   uint32_t  invert;
   uint32_t  revert;
   uint32_t  cbit_en;
   uint32_t  dig_code;
   uint32_t  jpos;
   uint32_t  kpos;          
   uint32_t  lpos;
   uint32_t  mpos;
   uint32_t  wdr_len;
   uint32_t  full_window;
   uint32_t  real_mode_active_pixel_dly;                   
   uint32_t  adc_quad2_en;
   uint32_t  chn_diversity_en;
   uint32_t  readout_pclk_cnt_max;
   uint32_t  line_period_pclk;
   uint32_t  active_line_start_num;
   uint32_t  active_line_end_num;
   uint32_t  pix_samp_num_per_ch;
   uint32_t  sof_posf_pclk;
   uint32_t  eof_posf_pclk;                
   uint32_t  sol_posl_pclk;                
   uint32_t  eol_posl_pclk;                
   uint32_t  eol_posl_pclk_p1;
   uint32_t  hgood_samp_sum_num;           
   uint32_t  hgood_samp_mean_numerator;    
   uint32_t  vgood_samp_sum_num;           
   uint32_t  vgood_samp_mean_numerator;    
   uint32_t  hgood_samp_first_pos_per_ch;
   uint32_t  hgood_samp_last_pos_per_ch;
   uint32_t  xsize_div_tapnum;             
   
   uint32_t  adc_clk_source_phase;           
   uint32_t  adc_clk_pipe_sel;               
   uint32_t  cfg_num;                        
   uint32_t  fpa_stretch_acq_trig; // utilisé par le trig_precontroller.vhd 
   uint32_t  fpa_intf_data_source;
   uint32_t  cbit_pipe_dly;
   
};
typedef struct s_FpaIntfConfig t_FpaIntf;

#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x0065, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0}


// statuts provenant du vhd
struct s_FpaStatus    // 
{
   // adc board (iddcas analogiques)
   uint32_t  adc_oper_freq_max_khz;    // frequence maximale d'operation des adcs soudées sur la carte EFA-00253  (lié à l'ID)
   uint32_t  adc_analog_channel_num;   // nombre de canaux total disponible sur la carte (lié à l'ID)
   uint32_t  adc_resolution;           // statut du built_in test de la carte ADC
   uint32_t  adc_brd_spare;            // spare de statut pour la carte ADC
   
   // ddc board (iddcas numériques)
   uint32_t  ddc_fpa_roic;             // type de detecteur pour lequel la carte DDC est conçue (voir fpa_hardw_stat_type dans fichier fpa_common_pkg pour details )
   uint32_t  ddc_brd_spare;            // 
   
   // flex board
   uint32_t  flex_fpa_roic;            // type de detecteur pour lequel la carte FLEX est conçue (voir fpa_hardw_stat_type dans fichier fpa_common_pkg pour details )
   uint32_t  flex_fpa_input;           // type d'entrée de contrôle du ROIC du FPA (LVTTL5, LVCMOS etc... voir fpa_hardw_stat_type dans fichier fpa_common_pkg pour details )
   uint32_t  flex_ch_diversity_num;    // permet de savoir, pour la carte flex, le nombre de canaux de diversité par tap detecteur
   
   // cooler
   uint32_t  cooler_volt_min_mV;       // Tension Minimale en millivolts au-dessus duquel allumer Cooler (valeur en milliVolts)
   uint32_t  cooler_volt_max_mV;       // Tension Maximale millivolts en-dessous duquel allumer Cooler (valeur en milliVolts)     
   uint32_t  fpa_temp_raw;             // Temperature brute (non convertie en degrés) du fpa en digital level       
   
   // power on feedback
   uint32_t  global_done;              // done global du module vhd fpa_intf
   uint32_t  fpa_powered;              // Feedback. À '1' si le fpa ou le proxy est allumé. attention, Proxy allumé ne veut pas dire forcément fpa allumé
   uint32_t  cooler_powered;           // Feedback. À '1' si le cooler est allumé. À 0xFFFF si statut inconnu. Statut peut être inconnu dans le cas des coolers non allumés par les module fpa_intf
   
   // errors lacths
   uint32_t  errors_latchs;            // erreurs latchées. S'effacent avec la fonction FPA_ClearErr. Définition dans le fichier fpa_status_gen.vhd
   
   // driver status
   uint32_t  intf_seq_stat;            // statut du sequenceur. Définition dans fpa_intf_sequencer.vhd
   uint32_t  data_path_stat;           // statut de la chaine de données. Définition dans "fpa"_intf.bde
   uint32_t  trig_ctler_stat;          // statut du controleur de trig. Définition dans fpa_trig_controller.vhd
   uint32_t  fpa_driver_stat;          // statut du hw driver. Définition dans "fpa"_hw_driver.bde

   // pour le power management
   uint32_t  adc_ddc_detect_process_done; // dit si le  processus de détection de la carte ADC/ DDC est achevé
   uint32_t  adc_ddc_present;             // dit si une carte valide est détectée
   uint32_t  flex_flegx_detect_process_done; // dit si le  processus de détection du flex est achevé
   uint32_t  flex_flegx_present;             // dit si une carte valide est détectée
   uint32_t  flegx_present;               // '1' dit si l'électronique de proximité est un flegX, sinon, c'est un flex

   uint32_t  id_cmd_in_error;             // donne la commande en erreur pour les detecteurs numeriques. 0xFF -> aucune cmd en erreur

   // fpa serdes
   uint32_t  fpa_serdes_done;             // donne l'état de la calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_success;          // donne le résultat de la calibration des serdes pour chaque canal
   uint8_t   fpa_serdes_delay[4];         // donne le délai de calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_edges[4];         // donne les edges trouvés lors de la calibration des serdes pour chaque canal

   // fpa init status
   uint32_t  fpa_init_done;               // donne l'état de l'initialisation du FPA
   uint32_t  fpa_init_success;            // donne le résultat de l'initialisation du FPA
   uint32_t  prog_init_done;              // -- monte à '1' lorsque la config d'initialisation est programmée dans le ROIC. Ce qui est intéressant pour les ROIC necessitant une config d'initialisation
   
   // cooler
   uint32_t  cooler_on_curr_min_mA;       // seuil au dessus duquel considérer que le refroidisseur est allumé
   uint32_t  cooler_off_curr_max_mA;      // seuil en dessous duquel considérer que le refroidisseur est eteint
   
   // watchdog
   uint32_t  acq_trig_cnt;    
   uint32_t  acq_int_cnt;     
   uint32_t  fpa_readout_cnt; 
   uint32_t  acq_readout_cnt; 
   uint32_t  out_pix_cnt_min; 
   uint32_t  out_pix_cnt_max;
   uint32_t  trig_to_int_delay_min;
   uint32_t  trig_to_int_delay_max;
   uint32_t  int_to_int_delay_min;
   uint32_t  int_to_int_delay_max; 
   uint32_t  fast_hder_cnt; 
};
typedef struct s_FpaStatus t_FpaStatus;

extern t_FpaResolutionCfg gFpaResolutionCfg[FPA_MAX_NUMBER_CONFIG_MODE];

// Function prototypes

// pour initialiser le module vhd avec les bons parametres de départ
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs);

//pour effacer les bits d'erreurs du bloc FPA_interface
void FPA_ClearErr(const t_FpaIntf *ptrA);

//pour configurer le bloc FPA_interface et le lancer
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs); 

//pour calculer le frame rate max se rappportant à une configuration donnée
float FPA_MaxFrameRate(const gcRegistersData_t *pGCRegs);

//pour calculer le temps d'exposition max se rappportant à une configuration donnée
float FPA_MaxExposureTime(const gcRegistersData_t *pGCRegs);

// pour avoir la température du détecteur
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA);

// pour avoir les statuts complets
void FPA_GetStatus(t_FpaStatus *Stat, const t_FpaIntf *ptrA);

// pour afficher le feedback de FPA_INTF_CFG
void FPA_PrintConfig(const t_FpaIntf *ptrA);

// pour mttre les io en 'Z' avant d'éteindre la carte DDC
void  FPA_PowerDown(const t_FpaIntf *ptrA);

#endif // __FPA_INTF_H__
