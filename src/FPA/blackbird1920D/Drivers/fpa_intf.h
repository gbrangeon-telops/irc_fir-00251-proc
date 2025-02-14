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
#include "IRC_status.h"
#include "FPABinningConfig.h"

#ifndef SCD_PROXY
   #define SCD_PROXY
#endif

#ifdef FPA_VERBOSE
   #define FPA_PRINTF(fmt, ...)    FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#else
   #define FPA_PRINTF(fmt, ...)    DUMMY_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)
#endif

#define FPA_ERR(fmt, ...)        FPGA_PRINTF("FPA: Error: " fmt "\n", ##__VA_ARGS__)
#define FPA_INF(fmt, ...)        FPGA_PRINTF("FPA: " fmt "\n", ##__VA_ARGS__)

#define FPA_DEVICE_MODEL_NAME    "BLACKBIRD1920"

/*Standard*/
#define FPA_WIDTH_MIN      64
#define FPA_WIDTH_MAX      1920
#define FPA_WIDTH_MULT     4
#define FPA_WIDTH_INC      FPA_WIDTH_MULT

#define FPA_HEIGHT_MIN     8
#define FPA_HEIGHT_MAX     1536
#define FPA_HEIGHT_MULT    4
#define FPA_HEIGHT_INC     8 // lcm(FPA_HEIGHT_MULT, 2 * FPA_OFFSETY_MULT) //plus possible de le faire avec une structure

#define FPA_OFFSETX_MIN    0
#define FPA_OFFSETX_MULT   8
#define FPA_OFFSETX_MAX    (FPA_WIDTH_MAX-FPA_WIDTH_MIN)

#define FPA_OFFSETY_MIN    0
#define FPA_OFFSETY_MULT   4
//#define FPA_OFFSETY_MULT_CORR    4
#define FPA_OFFSETY_MAX    (FPA_HEIGHT_MAX-FPA_HEIGHT_MIN)

#define FPA_MAX_NUMBER_CONFIG_MODE 2U

/*Binning 960x768*/
#define FPA_BIN1_WIDTH_MIN      64
#define FPA_BIN1_WIDTH_MAX      960
#define FPA_BIN1_WIDTH_MULT     4
#define FPA_BIN1_WIDTH_INC      FPA_BIN1_WIDTH_MULT

#define FPA_BIN1_HEIGHT_MIN     8
#define FPA_BIN1_HEIGHT_MAX     768 //Note: in binning mode there are 767 active image rows. Added to these 767 rows, in full rate video + binning the last (768) row is invalid due to matrix architecture.
#define FPA_BIN1_HEIGHT_MULT    4
#define FPA_BIN1_HEIGHT_INC     8 // lcm(FPA_BIN1_HEIGHT_MULT, 2 * FPA_BIN1_OFFSETY_MULT) //plus possible de le faire avec une structure

#define FPA_BIN1_OFFSETX_MIN    0
#define FPA_BIN1_OFFSETX_MULT   8
#define FPA_BIN1_OFFSETX_MAX    (FPA_BIN1_WIDTH_MAX-FPA_BIN1_WIDTH_MIN) // lors d'un changement mettre � jour aussi les regitres

#define FPA_BIN1_OFFSETY_MIN    0
#define FPA_BIN1_OFFSETY_MULT   4
#define FPA_BIN1_OFFSETY_MAX    (FPA_BIN1_HEIGHT_MAX-FPA_BIN1_HEIGHT_MIN) // lors d'un changement mettre � jour aussi les regitres


#define FPA_FORCE_CENTER   1
#define FPA_FLIP_LR        0
#define FPA_FLIP_UD        0

#define FPA_INTEGRATION_MODE     IM_IntegrateThenRead
#define FPA_SENSOR_WELL_DEPTH    SWD_LowGain
#define FPA_TDC_FLAGS            (Blackbird1920DIsImplemented | ITRIsImplementedMask | IWRIsImplementedMask | HighGainSWDIsImplementedMask)
#define FPA_TDC_FLAGS2           (ManufacturerStaticImageIsImplementedMask /*| Binning2x2IsImplementedMask*/ | AECIsImplementedMask | \
                                 CalibrationFileStorageIsImplementedMask)

#define FPA_COOLER_TEMP_THRES    -20815   //[cC]
#define FPA_COOLER_TEMP_TOL      1000     //[cC]
#ifdef SIM
   #define FPA_DEFAULT_EXPOSURE     5.0F //[us]
   #define FPA_DEFAULT_FRAME_RATE   1000.0F //[Hz]
#else
   #define FPA_DEFAULT_EXPOSURE     10.0F //[us]
   #define FPA_DEFAULT_FRAME_RATE   12.0F //[Hz]
#endif

// TODO Update EHDRI default exposure times.
#define FPA_EHDRI_EXP_0    23.0F  // Saturation � 395C
#define FPA_EHDRI_EXP_1    200.0F
#define FPA_EHDRI_EXP_2    1000.0F
#define FPA_EHDRI_EXP_3    6893.0F  // Saturation � 28

#define FPA_MIN_EXPOSURE               0.5F     // [us]
#define FPA_MAX_EXPOSURE               80000.0F // [us]

#define FPA_MCLK_RATE_HZ               70E+6F   // fr�quence de l'horloge d'integration
#define FPA_EXPOSURE_TIME_RESOLUTION   (1E6F/FPA_MCLK_RATE_HZ)

#define FPA_DATA_RESOLUTION            13
#define FPA_PIXEL_PITCH                10E-6F

#define FPA_INVALID_TEMP               -32768   // cC

#define FPA_PIX_THROUGHPUT_PEAK        338E+6F  // [pix/sec]  avec ou sans reducteur de vitesse, on ne depassera pas virtuellement cette vitesse

#define XTRA_TRIG_MODE_DELAY           100000  // us

#define SCD_MIN_OPER_FPS               (float)12.0 // [Hz] fr�quence minimale pour la configuration du SCD. N'emp�che pas de le trigger plus lentement


#define SEND_CONFIG_DELAY              TIME_ONE_SECOND_US

#define ROIC_WRITE_CMD_ID              0x8500
#define ROIC_READ_CMD_ID               0x8501
#define PROXY_WRITE_CMD_ID             0x8502
#define PROXY_READ_CMD_ID              0x8503

#define OUTGOING_COM_HDER              0xAA
#define INCOMING_COM_HDER              0x55
#define INCOMING_COM_FAIL_ID           0xFFFF
#define INCOMING_COM_OVH_LEN           6
#define OUTGOING_COM_OVH_LEN           5

// structure de config envoy�e au vhd 
// c'est la commande operationnelle de scd �tendue au vhd complet
struct s_FpaIntfConfig    // Remarquer la disparition du champ fpa_integration_time. le temps d'integration n'est plus d�fini par le module FPA_INTF
{
   uint32_t  SIZE;
   uint32_t  ADD;
   
   // common   
   uint32_t  fpa_diag_mode                     ;                                      
   uint32_t  fpa_diag_type                     ;                                      
   uint32_t  fpa_pwr_on                        ;                                      
   uint32_t  fpa_acq_trig_mode                 ;                                      
   uint32_t  fpa_acq_trig_ctrl_dly             ;                                      
   uint32_t  fpa_xtra_trig_mode                ;                                      
   uint32_t  fpa_xtra_trig_ctrl_dly            ;                                      
   uint32_t  fpa_trig_ctrl_timeout_dly         ;                                      
   uint32_t  fpa_stretch_acq_trig              ;                                      
   uint32_t  clk100_to_intclk_conv_numerator   ;                                      
   uint32_t  intclk_to_clk100_conv_numerator   ;
   uint32_t  fpa_intf_data_source              ;
                                              
   // diag                                     
   uint32_t  diag_ysize                        ;                                          
   uint32_t  diag_xsize_div_tapnum             ;                                          
   uint32_t  diag_lovh_mclk_source             ;                                          
   uint32_t  real_mode_active_pixel_dly        ;                                          
                                               
   uint32_t  spare                             ;
                                              
   // aoi                                      
   uint32_t  aoi_xsize                         ;                                          
   uint32_t  aoi_ysize                         ;                                          
   uint32_t  aoi_data_sol_pos                  ;                                          
   uint32_t  aoi_data_eol_pos                  ;                                          
   uint32_t  aoi_flag1_sol_pos                 ;                                          
   uint32_t  aoi_flag1_eol_pos                 ;                                          
   uint32_t  aoi_flag2_sol_pos                 ;                                          
   uint32_t  aoi_flag2_eol_pos                 ;                                          
                                               
   // op struct cmd                            ;
   uint32_t  op_xstart                         ;                                          
   uint32_t  op_ystart                         ;                                          
   uint32_t  op_xsize                          ;                                          
   uint32_t  op_ysize                          ;                                          
   uint32_t  op_frame_time                     ;                                          
   uint32_t  op_gain                           ;                                          
   uint32_t  op_int_mode                       ;                                          
   uint32_t  op_test_mode                      ;                                          
   uint32_t  op_det_vbias                      ;                                          
   uint32_t  op_det_ibias                      ;                                          
   uint32_t  op_binning                        ;                                          
   uint32_t  op_output_rate                    ;
   uint32_t  op_mtx_int_low                    ;
   uint32_t  op_frm_res                        ;
   uint32_t  op_frm_dat                        ;
   uint32_t  op_cfg_num                        ;

   // roic read serial cmd
   uint32_t  roic_reg_cmd_id                  ;
   uint32_t  roic_reg_cmd_data_size           ;
   uint32_t  roic_reg_cmd_dlen                ;
   uint32_t  roic_reg_cmd_sof_add             ;
   uint32_t  roic_reg_cmd_eof_add             ;
                                              
   // int cmd                                  
   uint32_t  int_cmd_id                        ;
   uint32_t  int_cmd_data_size                 ;  
   uint32_t  int_cmd_dlen                      ;                                          
   uint32_t  int_cmd_offs                      ;                                          
   uint32_t  int_cmd_sof_add                   ;                                          
   uint32_t  int_cmd_eof_add                   ;                                          
   uint32_t  int_cmd_sof_add_m1                ;                                          
   uint32_t  int_checksum_add                  ;                                          
   uint32_t  frame_dly_cst                     ;                                          
   uint32_t  int_dly_cst                       ;                                          
                                              
   // op serial cmd                            
   uint32_t  op_cmd_id                         ;
   uint32_t  op_cmd_data_size                  ;
   uint32_t  op_cmd_dlen                       ;
   uint32_t  op_cmd_sof_add                    ;                                          
   uint32_t  op_cmd_eof_add                    ;                                          
                                               ;
   // temp serial cmd                          ;
   uint32_t  temp_cmd_id                       ;
   uint32_t  temp_cmd_data_size                ;
   uint32_t  temp_cmd_dlen                     ;
   uint32_t  temp_cmd_sof_add                  ;                                          
   uint32_t  temp_cmd_eof_add                  ;                                          
                                              
   // misc                                     
   uint32_t  outgoing_com_hder                 ;
   uint32_t  outgoing_com_ovh_len              ;
   uint32_t  incoming_com_hder                 ;
   uint32_t  incoming_com_fail_id              ;
   uint32_t  incoming_com_ovh_len              ;
   uint32_t  fpa_serdes_lval_num               ;
   uint32_t  fpa_serdes_lval_len               ;
   uint32_t  int_clk_period_factor             ;
   int32_t   int_time_offset                   ;
   uint32_t  vid_if_bit_en                     ;
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

#define FpaIntf_Ctor(add) {sizeof(t_FpaIntf)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}


// pour initialiser le module vhd avec les bons parametres de d�part
void FPA_Init(t_FpaStatus *Stat, t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs);

//pour effacer les bits d'erreurs du bloc FPA_interface
void FPA_ClearErr(const t_FpaIntf *ptrA);

//pour configurer le bloc FPA_interface et le lancer
void FPA_SendConfigGC(t_FpaIntf *ptrA, const gcRegistersData_t *pGCRegs); 

//pour configurer la r�solution de frame
void FPA_SetFrameResolution(t_FpaIntf *ptrA);// Not used (needed for BB1280)

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

// pour imposer une s�quence d'initialisation particuli�re
bool FPA_Specific_Init_SM(t_FpaIntf *ptrA, gcRegistersData_t *pGCRegs, bool run);

// pour d�sactiver l'envoi de commande de temps d'int�gration
void FPA_EnableSerialExposureTimeCMD(t_FpaIntf *ptrA, bool state);


/**
 * FPA Initialization state.
 */
enum fpaInitStateEnum {
   // Initialization states
   IDLE = 0,
   READ_ROIC_REG19,
   WAIT_RESPONSE,
   SEND_1ST_CFG,
   START_SERDES_INITIALIZATION
};

/**
 * FPA Initialization state data type.
 */
typedef enum fpaInitStateEnum fpaInitState_t;


#endif // __FPA_INTF_H__
