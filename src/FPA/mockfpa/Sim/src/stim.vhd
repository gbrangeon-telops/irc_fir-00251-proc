-------------------------------------------------------------------------------
--
-- Title       : axis_lane_stim
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
use work.tel2000.all; 
use work.fpa_define.all;
use work.fpa_common_pkg.all;
use work.Proxy_define.all; 
use work.mock_fpa_testbench_pkg.all; 


entity stim is               
end stim;

architecture TB_ARCHITECTURE of stim is

component Top 
      port(
         ARESETN        : in std_logic;
         CLK_100M       : in std_logic;
         

         -- temps d'intégration
         FPA_EXP_INFO   : in exp_info_type;
		 
         -- header part
         HDER_MOSI      : out t_axi4_lite_mosi;
         HDER_MISO      : in t_axi4_lite_miso;  
         

         XTRA_TRIG		: in std_logic;
		 ACQ_TRIG		: in std_logic;
         -- microblaze CLK
         MB_MISO        : out t_axi4_lite_miso;
         MB_MOSI        : in  t_axi4_lite_mosi

         );
end component; 
	-------------------Sim params---------------------------------------
    constant FRAME_RATE        : real                  := 50000.0; -- in Hz	
    constant EXP_TIME          : real                  := 1.0;	-- in us
    constant HEIGHT            : unsigned(31 downto 0) := to_unsigned(2,32); 
    constant WIDTH             : unsigned(31 downto 0) := to_unsigned(128,32);	
    --constant WIDTH             : real                  := 128.0;
-----------------------------------------------------------------------

    constant SIM_CLK_PERIOD_NS : time    := 10 ns;
    --constant XSIZE_DIV_TAP_NUM : unsigned(31 downto 0) := to_unsigned(integer(WIDTH/16.0),32);  

       
    signal ARESETN             : std_logic;
    signal CLK_100M            : std_logic := '0';
    signal FPA_EXP_INFO	       : exp_info_type;	
    signal HDER_MOSI	       : t_axi4_lite_mosi;
    signal HDER_MISO	       : t_axi4_lite_miso;  
    signal MB_MOSI             : t_axi4_lite_mosi;
    signal MB_MISO             : t_axi4_lite_miso;
    signal ACQ_TRIG            : std_logic;
    signal XTRA_TRIG           : std_logic;
    
    type trig_sm_type   is (idle, trig_gen);
    signal trig_sm             : trig_sm_type := idle;
    signal trig_period         : integer := to_integer(sec_to_clks(real(1.0/FRAME_RATE)));
    signal trig_duration       : integer := 3;
    signal cnt                 : integer := 0;
    signal acq_trig_i          : std_logic;
    signal xtra_trig_i         : std_logic;



begin

   ACQ_TRIG <= acq_trig_i;	
   XTRA_TRIG <= xtra_trig_i;	 
   xtra_trig_i <= '0';
   
   U1A: process(CLK_100M)
   begin
   CLK_100M <= not CLK_100M after SIM_CLK_PERIOD_NS/2; 
   end process;
  
     -- Unit Under Test port map
   UUT : Top 
   port map (
      ARESETN => ARESETN,
      CLK_100M => CLK_100M,
      FPA_EXP_INFO => FPA_EXP_INFO, 
  HDER_MOSI => HDER_MOSI,
      HDER_MISO => HDER_MISO,
      XTRA_TRIG => XTRA_TRIG, 
      ACQ_TRIG =>  ACQ_TRIG,
      MB_MOSI => MB_MOSI,
      MB_MISO => MB_MISO
      );
      
   ublaze_sim: process is
   begin  
       
      ARESETN <= '0';
      
      MB_MOSI.awaddr <= (others => '0');
      MB_MOSI.awprot <= (others => '0');
      MB_MOSI.wdata <= (others => '0');
      MB_MOSI.wstrb <= (others => '0');
      MB_MOSI.araddr <= (others => '0');
      MB_MOSI.arprot <= (others => '0');
      MB_MOSI.awvalid <= '0';
      MB_MOSI.wvalid <= '0';
      MB_MOSI.bready <= '0';
      MB_MOSI.arvalid <= '0';
      MB_MOSI.rready <= '0';  
  
      HDER_MISO.AWREADY <= '1';   
      HDER_MISO.WREADY <= '1';
      HDER_MISO.BVALID <= '1';
      HDER_MISO.BRESP <= AXI_OKAY;
      HDER_MISO.ARREADY <= '0';
      HDER_MISO.RVALID <= '0';
      HDER_MISO.RDATA <= (others=>'0');
      HDER_MISO.RRESP <= (others=>'0');
      
      -- Initialisation du feedback de temps d'exposition
      FPA_EXP_INFO.exp_dval <= '0';
      FPA_EXP_INFO.exp_time <= resize(sec_to_clks(real(EXP_TIME)/1000000.0), FPA_EXP_INFO.exp_time'length);
      FPA_EXP_INFO.exp_indx <= (others =>'0'); 
      
      wait for 100 ns; 
      wait until rising_edge(CLK_100M); 
      
      wait for 100 ns; 
      wait until rising_edge(CLK_100M);
      
      ARESETN <= '1';  
      wait for 1 us; 
      wait until rising_edge(CLK_100M);
      
--//	  write_axi_lite (CLK_100M, resize(X"000",32), (others => '0'), MB_MISO,  MB_MOSI); -- user_cfg_in_progress = 1
--      wait for 150 ns;
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"014",32), std_logic_vector(FPA_EXP_INFO.exp_time), MB_MISO,  MB_MOSI); -- fpa_spare 
      wait for 150 ns;
----------------------------------------------------------------------------------------------------
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"000",32), (others => '0'), MB_MISO,  MB_MOSI);		   --dval  
      wait for 150 ns;
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"004",32), resize(X"1",32), MB_MISO,  MB_MOSI); 	   --stalled_cnt                         
      wait for 150 ns;
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"008",32), resize(X"1",32), MB_MISO,  MB_MOSI);		   --valid_cnt                           
      wait for 150 ns;
      wait until rising_edge(CLK_100M);	
      write_axi_lite (CLK_100M, resize(X"02C",32),STD_LOGIC_VECTOR(WIDTH) , MB_MISO,  MB_MOSI); 	   --width   
      wait for 150 ns;
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"01C",32), resize(X"A",32), MB_MISO,  MB_MOSI);		   --lval_pause_min                      
      wait for 150 ns;	
      wait until rising_edge(CLK_100M);	
      write_axi_lite (CLK_100M, resize(X"020",32), resize(X"3",32), MB_MISO,  MB_MOSI); 	   --fval_pause_min 
      wait for 150 ns;	
      wait until rising_edge(CLK_100M);	
      write_axi_lite (CLK_100M, resize(X"000",32), (others => '1'), MB_MISO,  MB_MOSI);		   --dval				  
      wait for 150 ns;	
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"028",32), std_logic_vector(HEIGHT), MB_MISO,  MB_MOSI); -- diag.ysize 
      wait for 150 ns; 
      wait until rising_edge(CLK_100M);	
      -----------------------------------------------------------------------------------------------------
      write_axi_lite (CLK_100M, resize(X"02C",32), std_logic_vector(WIDTH), MB_MISO,  MB_MOSI); -- diag.xsize_div_tapnum 
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"154",32), (others => '0'), MB_MISO,  MB_MOSI); -- int_time_offset_mclk = 0 us
      wait for 150 ns;
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"158",32), (others => '0'), MB_MISO,  MB_MOSI); -- user_cfg_in_progress = 0
      wait for 150 ns;
      wait until rising_edge(CLK_100M);	
      write_axi_lite (CLK_100M, resize(X"D00",32), (others => '0'), MB_MISO,  MB_MOSI); 
      wait for 150 ns;
      wait until rising_edge(CLK_100M);
      write_axi_lite (CLK_100M, resize(X"D1C",32), (others => '0'), MB_MISO,  MB_MOSI); 
      wait for 150 ns;
      wait until rising_edge(CLK_100M);
      
      -- Exposure time config
      FPA_EXP_INFO.exp_dval <= '1';
      wait for 30 ns;
      FPA_EXP_INFO.exp_dval <= '0';
      
      wait;
      report "FCR written"; 
      
      report "END OF SIMULATION" 
      severity error;
   end process ublaze_sim;   
 

   -- Trigger generator
   U2: process(CLK_100M)
   begin
      if rising_edge(CLK_100M) then
         
         if ARESETN = '0' then
            cnt <= 0;
            trig_sm <= trig_gen; 
            acq_trig_i <= '0';
         else

            case trig_sm  is 
               
               when idle  => 
               
                  if cnt < (trig_period - trig_duration) then 
                     cnt <= cnt + 1;
                     trig_sm <= idle;
                  else
                     cnt <= 0; 
                     trig_sm <= trig_gen;
                  end if;
   
               when trig_gen  =>
                  if cnt < 3 then 
                    acq_trig_i <= '1';
                    cnt <= cnt + 1;
                    trig_sm <= trig_gen;
                  else
                    cnt <= 0;
                    acq_trig_i <= '0';
                    trig_sm <= idle;
                  end if;
      
               when others =>
            
            end case;  
         end if;
         
      end if;
      
   end process;
   
   
end TB_ARCHITECTURE; 

configuration TESTBENCH_FOR_STIM of stim is
   for TB_ARCHITECTURE
      for UUT : Top
         use entity work.Top(sch);
      end for;
   end for;

 end TESTBENCH_FOR_STIM;