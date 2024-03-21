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

#define FPA_WIDTH_MIN      64  // La limitation � 64 est propre � Telops (minimum pour contenir un header). Le proxy est limit� � 16.
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
#define FPA_EHDRI_EXP_0    23.0F  // Saturation � 395C
#define FPA_EHDRI_EXP_1    200.0F
#define FPA_EHDRI_EXP_2    1000.0F
#define FPA_EHDRI_EXP_3    6893.0F  // Saturation � 28

#define FPA_CAL_MIN_EXPOSURE  0.5F
#define FPA_CAL_MAX_EXPOSURE  85000.0F

#define FPA_MIN_EXPOSURE               0.5F     // [us]
#define FPA_MAX_EXPOSURE               80000.0F // [us]

#define FPA_AECP_MIN_EXPOSURE          FPA_MIN_EXPOSURE // [us] Minimum exposure time when AEC+ is active.

#define FPA_VHD_INTF_CLK_RATE_HZ       100E+6F  // fr�quence de l'horloge du module FPA_Interface en Hz
#define FPA_FPP_CLK_RATE_HZ            70E+6F   // fr�quence de l'horloge du SCD Proxy
#define FPA_CLINK_CLK_RATE_HZ          80E+6F   // fr�quence de l'horloge du ROIC (specific to BB1280)
#define SCD_FRAME_RESOLUTION           7.0F
#define FPA_EXPOSURE_TIME_RESOLUTION   (1E6F/(FPA_FPP_CLK_RATE_HZ/SCD_FRAME_RESOLUTION))

#define FPA_DATA_RESOLUTION            13
#define FPA_PIXEL_PITCH                10E-6F

#define FPA_INVALID_TEMP               -32768   // cC

#define FPA_PIX_THROUGHPUT_PEAK        (FPA_CLINK_PIX_NUM * FPA_CLINK_CLK_RATE_HZ)  // [pix/sec]

#define XTRA_TRIG_MODE_DELAY           100000  // us

#define SCD_MIN_OPER_FPS (float)12.0 // [Hz] fr�quence minimale pour la configuration du SCD. N'emp�che pas de le trigger plus lentement

#define SEND_CONFIG_DELAY             TIME_ONE_SECOND_US

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
   uint32_t  scd_boost_mode;
   uint32_t  scd_pix_res;              
   uint32_t  scd_frame_period_min;

   // partie scd cmd diag (tout changement dans cette partie entraine la reprogrammation du d�tecteur)
   uint32_t  scd_bit_pattern;       
       
   // partie misc   (quelques parametres utilis�s en mode diag Telops pour simuler le detecteur et en extra_trig . Les changements dans cette partie n'affectent pas la reprogrammation du detecteur)
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
   uint32_t  fpa_stretch_acq_trig;     // utilis� par le trig_precontroller.vhd
   
   // specifie la partie de la structure � mettre � jour (pour eviter des bugs)
   uint32_t  proxy_cmd_to_update_id;
};
typedef struct s_FpaIntfConfig t_FpaIntf;

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
   uint32_t  flex_flegx_present;             // dit si une carte valide est d�tect�e
   uint32_t  flegx_present;               // '1' dit si l'�lectronique de proximit� est un flegX, sinon, c'est un flex

   uint32_t  id_cmd_in_error;             // donne la commande en erreur pour les detecteurs numeriques. 0xFF -> aucune cmd en erreur

   // fpa serdes
   uint32_t  fpa_serdes_done;             // donne l'�tat de la calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_success;          // donne le r�sultat de la calibration des serdes pour chaque canal
   uint8_t   fpa_serdes_delay[4];         // donne le d�lai de calibration des serdes pour chaque canal
   uint32_t  fpa_serdes_edges[4];         // donne les edges trouv�s lors de la calibration des serdes pour chaque canal

   // hw init status
   uint32_t  hw_init_done;               // donne l'�tat de l'initialisation du FPA
   uint32_t  hw_init_success;            // donne le r�sultat de l'initialisation du FPA
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
																						  
// Function prototypes
#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}



// pour initialiser le module vhd avec les bons parametres de d�part
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs);

//pour effacer les bits d'erreurs du bloc FPA_interface
void FPA_ClearErr(const t_FpaIntf *ptrA);


//pour configurer le bloc FPA_interface et le lancer
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs); 


void FPA_EnableSerialExposureTimeCMD(t_FpaIntf *ptrA, bool state);

//pour configurer la r�solution de frame
void FPA_SetFrameResolution(t_FpaIntf *ptrA);
void FPA_SetFrameResolution_V2(t_FpaIntf *ptrA);

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
