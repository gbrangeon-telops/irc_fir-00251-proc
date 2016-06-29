------------------------------------------------------------------
--!   @file : calib_fast_hder_gen
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
use work.calib_define.all;
use work.img_header_define.all;

entity calib_fast_hder_gen is
   port(
      ARESET              : in std_logic;
      CLK                 : in std_logic;
      
      FRAME_ID            : in std_logic_vector(7 downto 0);
      HDER_INFO           : in calib_hder_type;
      HDER_SEND_START     : in std_logic;
      
      -- envoi de la partie du Header
      HDER_MOSI           : out t_axi4_lite_mosi;
      HDER_MISO           : in t_axi4_lite_miso  
   );
end calib_fast_hder_gen;


architecture rtl of calib_fast_hder_gen is
   
   component sync_reset
      port(
         ARESET : in std_logic;
         SRESET : out std_logic;
         CLK    : in std_logic);
   end component;                                  
   
   type fast_hder_sm_type is (idle, send_hder_st);
   
   signal fast_hder_sm              : fast_hder_sm_type;
   signal hder_link_rdy             : std_logic;
   signal sreset                    : std_logic;   
   signal hder_mosi_i               : t_axi4_lite_mosi;
   signal hcnt                      : unsigned(7 downto 0);
   signal frame_id_i                : std_logic_vector(FRAME_ID'range);
   signal hder_info_i               : calib_hder_type;
   
begin   
   
   hder_link_rdy <= HDER_MISO.WREADY and HDER_MISO.AWREADY;
   HDER_MOSI <= hder_mosi_i;
   -----------------------------------------------------
   -- Synchronisation reset
   -----------------------------------------------------
   U1: sync_reset
   Port map(		
      ARESET   => ARESET,		
      SRESET   => sreset,
      CLK   => CLK);  
   
   -------------------------------------------------------------------
   -- Sorties des données
   -------------------------------------------------------------------   
   U2: process(CLK)
   begin          
      if rising_edge(CLK) then         
         if sreset = '1' then
            fast_hder_sm <= idle;
            hder_mosi_i.awvalid <= '0';
            hder_mosi_i.wvalid <= '0';
            hder_mosi_i.wstrb <= (others => '0');
            hder_mosi_i.awprot <= (others => '0');
            hder_mosi_i.arvalid <= '0';
            hder_mosi_i.bready <= '1';
            hder_mosi_i.rready <= '0';
            hder_mosi_i.arprot <= (others => '0');
         else            
            -- sortie de la partie header fast provenant du module
            case fast_hder_sm is
               
               when idle =>
                  hder_mosi_i.awvalid <= '0';
                  hder_mosi_i.wvalid <= '0';
                  hder_mosi_i.wstrb <= (others => '0');
                  hcnt <= to_unsigned(1, hcnt'length);
                  frame_id_i <= FRAME_ID;
                  hder_info_i <= HDER_INFO;
                  if HDER_SEND_START = '1' then
                     fast_hder_sm <= send_hder_st;                     
                  end if;
               
               when send_hder_st =>
                  if hder_link_rdy = '1' then 
                     if hcnt = 1 then    -- offset_fp32
                        hder_mosi_i.awaddr <= x"0000" & frame_id_i & std_logic_vector(resize(DataOffsetAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_info_i.offset_fp32), 32), DataOffsetShift));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= DataOffsetBWE;
                        
                     elsif hcnt = 2 then -- data_exponent
                        hder_mosi_i.awaddr <= x"0000" & frame_id_i & std_logic_vector(resize(DataExpAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_info_i.data_exponent), 32), DataExpShift));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= DataExpBWE;
                        
                     elsif hcnt = 3 then    -- cal_block_index
                        hder_mosi_i.awaddr <= x"0000" & frame_id_i & std_logic_vector(resize(CalibrationBlockIndexAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <=  std_logic_vector(shift_left(resize(hder_info_i.cal_block_index, 32), CalibrationBlockIndexShift));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= CalibrationBlockIndexBWE;
                        
                     elsif hcnt = 4 then -- cal_block_posix
                        hder_mosi_i.awaddr <= x"0000" & frame_id_i & std_logic_vector(resize(CalibrationBlockPOSIXTimeAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_info_i.cal_block_posix), 32), CalibrationBlockPOSIXTimeShift));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= CalibrationBlockPOSIXTimeBWE;
                     
                     elsif hcnt = 5 then -- block_act_posix
                        hder_mosi_i.awaddr <= x"FFFF" & frame_id_i & std_logic_vector(resize(ImageCorrectionPOSIXTimeAdd32, 8));
                        hder_mosi_i.awvalid <= '1';
                        hder_mosi_i.wdata <= std_logic_vector(shift_left(resize(unsigned(hder_info_i.block_act_posix), 32), ImageCorrectionPOSIXTimeShift));
                        hder_mosi_i.wvalid <= '1';
                        hder_mosi_i.wstrb <= ImageCorrectionPOSIXTimeBWE;
                        fast_hder_sm <= idle;
                     end if;
                     hcnt <= hcnt + 1;
                  end if;
               
               when others =>
               
            end case;               
            
         end if;  
      end if;
   end process; 
end rtl;
