/**
 * @file hder_inserter.h
 * IR camera header inserter driver module header.
 *
 * This file defines the IR camera header inserter driver module interface.
 *
 * $Rev$
 * $Author$
 * $Date$
 * $Id$
 * $URL$
 *
 * (c) Copyright 2014 Telops Inc.
 */

#ifndef __HDER_INSERTER_H__
#define __HDER_INSERTER_H__

#include <stdint.h>
#include "GC_Registers.h"
#include "IRC_status.h"



#define EFFECTIVE_HDER_LENGTH  128     // taille minimale du header en pixels

#define HDER_TLAST_ENABLED     1       // 0 pour desactiver l'envoi de TLAST à la fin de la trame du header. 1 pour l'activer

// structure de configuration du hder_inserter
struct s_HderInserter
{
   uint32_t SIZE;                   // Number of config elements, excluding SIZE and ADD.
   uint32_t ADD;
   
   uint32_t eff_hder_len;           // Number d'elements du header sans le zero pad (unité = pixel)   
   uint32_t zero_pad_len;           // Number de zeros à padder (unité = pixel)					   
   uint32_t hder_len;               // Number d'éléments au total constituant le header (unité = pixel) 						   
   uint32_t eff_hder_len_div2_m1;   // HeadRealLen/2-1 
   uint32_t zero_pad_len_div2_m1;   // ZPadLen/2-1 
   uint32_t need_padding;           // dit si on a besoin de padder le header
   uint32_t hder_tlast_en;          // dit s'il doit y avoir un TLAST à la fin du header ou pas
   };
typedef struct s_HderInserter t_HderInserter;

// Function prototypes

#define HderInserter_Ctor(add) {sizeof(t_HderInserter)/4 - 2, add, 0, 0, 0, 0, 0, 0, 0}


//pour configurer le contrôleur des dacs du bloc hder_inserter
void HDER_SendConfigGC(t_HderInserter *a, const gcRegistersData_t *pGCRegs); 

//pour envoyer le header 
void HDER_SendHeaderGC(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// ENO 14 fev 2014: HDER_Start et HDER_Stop non necessaires. Il faut juste utiliser HDER_SendConfigGC après changement de config.


//pour avoir le DONE du bloc hder_inserter
IRC_Status_t HDER_Done(const t_HderInserter *a);

//pour avoir les statuts
uint32_t HDER_GetStatus(const t_HderInserter *a);

//pour reset des registres d'erreurs
void HDER_ResetErr(const t_HderInserter *a);

// Pour update du NDF dans le Header
void HDER_UpdateNDFPositionHeader(const t_HderInserter *a, uint8_t position);

// Pour update du ICU dans le Header
void HDER_UpdateICUPositionHeader(const t_HderInserter *a, uint8_t position);

// Pour update du la roue à filtre dans le Header
void HDER_UpdateFWPositionHeader(const t_HderInserter *a, uint8_t position);

// Pour update des temperatures dans le header
void HDER_UpdateTemperaturesHeader(const t_HderInserter *a, DeviceTemperatureSelector_t dts);

// Pour update des champs GPS dans le header
void HDER_UpdateGPSHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update des champs AEC dans le header
void HDER_UpdateAECHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update du champ ExternalBlackBodyTemperature dans le header
void HDER_UpdateExternalBBTempHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update du champ FWSpeedSetpoint dans le header
void HDER_UpdateFWSpeedSetpointHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update du champ TimeSource dans le header
void HDER_UpdateTimeSourceHeader(const t_HderInserter *a, uint8_t timeSource);

// Pour update des optical serial numbers dans le header
void HDER_UpdateOpticalSerialNumbersHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update des reverse X et Y dans le header
void HDER_UpdateReverseXHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);
void HDER_UpdateReverseYHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update du frame rate
void HDER_UpdateAcquisitionFrameRateHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update du champ BadPixelReplacement dans le header
void HDER_UpdateBadPixelReplacementHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

// Pour update des champs de FOV/Focus dans le header
void HDER_UpdateFOVHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);
void HDER_UpdateFocusPositionRawHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);
void HDER_UpdateFOVPositionHeader(const t_HderInserter *a, const gcRegistersData_t *pGCRegs);

#endif // __HDER_INSERTER_H__
