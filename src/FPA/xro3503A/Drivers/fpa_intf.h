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
#include "FPABinningConfig.h"

#ifdef FPA_VERBOSE
   #define FPA_PRINTF(fmt, ...)    FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#else
   #define FPA_PRINTF(fmt, ...)    DUMMY_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#endif

#define FPA_ERR(fmt, ...)        FPGA_PRINTF("FPA: Error: " fmt "\n", ##__VA_ARGS__)
#define FPA_INF(fmt, ...)        FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)

#define FPA_DEVICE_MODEL_NAME    "XRO3503A " XSTR(FPA_MCLK_RATE_HZ) " Hz"

#define FPA_WIDTH_MIN      64    // camera min is 64 even if FPA can do 32
#define FPA_WIDTH_MAX      640
#define FPA_WIDTH_MULT     16
#define FPA_WIDTH_INC      FPA_WIDTH_MULT

#define FPA_HEIGHT_MIN     4
#define FPA_HEIGHT_MAX     512
#define FPA_HEIGHT_MULT    4
#define FPA_HEIGHT_INC     8 // lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT) //plus possible de le faire avec une structure

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   16
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX-FPA_WIDTH_MIN)

#define FPA_OFFSETY_MIN    0
#define FPA_OFFSETY_MULT   4
#define FPA_OFFSETY_MAX    (FPA_HEIGHT_MAX-FPA_HEIGHT_MIN)

#define FPA_MAX_NUMBER_CONFIG_MODE 1U

#define FPA_FORCE_CENTER   0
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (Xro3503AIsImplemented | ITRIsImplementedMask | IWRIsImplementedMask | HighGainSWDIsImplementedMask)
#define FPA_TDC_FLAGS2           (AECIsImplementedMask | CalibrationFileStorageIsImplementedMask)

#define FPA_NUMTAPS        16  // [taps]

#define FPA_COOLER_TEMP_THRES    2500     //[cC]
#define FPA_COOLER_TEMP_TOL      500      //[cC]
#define FPA_DEFAULT_EXPOSURE     5000.0F  //[us]
#define FPA_DEFAULT_FRAME_RATE   25.0F    //[Hz]

#define FPA_EHDRI_EXP_0    50.0F
#define FPA_EHDRI_EXP_1    200.0F
#define FPA_EHDRI_EXP_2    1000.0F
#define FPA_EHDRI_EXP_3    5000.0F

#define FPA_MIN_EXPOSURE               1.0F     // [us] comportement non-lin�aire en bas de 1us
#define FPA_MAX_EXPOSURE               1000000.0F // [us]  ne pas depasser 2 secondes pour les d�tecteurs analogiques car le convertisseur vhd de temps d'exposition en depend

#define FPA_DATA_RESOLUTION            14
#define FPA_PIXEL_PITCH                20E-6F

#define FPA_INVALID_TEMP               -32768   // cC

//#define FPA_MCLK_RATE_HZ               10E+6F    // le master clock du FPA
#define FPA_MCLK_RATE_HZ               27E+6F    // le master clock du FPA
//#define FPA_MCLK_RATE_HZ               40E+6F    // le master clock du FPA
#define FPA_MCLK_SOURCE_RATE_HZ        (4.0F * FPA_MCLK_RATE_HZ)    // le master clock source
#define FPA_EXPOSURE_TIME_RESOLUTION   (1E6F/FPA_MCLK_RATE_HZ)

#define FPA_PIX_THROUGHPUT_PEAK        (FPA_NUMTAPS * FPA_MCLK_RATE_HZ)  // [pix/sec]

#define FPA_MAX_NUMBER_BINNING_CONFIG 1

// structure de config envoy�e au vhd 
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
   uint32_t  fpa_trig_ctrl_timeout_dly;  // utilis� par le trig_controller.vhd
   uint32_t  fpa_stretch_acq_trig;       // utilis� par le trig_precontroller.vhd
   uint32_t  fpa_intf_data_source;       // utilis� par le afpa_flow_mux.vhd
   
   // diag
   uint32_t  diag_ysize;
   uint32_t  diag_xsize_div_tapnum;

   // prog ctrl
   uint32_t  xstart;             
   uint32_t  ystart;             
   uint32_t  xstop;
   uint32_t  ystop;
   uint32_t  sub_window_mode;
   uint32_t  read_dir_down;
   uint32_t  read_dir_left;
   uint32_t  gain;            
   uint32_t  ctia_bias_current;

   // dval gen
   uint32_t  real_mode_active_pixel_dly;

   // readout ctrl
   uint32_t  line_period_pclk;
   uint32_t  readout_pclk_cnt_max;
   uint32_t  active_line_start_num;
   uint32_t  active_line_end_num;                   
   uint32_t  window_lsync_num;
   uint32_t  sof_posf_pclk;
   uint32_t  eof_posf_pclk;   
   uint32_t  sol_posl_pclk;          
   uint32_t  eol_posl_pclk;  
   uint32_t  eol_posl_pclk_p1;

   // sample proc
   uint32_t  pix_samp_num_per_ch;
   uint32_t  hgood_samp_sum_num;          
   uint32_t  hgood_samp_mean_numerator;                
   uint32_t  vgood_samp_sum_num;                
   uint32_t  vgood_samp_mean_numerator;                
   uint32_t  good_samp_first_pos_per_ch;                
   uint32_t  good_samp_last_pos_per_ch;

   // clk gen
   uint32_t  adc_clk_source_phase;           
   uint32_t  adc_clk_pipe_sel;

   // image info
   uint32_t  offsetx;
   uint32_t  offsety;
   uint32_t  width;
   uint32_t  height;

   // digio
   uint32_t  roic_cst_output_mode;
   uint32_t  fpa_pwr_override_mode;

   // diag lovh
   uint32_t  diag_lovh_mclk_source;

   // fpa temp correction
   uint32_t  fpa_temp_pwroff_correction;

   // new config
   uint32_t  cfg_num;
   
   // cropping
   uint32_t  aoi_data_sol_pos;
   uint32_t  aoi_data_eol_pos;
   uint32_t  aoi_flag1_sol_pos;
   uint32_t  aoi_flag1_eol_pos;
   uint32_t  aoi_flag2_sol_pos;
   uint32_t  aoi_flag2_eol_pos;
};
typedef struct s_FpaIntfConfig t_FpaIntf;

#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                                         0, 0, 0, 0, 0, 0}

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

   // driver status
   uint32_t  intf_seq_stat;            // statut du sequenceur. D�finition dans fpa_intf_sequencer.vhd
   uint32_t  data_path_stat;           // statut de la chaine de donn�es. D�finition dans "fpa"_intf.bde
   uint32_t  trig_ctler_stat;          // statut du controleur de trig. D�finition dans fpa_trig_controller.vhd
   uint32_t  fpa_driver_stat;          // statut du hw driver. D�finition dans "fpa"_hw_driver.bde

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
int16_t FPA_GetTemperature(const t_FpaIntf *ptrA);

// pour avoir les statuts complets
void FPA_GetStatus(t_FpaStatus *Stat, const t_FpaIntf *ptrA);

// pour afficher le feedback de FPA_INTF_CFG
void FPA_PrintConfig(const t_FpaIntf *ptrA);

// pour mttre les io en 'Z' avant d'�teindre la carte DDC
void  FPA_PowerDown(const t_FpaIntf *ptrA);

#endif // __FPA_INTF_H__
