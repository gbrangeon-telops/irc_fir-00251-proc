------------------------------------------------------------------
--!   @file tel2000pkg.vhd
--!   @brief Package file for TEL-2000 projects.
--!   @details This file contains the records and constants used in the project.
--!
--!   $Rev: 22549 $
--!   $Author: elarouche $
--!   $Date: 2018-11-28 11:28:39 -0500 (mer., 28 nov. 2018) $
--!   $Id: tel2000pkg.vhd 22549 2018-11-28 16:28:39Z elarouche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Common/branchs/2018-09-04%20Forrest%20Gump%20Release/VHDL/tel2000pkg.vhd $
------------------------------------------------------------------

--!   Use IEEE standard library.
library IEEE;
--!   Use logic elements package from IEEE library.
use IEEE.STD_LOGIC_1164.all; 
--!   Use numeric package package from IEEE library. 
use ieee.numeric_std.all;

package TEL2000 is
   ------------------------------------------
   -- Attribute use in design
   ------------------------------------------ 
   attribute KEEP : string;
   attribute DONT_TOUCH : string;
   --usage example
   --attribute KEEP of trig : signal is "TRUE"; 
    
    
   ------------------------------------------
   -- Types used in entity ports
   ------------------------------------------
   
   -- AXI4 Lite ports
   type t_axi4_lite_mosi is record --! AXI4-Lite MOSI
      -- Write Addres Channel
      AWVALID : std_logic; --! Write Address Valid
      AWADDR : std_logic_vector(31 downto 0); --! Write Address
      AWPROT : std_logic_vector(2 downto 0); --! Write Address Protection Type
      -- Write Data Channel
      WVALID : std_logic; --! Write Data Valid
      WDATA : std_logic_vector(31 downto 0); --! Write Data
      WSTRB : std_logic_vector(3 downto 0); --! Write Data Strobe
      -- Write Response Channel
      BREADY : std_logic; --! Write Response Ready
      -- Read Address channel
      ARVALID : std_logic; --! Read Address Valid
      ARADDR : std_logic_vector(31 downto 0); --! Read Address
      ARPROT : std_logic_vector(2 downto 0); --! Read Address Protection Type
      -- Read Data Channel
      RREADY : std_logic; --! Read Response Ready
   end record;
   
   type t_axi4_lite_a64_mosi is record --! AXI4-Lite MOSI
      -- Write Addres Channel
      AWVALID : std_logic; --! Write Address Valid
      AWADDR : std_logic_vector(63 downto 0); --! Write Address
      AWPROT : std_logic_vector(2 downto 0); --! Write Address Protection Type
      -- Write Data Channel
      WVALID : std_logic; --! Write Data Valid
      WDATA : std_logic_vector(31 downto 0); --! Write Data
      WSTRB : std_logic_vector(3 downto 0); --! Write Data Strobe
      -- Write Response Channel
      BREADY : std_logic; --! Write Response Ready
      -- Read Address channel
      ARVALID : std_logic; --! Read Address Valid
      ARADDR : std_logic_vector(63 downto 0); --! Read Address
      ARPROT : std_logic_vector(2 downto 0); --! Read Address Protection Type
      -- Read Data Channel
      RREADY : std_logic; --! Read Response Ready
   end record;
   
   type t_axi4_lite_miso is record --! AXI4-Lite MISO
      -- Write Addres Channel
      AWREADY : std_logic; --! Write Address Ready
      -- Write Data Channel
      WREADY : std_logic; --! Write Data Ready
      -- Write Response Channel
      BVALID : std_logic; --! Write Response Valid
      BRESP : std_logic_vector(1 downto 0); --! Write Response
      -- Read Address Channel
      ARREADY : std_logic; --! Read Address Ready
      -- Read Data Channel
      RVALID : std_logic; --! Read Data Valid
      RDATA : std_logic_vector(31 downto 0); --! Read Data
      RRESP : std_logic_vector(1 downto 0); --! Read Response
   end record;
   
   type t_axi4_lite is record
      axi4_lite_mosi : t_axi4_lite_mosi;
      axi4_lite_miso : t_axi4_lite_miso;
   end record;
   
   -- AXI4 Stream ports
   type t_axi4_stream_mosi128 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(127 downto 0); --! Stream Data 128 bit
      TSTRB : std_logic_vector(15 downto 0); --! Stream Data Strobe (16bits)
      TKEEP : std_logic_vector(15 downto 0); --! Stream Data Keep (16bits)
      TLAST : std_logic; --! Stream Data Last
      TID : std_logic_vector(0 downto 0); --! Stream ID
      TDEST : std_logic_vector(2 downto 0); --! Stream Destination
      TUSER : std_logic_vector(31 downto 0); --! Stream User Data (32 bits)
   end record;
   
   type t_axi4_stream_mosi72 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(71 downto 0); --! Stream Data 72 bits
      TSTRB : std_logic_vector(8 downto 0); --! Stream Data Strobe (9bits)
      TKEEP : std_logic_vector(8 downto 0); --! Stream Data Keep (9bits)
      TLAST : std_logic; --! Stream Data Last
      TID   : std_logic_vector(0 downto 0); --! Stream ID
      TDEST : std_logic_vector(2 downto 0); --! Stream Destination
      TUSER : std_logic_vector(17 downto 0); --! Stream User Data (18 bits)
   end record;
   
   type t_axi4_stream_mosi64 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(63 downto 0); --! Stream Data 64 bit
      TSTRB : std_logic_vector(7 downto 0); --! Stream Data Strobe (8bits)
      TKEEP : std_logic_vector(7 downto 0); --! Stream Data Keep (8bits)
      TLAST : std_logic; --! Stream Data Last
      TID : std_logic_vector(0 downto 0); --! Stream ID
      TDEST : std_logic_vector(2 downto 0); --! Stream Destination
      TUSER : std_logic_vector(15 downto 0); --! Stream User Data (16 bits)
   end record;
   
   type t_axi4_stream_mosi32 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(31 downto 0); --! Stream Data 32 bit
      TSTRB : std_logic_vector(3 downto 0); --! Stream Data Strobe (4bits)
      TKEEP : std_logic_vector(3 downto 0); --! Stream Data Keep (4bits)
      TLAST : std_logic; --! Stream Data Last
      TID : std_logic_vector(0 downto 0); --! Stream ID
      TDEST : std_logic_vector(2 downto 0); --! Stream Destination
      TUSER : std_logic_vector(7 downto 0); --! Stream User Data (8 bits)
   end record;
   
   type t_axi4_stream_mosi32_lite is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(31 downto 0); --! Stream Data 32 bit
      TKEEP : std_logic_vector(3 downto 0); --! Stream Data Keep (4bits)
      TLAST : std_logic; --! Stream Data Last
   end record;
   
   type t_axi4_stream_mosi16 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(15 downto 0); --! Stream Data 16 bit
      TSTRB : std_logic_vector(1 downto 0); --! Stream Data Strobe (2 bits)
      TKEEP : std_logic_vector(1 downto 0); --! Stream Data Keep (2 bits)
      TLAST : std_logic; --! Stream Data Last
      TID : std_logic_vector(0 downto 0); --! Stream ID
      TDEST : std_logic_vector(2 downto 0); --! Stream Destination
      TUSER : std_logic_vector(3 downto 0); --! Stream User Data (4 bits)
   end record;
   
   type t_axi4_stream_mosi16_lite is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(15 downto 0); --! Stream Data 16 bit
      TKEEP : std_logic_vector(1 downto 0); --! Stream Data Keep (2 bits)
      TLAST : std_logic; --! Stream Data Last
   end record;
   
   type t_axi4_stream_mosi8 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(7 downto 0); --! Stream Data 8 bits
      TSTRB : std_logic_vector(0 downto 0); --! Stream Data Strobe (1 bit)
      TKEEP : std_logic_vector(0 downto 0); --! Stream Data Keep (1 bit)
      TLAST : std_logic; --! Stream Data Last
      TID : std_logic_vector(0 downto 0); --! Stream ID
      TDEST : std_logic_vector(2 downto 0); --! Stream Destination
      TUSER : std_logic_vector(3 downto 0); --! Stream User Data (4 bits)
   end record;
   
   type t_axi4_stream_miso is record
      TREADY : std_logic; --! Stream Ready to Accept Data
   end record;
   
   type t_axi4_stream_mosi_cmd32 is record -- AXI Stream Commmand
      TDATA : std_logic_vector(71 downto 0);
      TVALID : std_logic;
   end record;
   
   type t_axi4_stream_mosi_cmd64 is record -- AXI Stream Commmand
      TDATA : std_logic_vector(103 downto 0);
      TVALID : std_logic;
   end record;
   
   type t_axi4_stream_miso_cmd32 is record -- AXI Stream Commmand
      TREADY : std_logic;
   end record;
   
   type t_axi4_stream_miso_status is record --! AXI Stream Status
      TREADY : std_logic;
   end record;
   
   type t_axi4_stream_mosi_status is record --! AXI Stream Status
      TDATA : std_logic_vector(7 downto 0);
      TKEEP : std_logic_vector(0 downto 0);
      TLAST : std_logic;
      TVALID : std_logic;
   end record;
   
   -- AXI4 Stream datamover ports
   type t_axis_dm_mosi64 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(63 downto 0); --! Stream Data 64 bit
      TKEEP : std_logic_vector(7 downto 0); --! Stream Data Keep (8bits)
      TLAST : std_logic; --! Stream Data Last
   end record;
   
   type t_axis_dm_mosi32 is record
      TVALID : std_logic; --! Stream Data Valid
      TDATA : std_logic_vector(31 downto 0); --! Stream Data 64 bit
      TKEEP : std_logic_vector(3 downto 0); --! Stream Data Keep (8bits)
      TLAST : std_logic; --! Stream Data Last
   end record;
   
   -- AXI4 FULL ports
   type t_axi4_a32_d32_mosi is record --! AXI4-FULL MOSI
      -- Write Addres Channel
      awaddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      awburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      awcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      awlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      awprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awvalid :  STD_LOGIC;
      -- Write Data Channel
      wdata :  STD_LOGIC_VECTOR ( 31 downto 0 );
      wlast :  STD_LOGIC;
      wstrb :  STD_LOGIC_VECTOR ( 3 downto 0 );
      wvalid :  STD_LOGIC;   
      -- Response Channel
      bready :  STD_LOGIC;
      -- Read Address channel
      araddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      arburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      arcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      arlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      arprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arvalid :  STD_LOGIC;
      -- Read Data Channel
      rready :  STD_LOGIC;
   end record;
   
   type t_axi4_a32_d32_miso is record --! AXI4-FULL MISO
      -- Write Addres Channel
      awready :  STD_LOGIC;
      -- Write Data Channel
      wready :  STD_LOGIC;
      -- Response Channel
      bresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
      bvalid :  STD_LOGIC;
      -- Read Address channel
      arready :  STD_LOGIC;
      -- Read Data Channel
      rdata :  STD_LOGIC_VECTOR ( 31 downto 0 );
      rlast :  STD_LOGIC;
      rvalid :  STD_LOGIC;
      rresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
   end record;
   
   type t_axi4_a32_d128_mosi is record --! AXI4-FULL MOSI
      -- Write Addres Channel
      awaddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      awburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      awcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      awlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      awprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awvalid :  STD_LOGIC;
      -- Write Data Channel
      wdata :  STD_LOGIC_VECTOR ( 127 downto 0 );
      wlast :  STD_LOGIC;
      wstrb :  STD_LOGIC_VECTOR ( 15 downto 0 );
      wvalid :  STD_LOGIC;   
      -- Response Channel
      bready :  STD_LOGIC;
      -- Read Address channel
      araddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      arburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      arcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      arlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      arprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arvalid :  STD_LOGIC;
      -- Read Data Channel
      rready :  STD_LOGIC;
   end record;
   
   type t_axi4_a32_d128_miso is record --! AXI4-FULL MISO
      -- Write Addres Channel
      awready :  STD_LOGIC;
      -- Write Data Channel
      wready :  STD_LOGIC;
      -- Response Channel
      bresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
      bid:  STD_LOGIC_VECTOR ( 3 downto 0 );
      bvalid :  STD_LOGIC;
      -- Read Address channel
      arready :  STD_LOGIC;
      -- Read Data Channel
      rdata :  STD_LOGIC_VECTOR ( 127 downto 0 );
      rlast :  STD_LOGIC;
      rvalid :  STD_LOGIC;
      rresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
      rid:  STD_LOGIC_VECTOR ( 3 downto 0 );
   end record;
   
   type t_axi4_a32_d32_read_mosi is record --! AXI4-FULL MOSI
      -- Read Address channel
      araddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      arburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      arcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      arlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      arprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arvalid :  STD_LOGIC;
      -- Read Data Channel
      rready :  STD_LOGIC;
   end record;
   
   type t_axi4_a32_d32_read_miso is record --! AXI4-FULL MISO
      -- Read Address channel
      arready :  STD_LOGIC;
      -- Read Data Channel
      rdata :  STD_LOGIC_VECTOR ( 31 downto 0 );
      rlast :  STD_LOGIC;
      rvalid :  STD_LOGIC;
      rresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
      rid : STD_LOGIC_VECTOR ( 1 downto 0 );
   end record;
   
   type t_axi4_a32_d32_write_mosi is record --! AXI4-FULL MOSI
      -- Write Addres Channel
      awaddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      awburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      awcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      awlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      awprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awvalid :  STD_LOGIC;
      -- Write Data Channel
      wdata :  STD_LOGIC_VECTOR ( 31 downto 0 );
      wlast :  STD_LOGIC;
      wstrb :  STD_LOGIC_VECTOR ( 3 downto 0 );
      wvalid :  STD_LOGIC;   
      -- Response Channel
      bready :  STD_LOGIC;
   end record;   
   
   type t_axi4_a32_d32_write_miso is record --! AXI4-FULL MISO
      -- Write Addres Channel
      awready :  STD_LOGIC;
      -- Write Data Channel
      wready :  STD_LOGIC;
      -- Response Channel
      bresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
      bvalid :  STD_LOGIC;
   end record;
   
   type t_axi4_a32_read_mosi is record --! AXI4-FULL MOSI
      -- Read Address channel
      araddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      arburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      arcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      arlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      arprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      arvalid :  STD_LOGIC;
      -- Read Data Channel
      rready :  STD_LOGIC;
   end record;
   
   type t_axi4_a64_read_mosi is record --! AXI4-FULL MOSI
      -- Read Address channel
      araddr : STD_LOGIC_VECTOR ( 63 downto 0 );
      arburst : STD_LOGIC_VECTOR ( 1 downto 0 );
      arcache : STD_LOGIC_VECTOR ( 3 downto 0 );
      arid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      arlen : STD_LOGIC_VECTOR ( 7 downto 0 );
      arlock : STD_LOGIC_VECTOR ( 0 to 0 );
      arprot : STD_LOGIC_VECTOR ( 2 downto 0 );
      arqos : STD_LOGIC_VECTOR ( 3 downto 0 );
      arregion : STD_LOGIC_VECTOR ( 3 downto 0 );
      arsize : STD_LOGIC_VECTOR ( 2 downto 0 );
      arvalid : STD_LOGIC;
      -- Read Data Channel
      rready : STD_LOGIC;
   end record;
   
   type t_axi4_d32_read_miso is record --! AXI4-FULL MISO
      -- Read Address channel
      arready :  STD_LOGIC;
      -- Read Data Channel
      rdata :  STD_LOGIC_VECTOR ( 31 downto 0 );
      rlast :  STD_LOGIC;
      rvalid :  STD_LOGIC;
      rresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
      rid : STD_LOGIC_VECTOR ( 1 downto 0 );
   end record;
   
   type t_axi4_d64_read_miso is record --! AXI4-FULL MISO
      -- Read Address channel
      arready :  STD_LOGIC;
      -- Read Data Channel
      rdata :  STD_LOGIC_VECTOR ( 63 downto 0 );
      rlast :  STD_LOGIC;
      rvalid :  STD_LOGIC;
      rresp :  STD_LOGIC_VECTOR ( 1 downto 0 );
      rid : STD_LOGIC_VECTOR ( 1 downto 0 );
   end record;
   
   type t_axi4_d256_read_miso is record --! AXI4-FULL MISO
      -- Read Address channel
      arready : STD_LOGIC;
      -- Read Data Channel
      rdata : STD_LOGIC_VECTOR ( 255 downto 0 );
      rlast : STD_LOGIC;
      rresp : STD_LOGIC_VECTOR ( 1 downto 0 );
      rvalid : STD_LOGIC;
      rid : STD_LOGIC_VECTOR ( 3 downto 0 );
   end record;
   
   type t_axi4_a32_d64_write_mosi is record --! AXI4-FULL MOSI
      -- Write Addres Channel
      awaddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      awburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      awcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      awlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      awprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awvalid :  STD_LOGIC;
      -- Write Data Channel
      wdata :  STD_LOGIC_VECTOR ( 63 downto 0 );
      wlast :  STD_LOGIC;
      wstrb :  STD_LOGIC_VECTOR ( 7 downto 0 );
      wvalid :  STD_LOGIC;   
      -- Response Channel
      bready :  STD_LOGIC;
   end record;
   
   type t_axi4_a32_d128_write_mosi is record --! AXI4-FULL MOSI
      -- Write Addres Channel
      awaddr :  STD_LOGIC_VECTOR ( 31 downto 0 );
      awburst :  STD_LOGIC_VECTOR ( 1 downto 0 );
      awcache :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awlen :  STD_LOGIC_VECTOR ( 7 downto 0 );
      awlock :  STD_LOGIC_VECTOR ( 0 to 0 );
      awprot :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awqos :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awregion :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awsize :  STD_LOGIC_VECTOR ( 2 downto 0 );
      awvalid :  STD_LOGIC;
      -- Write Data Channel
      wdata :  STD_LOGIC_VECTOR ( 127 downto 0 );
      wlast :  STD_LOGIC;
      wstrb :  STD_LOGIC_VECTOR ( 15 downto 0 );
      wvalid :  STD_LOGIC;   
      -- Response Channel
      bready :  STD_LOGIC;
   end record;
   
   type t_axi4_a64_d256_write_mosi is record --! AXI4-FULL MOSI
      -- Write Address Channel
      awaddr : STD_LOGIC_VECTOR ( 63 downto 0 );
      awburst : STD_LOGIC_VECTOR ( 1 downto 0 );
      awcache : STD_LOGIC_VECTOR ( 3 downto 0 );
      awlen : STD_LOGIC_VECTOR ( 7 downto 0 );
      awlock : STD_LOGIC_VECTOR ( 0 to 0 );
      awprot : STD_LOGIC_VECTOR ( 2 downto 0 );
      awid :  STD_LOGIC_VECTOR ( 3 downto 0 );
      awqos : STD_LOGIC_VECTOR ( 3 downto 0 );
      awregion : STD_LOGIC_VECTOR ( 3 downto 0 );
      awsize : STD_LOGIC_VECTOR ( 2 downto 0 );
      awvalid : STD_LOGIC;
      -- Write Data Channel
      wdata : STD_LOGIC_VECTOR ( 255 downto 0 );
      wlast : STD_LOGIC;
      wstrb : STD_LOGIC_VECTOR ( 31 downto 0 );
      wvalid : STD_LOGIC;
      -- Response Channel
      bready : STD_LOGIC;
   end record;
   
   type t_axi4_write_miso is record --! AXI4-FULL MISO
      -- Write Address Channel   
      awready : STD_LOGIC;
      -- Write Data Channel
      wready : STD_LOGIC;
      -- Response Channel
      bresp : STD_LOGIC_VECTOR ( 1 downto 0 );
      bvalid : STD_LOGIC;
   end record;
   
   type t_axis4_mosi16_a is array (natural range <>) of t_axi4_stream_mosi16;
   type t_axis4_mosi32_a is array (natural range <>) of t_axi4_stream_mosi32;
   type t_axis4_miso_a is array (natural range <>) of t_axi4_stream_miso;
   
   type t_uartns550_out is record
      BAUDOUTN : std_logic; --! uart output signal
      DDIS : std_logic; --! uart output signal
      DTRN : std_logic; --! uart output signal
      OUT1N : std_logic; --! uart output signal
      OUT2N : std_logic; --! uart output signal
      RTSN : std_logic; --! uart output signal
      RXRDYN : std_logic; --! uart output signal
      TXD : std_logic; --! uart output signal
      TXRDYN : std_logic; --! uart output signal
   end record;
   
   type t_uartns550_in is record
      CTSN : std_logic; --! uart input signal
      DCDN : std_logic; --! uart input signal
      DSRN : std_logic; --! uart input signal
      RI : std_logic; --! uart input signal
      RXD : std_logic; --! uart input signal
   end record;
   
   -- type definissant le temps d'intégration
   -- Attention !!!C'est sur l'horloge du module fpa_interface
   type exp_info_type is 
   record      
      exp_time     : unsigned(31 downto 0); --! temps d'integration en coups d'horloge de 100MHz
      exp_indx     : std_logic_vector(7 downto 0); --! index associé au temps d'intégration.
      exp_dval     : std_logic;  --! signal de validation du temps d'integration. Attention !! Il peut subvenir après ou avant exposure_feedbk.
   end record;
   
   
   -- infos sur l'image en cours (générées par le module fpa_interface). 
   -- Attention !!!C'est sur l'horloge du module fpa_interface
   type img_info_type is 
   record      
      exp_feedbk   : std_logic; --! feedback du signal d'intégration. C'est aussi le signal de validation de frame_id
      frame_id     : unsigned(31 downto 0);  --! numero de l'image associée à exp_feedbk
      exp_info     : exp_info_type; --! données du temps d'intégration de l'image dont le numero est frame_id
      ref_feedbk   : std_logic_vector(1 downto 0); --! feedback pour elcorr. Utilisé uniquement dans module fpa
   end record;
   
   
   -- Posix time
   type POSIX_time_type is record
      Seconds     : unsigned(31 downto 0); -- Number of seconds elapsed since midnight UTC of January 1, 1970.
      SubSeconds  : unsigned(23 downto 0); -- 100 ns resolution sub-second counter.
   end record;
   
   
   -- lut  parameters
   type lut_param_type is record
      x_min         : std_logic_vector(31 downto 0);  -- valeur minimale autorisée pour X (en floating point)
      x_range       : std_logic_vector(31 downto 0);  -- range de X autorisée (en floating point). x_max = x_min + range
      lut_size      : std_logic_vector(31 downto 0);  -- nombre de points dans le LUT (en floating point)
      lut_start_add : unsigned(15 downto 0);          -- adresse du premier point dans le LUT
      lut_end_add   : unsigned(15 downto 0);          -- adresse du dernier point dans le LUT
      lut_factor    : std_logic_vector(31 downto 0);  -- ce parametre (en floating point) vaut lut_size/x_range
      lut_factor_inv: std_logic_vector(31 downto 0);  -- ce parametre (en floating point) vaut x_range/lut_size
   end record;
   
      -- lut  parameters
   type axis_lut_param_type_mosi is record
      x_min_mosi         : t_axi4_stream_mosi32;  -- valeur minimale autorisée pour X (en floating point)
      x_range_mosi       : t_axi4_stream_mosi32;  -- range de X autorisée (en floating point). x_max = x_min + range
      lut_size_mosi      : t_axi4_stream_mosi32;  -- nombre de points dans le LUT (en floating point)
      lut_start_add_mosi : t_axi4_stream_mosi32;          -- adresse du premier point dans le LUT
      lut_end_add_mosi   : t_axi4_stream_mosi32;          -- adresse du dernier point dans le LUT
      lut_factor_mosi    : t_axi4_stream_mosi32;  -- ce parametre (en floating point) vaut lut_size/x_range
      lut_factor_inv_mosi: t_axi4_stream_mosi32;  -- ce parametre (en floating point) vaut x_range/lut_size
   end record;
   
    type axis_lut_param_type_miso is record
      x_min_miso         : t_axi4_stream_miso;
      x_range_miso       : t_axi4_stream_miso;
      lut_size_miso      : t_axi4_stream_miso;
      lut_start_add_miso : t_axi4_stream_miso;
      lut_end_add_miso   : t_axi4_stream_miso;
      lut_factor_miso    : t_axi4_stream_miso;
      lut_factor_inv_miso: t_axi4_stream_miso;
   end record;
   
   
   -- decoded header info
   type decoded_hdr_type is record
      dval           : std_logic;
      exposure_time  : std_logic_vector(31 downto 0);
      width          : std_logic_vector(15 downto 0);
      height         : std_logic_vector(15 downto 0);
      offsetx        : std_logic_vector(15 downto 0);
      offsety        : std_logic_vector(15 downto 0);
      fw_position    : std_logic_vector(7 downto 0);
      ndf_position   : std_logic_vector(7 downto 0);
      ehdri_index    : std_logic_vector(7 downto 0);
   end record;
   
   -- Response constant.
   constant AXI_OKAY   : std_logic_vector(1 downto 0) := "00"; --! Successful Read or Write Acces
   constant AXI_EXOKAY : std_logic_vector(1 downto 0) := "01"; --! Successful Exclusive Read or Write Access
   constant AXI_SLVERR : std_logic_vector(1 downto 0) := "10"; --! Slave Error
   constant AXI_DECERR : std_logic_vector(1 downto 0) := "11"; --! Interconnect Decode Error
   
   
   -- clock rate de l'horloge principale du module FPA_INTF 
   constant FPA_INTF_CLK_RATE : integer := 100_000_000; --!
   
   
   --t_axi4_stream_mosi_cmd32 default value
   constant axi4_stream_mosi_cmd32_dflt : t_axi4_stream_mosi_cmd32 := ((others => '0'),'0');
   constant axi4_stream_mosi72_dflt : t_axi4_stream_mosi72 := ('0',(others => '0'),(others => '0'),(others => '0'),'0',(others => '0'),(others => '0'),(others => '0'));
   
   
   constant axi4_stream_mosi_status_dftl : t_axi4_stream_mosi_status := ((others => '0'),"0",'0','0');
   
   
   -- Pixel special values (tag)
   constant VALID_PIX_MAX_VAL    : std_logic_vector(15 downto 0) := x"FFF0";
   constant TAG_BAD_PIX          : std_logic_vector(15 downto 0) := x"FFFE";
   constant TAG_SATURATED_PIX    : std_logic_vector(15 downto 0) := x"FFFF";
   
   -- TUSER bit definitions
   constant TUSER_BAD_PIX_BIT       : integer := 0;
   constant TUSER_SATURATED_PIX_BIT : integer := 1;
   
   
   ------------------------------------------
   -- General functions
   ------------------------------------------
   function log2 (x : unsigned) return natural;
   function log2 (x : positive) return natural;
   function resize(a: std_logic_vector; len: natural) return std_logic_vector;
   function resize(a: std_logic; len: natural) return std_logic_vector;
   function BooltoStd(x:boolean) return std_logic;
   
   ------------------------------------------
   -- AXI functions
   ------------------------------------------
   procedure write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi);
   procedure read_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); signal miso : in  t_axi4_lite_miso; signal mosi : out t_axi4_lite_mosi;signal  ReadValue : out std_logic_vector(31 downto 0));
   procedure write_axis64 (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi64 );
   procedure write_axis32 (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi32 );
   procedure write_axis32_hdr (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi32 );
   procedure write_axis16 (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi16 );
   
end TEL2000;

package body TEL2000 is
   
   function log2 (x : unsigned) return natural is 
      -- Author : Tuukka Toivonen 
      -- Modified by PDU to support operand larger than 32 bits
   begin
      if x <= 1 then
         return 0;
      else
         return log2 (x / 2) + 1;
      end if;
   end function log2; 
   
   function log2 (x : positive) return natural is 
   begin
      return log2(to_unsigned(x,32));
   end function log2;
   
   -- function resize
   function resize(a: std_logic_vector; len: natural) return std_logic_vector is
   begin
      return std_logic_vector(resize(unsigned(a), len));
   end resize;
   
   function resize(a: std_logic; len: natural) return std_logic_vector is
      variable	y : std_logic_vector(len-1 downto 0) := (others => '0');
   begin
      y(0) := a;
      return y;
   end resize;
   
   function BooltoStd(x:boolean) return std_logic is 
      -- author: ENO et JPA
      --   
      variable	y : std_logic;
   begin
      if x then
         y := '1';
      else
         y := '0';
      end if;
      return y;
   end BooltoStd;
   
   -- procedure write_axi_l
   procedure write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi) is
      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)      
   begin
      mosi.ARVALID   <= '0';
      mosi.ARADDR    <= (others => '0');
      mosi.ARPROT    <= (others => '0');
      mosi.RREADY    <= '0';
      mosi.AWADDR    <= Addr ;
      mosi.AWVALID	<= '1';
      mosi.AWPROT    <= (others => '0') ;
      mosi.BREADY	   <='0';
      mosi.WDATA	   <= Value ;
      mosi.WVALID	   <= '1';
      mosi.WSTRB	   <= (others =>'1');
      wait until (miso.AWREADY = '1' and miso.WREADY = '1' and rising_edge(Clk));
      wait until (miso.BVALID = '1' and rising_edge(Clk));
      mosi.BREADY <= '1';
      mosi.AWVALID	<= '0';
      mosi.WVALID	<= '0';
   end write_axi_lite;
   
   procedure read_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); signal miso : in  t_axi4_lite_miso; signal mosi : out t_axi4_lite_mosi; signal ReadValue : out std_logic_vector(31 downto 0)) is
      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)      
   begin
      
      mosi.ARVALID   <= '1';
      mosi.ARADDR    <= Addr;
      mosi.ARPROT    <= (others => '0');
      mosi.RREADY    <= '0';
      mosi.AWADDR    <= (others => '0');
      mosi.AWVALID	<= '0';
      mosi.AWPROT    <= (others => '0');
      mosi.BREADY	   <='0';
      mosi.WDATA	   <= (others => '0');
      mosi.WVALID	   <= '0';
      mosi.WSTRB	   <= (others =>'0');
      wait until (miso.RVALID = '1'  and rising_edge(Clk));
      ReadValue      <= miso.RDATA;
      mosi.ARVALID	<= '0';
      mosi.RREADY	   <= '1';
      wait until rising_edge(Clk);
      mosi.ARVALID	<= '0';
      mosi.RREADY	   <= '0';
   end read_axi_lite; 
   
   procedure write_axis64 (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi64 ) is
      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)      
   begin
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID   <= '1';
      mosi.TDATA	   <= Value ;
      mosi.TSTRB    <= (others => '1');
      mosi.TKEEP    <= (others => '1');
      mosi.TLAST    <= tlast;
      mosi.TID    <= (others => '0') ;
      mosi.TDEST	<= (others => '0') ;
      mosi.TUSER	<= (others => '0') ;
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID	<= '0';
      mosi.TLAST	<= '0';
   end write_axis64;
   
   procedure write_axis32 (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi32 ) is
      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)      
   begin
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID   <= '1';
      mosi.TDATA	   <= Value ;
      mosi.TSTRB    <= (others => '1');
      mosi.TKEEP    <= (others => '1');
      mosi.TLAST    <= tlast;
      mosi.TID    <= (others => '0') ;
      mosi.TDEST	<= (others => '0') ;
      mosi.TUSER	<= (others => '0') ;
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID	<= '0';
      mosi.TLAST	<= '0';
   end write_axis32;
   
   procedure write_axis32_hdr (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi32 ) is
      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)      
   begin
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID   <= '1';
      mosi.TDATA	   <= Value ;
      mosi.TSTRB    <= (others => '1');
      mosi.TKEEP    <= (others => '1');
      mosi.TLAST    <= tlast;
      mosi.TID    <= (others => '1') ;    -- TID = '1' in header
      mosi.TDEST	<= (others => '0') ;
      mosi.TUSER	<= (others => '0') ;
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID	<= '0';
      mosi.TLAST	<= '0';
   end write_axis32_hdr;
   
   procedure write_axis16 (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi16 ) is
      -- subprogram_declarative_items (constant declarations, variable declarations, etc.)      
   begin
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID   <= '1';
      mosi.TDATA	   <= Value ;
      mosi.TSTRB    <= (others => '1');
      mosi.TKEEP    <= (others => '1');
      mosi.TLAST    <= tlast;
      mosi.TID    <= (others => '0') ;
      mosi.TDEST	<= (others => '0') ;
      mosi.TUSER	<= (others => '0') ;
      wait until (miso.TREADY = '1' and rising_edge(Clk));
      mosi.TVALID	<= '0';
      mosi.TLAST	<= '0';
   end write_axis16; 
   
end package body TEL2000;