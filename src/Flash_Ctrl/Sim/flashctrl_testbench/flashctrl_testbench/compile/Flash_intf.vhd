-------------------------------------------------------------------------------
--
-- Title       : Flash_intf
-- Design      : flashctrl_testbench
-- Author      : Unknown
-- Company     : Unknown
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\Sim\flashctrl_testbench\flashctrl_testbench\compile\Flash_intf.vhd
-- Generated   : Thu Dec 11 14:52:09 2014
-- From        : D:\Telops\FIR-00251-Proc\src\Flash_Ctrl\HDL\Flash_intf.bde
-- By          : Bde2Vhdl ver. 2.6
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;
library work;
use work.tel2000.all;

-- other libraries declarations
library WORK;

entity Flash_intf is
  port(
       Rst : in STD_LOGIC;
       Sys_clk : in STD_LOGIC;
       AxiL_Mosi : in t_axi4_a32_d32_mosi;
       FlashReadyBusy : in STD_LOGIC_VECTOR(1 downto 0);
       AxiL_Miso : out t_axi4_a32_d32_miso;
       CmdIO : inout STD_LOGIC_VECTOR(5 downto 0);
       DataIO : inout STD_LOGIC_VECTOR(7 downto 0)
  );
end Flash_intf;

architecture Flash_intf of Flash_intf is

---- Component declarations -----

component axi_bram_ctrl_wrapper
  port (
       Axi_Mosi : in T_AXI4_A32_D32_MOSI;
       bram_rddata_a : in STD_LOGIC_VECTOR(31 downto 0);
       s_axi_aclk : in STD_LOGIC;
       s_axi_aresetn : in STD_LOGIC;
       Axi_Miso : out T_AXI4_A32_D32_MISO;
       bram_addr_a : out STD_LOGIC_VECTOR(12 downto 0);
       bram_clk_a : out STD_LOGIC;
       bram_en_a : out STD_LOGIC;
       bram_rst_a : out STD_LOGIC;
       bram_we_a : out STD_LOGIC_VECTOR(3 downto 0);
       bram_wrdata_a : out STD_LOGIC_VECTOR(31 downto 0)
  );
end component;
component blk_mem_gen_w32_d8192_wrapper
  port (
       addra : in STD_LOGIC_VECTOR(12 downto 0);
       addrb : in STD_LOGIC_VECTOR(12 downto 0);
       clka : in STD_LOGIC;
       clkb : in STD_LOGIC;
       dina : in STD_LOGIC_VECTOR(31 downto 0);
       dinb : in STD_LOGIC_VECTOR(31 downto 0);
       ena : in STD_LOGIC;
       enb : in STD_LOGIC;
       rsta : in STD_LOGIC;
       rstb : in STD_LOGIC;
       wea : in STD_LOGIC_VECTOR(3 downto 0);
       web : in STD_LOGIC_VECTOR(3 downto 0);
       douta : out STD_LOGIC_VECTOR(31 downto 0);
       doutb : out STD_LOGIC_VECTOR(31 downto 0)
  );
end component;
component flash_ctrl
  port (
       Axi_Mosi : in T_AXI4_A32_D32_MOSI;
       BRAM_Miso : in T_AXI4_A32_D32_MISO;
       Flash_Command_In : in STD_LOGIC_VECTOR(5 downto 0);
       Flash_Data_In : in STD_LOGIC_VECTOR(7 downto 0);
       ReadyBusyN : in STD_LOGIC_VECTOR(2 downto 0);
       Rst : in STD_LOGIC;
       Sys_clk : in STD_LOGIC;
       Axi_Miso : out T_AXI4_A32_D32_MISO;
       BRAM_Mosi : out T_AXI4_A32_D32_MOSI;
       Flash_Command_Ctrl : out STD_LOGIC_VECTOR(5 downto 0);
       Flash_Command_Out : out STD_LOGIC_VECTOR(5 downto 0);
       Flash_Data_Ctrl : out STD_LOGIC_VECTOR(7 downto 0);
       Flash_Data_Out : out STD_LOGIC_VECTOR(7 downto 0);
       NAND_SM : out STD_LOGIC_VECTOR(3 downto 0)
  );
end component;
component flash_output
  port (
       Flash_Command_Ctrl : in STD_LOGIC_VECTOR(5 downto 0);
       Flash_Command_In : in STD_LOGIC_VECTOR(5 downto 0);
       Flash_Data_Ctrl : in STD_LOGIC_VECTOR(7 downto 0);
       Flash_Data_In : in STD_LOGIC_VECTOR(7 downto 0);
       NAND_DATA_WRITE_iv8 : in STD_LOGIC_VECTOR(7 downto 0);
       NAND_RDENn : in STD_LOGIC;
       NAND_READ_BUSY : in STD_LOGIC;
       NAND_WRENn : in STD_LOGIC;
       NAND_WRITE_BUSY : in STD_LOGIC;
       Flash_Command_Out : out STD_LOGIC_VECTOR(5 downto 0);
       Flash_Data_Out : out STD_LOGIC_VECTOR(7 downto 0);
       Flash_Command_IO : inout STD_LOGIC_VECTOR(5 downto 0);
       Flash_Data_IO : inout STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component flash_process
  port (
       BRAM_PORTB_dout : in STD_LOGIC_VECTOR(31 downto 0);
       Flash_Data : in STD_LOGIC_VECTOR(7 downto 0);
       Rst : in STD_LOGIC;
       Start_NANDSM : in STD_LOGIC_VECTOR(3 downto 0);
       Sys_clk : in STD_LOGIC;
       BRAM_PORTB_addr : out STD_LOGIC_VECTOR(31 downto 0);
       BRAM_PORTB_clk : out STD_LOGIC;
       BRAM_PORTB_din : out STD_LOGIC_VECTOR(31 downto 0);
       BRAM_PORTB_en : out STD_LOGIC;
       BRAM_PORTB_rst : out STD_LOGIC;
       BRAM_PORTB_we : out STD_LOGIC_VECTOR(3 downto 0);
       NAND_DATA_WRITE_iv8 : out STD_LOGIC_VECTOR(7 downto 0);
       NAND_SM_RDENn : out STD_LOGIC;
       NAND_SM_READ_BUSY : out STD_LOGIC;
       NAND_SM_WRENn : out STD_LOGIC;
       NAND_SM_WRITE_BUSY : out STD_LOGIC
  );
end component;

---- Signal declarations used on the diagram ----

signal BRAM_Miso : t_axi4_a32_d32_miso;
signal BRAM_Mosi : t_axi4_a32_d32_mosi;
signal NAND_SM_WRITE_BUSY : STD_LOGIC;
signal NET1604 : STD_LOGIC;
signal NET1636 : STD_LOGIC;
signal NET1727 : STD_LOGIC;
signal NET2082 : STD_LOGIC;
signal NET2112 : STD_LOGIC;
signal NET2144 : STD_LOGIC;
signal NET2182 : STD_LOGIC;
signal NET3339 : STD_LOGIC;
signal RECORD1654 : t_axi4_a32_d32_miso;
signal RECORD1661 : t_axi4_a32_d32_mosi;
signal resetn : STD_LOGIC;
signal BRAM_AddrIn : STD_LOGIC_VECTOR (12 downto 0);
signal BRAM_Process_AddrOut : STD_LOGIC_VECTOR (31 downto 0);
signal BUS1454 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS1553 : STD_LOGIC_VECTOR (12 downto 0);
signal BUS1558 : STD_LOGIC_VECTOR (31 downto 0);
signal BUS1563 : STD_LOGIC_VECTOR (31 downto 0);
signal BUS1986 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS2000 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS2191 : STD_LOGIC_VECTOR (3 downto 0);
signal BUS2254 : STD_LOGIC_VECTOR (31 downto 0);
signal BUS2263 : STD_LOGIC_VECTOR (31 downto 0);
signal BUS2412 : STD_LOGIC_VECTOR (7 downto 0);
signal Flash_Command_Ctrl : STD_LOGIC_VECTOR (5 downto 0);
signal Flash_Command_In : STD_LOGIC_VECTOR (5 downto 0);
signal Flash_Command_Out : STD_LOGIC_VECTOR (5 downto 0);
signal Flash_Data : STD_LOGIC_VECTOR (7 downto 0);
signal Nand_SM : STD_LOGIC_VECTOR (3 downto 0);
signal ReadyBusyN : STD_LOGIC_VECTOR (2 downto 0);

begin

---- User Signal Assignments ----
ReadyBusyN(0) <= FlashReadyBusy(0);
ReadyBusyN(1) <= FlashReadyBusy(1);
ReadyBusyN(2) <= NAND_SM_WRITE_BUSY;
BRAM_AddrIn <= BRAM_Process_AddrOut(12 downto 0);

----  Component instantiations  ----

U1 : flash_ctrl
  port map(
       Axi_Miso => RECORD1654,
       Axi_Mosi => RECORD1661,
       BRAM_Miso => BRAM_Miso,
       BRAM_Mosi => BRAM_Mosi,
       Flash_Command_Ctrl => Flash_Command_Ctrl,
       Flash_Command_In => Flash_Command_Out,
       Flash_Command_Out => Flash_Command_In,
       Flash_Data_Ctrl => BUS2000,
       Flash_Data_In => Flash_Data,
       Flash_Data_Out => BUS1986,
       NAND_SM => Nand_SM,
       ReadyBusyN => ReadyBusyN,
       Rst => Rst,
       Sys_clk => Sys_clk
  );

U2 : axi_bram_ctrl_wrapper
  port map(
       Axi_Miso => BRAM_Miso,
       Axi_Mosi => BRAM_Mosi,
       bram_addr_a => BUS1553,
       bram_clk_a => NET1727,
       bram_en_a => NET1604,
       bram_rddata_a => BUS1563,
       bram_rst_a => NET1636,
       bram_we_a => BUS1454,
       bram_wrdata_a => BUS1558,
       s_axi_aclk => Sys_clk,
       s_axi_aresetn => resetn
  );

resetn <= not(Rst);

U4 : blk_mem_gen_w32_d8192_wrapper
  port map(
       addra => BUS1553,
       addrb => BRAM_AddrIn,
       clka => NET1727,
       clkb => Sys_clk,
       dina => BUS1558,
       dinb => BUS2254,
       douta => BUS1563,
       doutb => BUS2263,
       ena => NET1604,
       enb => NET2182,
       rsta => NET1636,
       rstb => NET3339,
       wea => BUS1454,
       web => BUS2191
  );

U5 : flash_output
  port map(
       Flash_Command_Ctrl => Flash_Command_Ctrl,
       Flash_Command_IO => CmdIO,
       Flash_Command_In => Flash_Command_In,
       Flash_Command_Out => Flash_Command_Out,
       Flash_Data_Ctrl => BUS2000,
       Flash_Data_IO => DataIO,
       Flash_Data_In => BUS1986,
       Flash_Data_Out => Flash_Data,
       NAND_DATA_WRITE_iv8 => BUS2412,
       NAND_RDENn => NET2112,
       NAND_READ_BUSY => NET2144,
       NAND_WRENn => NET2082,
       NAND_WRITE_BUSY => NAND_SM_WRITE_BUSY
  );

U6 : flash_process
  port map(
       BRAM_PORTB_addr => BRAM_Process_AddrOut,
       BRAM_PORTB_din => BUS2254,
       BRAM_PORTB_dout => BUS2263,
       BRAM_PORTB_en => NET2182,
       BRAM_PORTB_rst => NET3339,
       BRAM_PORTB_we => BUS2191,
       Flash_Data => Flash_Data,
       NAND_DATA_WRITE_iv8 => BUS2412,
       NAND_SM_RDENn => NET2112,
       NAND_SM_READ_BUSY => NET2144,
       NAND_SM_WRENn => NET2082,
       NAND_SM_WRITE_BUSY => NAND_SM_WRITE_BUSY,
       Rst => Rst,
       Start_NANDSM => Nand_SM,
       Sys_clk => Sys_clk
  );


---- Terminal assignment ----

    -- Inputs terminals
	RECORD1661 <= AxiL_Mosi;

    -- Output\buffer terminals
	AxiL_Miso <= RECORD1654;


end Flash_intf;
