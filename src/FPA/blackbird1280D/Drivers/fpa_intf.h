/*-----------------------------------------------------------------------------
--
-- Title       : FPA_INTF header
-- Author      : Philippe Couture
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
#include "IRC_status.h"

#ifndef SCD_PROXY
   #define SCD_PROXY
#endif

#ifndef SCD_BLACKBIRD1280D
   #define SCD_BLACKBIRD1280D
#endif

#ifdef FPA_VERBOSE
   #define FPA_PRINTF(fmt, ...)    FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#else
   #define FPA_PRINTF(fmt, ...)    DUMMY_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#endif

#define FPA_ERR(fmt, ...)        FPGA_PRINTF("FPA: Error: " fmt "\n", ##__VA_ARGS__)
#define FPA_INF(fmt, ...)        FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)

#define FPA_DEVICE_MODEL_NAME    "BLACKBIRD1280"

#define FPA_WIDTH_MIN      64  // La limitation à 64 est propre à Telops (minimum pour contenir un header). Le proxy est limité à 16.
#define FPA_WIDTH_MAX      1280
#define FPA_WIDTH_MULT     4
#define FPA_WIDTH_INC      FPA_WIDTH_MULT

#define FPA_HEIGHT_MIN     8
#define FPA_HEIGHT_MAX     1024
#define FPA_HEIGHT_MULT    4
#define FPA_HEIGHT_INC     lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT)

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   4
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX-FPA_WIDTH_MIN)

#define FPA_OFFSETY_MIN          0
#define FPA_OFFSETY_MULT         4
//#define FPA_OFFSETY_MULT_CORR    4   // Inutile pour BB1280.
#define FPA_OFFSETY_MAX          (FPA_HEIGHT_MAX-FPA_HEIGHT_MIN)

#define FPA_FORCE_CENTER   1
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0
#define FPA_NUM_CH         3  // nombre de canaux de sorties  (1, 2 ou 3)
#define FPA_CLINK_PIX_NUM  4

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (Blackbird1280DIsImplemented | ITRIsImplementedMask | IWRIsImplementedMask)
#define FPA_TDC_FLAGS2           0

#define FPA_COOLER_TEMP_THRES    -19400   //[cC]
#define FPA_COOLER_TEMP_TOL      1000     //[cC]
#ifdef SIM
   #define FPA_DEFAULT_EXPOSURE     5.0F //[us]
   #define FPA_DEFAULT_FRAME_RATE   1000.0F //[Hz]
#else
   #define FPA_DEFAULT_EXPOSURE     5000.0F //[us]
   #define FPA_DEFAULT_FRAME_RATE   12.0F //[Hz]
#endif

// TODO Update EHDRI default exposure times.
#define FPA_EHDRI_EXP_0    23.0F  // Saturation à 395C
#define FPA_EHDRI_EXP_1    200.0F
#define FPA_EHDRI_EXP_2    1000.0F
#define FPA_EHDRI_EXP_3    6893.0F  // Saturation à 28

#define FPA_CAL_MIN_EXPOSURE  0.5F
#define FPA_CAL_MAX_EXPOSURE  85000.0F

#define FPA_MIN_EXPOSURE               0.5F     // [us]
#define FPA_MAX_EXPOSURE               80000.0F // [us]

#define FPA_AECP_MIN_EXPOSURE          FPA_MIN_EXPOSURE // [us] Minimum exposure time when AEC+ is active.

#define FPA_VHD_INTF_CLK_RATE_HZ       100E+6F  // fréquence de l'horloge du module FPA_Interface en Hz
#define FPA_FPP_CLK_RATE_HZ            70E+6F   // fréquence de l'horloge du SCD Proxy
#define FPA_CLINK_CLK_RATE_HZ          80E+6F   // fréquence de l'horloge du ROIC (specific to BB1280)
#define SCD_FRAME_RESOLUTION           7.0F
#define FPA_EXPOSURE_TIME_RESOLUTION   (1E6F/(FPA_FPP_CLK_RATE_HZ/SCD_FRAME_RESOLUTION))

#define FPA_DATA_RESOLUTION            13
#define FPA_PIXEL_PITCH                10E-6F

#define FPA_INVALID_TEMP               -32768   // cC

#define FPA_PIX_THROUGHPUT_PEAK        (FPA_CLINK_PIX_NUM * FPA_CLINK_CLK_RATE_HZ)  // [pix/sec]

#define XTRA_TRIG_MODE_DELAY           100000  // us

#define SCD_MIN_OPER_FPS (float)12.0 // [Hz] fréquence minimale pour la configuration du SCD. N'empêche pas de le trigger plus lentement

#define SEND_CONFIG_DELAY             TIME_ONE_SECOND_US

// structure de config envoyée au vhd 
// c'est la commande operationnelle de scd étendue au vhd complet
struct s_FpaIntfConfig    // Remarquer la disparition du champ fpa_integration_time. le temps d'integration n'est plus défini par le module FPA_INTF
{
   uint32_t  SIZE;
   uint32_t  ADD;
   
   // partie commune (modules communs dans le vhd de fpa_interface. Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   uint32_t  fpa_diag_mode;              // utilisé par le trig_controller.vhd            
   uint32_t  fpa_diag_type;              // utilisé par le generateur de données diag de Telops
   uint32_t  fpa_pwr_on;                 // utilisé par le fpa_intf_sequencer.vhd            
   uint32_t  fpa_trig_ctrl_mode;         // utilisé par le trig_controller.vhd    
   uint32_t  fpa_acq_trig_ctrl_dly;      // utilisé par le trig_controller.vhd  
   uint32_t  fpa_spare;                  // utilisé par le trig_controller.vhd
   uint32_t  fpa_xtra_trig_ctrl_dly;     // utilisé par le trig_controller.vhd  
   uint32_t  fpa_trig_ctrl_timeout_dly;   // utilisé par le trig_controller.vhd
   
   // partie scd cmd operationnelle (tout changement dans cette partie entraine la reprogrammation du détecteur)
   uint32_t  scd_xstart;                
   uint32_t  scd_ystart;                
   uint32_t  scd_xsize;                
   uint32_t  scd_ysize;                
   uint32_t  scd_gain;                 
   uint32_t  scd_out_chn;              
   uint32_t  scd_diode_bias;                           
   uint32_t  scd_int_mode;
   uint32_t  scd_boost_mode;
   uint32_t  scd_pix_res;              
   uint32_t  scd_frame_period_min;

   // partie scd cmd diag (tout changement dans cette partie entraine la reprogrammation du détecteur)
   uint32_t  scd_bit_pattern;       
       
   // partie misc   (quelques parametres utilisés en mode diag Telops pour simuler le detecteur et en extra_trig . Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   uint32_t  scd_x_to_readout_start_dly;              // BB1280 : FR_DLY (section 3.2.4.3.2 in D15F002 REV2 ), Pelican/Hercule : delay T6 on fig 1 or 3(d1k3008-rev1)
   uint32_t  scd_fsync_re_to_fval_re_dly;             // Pelican/Hercule : delay T1 on fig 5 (d1k3008-rev1)
   uint32_t  scd_fval_re_to_dval_re_dly;              // Pelican/Hercule : delay T2 on fig 5 (d1k3008-rev1)
   uint32_t  scd_hdr_high_duration;                   // Pelican/Hercule : delay T6 on fig 5 (d1k3008-rev1)
   uint32_t  scd_lval_high_duration;                  // Pelican/Hercule : delay T3 on fig 5 (d1k3008-rev1)
   uint32_t  scd_hdr_start_to_lval_re_dly;            // Pelican/Hercule : delay T5 on fig 5 (d1k3008-rev1)
   uint32_t  scd_lval_pause_dly;                      // Pelican/Hercule : delay T4 on fig 5 (d1k3008-rev1)
   uint32_t  scd_x_to_next_fsync_re_dly;              // Pelican/Hercule : delay T5 on fig 1 & 3 (d1k3008-rev1)
   uint32_t  scd_fsync_re_to_intg_start_dly;          // Pelican/Hercule : delay T4 on fig 1 & 3 (d1k3008-rev1)
   uint32_t  scd_xsize_div_per_pixel_num;             // Pelican/Hercule = clink base (pixel_num = 2), BB1280 = clink full (pixel_num = 4)
   uint32_t  aoi_data_sol_pos;                        // Config module de cropping.
   uint32_t  aoi_data_eol_pos;                        // Config module de cropping.
   uint32_t  cfg_num;
   
   // partie commune (modules communs dans le vhd de fpa_interface. Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
   uint32_t  fpa_stretch_acq_trig;     // utilisé par le trig_precontroller.vhd
   
   // specifie la partie de la structure à mettre à jour (pour eviter des bugs)
   uint32_t  proxy_cmd_to_update_id;
};
typedef struct s_FpaIntfConfig t_FpaIntf;

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
   uint32_t  flex_flegx_present;             // dit si une carte valide est détectée
   uint32_t  flegx_present;               // '1' dit si l'électronique de proximité est un flegX, sinon, c'est un flex

   uint32_t  id_cmd_in_error;             // donne la commande en erreur pour les detecteurs numeriques. 0xFF -> aucune cmd en erreur

   // fpa serdes
   uint32_t  fpa_serdes_done;             // donne l'état de la calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_success;          // donne le résultat de la calibration des serdes pour chaque canal
   uint8_t   fpa_serdes_delay[4];         // donne le délai de calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_edges[4];         // donne les edges trouvés lors de la calibration des serdes pour chaque canal

   // hw init status
   uint32_t  hw_init_done;               // donne l'état de l'initialisation du FPA
   uint32_t  hw_init_success;            // donne le résultat de l'initialisation du FPA
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
#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}



// pour initialiser le module vhd avec les bons parametres de départ
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs);

//pour effacer les bits d'erreurs du bloc FPA_interface
void FPA_ClearErr(const t_FpaIntf *ptrA);


//pour configurer le bloc FPA_interface et le lancer
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs); 


void FPA_EnableSerialExposureTimeCMD(t_FpaIntf *ptrA, bool state);

//pour configurer la résolution de frame
void FPA_SetFrameResolution(t_FpaIntf *ptrA);
void FPA_SetFrameResolution_V2(t_FpaIntf *ptrA);

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

bool FPA_Specific_Init_SM(t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs, bool run);

/**
 * FPA Initialization state.
 */
enum fpaInitStateEnum {
   // Initialization states
   IDLE = 0,
   SEND_1ST_FPA_CONFIG,
   SEND_FRAME_RESOLUTION_CONFIG,
   SEND_2ND_FPA_CONFIG,
   START_SERDES_INITIALIZATION
};

/**
 * FPA Initialization state data type.
 */
typedef enum fpaInitStateEnum fpaInitState_t;

#endif // __FPA_INTF_H__
