/*-----------------------------------------------------------------------------
--
-- Title       : FPA_INTF header
-- Author      : Patrick Daraiche
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision$
-- $Author$
-- $LastChangedDate$
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

#ifdef FPA_VERBOSE
   #define FPA_PRINTF(fmt, ...)    FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#else
   #define FPA_PRINTF(fmt, ...)    DUMMY_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#endif

#define FPA_ERR(fmt, ...)        FPGA_PRINTF("FPA: Error: " fmt "\n", ##__VA_ARGS__)
#define FPA_INF(fmt, ...)        FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)

#define FPA_DEVICE_MODEL_NAME    "CALCIUM640D"

#define FPA_WIDTH_MIN      64    // camera min is 64 even if FPA can do 8   
#define FPA_WIDTH_MAX      640
#define FPA_WIDTH_MULT     8
#define FPA_WIDTH_INC      FPA_WIDTH_MULT

#define FPA_HEIGHT_MIN     1
#define FPA_HEIGHT_MAX     512
#define FPA_HEIGHT_MULT    1
#define FPA_HEIGHT_INC     lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT)

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   8
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX-FPA_WIDTH_MIN)

#define FPA_OFFSETY_MIN    0
#define FPA_OFFSETY_MULT   1
#define FPA_OFFSETY_MAX    (FPA_HEIGHT_MAX-FPA_HEIGHT_MIN)

#define FPA_FORCE_CENTER   0
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (Calcium640DIsImplemented | ITRIsImplementedMask | IWRIsImplementedMask | HighGainSWDIsImplementedMask)
#define FPA_TDC_FLAGS2           (ManufacturerStaticImageIsImplementedMask)

#define FPA_COOLER_TEMP_THRES    -19400   // [cC]
#define FPA_COOLER_TEMP_TOL      1000     // [cC]
#define FPA_DEFAULT_EXPOSURE     1000.0F  // [us]
#define FPA_DEFAULT_FRAME_RATE   25.0F    // [Hz]

#define FPA_EHDRI_EXP_0    23.0F
#define FPA_EHDRI_EXP_1    200.0F
#define FPA_EHDRI_EXP_2    1000.0F
#define FPA_EHDRI_EXP_3    6893.0F

// horloges du module FPA et du ROIC
// les relations entre les horloges sont vérifiées dans la fonction FPA_SpecificParams
#define VHD_CLK_100M_RATE_HZ        100e6F
#define CALCIUM_CLK_DDR_HZ          400e6F
#define CALCIUM_CLK_CORE_HZ         10e6F
#define CALCIUM_CLK_CTRL_DSM_HZ     CALCIUM_CLK_CORE_HZ
#define CALCIUM_CLK_COL_HZ          50e6F

// paramètres du ROIC
#define CALCIUM_TX_OUTPUTS          8     // nombre d'outputs en parallèle
#define CALCIUM_BITS_PER_PIX        24    // nombre de bits transmis pour 1 pixel
#define CALCIUM_bTestRowsEn         1     // désactive (0) ou active (1) les 2 test rows
#define CALCIUM_bADRstCnt           16    // reset time for the ADC, in ClkCol cycles
#define CALCIUM_bPixRstHCnt         0     // reset time of hold capacitor, in units of ClkCore
#define CALCIUM_bPixXferCnt         0     // transfer time of hold capacitor, in units of ClkCore
#define CALCIUM_bPixOHCnt           0     // overhead time between reset and transfer of hold capacitor, in units of ClkCore
#define CALCIUM_bPixOH2Cnt          0     // overhead time between transfer of hold capacitor and pixel back-end reset, in units of ClkCore
#define CALCIUM_bPixRstBECnt        0     // reset time for pixel back-end counters, in units of ClkCore
#define CALCIUM_bRODelayCnt         0     // readout delay time after reset of pixel back-end counters, in units of ClkCore

#define FPA_EXPOSURE_TIME_RESOLUTION   (1e6F/CALCIUM_CLK_CORE_HZ)     // [us]

#define FPA_MIN_EXPOSURE               1.0F  // [us]
#define FPA_MAX_EXPOSURE               (1048575.0F * FPA_EXPOSURE_TIME_RESOLUTION)   // [us]  registre bIntcnt est sur 20b

#define FPA_CAL_MIN_EXPOSURE           FPA_MIN_EXPOSURE
#define FPA_CAL_MAX_EXPOSURE           FPA_MAX_EXPOSURE

#define FPA_AECP_MIN_EXPOSURE          FPA_MIN_EXPOSURE // [us] Minimum exposure time when AEC+ is active.

#define FPA_DATA_RESOLUTION            16
#define FPA_PIXEL_PITCH                20E-6F

#define FPA_INVALID_TEMP               -32768   // [cC]

#define FPA_PIX_THROUGHPUT_PEAK        (CALCIUM_TX_OUTPUTS * CALCIUM_CLK_DDR_HZ * 2.0F / CALCIUM_BITS_PER_PIX)  // [pix/sec]  8 canaux à 400MHz DDR à 24b par pixel


// structure de config envoyée au vhd
struct s_FpaIntfConfig    // Remarquer la disparition du champ fpa_integration_time. le temps d'integration n'est plus défini par le module FPA_INTF
{
   uint32_t  SIZE;
   uint32_t  ADD;
   
   uint32_t  fpa_diag_mode;
   uint32_t  fpa_diag_type;
   uint32_t  fpa_pwr_on;
   uint32_t  fpa_acq_trig_mode;
   uint32_t  fpa_acq_trig_ctrl_dly;
   uint32_t  fpa_xtra_trig_mode;
   uint32_t  fpa_xtra_trig_ctrl_dly;
   uint32_t  fpa_trig_ctrl_timeout_dly;
   uint32_t  fpa_stretch_acq_trig;
   uint32_t  fpa_intf_data_source;
   uint32_t  fpa_xtra_trig_int_time;
   uint32_t  fpa_prog_trig_int_time;
   uint32_t  intclk_to_clk100_conv_numerator;
   uint32_t  clk100_to_intclk_conv_numerator;
   uint32_t  offsetx;
   uint32_t  offsety;
   uint32_t  width;
   uint32_t  height;
   uint32_t  active_line_start_num;
   uint32_t  active_line_end_num;
   uint32_t  active_line_width_div4;
   uint32_t  diag_x_to_readout_start_dly;
   uint32_t  diag_fval_re_to_dval_re_dly;
   uint32_t  diag_lval_pause_dly;
   uint32_t  diag_x_to_next_fsync_re_dly;
   uint32_t  diag_xsize_div_per_pixel_num;
   int32_t   fpa_int_time_offset;
   uint32_t  int_fdbk_dly;
   uint32_t  kpix_pgen_value;
   uint32_t  kpix_mean_value;
   uint32_t  use_ext_pixqnb;
   uint32_t  clk_frm_pulse_width;
   uint32_t  fpa_serdes_lval_num;
   uint32_t  fpa_serdes_lval_len;
   float     compr_ratio_fp32;
   uint32_t  cfg_num;
   
};
typedef struct s_FpaIntfConfig t_FpaIntf;

#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add}

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
   
   // driver status
   uint32_t  intf_seq_stat;            // statut du sequenceur. Définition dans fpa_intf_sequencer.vhd
   uint32_t  data_path_stat;           // statut de la chaine de données. Définition dans "fpa"_intf.bde
   uint32_t  trig_ctler_stat;          // statut du controleur de trig. Définition dans fpa_trig_controller.vhd
   uint32_t  fpa_driver_stat;          // statut du hw driver. Définition dans "fpa"_hw_driver.bde

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
