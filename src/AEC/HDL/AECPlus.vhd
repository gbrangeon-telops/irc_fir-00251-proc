-------------------------------------------------------------------------------
--
-- Title       : AECPlus
-- Design      : FIR_00180_IRC
-- Author      : Patrick Daraiche
-- Company     : Telops Inc.
--
-------------------------------------------------------------------------------
-- $Author: jboulet $
-- $LastChangedDate: 2013-07-10 15:31:45 -0400 (mer., 10 juil. 2013) $
-- $Revision: 12526 $
-- $HeadURL: http://einstein/svn/firmware/FIR-00180-IRC%20(IRCDEV)/trunk/src/AEC/src/AECPlus.vhd $
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00180-IRC\src\AEC\src\AECPlus.vhd
-- Generated   : Fri Apr  5 09:36:19 2013
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Bloc that sums the incoming pixels and tag the ExposureTime
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {AECPlus} architecture {AECPlus}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

library work;
use work.tel2000.all;

entity AECPlus is
    generic(
    CAL_2CH : boolean := FALSE
    );
	 port(
		 ARESETN : in STD_LOGIC;
		 CLK : in STD_LOGIC;
       
		 RX_MOSI : in T_AXI4_STREAM_MOSI32;
		 RX_MISO : in T_AXI4_STREAM_MISO;
       
		 FILTER_NB : in STD_LOGIC_VECTOR(7 downto 0);
		 EXP_TIME : in STD_LOGIC_VECTOR(31 downto 0);
       HDER_VALID : in STD_LOGIC;
       
		 EXP_TIME_AECPLUS : out STD_LOGIC_VECTOR(31 downto 0);
		 SUM_CNTS : out STD_LOGIC_VECTOR(41 downto 0);
		 NB_PIXELS : out STD_LOGIC_VECTOR(31 downto 0);
		 AECP_DATA_VALID : out STD_LOGIC
   );
end AECPlus;

--}} End of automatically maintained section

architecture AECPlus of AECPlus is
   constant NDF_InTransition : std_logic_vector(7 downto 0) := x"03";

   component sync_resetn
      port(
         ARESETN                : in std_logic;
         SRESETN                : out std_logic;
         CLK                    : in std_logic);
   end component;

   signal sresetn : std_logic;
   signal sum : unsigned(41 downto 0);
   signal nb_pixels_i : unsigned(31 downto 0);
   signal latch_data : std_logic;

   signal hder_valid_last : std_logic;
   signal exp_time_latched : std_logic_vector(31 downto 0);
   signal filter_nb_latched : std_logic_vector(7 downto 0);
   
   signal pix_cnt_value : unsigned(7 downto 0);

   
begin

   sresetn_gen : sync_resetn
   port map(
      ARESETN => ARESETN,
      CLK    => CLK,
      SRESETN => sresetn
      );
   
   --Generate statement to chose if we count 1 or 2 pixel per transaction   
   pix_value_inst_F : if(CAL_2CH = FALSE) generate
   begin
       pix_cnt_value <= to_unsigned(1,8);
   end generate;
   
   pix_value_inst_T : if(CAL_2CH = TRUE) generate
   begin
       pix_cnt_value <= to_unsigned(2,8);
   end generate;
  
      
   sum_gen : process(CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            sum <= (others => '0');
            latch_data <= '0';
            nb_pixels_i <= (others => '0');
         else
            -- if data latched, reset sum and nb_pixels
            if latch_data = '1' then
               latch_data <= '0';
               sum <= (others => '0');
               nb_pixels_i <= (others => '0');
            elsif filter_nb_latched /= NDF_InTransition then 
               if RX_MOSI.TVALID = '1' and RX_MISO.TREADY = '1' then
                  sum <= sum + unsigned(RX_MOSI.TDATA);
                  nb_pixels_i <= nb_pixels_i + pix_cnt_value;
                  
                  if RX_MOSI.TLAST = '1' then
                     latch_data <= '1';
                  end if;
               end if;
            end if;
         end if;
      end if;
   end process;

   hder_input_gen : process(CLK)
   begin
      if rising_edge(CLK) then
         if sresetn = '0' then
            exp_time_latched <= (others => '0');
            filter_nb_latched <= (others => '0');
            hder_valid_last <= '0';
         else
            hder_valid_last <= HDER_VALID;
            
            if HDER_VALID = '1' and hder_valid_last = '0' then
               exp_time_latched <= EXP_TIME;
               filter_nb_latched <= FILTER_NB;
            end if;
         end if;
      end if;
  end process;
  
  output_gen : process(CLK)
  begin
     if rising_edge(CLK) then
        if sresetn = '0' then
           SUM_CNTS <= (others => '0');
           EXP_TIME_AECPLUS <= (others => '0');
           NB_PIXELS <= (others => '0');
           AECP_DATA_VALID <= '0';
        else
           if filter_nb_latched /= NDF_InTransition then
              if latch_data = '1' then
                 EXP_TIME_AECPLUS <= exp_time_latched;
                 SUM_CNTS <= std_logic_vector(sum);
                 NB_PIXELS <= std_logic_vector(nb_pixels_i);
                 AECP_DATA_VALID <= '1';
              end if;
           else
              AECP_DATA_VALID <= '0';
           end if;
        end if;
     end if;
  end process;
  
   
end AECPlus;
