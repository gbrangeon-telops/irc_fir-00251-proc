/*-----------------------------------------------------------------------------
--
-- Title       : 
-- Author      : 
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
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

#define FPA_DEVICE_MODEL_NAME    "ISC0804A_2k__17.5MHz SVN_TRUNK"

#define FPA_WIDTH_MIN      64    //
#define FPA_WIDTH_MAX      640
#define FPA_WIDTH_MULT     32
#define FPA_WIDTH_INC      FPA_WIDTH_MULT

#define FPA_HEIGHT_MIN     8     // 
#define FPA_HEIGHT_MAX     512
#define FPA_HEIGHT_MULT    4
#define FPA_HEIGHT_INC     8 // lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT) //plus possible de le faire avec une structurelcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT)

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   32 
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX-FPA_WIDTH_MIN)
#define FPA_OFFSETY_MIN    0
#define FPA_OFFSETY_MULT   4
#define FPA_OFFSETY_MAX    (FPA_HEIGHT_MAX-FPA_HEIGHT_MIN)
#define FPA_MAX_NUMBER_CONFIG_MODE 1U
#define FPA_FORCE_CENTER   1
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (Isc0804A_2kIsImplemented | ITRIsImplementedMask)
#define FPA_TDC_FLAGS2           (AECIsImplementedMask | CalibrationFileStorageIsImplementedMask)

#define FPA_MAX_GAIN       0
#define FPA_NUMTAPS        16  // [taps]

#define FPA_COOLER_TEMP_THRES    -17300   //[cC]
#define FPA_COOLER_TEMP_TOL      1000     //[cC]
#define FPA_DEFAULT_EXPOSURE     50.0F //[us]
#define FPA_DEFAULT_FRAME_RATE   30.0F //[Hz]

// TODO Update EHDRI default exposure times.
#define FPA_EHDRI_EXP_0    25.0F  // Saturation � 395C
#define FPA_EHDRI_EXP_1    50.0F
#define FPA_EHDRI_EXP_2    100.0F
#define FPA_EHDRI_EXP_3    200.0F  // Saturation � 28

#define FPA_MIN_EXPOSURE               0.400F //0.271F     // 0.6F //0.271F     // [us]
#define FPA_MAX_EXPOSURE               1000000.0F // [us]  ne pas depasser 2 secondes pour les d�tyecteurs analogiques car le convertisseur vhd de temps d'exposition en depend

#define FPA_DATA_RESOLUTION 14
#define FPA_PIXEL_PITCH                25E-6F

#define FPA_INVALID_TEMP               -32768   // cC  

#define FPA_NOMINAL_MCLK_RATE_HZ       17500000

#define FPA_MCLK_RATE_HZ               FPA_NOMINAL_MCLK_RATE_HZ          //5500000     //11100000          //11880000          //5000000    //11100000          // le master clock du FPA
#define FPA_EXPOSURE_TIME_RESOLUTION   (1E6F/FPA_MCLK_RATE_HZ)

#define FPA_PIX_THROUGHPUT_PEAK        (FPA_NUMTAPS * FPA_MCLK_RATE_HZ * 2.0F)  // [pix/sec] , one pixel per mclk edges (DDR)

// structure de config envoy�e au vhd 
struct s_FpaIntfConfig    // Remarquer la disparition du champ fpa_integration_time. le temps d'integration n'est plus d�fini par le module FPA_INTF
{
   uint32_t  SIZE;
   uint32_t  ADD;
  
   uint32_t  fpa_diag_mode                         ;
   uint32_t  fpa_diag_type                         ;
   uint32_t  fpa_pwr_on                            ;
   uint32_t  fpa_acq_trig_mode                     ;
   uint32_t  fpa_acq_trig_ctrl_dly                 ;
   uint32_t  fpa_xtra_trig_mode                    ;
   uint32_t  fpa_xtra_trig_ctrl_dly                ;
   uint32_t  fpa_trig_ctrl_timeout_dly             ;
   uint32_t  fpa_stretch_acq_trig                  ;
   uint32_t  fpa_intf_data_source                  ;
   
   uint32_t  diag_ysize                            ;     
   uint32_t  diag_xsize_div_tapnum                 ;     
   
   uint32_t  roic_ystart                           ;     
   uint32_t  roic_ysize_div4_m1                    ;     

   uint32_t  vdet_code                             ;     
   uint32_t  ref_mode_en                           ;     
   uint32_t  ref_chn_en                            ;     
   uint32_t  clamping_level                        ;     
   uint32_t  real_mode_active_pixel_dly            ;     
   uint32_t  user_area_line_start_num_m1           ;     
   uint32_t  proxim_is_flegx                       ;
   
   uint32_t  raw_area_line_start_num               ;     
   uint32_t  raw_area_line_end_num                 ;     
   uint32_t  raw_area_sof_posf_pclk                ;     
   uint32_t  raw_area_eof_posf_pclk                ;     
   uint32_t  raw_area_sol_posl_pclk                ;     
   uint32_t  raw_area_eol_posl_pclk                ;     
   uint32_t  raw_area_lsync_start_posl_pclk        ;     
   uint32_t  raw_area_lsync_end_posl_pclk          ;     
   uint32_t  raw_area_lsync_num                    ;     
   uint32_t  raw_area_clk_id                       ;     
   uint32_t  raw_area_line_period_pclk             ;     
   uint32_t  raw_area_readout_pclk_cnt_max         ;     
   
   uint32_t  user_area_line_start_num              ;     
   uint32_t  user_area_line_end_num                ;     
   uint32_t  user_area_sol_posl_pclk               ;     
   uint32_t  user_area_eol_posl_pclk               ;     
   uint32_t  user_area_clk_id                      ;     
   
   uint32_t  clk_area_a_line_start_num             ;     
   uint32_t  clk_area_a_line_end_num               ;     
   uint32_t  clk_area_a_sol_posl_pclk              ;     
   uint32_t  clk_area_a_eol_posl_pclk              ;     
   uint32_t  clk_area_a_spare                      ;     
   uint32_t  clk_area_a_clk_id                     ;     
   
   uint32_t  clk_area_b_line_start_num             ;     
   uint32_t  clk_area_b_line_end_num               ;     
   uint32_t  clk_area_b_sol_posl_pclk              ;     
   uint32_t  clk_area_b_eol_posl_pclk              ;     
   uint32_t  clk_area_b_spare                      ;     
   uint32_t  clk_area_b_clk_id                     ;     
   
   uint32_t  pix_samp_num_per_ch                   ;     
   uint32_t  hgood_samp_sum_num                    ;     
   uint32_t  hgood_samp_mean_numerator             ;     
   uint32_t  vgood_samp_sum_num                    ;     
   uint32_t  vgood_samp_mean_numerator             ;     
   uint32_t  good_samp_first_pos_per_ch            ;     
   uint32_t  good_samp_last_pos_per_ch             ;     
   
   uint32_t  adc_clk_source_phase1                 ;
   uint32_t  adc_clk_pipe_sel1                     ;
   uint32_t  spare2a                               ;     
   
   uint32_t  lsydel_mclk                           ;     
   uint32_t  boost_mode                            ;     
   uint32_t  speedup_lsydel                        ;     
   uint32_t  adc_clk_source_phase2                 ;
   uint32_t  adc_clk_pipe_sel2                     ;
   
   uint32_t  elcorr_enabled                        ;     
   uint32_t  elcorr_spare1                         ;     
   uint32_t  elcorr_spare2                         ;     
   
   uint32_t  elcorr_ref_cfg_0_ref_enabled          ;    
   uint32_t  elcorr_ref_cfg_0_ref_cont_meas_mode   ;    
   uint32_t  elcorr_ref_cfg_0_start_dly_sampclk    ;    
   uint32_t  elcorr_ref_cfg_0_samp_num_per_ch      ;    
   uint32_t  elcorr_ref_cfg_0_samp_mean_numerator  ;    
   uint32_t  elcorr_ref_cfg_0_ref_value            ;    
   
   uint32_t  elcorr_ref_cfg_1_ref_enabled          ;    
   uint32_t  elcorr_ref_cfg_1_ref_cont_meas_mode   ;    
   uint32_t  elcorr_ref_cfg_1_start_dly_sampclk    ;    
   uint32_t  elcorr_ref_cfg_1_samp_num_per_ch      ;    
   uint32_t  elcorr_ref_cfg_1_samp_mean_numerator  ;    
   uint32_t  elcorr_ref_cfg_1_ref_value            ;    
   uint32_t  elcorr_ref_dac_id                     ;     
   int32_t   elcorr_atemp_gain                     ;     
   int32_t   elcorr_atemp_ofs                      ;     
   uint32_t  elcorr_ref0_op_sel                    ;     
   
   uint32_t  elcorr_ref1_op_sel                    ;     
   uint32_t  elcorr_mult_op_sel                    ;     
   uint32_t  elcorr_div_op_sel                     ;     
   uint32_t  elcorr_add_op_sel                     ;     
   uint32_t  elcorr_spare3                         ;     
   
   uint32_t  sat_ctrl_en                           ;     
   uint32_t  cfg_num                               ;     
   uint32_t  elcorr_spare4                         ;     
   uint32_t  roic_cst_output_mode                  ;     
   uint32_t  adc_clk_source_phase3                 ;
   uint32_t  adc_clk_pipe_sel3                     ;
   uint32_t  spare3c                               ;
   uint32_t  roic_dbg_reg                          ;     
   uint32_t  roic_test_row_en                      ;     
   
   uint32_t  adc_clk_source_phase4                 ;
   uint32_t  adc_clk_pipe_sel4                     ;
   
   uint32_t  single_samp_mode_en                   ;
   uint32_t  nominal_clk_id_sample_pos             ;
   uint32_t  mclk1_id_sample_pos                   ;
   uint32_t  mclk2_id_sample_pos                   ;
   uint32_t  mclk3_id_sample_pos                   ;

   uint32_t  elcorr_ref_cfg_0_forced_val_enabled   ;
   uint32_t  elcorr_ref_cfg_0_forced_val           ;
   uint32_t  elcorr_ref_cfg_1_forced_val_enabled   ;
   uint32_t  elcorr_ref_cfg_1_forced_val           ;

   uint32_t  dynrange_scaling_numerator            ;
   uint32_t  dynrange_clipping_level               ;
   int32_t   dynrange_global_offset                ;
   uint32_t  dynrange_op_sel                       ;

   uint32_t  clk_area_c_line_start_num             ;
   uint32_t  clk_area_c_line_end_num               ;
   uint32_t  clk_area_c_sol_posl_pclk              ;
   uint32_t  clk_area_c_eol_posl_pclk              ;
   uint32_t  clk_area_c_spare                      ;
   uint32_t  clk_area_c_clk_id                     ;

   uint32_t  offcorr_line_start                    ;
   uint32_t  offcorr_line_end                      ;
   uint32_t  offcorr_coeff0                        ;

};                                  
typedef struct s_FpaIntfConfig t_FpaIntf;

// ENO :ATTENTION , V�rifier valeur de DET dans le constructeur
// ELA : Les valeurs par d�faut du constructeur ne sont plus activement utilis�es comme
//       fpa_init() �crase les bonnes valeurs initiales avant m�me que le module
//       FPA devienne actif.
#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0}

// statuts provenant du vhd
struct s_FpaStatus    // 
{
   // fpa init status (ne provient pas du vhd)
   uint32_t  fpa_init_done;            // donne l'�tat de l'initialisation du module FPA (hw + sw)
   uint32_t  fpa_init_success;         // donne le r�sultat de l'initialisation du module FPA (hw + sw) 
   
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
   
   // driver status
   uint32_t  intf_seq_stat;            // statut du sequenceur. D�finition dans fpa_intf_sequencer.vhd
   uint32_t  data_path_stat;           // statut de la chaine de donn�es. D�finition dans "fpa"_intf.bde
   uint32_t  trig_ctler_stat;          // statut du controleur de trig. D�finition dans fpa_trig_controller.vhd
   uint32_t  fpa_driver_stat;          // statut du hw driver. D�finition dans "fpa"_hw_driver.bde

   // pour le power management
   uint32_t  adc_ddc_detect_process_done; // dit si le  processus de d�tection de la carte ADC/ DDC est achev�
   uint32_t  adc_ddc_present;             // dit si une carte valide est d�tect�e
   uint32_t  flex_flegx_detect_process_done; // dit si le  processus de d�tection du flex est achev�
   uint32_t  flex_flegx_present;          // dit si une carte valide est d�tect�e
   uint32_t  flegx_present;               // '1' dit si l'�lectronique de proximit� est un flegX, sinon, c'est un flex

   uint32_t  id_cmd_in_error;             // donne la commande en erreur pour les detecteurs numeriques. 0xFF -> aucune cmd en erreur

   // fpa serdes
   uint32_t  fpa_serdes_done;             // donne l'�tat de la calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_success;          // donne le r�sultat de la calibration des serdes pour chaque canal
   uint8_t   fpa_serdes_delay[4];         // donne le d�lai de calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_edges[4];         // donne les edges trouv�s lors de la calibration des serdes pour chaque canal

   // hw init status
   uint32_t  hw_init_done;                // donne l'�tat de l'initialisation du hw
   uint32_t  hw_init_success;             // donne le r�sultat de l'initialisation du hw
   uint32_t  prog_init_done;              // -- monte � '1' lorsque la config d'initialisation est programm�e dans le ROIC. Ce qui est int�ressant pour les ROIC necessitant une config d'initialisation
   
   // cooler
   uint32_t  cooler_on_curr_min_mA;       // seuil au dessus duquel consid�rer que le refroidisseur est allum�
   uint32_t  cooler_off_curr_max_mA;      // seuil en dessous duquel consid�rer que le refroidisseur est eteint
   
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
int16_t FPA_GetTemperature(t_FpaIntf *ptrA);

// pour avoir les statuts complets
void FPA_GetStatus(t_FpaStatus *Stat, t_FpaIntf *ptrA);

// pour afficher le feedback de FPA_INTF_CFG
void FPA_PrintConfig(const t_FpaIntf *ptrA);

// pour mttre les io en 'Z' avant d'�teindre la carte DDC
void  FPA_PowerDown(const t_FpaIntf *ptrA);

#endif // __FPA_INTF_H__
