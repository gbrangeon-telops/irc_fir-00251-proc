/**
 *  @file mb_transactor_if.h
 *  Defines the interface and the ports of a transactor.
 *  A transctor is a channel between VHDL and c code
 *  
 *  Detailed Description.
 *  
 *  $Rev$
 *  $Author$
 *  $LastChangedDate$
 *  $Id$
 *  $URL$
 */
#ifndef __MB_TRANSACTOR_IF_H__
#define __MB_TRANSACTOR_IF_H__

#include <systemc.h>


#ifdef Xil_Out32
#undef Xil_Out32
#endif
#ifdef Xil_In32
#undef Xil_In32
#endif

/**
 *  Microblaze transactor task interface.
 *  This class defines the functions used by the transactor.
 */
class mb_transactor_task_if : virtual public sc_interface
{
public:
   virtual void initialize() = 0;
   virtual void mb_instruction_delay(uint32_t n_inst) = 0;
   virtual void mb_wait_us(uint32_t useconds) = 0;
   virtual uint32_t AXI4L_read(uint32_t add) = 0;
   virtual uint8_t AXI4L_write(uint32_t data, uint32_t add) = 0;
   virtual uint8_t AXI4L_write16(uint16_t data, uint32_t add) = 0;
   virtual uint8_t AXI4L_write8(uint8_t data, uint32_t add) = 0;
   virtual void XTime_GetTime(uint64_t *ticks) = 0;
   virtual uint32_t Xil_In32(uint32_t address) = 0;
   virtual void Xil_Out32(uint32_t address, uint32_t data) = 0;

};

/**
 *  Microblaze transactor port interface.
 *  This class defines the ports of a transactor
 */
class mb_transactor_port_if : public sc_module
{
   public:
      // Global Signal
      sc_in<sc_logic > ACLK;
      sc_in<sc_logic > ARESETn;
      // Write Address Channel
      sc_out< sc_lv<16> > AWVALID;
      sc_out< sc_lv<512> > AWADDR;
      sc_out< sc_lv<48> > AWPROT;     
      sc_in< sc_lv<16> > AWREADY;
      // Write Data Channel
      sc_out< sc_lv<16> > WVALID;
      sc_in< sc_lv<16> > WREADY;
      sc_out< sc_lv<512> > WDATA;
      sc_out< sc_lv<64> > WSTRB;
      // Write Response Channel
      sc_in< sc_lv<16> > BVALID;
      sc_out< sc_lv<16> > BREADY;
      sc_in< sc_lv<32> > BRESP;
      // Read Address Channel
      sc_out< sc_lv<16> > ARVALID;
      sc_out< sc_lv<512> > ARADDR;
      sc_out< sc_lv<48> > ARPROT;
      sc_in< sc_lv<16> > ARREADY;
      // Read Data Channel
      sc_in< sc_lv<16> > RVALID;
      sc_out< sc_lv<16> > RREADY;
      sc_in< sc_lv<512> > RDATA;
      sc_in< sc_lv<32> > RRESP;
      
   // Constructor
   mb_transactor_port_if(sc_module_name nm) : sc_module(nm),
      ACLK("ACLK"),
      ARESETn("ARESETn"),
      AWVALID("AWVALID"),
      AWADDR("AWADDR"),
      AWPROT("AWPROT"),
      AWREADY("AWREADY"),
      WVALID("WVALID"),
      WREADY("WREADY"),
      WDATA("WDATA"),
      WSTRB("WSTRB"),
      BVALID("BVALID"),
      BREADY("BREADY"),
      BRESP("BRESP"),
      ARVALID("ARVALID"),
      ARADDR("ARADDR"),
      ARPROT("ARPROT"),
      ARREADY("ARREADY"),
      RVALID("RVALID"),
      RREADY("RREADY"),
      RDATA("RDATA"),
      RRESP("RRESP")
   {}
};



#endif // __MB_TRANSACTOR_IF_H__
