------------------------------------------------------------------
--!   @file : exp_fifo_writer
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;

entity exp_fifo_writer is
   port(
      ARESET         : in std_logic;
      CLK            : in std_logic;
      
      FPA_IMG_INFO   : in img_info_type;
      FPA_INTF_CLK   : in std_logic;
      
      DINi_MOSI      : in t_axi4_stream_mosi16;
      DINi_MISO      : in t_axi4_stream_miso;
      
      EXPOSUREi_FP32_MOSI : out t_axi4_stream_mosi32;
      EXPOSUREi_FP32_MISO : in t_axi4_stream_miso;
      
      ERR            : out std_logic
      );
end exp_fifo_writer;


architecture rtl of exp_fifo_writer is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK : in std_logic);
   end component;
   
   component double_sync
      generic ( INIT_VALUE : bit := '0' );
      port (
         D     : in STD_LOGIC;
         Q     : out STD_LOGIC := '0';
         RESET : in STD_LOGIC;
         CLK   : in STD_LOGIC);
   end component;
   
   component native_to_axis32
      port (
         ARESET : in STD_LOGIC;
         AXIS_MISO : in T_AXI4_STREAM_MISO;
         CLK : in STD_LOGIC;
         IN_DATA : in STD_LOGIC_VECTOR(31 downto 0);
         IN_DVAL : in STD_LOGIC;
         IN_EOF  : in STD_LOGIC;
         AXIS_MOSI : out T_AXI4_STREAM_MOSI32;
         ERR : out STD_LOGIC;
         IN_BUSY : out STD_LOGIC
         );
   end component;
   
   component axis_fi32tofp32
      generic(
         input_efflen : NATURAL := 12;
         input_signed : BOOLEAN := false
         );
      port (
         ARESETN  : in STD_LOGIC;
         CLK      : in STD_LOGIC;
         RX_MOSI  : in t_axi4_stream_mosi32;
         TX_MISO  : in t_axi4_stream_miso;
         RX_MISO  : out t_axi4_stream_miso;
         TX_MOSI  : out t_axi4_stream_mosi32
         );
   end component;
   
   type   exp_reg_type is array (0 to 1) of std_logic_vector(31 downto 0); 
   signal sreset                    : std_logic;
   signal exp_reg_indx              : integer range 0 to 1;
   signal exp_reg_indx_temp         : std_logic_vector(2 downto 0);
   signal exp_reg                   : exp_reg_type;
   signal exp_reg_dval              : std_logic;
   signal din_exp_time_indx         : integer range 0 to 1;
   signal din_exp_time_indx_temp    : std_logic_vector(2 downto 0);
   signal din_exp_time_dval         : std_logic;
   signal din_exp_time              : std_logic_vector(31 downto 0);
   signal exp_mosi_fp32             : t_axi4_stream_mosi32;
   signal exp_miso_i                : t_axi4_stream_miso;
   signal exp_mosi_i                : t_axi4_stream_mosi32;
   signal ARESETN                   : std_logic;
   
begin
   
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U0: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );

    ARESETN <= not ARESET;   
   --------------------------------------------------
   -- double sync 
   --------------------------------------------------   
   
   
   --------------------------------------------------
   -- Remplissage des registres de ExpTime
   -------------------------------------------------- 
   exp_reg_indx_temp <= resize('0'& FPA_IMG_INFO.EXP_INFO.EXP_INDX, exp_reg_indx_temp'length);
   exp_reg_indx <= to_integer(unsigned(exp_reg_indx_temp));
   U3: process(FPA_INTF_CLK)
   begin          
      if rising_edge(FPA_INTF_CLK) then 
         if FPA_IMG_INFO.EXP_INFO.EXP_DVAL = '1' then
            exp_reg(0) <= std_logic_vector(FPA_IMG_INFO.EXP_INFO.EXP_TIME); --TEST FIX, va fonctionner en ITR et pas fast mais pas IWR, REvoir pour mettre un pipe de Temps d'Expostion lu sur SOF
         end if;      
      end if;
   end process;
   
   --------------------------------------------------
   -- Choix du registre selon le TUSER du pixel
   --------------------------------------------------
   din_exp_time_indx_temp <= resize('0' & DINi_MOSI.TUSER(2), din_exp_time_indx_temp'length); 
   din_exp_time_indx <= to_integer(unsigned(din_exp_time_indx_temp));
   U4: process(CLK)
   begin          
      if rising_edge(CLK) then 
         if sreset = '1' then 
            din_exp_time_dval <= '0';            
         else            
            if DINi_MOSI.TVALID = '1' and DINi_MISO.TREADY = '1' then
               din_exp_time <= exp_reg(0);
               din_exp_time_dval <= '1';
            else
               din_exp_time_dval <= '0';
            end if;             
         end if;
      end if;
   end process;
   
   --------------------------------------------------
   -- Conversion en lien axi_stream32
   -------------------------------------------------- 
   U5 : native_to_axis32
   port map(
      ARESET => ARESET,
      CLK => CLK,
      IN_DATA => din_exp_time,
      IN_DVAL => din_exp_time_dval,
      IN_EOF  => '0',
      AXIS_MOSI => exp_mosi_i,
      AXIS_MISO => exp_miso_i
      );
   
   --------------------------------------------------
   -- conversion du temps d'intégration en fp32
   -------------------------------------------------- 
   U1 : axis_fi32tofp32
   generic map (
      input_efflen => 32,
      input_signed => false
      )
   port map(
      ARESETN => ARESETN,
      CLK     => CLK,
      RX_MOSI => exp_mosi_i,
      RX_MISO => exp_miso_i,
      TX_MOSI => exp_mosi_fp32,
      TX_MISO => EXPOSUREi_FP32_MISO
      );
   
   EXPOSUREi_FP32_MOSI <= exp_mosi_fp32;
   ERR <= exp_mosi_fp32.tvalid and not EXPOSUREi_FP32_MISO.TREADY; -- je ne supporte pas le contrôle de flow
   
end rtl;
