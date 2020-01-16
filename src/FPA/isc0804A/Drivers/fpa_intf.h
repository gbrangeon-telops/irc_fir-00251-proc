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

#define FPA_DEVICE_MODEL_NAME    "ISC0804A__11.1MHz SVN_TRUNK"

#define FPA_WIDTH_MIN      64    //
#define FPA_WIDTH_MAX      640
#define FPA_WIDTH_MULT     32
#define FPA_WIDTH_INC      FPA_WIDTH_MULT

#define FPA_HEIGHT_MIN     4
#define FPA_HEIGHT_MAX     512
#define FPA_HEIGHT_MULT    4
#define FPA_HEIGHT_INC     lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT)

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   32 
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX-FPA_WIDTH_MIN)
#define FPA_OFFSETY_MIN    0
#define FPA_OFFSETY_MULT   4
#define FPA_OFFSETY_MAX    (FPA_HEIGHT_MAX-FPA_HEIGHT_MIN)

#define FPA_FORCE_CENTER   1
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (Isc0804AIsImplemented | ITRIsImplementedMask | ClFullIsImplementedMask)

#define FPA_MAX_GAIN       0
#define FPA_NUMTAPS        16  // [taps]

#define FPA_COOLER_TEMP_THRES    -17300
#define FPA_DEFAULT_EXPOSURE     50.0F //[us]
#define FPA_DEFAULT_FRAME_RATE   30.0F //[Hz]

// TODO Update EHDRI default exposure times.
#define FPA_EHDRI_EXP_0    25.0F  // Saturation à 395C
#define FPA_EHDRI_EXP_1    50.0F
#define FPA_EHDRI_EXP_2    100.0F
#define FPA_EHDRI_EXP_3    200.0F  // Saturation à 28

#define FPA_CAL_MIN_EXPOSURE  0.271F
#define FPA_CAL_MAX_EXPOSURE  1000000.0F

#define FPA_MIN_EXPOSURE               0.271F //0.271F     // 0.6F //0.271F     // [us]
#define FPA_MAX_EXPOSURE               1000000.0F // [us]  ne pas depasser 2 secondes pour les détyecteurs analogiques car le convertisseur vhd de temps d'exposition en depend 

#define FPA_AECP_MIN_EXPOSURE          FPA_MIN_EXPOSURE // [us] Minimum exposure time when AEC+ is active.

#define FPA_DATA_RESOLUTION 14
#define FPA_PIXEL_PITCH                25E-6F

#define FPA_INVALID_TEMP               -32768   // cC

#define FPA_MCLK_RATE_HZ            11100000          //5500000     //11100000          //11880000          //5000000    //11100000          // le master clock du FPA
#define FPA_CLOCK_FREQ_HZ           FPA_MCLK_RATE_HZ  // utilisé dans GC_registers.c
#define FPA_PIX_THROUGHPUT_PEAK        (FPA_NUMTAPS * FPA_MCLK_RATE_HZ * 2.0F)  // [pix/sec] , one pixel per mclk edges (DDR) 

// structure de config envoyée au vhd 
struct s_FpaIntfConfig    // Remarquer la disparition du champ fpa_integration_time. le temps d'integration n'est plus défini par le module FPA_INTF
{
   uint32_t  SIZE;
   uint32_t  ADD;
   
   // partie commune (modules communs dans le vhd de fpa_interface. Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   // champ 1 
   uint32_t  fpa_diag_mode;         
   uint32_t  fpa_diag_type;         
   uint32_t  fpa_pwr_on;  
   uint32_t  fpa_trig_ctrl_mode;    
   uint32_t  fpa_acq_trig_ctrl_dly; 
   uint32_t  fpa_spare;         
   uint32_t  fpa_xtra_trig_ctrl_dly;
   uint32_t  fpa_trig_ctrl_timeout_dly;        
   uint32_t  fpa_stretch_acq_trig;  
                                      
   // diag window param   ;
   // champ 10
   uint32_t  diag_ysize;                           
   uint32_t  diag_xsize_div_tapnum;           
                                             
   // Roic window param
   // champ 12
   uint32_t  roic_ystart;                           
   uint32_t  roic_ysize_div4_m1;                     
                                       
   // roic misc
   // champ 14
   uint32_t  vdet_code;               // ENO :ATTENTION , Vérifier valeur par defaut dans le constructeur                         
   uint32_t  ref_mode_en;                           
   uint32_t  ref_chn_en;                             
   uint32_t  clamping_level;                                             
   
   // champ 18
   uint32_t  real_mode_active_pixel_dly;             
                                        
   // 
   // champ 19
   uint32_t  speedup_lsync;                          
   uint32_t  speedup_sample_row;                     
   uint32_t  speedup_unused_area;                    
                                        
   // raw area
   // champ 22
   uint32_t  raw_area_line_start_num;                
   uint32_t  raw_area_line_end_num;                  
   uint32_t  raw_area_sof_posf_pclk;                 
   uint32_t  raw_area_eof_posf_pclk;                 
   uint32_t  raw_area_sol_posl_pclk;                 
   uint32_t  raw_area_eol_posl_pclk;                 
   uint32_t  raw_area_eol_posl_pclk_p1;             
   uint32_t  raw_area_window_lsync_num;              
   uint32_t  raw_area_line_period_pclk;              
   uint32_t  raw_area_readout_pclk_cnt_max;   
                                             
   // user_area
   // champ 32
   uint32_t  user_area_line_start_num;        
   uint32_t  user_area_line_end_num;          
   uint32_t  user_area_sol_posl_pclk;         
   uint32_t  user_area_eol_posl_pclk;         
   uint32_t  user_area_eol_posl_pclk_p1;
   
   // stretch_area
   // champ 37
   uint32_t  stretch_area_sol_posl_pclk;         
   uint32_t  stretch_area_eol_posl_pclk;         
                                
   // sampling param
   // champ 39
   uint32_t  pix_samp_num_per_ch;             
   uint32_t  hgood_samp_sum_num;              
   uint32_t  hgood_samp_mean_numerator;       
   uint32_t  vgood_samp_sum_num;              
   uint32_t  vgood_samp_mean_numerator;       
   uint32_t  good_samp_first_pos_per_ch;      
   uint32_t  good_samp_last_pos_per_ch;       
   
   // dephaseur
   // champ 46
   int32_t   adc_clk_source_phase;
   uint32_t  adc_clk_pipe_sel;
   
   // proximity electronics
   // champ 48
   uint32_t  proxim_is_flegx;
   
   // fast windowing
   // champ 49
   uint32_t  lsydel_mclk;                     
   uint32_t  boost_mode;                      
   uint32_t  speedup_lsydel;                  
   uint32_t  fastrd_sync_pos;
   
   //electrical gain and offset correction
   // champ 53
   uint32_t  elcorr_enabled;                        
   uint32_t  elcorr_spare1;         
   uint32_t  elcorr_spare2;                
                                           
   uint32_t  elcorr_ref_cfg_0_ref_enabled;
   uint32_t  elcorr_ref_cfg_0_ref_cont_meas_mode;
   uint32_t  elcorr_ref_cfg_0_start_dly_sampclk;
   uint32_t  elcorr_ref_cfg_0_samp_num_per_ch;
   uint32_t  elcorr_ref_cfg_0_samp_mean_numerator;
   uint32_t  elcorr_ref_cfg_0_ref_value;
                                                   
   uint32_t  elcorr_ref_cfg_1_ref_enabled;
   uint32_t  elcorr_ref_cfg_1_ref_cont_meas_mode;
   uint32_t  elcorr_ref_cfg_1_start_dly_sampclk;
   uint32_t  elcorr_ref_cfg_1_samp_num_per_ch;
   uint32_t  elcorr_ref_cfg_1_samp_mean_numerator;
   uint32_t  elcorr_ref_cfg_1_ref_value;

   uint32_t  elcorr_ref_dac_id;     
   int32_t   elcorr_atemp_gain;     
   int32_t   elcorr_atemp_ofs;   
   
   uint32_t  elcorr_ref0_op_sel;  
   uint32_t  elcorr_ref1_op_sel;  
   uint32_t  elcorr_mult_op_sel;  
   uint32_t  elcorr_div_op_sel;  
   uint32_t  elcorr_add_op_sel;
   
   uint32_t  sat_ctrl_en;   
   int32_t   roic_dbg_reg;
   
   uint32_t  roic_test_row_en;
   uint32_t  roic_cst_output_mode;
   
   uint32_t  elcorr_spare;
   uint32_t  cfg_num;
   uint32_t  elcorr_spare4;
   uint32_t  fpa_intf_data_source;
   uint32_t  permit_lsydel_clk_rate_beyond_2x;
};                                  
typedef struct s_FpaIntfConfig t_FpaIntf;

// ENO :ATTENTION , Vérifier valeur de DET dans le constructeur
#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  306888,1,0,  0, 0x17, 0, 0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  0,823269205, 0, 0, 0, 0, 0, 0, 0}

// statuts provenant du vhd
struct s_FpaStatus    // 
{
   // fpa init status (ne provient pas du vhd)
   uint32_t  fpa_init_done;            // donne l'état de l'initialisation du module FPA (hw + sw)
   uint32_t  fpa_init_success;         // donne le résultat de l'initialisation du module FPA (hw + sw) 
   
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

   // pour le power management
   uint32_t  adc_ddc_detect_process_done; // dit si le  processus de détection de la carte ADC/ DDC est achevé
   uint32_t  adc_ddc_present;             // dit si une carte valide est détectée
   uint32_t  flex_flegx_detect_process_done; // dit si le  processus de détection du flex est achevé
   uint32_t  flex_flegx_present;          // dit si une carte valide est détectée
   uint32_t  flegx_present;               // '1' dit si l'électronique de proximité est un flegX, sinon, c'est un flex

   uint32_t  id_cmd_in_error;             // donne la commande en erreur pour les detecteurs numeriques. 0xFF -> aucune cmd en erreur

   // fpa serdes
   uint32_t  fpa_serdes_done;             // donne l'état de la calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_success;          // donne le résultat de la calibration des serdes pour chaque canal
   uint8_t   fpa_serdes_delay[4];         // donne le délai de calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_edges[4];         // donne les edges trouvés lors de la calibration des serdes pour chaque canal

   // hw init status
   uint32_t  hw_init_done;                // donne l'état de l'initialisation du hw
   uint32_t  hw_init_success;             // donne le résultat de l'initialisation du hw
   uint32_t  prog_init_done;              // -- monte à '1' lorsque la config d'initialisation est programmée dans le ROIC. Ce qui est intéressant pour les ROIC necessitant une config d'initialisation
   
   // cooler
   uint32_t  cooler_on_curr_min_mA;       // seuil au dessus duquel considérer que le refroidisseur est allumé
   uint32_t  cooler_off_curr_max_mA;      // seuil en dessous duquel considérer que le refroidisseur est eteint
   
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
};
typedef struct s_FpaStatus t_FpaStatus;
																						  
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
int16_t FPA_GetTemperature(t_FpaIntf *ptrA);

// pour avoir les statuts complets
void FPA_GetStatus(t_FpaStatus *Stat, t_FpaIntf *ptrA);

// pour mttre les io en 'Z' avant d'éteindre la carte DDC
void  FPA_PowerDown(const t_FpaIntf *ptrA);

#endif // __FPA_INTF_H__
