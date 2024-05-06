/*-----------------------------------------------------------------------------
--
-- Title       : FPA_BINNING_CONFIG header
-- Author      : Alexis Pullara
-- Company     : Telops inc.
--
-------------------------------------------------------------------------------
--
-- SVN modified fields:
-- $Revision: 29151 $
-- $Author: apullara $
-- $LastChangedDate: 2023-09-12 07:39:45 +0200 (mar., 12 sept. 2023) $
--
-------------------------------------------------------------------------------
--
-- Description :
--
------------------------------------------------------------------------------*/

#ifndef __FPA_BINNING_CONFIG_H__
#define __FPA_BINNING_CONFIG_H__

#ifdef BIN_VERBOSE
   #define BIN_PRINTF(fmt, ...)  FPGA_PRINTF("BIN: " fmt, ##__VA_ARGS__)
#else
   #define BIN_PRINTF(fmt, ...)  DUMMY_PRINTF("BIN: " fmt, ##__VA_ARGS__)
#endif

#define BIN_ERR(fmt, ...)        FPGA_PRINTF("BIN: Error: " fmt "\n", ##__VA_ARGS__)
#define BIN_INF(fmt, ...)        FPGA_PRINTF("BIN: Info: " fmt "\n", ##__VA_ARGS__)
#define BIN_DBG(fmt, ...)        BIN_PRINTF("Debug: " fmt "\n", ##__VA_ARGS__)

#define FPA_STANDARD_RESOLUTION { \
      FPA_WIDTH_MAX, FPA_WIDTH_MIN, FPA_WIDTH_INC, FPA_WIDTH_MULT,\
      FPA_OFFSETX_MIN,FPA_OFFSETX_MULT,FPA_OFFSETX_MAX,FPA_HEIGHT_MAX,FPA_HEIGHT_MIN,\
      FPA_HEIGHT_INC,FPA_HEIGHT_MULT, FPA_OFFSETY_MIN,FPA_OFFSETY_MULT, FPA_OFFSETY_MAX\
}
//Il faudra s’assurer de bien gérer les tailles d’image possibles ainsi que les offsetX/Y possibles pour ne pas retomber dans le même bug que le Redmine #33634.
/* Binning resolution #1*/
#define FPA_BINNING_1_RESOLUTION {\
   FPA_BIN1_WIDTH_MAX, FPA_BIN1_WIDTH_MIN, FPA_BIN1_WIDTH_INC,FPA_BIN1_WIDTH_MULT,\
   FPA_BIN1_OFFSETX_MIN, FPA_BIN1_OFFSETX_MULT,FPA_BIN1_OFFSETX_MAX,\
   FPA_BIN1_HEIGHT_MAX, FPA_BIN1_HEIGHT_MIN, FPA_BIN1_HEIGHT_INC, FPA_BIN1_HEIGHT_MULT,\
   FPA_BIN1_OFFSETY_MIN, FPA_BIN1_OFFSETY_MULT, FPA_BIN1_OFFSETY_MAX }

// Exemple for others
/* Binning resolution #2*/
#define FPA_BINNING_2_RESOLUTION {\
   FPA_BIN2_WIDTH_MAX,   FPA_BIN2_WIDTH_MIN,   FPA_BIN2_WIDTH_INC, FPA_BIN2_WIDTH_MULT,\
   FPA_BIN2_OFFSETX_MIN, FPA_BIN2_OFFSETX_MULT,FPA_BIN2_OFFSETX_MAX,\
   FPA_BIN2_HEIGHT_MAX,  FPA_BIN2_HEIGHT_MIN,  FPA_BIN2_HEIGHT_INC,FPA_BIN2_HEIGHT_MULT,\
   FPA_BIN2_OFFSETY_MIN, FPA_BIN2_OFFSETY_MULT,FPA_BIN2_OFFSETY_MAX }

/* Binning resolution #3*/
#define FPA_BINNING_3_RESOLUTION {\
   FPA_BIN3_WIDTH_MAX,   FPA_BIN3_WIDTH_MIN,   FPA_BIN3_WIDTH_INC, FPA_BIN3_WIDTH_MULT,\
   FPA_BIN3_OFFSETX_MIN, FPA_BIN3_OFFSETX_MULT,FPA_BIN3_OFFSETX_MAX,\
   FPA_BIN3_HEIGHT_MAX,  FPA_BIN3_HEIGHT_MIN,  FPA_BIN3_HEIGHT_INC,FPA_BIN3_HEIGHT_MULT,\
   FPA_BIN3_OFFSETY_MIN, FPA_BIN3_OFFSETY_MULT,FPA_BIN3_OFFSETY_MAX }

/*Get and Set define*/
#define FPA_MAX_NUMBER_BINNING_MODE (BM_Mode4x4 - BM_NoBinning + 1)
//Validation to avoid overflow
#define FPA_CONFIG_GET(field) ((gcRegsData.BinningMode < FPA_MAX_NUMBER_CONFIG_MODE)? gFpaResolutionCfg[(gcRegsData.BinningMode)].field: gFpaResolutionCfg[0].field)
#define FPA_ALL_BINNING_MODE_MASK   (BM_Mode2x2 | BM_Mode4x4)
#define FPA_CONFIG_GET_SPECIFIC(field,bin)  ((bin < FPA_MAX_NUMBER_CONFIG_MODE)? gFpaResolutionCfg[bin].field: gFpaResolutionCfg[0].field)
#define FPA_BINNING_MODE_TO_OP(binningMode) (binningMode > BM_NoBinning) ? 1 : 0


/**
 * FPA config.
 */
typedef struct s_fpa_resolution_config {
      uint32_t width_max;
      uint32_t width_min;
      uint32_t width_inc;
      uint32_t width_mult; //same inc ?
      uint32_t offsetx_min;
      uint32_t offsetx_mult;
      uint32_t offsetx_max;
      uint32_t height_max;
      uint32_t height_min;
      uint32_t height_inc;
      uint32_t height_mult; //same inc
      uint32_t offsety_min;
      uint32_t offsety_mult;
      uint32_t offsety_max;
} t_FpaResolutionCfg;


//extern BinningMode_t gcurrentBinningMode;

//TODO TBD FAIRE UN FICHIER C
inline char * BinningModeToString(BinningMode_t binningMode)
{
   switch (binningMode)
   {

      case  BM_NoBinning:
         return "Binning 1x1 mode";
      case  BM_Mode2x2 :
         return "Binning 2x2 mode";
      case  BM_Mode4x4 :
         return "Binning 4x4 mode";
      default:
         return "Warning: Unknown Binning mode ";
   }
}



#endif
