/**
 *  @file mb_transactor.h
 *  SystemC Transactor.
 *  
 *  Defines the class mb_transactor.
 *  
 *  $Rev$
 *  $Author$
 *  $LastChangedDate$
 *  $Id$
 *  $URL$
 */
#ifndef __MB_TRANSACTOR_H__
#define __MB_TRANSACTOR_H__

#include <systemc.h>
#include "mb_transactor_if.h" // Contains the transactor task and transaction port interfaces.

#ifdef Xil_Out32
#undef Xil_Out32
#endif
#ifdef Xil_In32
#undef Xil_In32
#endif

/**
 *  Microblaze transactor.
 *  This class defines the transactor that is used to bridge the C code to the VHDL.
 */
class mb_transactor : public mb_transactor_port_if,
   public mb_transactor_task_if
{
public:
   // Constructor
   mb_transactor(sc_module_name nm) : mb_transactor_port_if(nm) {};

public:
   virtual void initialize();
   virtual void mb_instruction_delay(uint32_t n_inst);
   virtual void mb_wait_us(uint32_t useconds);
   virtual uint32_t AXI4L_read(uint32_t add);
   virtual uint8_t AXI4L_write(uint32_t data, uint32_t add);
   virtual uint8_t AXI4L_write16(uint16_t data, uint32_t add);
   virtual uint8_t AXI4L_write8(uint8_t data, uint32_t add);
   virtual void XTime_GetTime(uint64_t *ticks);
   virtual uint32_t Xil_In32(uint32_t address);
   virtual void Xil_Out32(uint32_t address, uint32_t data);
};

#endif // __MB_TRANSACTOR_H__
