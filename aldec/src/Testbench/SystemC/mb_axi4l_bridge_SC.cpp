/**
 *  @file mb_axi4l_bridge_SC.cpp
 *  Bridge between microblaze and AXI4-Lite for SystemsC transactions.
 *  
 *  Theses functions use a transactor to simulate microblaze to AXI4-Lite transactions.
 *  
 *  $Rev: 13301 $
 *  $Author: enofodjie $
 *  $LastChangedDate: 2014-03-13 11:22:29 -0400 (jeu., 13 mars 2014) $
 *  $Id: mb_axi4l_bridge_SC.cpp 13301 2014-03-13 15:22:29Z enofodjie $
 *  $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/Testbench/SystemC/mb_axi4l_bridge_SC.cpp $
 */
#include "mb_axi4l_bridge_SC.h" 	
//#include "ROIC_defines.h"
#include <systemc.h> 
#include "mb_transactor.h"
#include "xparameters.h"

//#define AXI4L_VERBOSE

#ifdef AXI4L_VERBOSE
   #include <iostream.h>
   #include <iomanip>   
#endif

extern sc_port<mb_transactor_task_if> *global_trans_ptr; /*< External pointer to a transactor */

//void WB_write16( uint16_t data, uint32_t add)
//{
//	uint32_t uct_out;
//	uint32_t uct_in;
//	
//	// Write on wishbone bus
//	uct_out = data | ((uint32_t)add << 16) | 0xB0000000;
//	(*global_trans_ptr)->ppc_instruction_delay(4);
//	(*global_trans_ptr)->wr_gpio(uct_out); 		
//	
//	#ifdef WB_VERBOSE 
//   	cout << "WB_write16: add: 0x" << hex << add << '\n';
//   	cout << "WB_write16: data: 0x" << hex << data << '\n';	
//   	cout << "WB_write16: uct_out: 0x" << hex << uct_out << '\n';
//	#endif	
//
//	// Wait for ack
//	do 
//	{ 
//		(*global_trans_ptr)->ppc_instruction_delay(1);
//		uct_in = (*global_trans_ptr)->rd_gpio();
//		(*global_trans_ptr)->ppc_instruction_delay(1);
//	}
//	while ((uct_in & 0x00010000) == 0x00000000);
//
//
//	// Send ack	 
//	(*global_trans_ptr)->wr_gpio(0xC0000000);		   
//	(*global_trans_ptr)->ppc_instruction_delay(2);
//}

/**
 *  AXI4L_write32.
 *  Function used to write 32 bits on the AXI4-Lite bus.
 *  
 *  @param data Data to write
 *  @param add Address to write to
 *  
 *  @return Status of the write operation according to AXI4-Lite
 */
uint8_t AXI4L_write32( uint32_t data, uint32_t add)
{
   (*global_trans_ptr)->AXI4L_write(data, add);
   
	#ifdef AXI4L_VERBOSE 
   	cout << "AXI4L_write32: add: 0x" << hex << add << '\n';
   	cout << "AXI4L_write32: data: 0x" << hex << data << '\n';
   	cout << "AXI4L_write32: uct_out: 0x" << hex << uct_out << '\n';		
	#endif	
	
}


uint8_t AXI4L_write16( uint16_t data, uint32_t add)
{
   (*global_trans_ptr)->AXI4L_write16(data, add);
   
	#ifdef WB_VERBOSE 
   	cout << "AXI4L_write16: add: 0x" << hex << add << '\n';
   	cout << "AXI4L_write16: data: 0x" << hex << data << '\n';
   	cout << "AXI4L_write16: uct_out: 0x" << hex << uct_out << '\n';		
	#endif	
	
}


uint8_t AXI4L_write8( uint8_t data, uint32_t add)
{
   (*global_trans_ptr)->AXI4L_write8(data, add);
   
	#ifdef AXI4L_VERBOSE 
   	cout << "AXI4L_write8: add: 0x" << hex << add << '\n';
   	cout << "AXI4L_write8: data: 0x" << hex << data << '\n';
   	cout << "AXI4L_write8: uct_out: 0x" << hex << uct_out << '\n';		
	#endif	
	
}

//uint32_t WB_read16(uint32_t add)
//{
//	uint32_t uct_out;
//	uint32_t uct_in;
//	uint32_t data;
//
//	// Write on wishbone bus 
//	uct_out = ((uint32_t)add << 16) | 0xA0000000;
//	(*global_trans_ptr)->ppc_instruction_delay(3);
//	(*global_trans_ptr)->wr_gpio(uct_out); 		
//
//	// Wait for ack
//	do 
//	{	
//		(*global_trans_ptr)->ppc_instruction_delay(1);
//		uct_in = (*global_trans_ptr)->rd_gpio();
//		(*global_trans_ptr)->ppc_instruction_delay(1);
//	}
//	while ((uct_in & 0x00010000) == 0x00000000);
//	
//	data = uct_in & 0x0000FFFF;	 
//	(*global_trans_ptr)->ppc_instruction_delay(1);
//
//	// Send ack	 
//	(*global_trans_ptr)->wr_gpio(0xC0000000);
//	
//	(*global_trans_ptr)->ppc_instruction_delay(2);
//	return data;		
//}

/**
 *  AXI4L_read32.
 *  Function used to read from the AXI4-Lite bus.
 *  
 *  @param data Pointer to a uint32_t variable
 *  @param add Addres to read from
 *  
 *  @return Status of the read operation according to AXI4-Lite
 */
uint32_t AXI4L_read32(uint32_t add)
{
   
  return (*global_trans_ptr)->AXI4L_read(add);
	
}


/*uint16_t WB_read16(uint32_t add)
{
   
   
	uint32_t data;
//	uint16_t data_high;
//	
//	data_high = WB_read16(add);
//	data_low = WB_read16(add+1);
//
//	return (uint32_t)(data_high << 16 | data_low);	
   data =  (*global_trans_ptr)->WB_read(add);
	return (uint16_t)(data & 0x0000FFFF);
}
*/


extern "C" void Xil_Out32(uint32_t add, uint32_t data)
{
   //cout << "Xil_Out32: add: 0x" << hex << add << '\n';
   //AXI4L_write32(data, add);
   (*global_trans_ptr)->Xil_Out32(add,data);
}


extern "C" uint32_t Xil_In32(uint32_t add)
{

//   uint32_t data;
//   
//   //cout << "Xil_In32: add: 0x" << hex << add << '\n';
//   data = AXI4L_read32(add);
//   
//   return data;    

   return (*global_trans_ptr)->Xil_In32(add);
}

