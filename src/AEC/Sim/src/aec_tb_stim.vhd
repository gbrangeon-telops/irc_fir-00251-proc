-------------------------------------------------------------------------------
--
-- Title       : AEC TB STIM
-- Design      : clink_tb
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Output\src\Clink\Simulations\clink_tb\src\axis_lane_stim.vhd
-- Generated   : Thu Jan 30 13:26:14 2014
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;                                             
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.img_header_define.all;
use work.tel2000.all;

entity aec_tb_stim is
   port(
      --------------------------------
      -- µBlaze Interface
      -------------------------------- 
      AXIL_MOSI : out t_axi4_lite_mosi;
      AXIL_MISO : in t_axi4_lite_miso;
      INTERUPT  : in std_logic;
   
      --------------------------------
      -- AXI Stream Interface
      --------------------------------
      AXI_STREAM_MOSI : out t_axi4_stream_mosi32;
      AXI_STREAM_MISO : in t_axi4_stream_miso;
      
      --------------------------------
      -- Random MISO Ctrl
      --------------------------------
      RANDOM    : out std_logic;
      FALL      : out std_logic;
      
      --------------------------------
      -- MISC
      --------------------------------
      CLK160    : out STD_LOGIC;
      CLK100    : out STD_LOGIC;
      ARESETN   : out STD_LOGIC
   );
end aec_tb_stim;



architecture rtl of aec_tb_stim is

   --+-----------------
   -- MB CTRL
   --------------------
   constant C_S_AXI_DATA_WIDTH      : integer := 32;
   constant C_S_AXI_ADDR_WIDTH      : integer := 32;
   constant AXI_STREAM_DATA_WIDTH   : integer := 32;
   constant AXI_STREAM_MAX_VAL      : integer := 2**16 - 1;

   ----------------------------   
   -- Address of registers
   ---------------------------- 
   constant IMAGE_FRACTION_ADDR       : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(0,C_S_AXI_ADDR_WIDTH));
   constant AECMODE_ADDR              : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(4,C_S_AXI_ADDR_WIDTH));
   constant NB_BIN_ADDR               : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(8,C_S_AXI_ADDR_WIDTH));
   constant MSB_POS_ADDR              : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(12,C_S_AXI_ADDR_WIDTH));
   constant CLEARMEM_ADDR             : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(16,C_S_AXI_ADDR_WIDTH));
   constant HIST_UPPERCUMSUM_ADDR     : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(20,C_S_AXI_ADDR_WIDTH));
   constant HIST_LOWERBIN_ID_ADDR     : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(24,C_S_AXI_ADDR_WIDTH));
   constant HIST_LOWERCUMSUM_ADDR     : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(28,C_S_AXI_ADDR_WIDTH));
   constant HIST_EXPOSURETIME_ADDR    : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(32,C_S_AXI_ADDR_WIDTH));
   constant HIST_TIMESTAMP_ADDR       : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(36,C_S_AXI_ADDR_WIDTH));
   constant HIST_NB_PIXEL_ADDR        : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(40,C_S_AXI_ADDR_WIDTH));
   constant CUMSUM_ERROR_ADDR         : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(44,C_S_AXI_ADDR_WIDTH));
   constant IMAGE_FRACTION_FBCK_ADDR  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0) := std_logic_vector(to_unsigned(48,C_S_AXI_ADDR_WIDTH));
   
   signal uppercumsum_i          : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal lowerbin_id_i          : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal timestamp_i            : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal exposuretime_i         : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal lowercumsum_i          : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal imagefraction_fbck_i   : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal nb_pixel_i             : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
   signal error_s                : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);


   -- CLK and RESET
   constant clk160_per : time := 6.25 ns;
   constant clk100_per : time := 10 ns;
   
   -- CLK and RESET
   signal clk160_o : std_logic := '0';
   signal clk100_o : std_logic := '0';
   signal rstn_i : std_logic := '0';
   
   -- Data stream
   constant NB_PIXEL          : integer := 128;
   signal stream_val          : integer range 0 to AXI_STREAM_MAX_VAL;
   constant HDR_LEN_IN_BYTE   : integer := 256;
   constant HDR_ADDR_MAX      : integer := HDR_LEN_IN_BYTE / 4 - 1;  -- addr on 4 bytes and starts at 0
   signal exposuretime_o      : unsigned(AXI_STREAM_DATA_WIDTH-1 downto 0);
   
   -- Set values
   signal image_fraction_o : integer range 1 to NB_PIXEL;

begin
   -- Assign clock
   CLK160 <= clk160_o;
   CLK100 <= clk100_o;
   ARESETN <= rstn_i;
   
   --! Clock 160MHz generation
   CLK160_GEN: process(clk160_o)
   begin
      clk160_o <= not clk160_o after clk160_per/2;                          
   end process;

   --! Clock 100MHz generation
   CLK100_GEN: process(clk100_o)
   begin
      clk100_o <= not clk100_o after clk100_per/2;                          
   end process;

   --! Reset Generation
   RST_GEN : process
   begin          
      rstn_i <= '0';
      wait for 5 us;
      rstn_i <= '1'; 
      wait;
   end process;

   
   --! Stream simulation
   STREAM_PROCESS : process 
   begin
      --! Note: 1st execution of the process is ignored by histogram because clear_mem signal is kept high by CUMSUM block
   
      AXI_STREAM_MOSI.TVALID <= '0';
      AXI_STREAM_MOSI.TDATA <= (others => '0');
      AXI_STREAM_MOSI.TLAST <= '0';
      
      --Reset 
      wait until rstn_i = '1';
      wait for 1 us;
      
      ------------------------------------------
      -- AXI Stream function signature
      ------------------------------------------
      --procedure write_axis32 (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi32 );
      --procedure write_axis32_hdr (signal Clk : in std_logic; Value : in std_logic_vector; tlast : in std_logic; signal miso : in  t_axi4_stream_miso; signal mosi : out t_axi4_stream_mosi32 );
      
      stream_val <= 0;
      --stream_val <= AXI_STREAM_MAX_VAL;
      --stream_val <= (AXI_STREAM_MAX_VAL+1) / NB_PIXEL;
      exposuretime_o <= to_unsigned(0, AXI_STREAM_DATA_WIDTH);
      loop
         -- header loop
         for addr_cnt in 0 to HDR_ADDR_MAX loop
            
            case addr_cnt is
               when HDR_ADDR_MAX =>
                  -- Adjust tlast
                  write_axis32_hdr(clk160_o, std_logic_vector(to_unsigned(0, AXI_STREAM_DATA_WIDTH)), '1', AXI_STREAM_MISO, AXI_STREAM_MOSI);
                  exposuretime_o <= exposuretime_o + 1024;
               
               when to_integer(unsigned(ImageHeaderLengthAdd32)) =>
                  -- Send Image Header Length
                  write_axis32_hdr(clk160_o, std_logic_vector(to_unsigned(HDR_LEN_IN_BYTE, AXI_STREAM_DATA_WIDTH)), '0', AXI_STREAM_MISO, AXI_STREAM_MOSI);
                  
               when to_integer(unsigned(ExposureTimeAdd32)) =>
                  -- Send Exposure Time
                  write_axis32_hdr(clk160_o, std_logic_vector(exposuretime_o), '0', AXI_STREAM_MISO, AXI_STREAM_MOSI);
                  
               when others =>
                  -- Padding
                  write_axis32_hdr(clk160_o, std_logic_vector(to_unsigned(100, AXI_STREAM_DATA_WIDTH)), '0', AXI_STREAM_MISO, AXI_STREAM_MOSI);
            end case;
            wait for 5 ns;
         end loop;
         
         -- data loop
         for pxl_cnt in 1 to NB_PIXEL loop
            -- Adjust tlast if last pixel
            if pxl_cnt = NB_PIXEL then
               write_axis32(clk160_o, std_logic_vector(to_unsigned(stream_val, AXI_STREAM_DATA_WIDTH)), '1', AXI_STREAM_MISO, AXI_STREAM_MOSI);
               --stream_val <= stream_val + 16;
               stream_val <= 0;
            else
               write_axis32(clk160_o, std_logic_vector(to_unsigned(stream_val, AXI_STREAM_DATA_WIDTH)), '0', AXI_STREAM_MISO, AXI_STREAM_MOSI);
               stream_val <= stream_val + ((AXI_STREAM_MAX_VAL+1) / NB_PIXEL);
            end if;
            wait for 5 ns;
         end loop;
         
      end loop;
      
   end process STREAM_PROCESS;
   
   
   --! Random MISO Ctrl
   RANDOM <= '1';    --Change to '0' to deactivate Random MISO block
   FALL <= '1';
   
   --! µBlaze simulation
   MB_PROCESS : process 
      variable j : integer := 0;
   begin
      --Reset 
      wait until rstn_i = '1';
      wait for 1 us;
      
      ------------------------------------------
      -- AXI Lite function signatures
      ------------------------------------------
      --procedure write_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); Value : in std_logic_vector(31 downto 0);signal  miso : in  t_axi4_lite_miso;signal  mosi : out t_axi4_lite_mosi);
      --procedure read_axi_lite (signal Clk : in std_logic; Addr : in std_logic_vector(31 downto 0); signal miso : in  t_axi4_lite_miso; signal mosi : out t_axi4_lite_mosi;signal  ReadValue : out std_logic_vector(31 downto 0));
      
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, IMAGE_FRACTION_ADDR , std_logic_vector(to_unsigned(0,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
      wait for 5 ns;
      
      --START MB Process
      --Configure and start the AEC
      
      image_fraction_o <= 1;
      --image_fraction_o <= 10;
      --image_fraction_o <= 100;
      --image_fraction_o <= NB_PIXEL; 
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, IMAGE_FRACTION_ADDR , std_logic_vector(to_unsigned(image_fraction_o, C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
      wait for 5 ns; 
      wait until rising_edge(clk100_o);
      write_axi_lite(clk100_o, NB_BIN_ADDR , std_logic_vector(to_unsigned(128,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
      wait for 5 ns; 
      wait until rising_edge(clk100_o); 
      write_axi_lite(clk100_o, MSB_POS_ADDR , std_logic_vector(to_unsigned(3,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
      wait for 5 ns; 
      wait until rising_edge(clk100_o); 
      write_axi_lite(clk100_o, CLEARMEM_ADDR , std_logic_vector(to_unsigned(0,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
      wait for 5 ns; 
      wait until rising_edge(clk100_o); 
      write_axi_lite(clk100_o, AECMODE_ADDR , std_logic_vector(to_unsigned(1,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
      wait for 5 ns; 
      
      loop
         --wait for the interup then read
         wait until rising_edge(clk100_o);
         wait until (INTERUPT = '1');
         
         --reset values
         uppercumsum_i    <= (others => '0'); 
         lowerbin_id_i    <= (others => '0'); 
         timestamp_i      <= (others => '0'); 
         exposuretime_i   <= (others => '0'); 
         lowercumsum_i    <= (others => '0');
         imagefraction_fbck_i <= (others => '0');
         nb_pixel_i       <= (others => '0');
         error_s          <= (others => '0');
         
         --change image fraction for next cumsum
         image_fraction_o <= 100;
         wait until rising_edge(clk100_o);
         write_axi_lite(clk100_o, IMAGE_FRACTION_ADDR , std_logic_vector(to_unsigned(image_fraction_o, C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
         wait for 5 ns;
         
         wait for 5 ns;   
         wait until rising_edge(clk100_o);
         
         --READ axi register
         read_axi_lite(clk100_o, HIST_TIMESTAMP_ADDR , AXIL_MISO, AXIL_MOSI    , timestamp_i);
         wait until rising_edge(clk100_o);
         read_axi_lite (clk100_o, HIST_LOWERBIN_ID_ADDR , AXIL_MISO, AXIL_MOSI  ,lowerbin_id_i);
         wait until rising_edge(clk100_o);
         read_axi_lite (clk100_o, HIST_LOWERCUMSUM_ADDR , AXIL_MISO,AXIL_MOSI  , lowercumsum_i);
         wait until rising_edge(clk100_o);
         read_axi_lite (clk100_o, HIST_UPPERCUMSUM_ADDR , AXIL_MISO, AXIL_MOSI  ,uppercumsum_i);
         wait until rising_edge(clk100_o);
         read_axi_lite (clk100_o, HIST_NB_PIXEL_ADDR , AXIL_MISO, AXIL_MOSI     ,nb_pixel_i);
         wait until rising_edge(clk100_o);
         read_axi_lite (clk100_o, HIST_EXPOSURETIME_ADDR , AXIL_MISO,AXIL_MOSI, exposuretime_i);
         wait until rising_edge(clk100_o);
         read_axi_lite (clk100_o, CUMSUM_ERROR_ADDR , AXIL_MISO,AXIL_MOSI, error_s);
         wait until rising_edge(clk100_o);
         read_axi_lite (clk100_o, IMAGE_FRACTION_FBCK_ADDR , AXIL_MISO,AXIL_MOSI, imagefraction_fbck_i);
         wait until rising_edge(clk100_o);
         
         ASSERT (unsigned(nb_pixel_i) = to_unsigned(NB_PIXEL, C_S_AXI_DATA_WIDTH)) 
            report "Nb pixel in the histogram is not good" severity error;
         
         --Clear mem
         write_axi_lite(clk100_o, CLEARMEM_ADDR , std_logic_vector(to_unsigned(1,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
         wait for 5 ns;  
         wait until rising_edge(clk100_o);
         write_axi_lite(clk100_o, CLEARMEM_ADDR , std_logic_vector(to_unsigned(0,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
         wait for 5 ns;
         wait until rising_edge(clk100_o);         
         
         if j=3 then
            write_axi_lite(clk100_o, AECMODE_ADDR , std_logic_vector(to_unsigned(0,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
            wait for 1 ms;
            write_axi_lite(clk100_o, AECMODE_ADDR , std_logic_vector(to_unsigned(1,C_S_AXI_DATA_WIDTH)) ,AXIL_MISO ,AXIL_MOSI);
         end if;
         
         j := j+1;
      end loop;
      
   end process MB_PROCESS;


end rtl;
