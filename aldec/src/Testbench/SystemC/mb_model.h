/**
 *  @file mb_model.h
 *  Microblaze SystemC model.
 *
 *  This is the microblaze model for SystemC simulation.
 *  It contains a AXI4-Lite port
 *
 *  $Rev$
 *  $Author$
 *  $LastChangedDate$
 *  $Id$
 *  $URL$
 */
#ifndef __mb_model_h__
#define __mb_model_h__

#include <systemc.h>
#include "mb_transactor.h"
#include "proc_ctrl.h"

SC_MODULE( mb_model )
{
   // Ports Declaration
   // Global Signal
   sc_in<sc_logic > ACLK;
   sc_in<sc_logic > ARESETn;
   // Write Address Channel
   sc_out< sc_lv<16> > AWVALID;
   sc_out< sc_lv<512> > AWADDR;
   sc_out< sc_lv<48> > AWPROT;
   sc_in<sc_lv<16> > AWREADY;
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

   // Pointer Declaration
   proc_ctrl      *p_ctrl;
   mb_transactor  *p_mb_trans;

   // Constructor for Microblaze Model
   SC_CTOR( mb_model ):
      // Assigning labels to the ports.
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
      {
         // Memorry allocation
         p_ctrl = new proc_ctrl("ctrl");
         p_mb_trans = new mb_transactor("mb_trans");

         // Wiring up ports to the transactor model
         p_mb_trans-> ACLK(ACLK);
         p_mb_trans-> ARESETn(ARESETn);
         p_mb_trans-> AWVALID(AWVALID);
         p_mb_trans-> AWADDR(AWADDR);
         p_mb_trans-> AWPROT(AWPROT);
         p_mb_trans-> AWREADY(AWREADY);
         p_mb_trans-> WVALID(WVALID);
         p_mb_trans-> WREADY(WREADY);
         p_mb_trans-> WDATA(WDATA);
         p_mb_trans-> WSTRB(WSTRB);
         p_mb_trans-> BVALID(BVALID);
         p_mb_trans-> BREADY(BREADY);
         p_mb_trans-> BRESP(BRESP);
         p_mb_trans-> ARVALID(ARVALID);
         p_mb_trans-> ARADDR(ARADDR);
         p_mb_trans-> ARPROT(ARPROT);
         p_mb_trans-> ARREADY(ARREADY);
         p_mb_trans-> RVALID(RVALID);
         p_mb_trans-> RREADY(RREADY);
         p_mb_trans-> RDATA(RDATA);
         p_mb_trans-> RRESP(RRESP);

         // Connect the transactor model to the controller model
         p_ctrl->transactor_interface.bind(*p_mb_trans);
      }

   // Destructor to free up memory
   ~mb_model()
   {
      delete p_ctrl;
      delete p_mb_trans;
   }

};

SC_REGISTER_LV(48);
SC_REGISTER_LV(64);
SC_REGISTER_LV(512);

//SC_MODULE_EXPORT is used to export the mb_model to be used by ActiveHDL (addsc)
SC_MODULE_EXPORT( mb_model )

#endif //__mb_model_h__

