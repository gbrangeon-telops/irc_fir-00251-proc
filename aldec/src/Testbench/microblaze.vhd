------------------------------------------------------------------
--!   @file microblaze.vhd
--!   @brief Microblaze for simulation in SystemC.
--!   @details This entity contains the SystemC model of the Microblaze. 
--!
--!   $Rev: 12770 $
--!   $Author: pdaraiche $
--!   $Date: 2013-12-20 12:01:34 -0500 (ven., 20 déc. 2013) $
--!   $Id: microblaze.vhd 12770 2013-12-20 17:01:34Z pdaraiche $
--!   $URL: http://einstein/svn/firmware/FIR-00251-Proc/branchs/2019-04-15%20FGR%20Defrag/aldec/src/Testbench/microblaze.vhd $
------------------------------------------------------------------

--!   Use Standard library.
library IEEE;
--!   Use logic elements.
use IEEE.STD_LOGIC_1164.ALL;

--! @brief Microblaze entity.
--! @details This entity defines the ports used by SystemC for simulation.
entity MICROBLAZE is
   port (
      -- Gen Signals
      ACLK : in std_logic; --! System clock
      ARESETn : in std_logic; --! Asynchronous system reset
      
      -- AXI4-Lite
      -- Write Address Channel
      M_AWVALID: out std_logic; --!  Write Address Valid
      M_AWREADY : in std_logic; --!  Write Address Ready
      M_AWADDR: out std_logic_vector(31 downto 0); --! Write Address
      M_AWPROT: out std_logic_vector(2 downto 0); --! Write Address Protection type
      -- Write Data Channel
      M_WVALID : out std_logic; --! Write Data Valid
      M_WREADY : in std_logic; --! Write Data Ready
      M_WDATA : out std_logic_vector(31 downto 0); --! Write Data
      M_WSTRB : out std_logic_vector(3 downto 0); --! Write Data Strobes
      -- Write Response Channel
      M_BVALID : in std_logic; --! Write Response Valid
      M_BREADY : out std_logic; --! Write Response Ready
      M_BRESP : in std_logic_vector(1 downto 0); --! Write Response
      -- Read Address Channel
      M_ARVALID : out std_logic; --! Read Address Valid
      M_ARREADY : in std_logic; --! Read Address Ready
      M_ARADDR : out std_logic_vector(31 downto 0); --! Read Address
      M_ARPROT : out std_logic_vector(2 downto 0); --! Read Address Protection Type
      -- Read Data Channel
      M_RVALID : in std_logic; --! Read Data Valid
      M_RREADY : out std_logic; --! Read Data Ready
      M_RDATA : in std_logic_vector(31 downto 0); --! Read Data
      M_RRESP : in std_logic_vector(1 downto 0) --! Read Data Response
      );
end MICROBLAZE;

--! @brief Architecture SystemC of Microblaze.
--! @details Architecture for simulation in SystemC.
architecture SystemC of MICROBLAZE is

   --! Call component compiled as a DLL
   component mb_model
      port(
         -- Gen Signals
         ACLK : in std_logic;
         ARESETn : in std_logic;
         
         -- AXI4-Lite
         -- Write Address Channel
         AWVALID: out std_logic;
         AWREADY : in std_logic;
         AWADDR: out std_logic_vector(31 downto 0);
         AWPROT: out std_logic_vector(2 downto 0);
         -- Write Data Channel
         WVALID : out std_logic;
         WREADY : in std_logic;
         WDATA : out std_logic_vector(31 downto 0);
         WSTRB : out std_logic_vector(3 downto 0);
         -- Write Response Channel
         BVALID : in std_logic;
         BREADY : out std_logic;
         BRESP : in std_logic_vector(1 downto 0);
         -- Read Address Channel
         ARVALID : out std_logic;
         ARREADY : in std_logic;
         ARADDR : out std_logic_vector(31 downto 0);
         ARPROT : out std_logic_vector(2 downto 0);
         -- Read Data Channel
         RVALID : in std_logic;
         RREADY : out std_logic;
         RDATA : in std_logic_vector(31 downto 0);
         RRESP : in std_logic_vector(1 downto 0));
   end component;
   
   
begin    
   
   --! Mapping the model to the entity ports
   MB_SC : mb_model
   port map(
      ACLK => ACLK,
      ARESETn => ARESETn,
      AWVALID => M_AWVALID,
      AWREADY => M_AWREADY,
      AWADDR => M_AWADDR,
      AWPROT => M_AWPROT,
      WVALID => M_WVALID,
      WREADY => M_WREADY,
      WDATA => M_WDATA,
      WSTRB => M_WSTRB,
      BVALID => M_BVALID,
      BREADY => M_BREADY,
      BRESP => M_BRESP,
      ARVALID => M_ARVALID,
      ARREADY => M_ARREADY,
      ARADDR => M_ARADDR,
      ARPROT => M_ARPROT,
      RVALID => M_RVALID,
      RREADY => M_RREADY,
      RDATA => M_RDATA,
      RRESP => M_RRESP
      );
   
   
end SystemC;
