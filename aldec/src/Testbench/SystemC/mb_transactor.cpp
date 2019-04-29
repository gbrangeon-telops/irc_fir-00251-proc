/**
 *  @file mb_transactor.cpp
 *  Microblaze Transactor.
 *  
 *  This file defines the functions that can be used by a transactor.
 *  A transctor is a channel between VHDL and c code
 *  
 *  $Rev: 13301 $
 *  $Author: enofodjie $
 *  $LastChangedDate: 2014-03-13 11:22:29 -0400 (jeu., 13 mars 2014) $
 *  $Id: mb_transactor.cpp 13301 2014-03-13 15:22:29Z enofodjie $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/Testbench/SystemC/mb_transactor.cpp $
 */
#include "mb_transactor.h"
#include <systemc.h>
#include "xparameters.h"

// Function Prototype
uint8_t GetAddrIndex(uint32_t add);

/**
 *  mb_transactor::initialize.
 *  Function that initilaze the systemC model ports.
 *  
 *  
 *  @return void
 */
void mb_transactor::initialize()
{
   cout << "Entering initialize()..." << endl;
   // Initialize ports to default state
   AWVALID.write(0x0000);
   AWADDR.write(0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000);
   AWPROT.write(0x000000000000);
   WVALID.write(0x0000);
   WDATA.write(0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000);
   WSTRB.write(0x0000000000000000);
   BREADY.write(0x0000);
   ARVALID.write(0x0000);		
   ARADDR.write(0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000);
   ARPROT.write(0x000000000000);
   RREADY.write(0x0000);

   cout << "About to call while( ACLK.read() != '0' ) " << endl;
   wait( ACLK.posedge_event() );
   
   // Check if ARESETn is not asserted
   while( ARESETn.read() != '0' ) 
   {
      wait( ACLK.posedge_event() );
   }
   
   wait( ACLK.posedge_event() );
   cout << "Exiting initialize()..." << endl;
}

/**
 *  mb_transactor::mb_instruction_delay.
 *  Function that inserts clock cycle as delay.
 *  
 *  @param n_inst number of clock cycle
 *  
 *  @return void
 */
void mb_transactor::mb_instruction_delay(uint32_t n_inst)
{
   int i;
   #ifdef NO_INST_DELAY
      i = n_inst*4 - 1;
   #else
      i = 0;
   #endif

   for (i; i<n_inst*4; ++i)
   {
      wait( ACLK.posedge_event() );
   }
}

/**
 *  mb_transactor::mb_wait_us.
 *  Function used to insert waiting time in us.
 *  
 *  @param useconds number of us to wait
 *  
 *  @return Return_Description
 */
void mb_transactor::mb_wait_us(uint32_t useconds)
{
   // Compute number of clock cycles to wait according to the microblaze clock frequency
   uint32_t clock_ticks = XPAR_MCU_MICROBLAZE_1_FREQ / 1000000 * useconds;
   for (uint32_t i=0; i<clock_ticks; ++i)
	{
		wait( ACLK.posedge_event() );
	}
}

/**
 *  mb_transactor::AXI4L_read.
 *  Function that manage AXI4-L protocole for a read.
 *  
 *  @param *data pointer to a uint32_t variable
 *  @param add address to read from
 *  
 *  @return Status of the read operation according to AXI4-Lite
 */
uint32_t mb_transactor::AXI4L_read(uint32_t add)
{          
   sc_uint<32> rdata;
   sc_uint<2> resp;
   
   sc_lv<512> add_i;
   sc_lv<512> data_i;
   sc_lv<16> arvalid_i;
   sc_lv<48> arprot_i;
   sc_lv<16> rready_i;
   sc_lv<512> rdata_i;
   sc_lv<2> resp_i;
   sc_lv<16> arready_i;
   sc_lv<16> rvalid_i;

   uint8_t addrIndex;

   addrIndex = GetAddrIndex(add);
   
   wait( ACLK.posedge_event() );
   
   // Read Address Channel
   
   add_i = add;
   add_i = add_i << (addrIndex * 32);
   ARADDR.write(add_i);
   
   arvalid_i = 1 << addrIndex;
   ARVALID.write(arvalid_i);
   
   arprot_i = 0x0 << (addrIndex * 3);
   ARPROT.write(arprot_i);
   
   // Read Data Channel
   rready_i = 1 << addrIndex;
   RREADY.write(rready_i);

   wait( ACLK.posedge_event() );

   arready_i = ARREADY.read();
   while( arready_i[addrIndex] != 1 )
   {
      wait( ACLK.posedge_event() );
      arready_i = ARREADY.read();
   }

   arvalid_i = 0 << addrIndex;
   ARVALID.write(arvalid_i);

   wait( ACLK.posedge_event() );

   rvalid_i = RVALID.read();
   while( rvalid_i[addrIndex] != 1 )
   {
      wait( ACLK.posedge_event() );
      rvalid_i = RVALID.read();
   }
   
   rdata_i = RDATA.read();
   rdata = rdata_i >> (addrIndex * 32);
   resp_i = RRESP.read();
   resp =  0x3 & (resp_i >> (addrIndex * 2));

   rready_i = 0 << addrIndex;
   RREADY.write(rready_i);
   
   //data = rdata;

   mb_instruction_delay(4);

   return rdata;
}

/**
 *  mb_transactor::AXI4L_write.
 *  Function that manage AXI4-L protocole for a write 32 bits.
 *  
 *  @param data Data to write
 *  @param add Address to write
 *  
 *  @return Status of the write operation according to AXI4-Lite
 */
uint8_t mb_transactor::AXI4L_write(uint32_t data, uint32_t add)
{
   sc_uint<2> resp;

   sc_lv<512> awaddr_i;
   sc_lv<512> wdata_i;
   sc_lv<16> awvalid_i;
   sc_lv<16> wvalid_i;
   sc_lv<48> awprot_i;
   sc_lv<16> awready_i;
   sc_lv<16> wready_i;
   sc_lv<2> bresp_i;
   sc_lv<64> wstrb_i;
   sc_lv<16> bready_i;
   sc_lv<16> bvalid_i;
   
   uint8_t addrIndex;

   addrIndex = GetAddrIndex(add);
   
   wait( ACLK.posedge_event() );

   //Write Address Channel
   awvalid_i = 1 << addrIndex;
   AWVALID.write(awvalid_i);
   
   awaddr_i = add;
   awaddr_i = awaddr_i << (addrIndex * 32);
   AWADDR.write(awaddr_i);
   
   awprot_i = 0 << (addrIndex * 3);
   AWPROT.write(awprot_i);
   
   //Write Data Channel
   wvalid_i = 1 << addrIndex;
   WVALID.write(wvalid_i);

   wdata_i = data;
   wdata_i = wdata_i << (addrIndex * 32); 
   WDATA.write(wdata_i);
   
   wstrb_i = 0xF;
   wstrb_i = wstrb_i << (addrIndex * 4);
   WSTRB.write(wstrb_i);
   
   //Write Response Channel
   bready_i = 1 << addrIndex;
   BREADY.write(bready_i);

   wait( ACLK.posedge_event() );

   awready_i = AWREADY.read();
   wready_i = WREADY.read();
   while( awready_i[addrIndex] != 1 && awready_i[addrIndex] != 1)
   {
      wait( ACLK.posedge_event() );
      awready_i = AWREADY.read();
      wready_i = WREADY.read();
   }
   
   awvalid_i = 0 << addrIndex;
   AWVALID.write(awvalid_i);

   wvalid_i = 0 << addrIndex;
   WVALID.write(wvalid_i);

   wait( ACLK.posedge_event() );

   bvalid_i = BVALID.read();
   while( bvalid_i[addrIndex] != 1 )
   {
      wait( ACLK.posedge_event() );
      bvalid_i = BVALID.read();
   }
   bresp_i = BRESP.read();
   resp = 0x3 & (bresp_i >> (addrIndex * 2));

   bready_i[addrIndex] = SC_LOGIC_1;
   BREADY.write(bready_i);

   mb_instruction_delay(4);

   return (uint8_t)resp;
}

/**
 *  mb_transactor::AXI4L_write16.
 *  Function that manage AXI4-L protocole for a write 16 bits.
 *  
 *  @param data Data to write
 *  @param add Address to write
 *  
 *  @return Status of the write operation according to AXI4-Lite
 */
uint8_t mb_transactor::AXI4L_write16(uint16_t data, uint32_t add)
{
   sc_uint<2> resp;

   uint32_t dataO;
   uint8_t sel;
   
   sc_lv<512> awaddr_i;
   sc_lv<512> wdata_i;
   sc_lv<16> awvalid_i;
   sc_lv<16> wvalid_i;
   sc_lv<48> awprot_i;
   sc_lv<16> awready_i;
   sc_lv<16> wready_i;
   sc_lv<2> bresp_i;
   sc_lv<64> wstrb_i;
   sc_lv<16> bready_i;
   sc_lv<16> bvalid_i;

   uint8_t addrIndex;

   addrIndex = GetAddrIndex(add);
   
   wait( ACLK.posedge_event() );
   
   switch (add%4)
   {
   case 0 : dataO = data << 16; sel = 0x0C; break;
   case 1 : dataO = data << 8;  sel = 0x06; break;
   case 2 : dataO = data;       sel = 0x03; break;
   default:                     sel = 0x00; break;
   }

   //Write Address Channel
   awvalid_i = 1 << addrIndex;
   AWVALID.write(awvalid_i);
   
   awaddr_i = add;
   awaddr_i = awaddr_i << (addrIndex * 32);
   AWADDR.write(awaddr_i);
   
   awprot_i = 0 << (addrIndex * 3);
   AWPROT.write(awprot_i);
   
   //Write Data Channel
   wvalid_i = 1 << addrIndex;
   WVALID.write(wvalid_i);

   wdata_i = dataO;
   wdata_i = wdata_i << (addrIndex * 32); 
   WDATA.write(wdata_i);
   
   wstrb_i = sel;
   wstrb_i = wstrb_i << (addrIndex * 4);
   WSTRB.write(wstrb_i);
   
   //Write Response Channel
   bready_i = 1 << addrIndex;
   BREADY.write(bready_i);

   wait( ACLK.posedge_event() );

   awready_i = AWREADY.read();
   wready_i = WREADY.read();
   while( awready_i[addrIndex] != 1 && awready_i[addrIndex] != 1)
   {
      wait( ACLK.posedge_event() );
      awready_i = AWREADY.read();
      wready_i = WREADY.read();
   }
   
   awvalid_i = 0 << addrIndex;
   AWVALID.write(awvalid_i);

   wvalid_i = 0 << addrIndex;
   WVALID.write(wvalid_i);

   wait( ACLK.posedge_event() );

   bvalid_i = BVALID.read();
   while( bvalid_i[addrIndex] != 1 )
   {
      wait( ACLK.posedge_event() );
      bvalid_i = BVALID.read();
   }
   bresp_i = BRESP.read();
   resp = 0x3 & (bresp_i >> (addrIndex * 2));

   bready_i[addrIndex] = SC_LOGIC_1;
   BREADY.write(bready_i);

   mb_instruction_delay(4);

   return (uint8_t)resp;
}

/**
 *  mb_transactor::AXI4L_write8.
 *  Function that manage AXI4-L protocole for a write 8 bits.
 *  
 *  @param data Data to write
 *  @param add Address to write
 *  
 *  @return Status of the write operation according to AXI4-Lite
 */
uint8_t mb_transactor::AXI4L_write8(uint8_t data, uint32_t add)
{
   sc_uint<2> resp;

   uint32_t dataO;
   uint8_t sel;
   
   sc_lv<512> awaddr_i;
   sc_lv<512> wdata_i;
   sc_lv<16> awvalid_i;
   sc_lv<16> wvalid_i;
   sc_lv<48> awprot_i;
   sc_lv<16> awready_i;
   sc_lv<16> wready_i;
   sc_lv<2> bresp_i;
   sc_lv<64> wstrb_i;
   sc_lv<16> bready_i;
   sc_lv<16> bvalid_i;

   uint8_t addrIndex;

   addrIndex = GetAddrIndex(add);
   
   wait( ACLK.posedge_event() );
   
   switch (add%4)
   {
   case 0 : dataO = data << 24; sel = 0x08; break;
   case 1 : dataO = data << 16; sel = 0x04; break;
   case 2 : dataO = data << 8;  sel = 0x02; break;
   case 3 : dataO = data;       sel = 0x01; break;
   default:                     sel = 0x00; break;
   }

   //Write Address Channel
   awvalid_i = 1 << addrIndex;
   AWVALID.write(awvalid_i);
   
   awaddr_i = add;
   awaddr_i = awaddr_i << (addrIndex * 32);
   AWADDR.write(awaddr_i);
   
   awprot_i = 0 << (addrIndex * 3);
   AWPROT.write(awprot_i);
   
   //Write Data Channel
   wvalid_i = 1 << addrIndex;
   WVALID.write(wvalid_i);

   wdata_i = dataO;
   wdata_i = wdata_i << (addrIndex * 32); 
   WDATA.write(wdata_i);
   
   wstrb_i = sel;
   wstrb_i = wstrb_i << (addrIndex * 4);
   WSTRB.write(wstrb_i);
   
   //Write Response Channel
   bready_i = 1 << addrIndex;
   BREADY.write(bready_i);

   wait( ACLK.posedge_event() );

   awready_i = AWREADY.read();
   wready_i = WREADY.read();
   while( awready_i[addrIndex] != 1 && awready_i[addrIndex] != 1)
   {
      wait( ACLK.posedge_event() );
      awready_i = AWREADY.read();
      wready_i = WREADY.read();
   }
   
   awvalid_i = 0 << addrIndex;
   AWVALID.write(awvalid_i);

   wvalid_i = 0 << addrIndex;
   WVALID.write(wvalid_i);

   wait( ACLK.posedge_event() );

   bvalid_i = BVALID.read();
   while( bvalid_i[addrIndex] != 1 )
   {
      wait( ACLK.posedge_event() );
      bvalid_i = BVALID.read();
   }
   bresp_i = BRESP.read();
   resp = 0x3 & (bresp_i >> (addrIndex * 2));

   bready_i[addrIndex] = SC_LOGIC_1;
   BREADY.write(bready_i);

   mb_instruction_delay(4);

   return (uint8_t)resp;
}

/**
 *  mb_transactor::XTime_GetTime.
 *  Function that gets the number of ticks (clock cycles) since the beginning of the simulation.
 *  
 *  @param ticks Pointer to a uint64_t variable
 *  
 *  @return void
 */
void mb_transactor::XTime_GetTime(uint64_t *ticks)
{
   unsigned long now_ns;
   
   // Gets the actual simulation time
   now_ns = (unsigned long)(sc_time_stamp().value()/1000);
   
   // Defines the microblaze core frequency in MHz
   #define CORE_CLOCK_FREQ_MHZ (XPAR_MCU_MICROBLAZE_1_FREQ/1000000)
   
   // Compute the number of ticks since the beginning of the simulation
   *ticks = (CORE_CLOCK_FREQ_MHZ * now_ns) / 1000 ;
}

uint32_t mb_transactor::Xil_In32(uint32_t address)
{
    uint32_t data;
    
    data = AXI4L_read(address);
    
    return data;
}


void mb_transactor::Xil_Out32(uint32_t address, uint32_t data)
{

   AXI4L_write(data, address);
}


uint8_t GetAddrIndex(uint32_t add)
{

   uint8_t i;
   
   if (add >= 0x40000000 && add <= 0x4000FFFF)  //GPIO
   {
      i = 0;
   }
   else if (add >= 0x40400000 && add <= 0x40401FFF) //USB_UART
   {
      i = 1;
   }
   else if (add >= 0x40402000 && add <= 0x40403FFF) //CLINK UART
   {
      i = 2;
   }
   else if (add >= 0x40404000 && add <= 0x40405FFF) //FPGA Output Uart
   {
      i = 3;
   }
   else if (add >= 0x40406000 && add <= 0x40407FFF) // OEM_UART
   {
      i = 4;
   }
   else if (add >= 0x40408000 && add <= 0x40409FFF) // Pleora UART
   {
      i = 5;
   }
   else if (add >= 0x44A90000 && add <= 0x44A9FFFF) //XADC
   {
      i = 6;
   }
   else if (add >= 0x41200000 && add <= 0x4120FFFF) //INTC
   {
      i = 7;
   }
   else if (add >= 0x44A00000 && add <= 0x44A0FFFF) //AECCTRL
   {
      i = 8;
   }
   else if (add >= 0x44A10000 && add <= 0x44A1FFFF) //BPR Flag CTRL
   {
      i = 9;
   }
   else if (add >= 0x44A20000 && add <= 0x44A2FFFF) // CAL_CTRL
   {
      i = 10;
   }
   else if (add >= 0x44A30000 && add <= 0x44A3FFFF) // EXPTIME_CTRL
   {
      i = 11;
   }
   else if (add >= 0x44A50000 && add <= 0x44A5FFFF) // FPA_CTRL
   {
      i = 12;
   }
   else if (add >= 0x44A60000 && add <= 0x44A6FFFF) // HEADER_CTRL
   {
      i = 13;
   }
   else if (add >= 0x44A70000 && add <= 0x44A7FFFF) // SFW_CTRL
   {
      i = 14;
   }
   else if (add >= 0x44A80000 && add <= 0x44A8FFFF) // TRIGGER_CTRL
   {
      i = 15;
   }
   else
   {
      i = 0;
   }

   return i;
}   
