
#ifndef EHDRIMANAGER_H
#define EHDRIMANAGER_H

#include "GC_Registers.h"
#include "IRC_Status.h"
#include <stdint.h>
#include "verbose.h"

#ifdef EHDRI_VERBOSE
   #define EHDRI_PRINTF(fmt, ...)    PRINTF("EHDRI: " fmt, ##__VA_ARGS__)
#else
   #define EHDRI_PRINTF(fmt, ...)    DUMMY_PRINTF("EHDRI: " fmt, ##__VA_ARGS__)
#endif

#define EHDRI_ERR(fmt, ...)          EHDRI_PRINTF("Error: " fmt "\n", ##__VA_ARGS__)
#define EHDRI_INF(fmt, ...)          EHDRI_PRINTF("Info: " fmt "\n", ##__VA_ARGS__)

#define EHDRI_BRAM_SIZE           1024
#define EHDRI_INDEX_TABLE_SIZE    EHDRI_BRAM_SIZE / 16
#define EHDRI_IDX_NBR      4

#define EHDRI_C_TO_KELVIN       273.15f

// Struct Definition
/**
 * EHDRI MANAGER STRUCT
 */
struct s_EhdriManagerStruct {
	uint32_t SIZE;                     // Number of config elements, excluding SIZE and ADD.
	uint32_t ADD;

    uint32_t ExpIndex[EHDRI_INDEX_TABLE_SIZE];
    uint32_t ExposureTime[EHDRI_IDX_NBR];
    uint32_t Enable;
    
};
typedef struct s_EhdriManagerStruct t_EhdriManager;

/***************** Macros (Inline Functions) Definitions ********************/
#define Ehdri_Intf_Ctor(add) {sizeof(t_EhdriManager) / 4 - 2, add, {0}, {0}, 0}

// Fonction defition
IRC_Status_t EHDRI_Init(t_EhdriManager *pEhdriCtrl);
void EHDRI_Reset(t_EhdriManager *pEhdriCtrl, gcRegistersData_t *pGCRegs);
void EHDRI_SendConfig(t_EhdriManager *a, gcRegistersData_t *pGCRegs);
void EHDRI_UpdateExpIndexSequence(t_EhdriManager *pEhdriCtrl, const gcRegistersData_t *pGCRegs);


#endif // EHDRIMANAGER_H
