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
use work.fb_testbench_pkg.all; 
use work.fbuffer_define.all;

entity stim is
   port(                                
      
      ARESETN : out STD_LOGIC;
            
      CLK_MB           : out std_logic;
      CLK_DATA         : out std_logic;
      CLK_DIN          : out std_logic;  
      
      MB_MISO          : in t_axi4_lite_miso;
      MB_MOSI          : out  t_axi4_lite_mosi;
         
         
      AXIS_MOSI : out t_axi4_stream_mosi64;     
      AXIS_MISO : in t_axi4_stream_miso


      );
end stim;

architecture stim of stim is

------------------- Constants definition -------------------------- 
-- Clocks frequency 
--constant CLK85_PERIOD : time := 11.764705882352941176470588235294 ns; 
constant CLK100_PERIOD : time := 10 ns; 
--constant CLK142_5_PERIOD : time := 7.0175438596491228070175438596491 ns; 
--constant CLK142_5_PERIOD : time := 10 ns; 
constant CLK85_PERIOD : time := 50 ns; 
constant CLK142_5_PERIOD : time := 10 ns; 

--IMAGE PARAM
constant FRAME_WIDTH : unsigned := to_unsigned(16,32);
constant FRAME_HEIGHT : unsigned := to_unsigned(4,32); --header included
constant FRAME_SIZE : unsigned := resize(FRAME_HEIGHT * FRAME_WIDTH,32);
constant IMG_DLY : unsigned := to_unsigned(10,32);
constant HDR_DLY : unsigned := to_unsigned(0,32);
constant FRAME_BYTE_SIZE    : unsigned(31 downto 0) := resize(FRAME_SIZE*2,32);

constant BUFFER_A_ADDR      : unsigned(31 downto 0) := resize(FRAME_BYTE_SIZE,32); 
constant BUFFER_B_ADDR      : unsigned(31 downto 0) := resize(2*FRAME_BYTE_SIZE,32);
constant BUFFER_C_ADDR      : unsigned(31 downto 0) := resize(3*FRAME_BYTE_SIZE,32);

constant HDR_PIX_SIZE       : unsigned(31 downto 0) := resize(FRAME_WIDTH*2,32); 
constant IMG_PIX_SIZE       : unsigned(31 downto 0) := resize(FRAME_SIZE - 2*(FRAME_WIDTH),32); 
constant LVAL_PAUSE_MIN     : unsigned(31 downto 0) := to_unsigned(0,32);
constant FVAL_PAUSE_MIN     : unsigned(31 downto 0) := to_unsigned(0,32); 

constant LVAL_PAUSE_MIN2     : unsigned(31 downto 0) := to_unsigned(5,32); 
constant NB_CFG_PARAM       : integer := 8; 


type  frame_gen_state_t is (Frame_Reset, transmit_hdr, hdr_delay_st ,transmit_img, img_delay_st);
signal frame_gen_state : frame_gen_state_t :=  Frame_Reset;
signal transmit : std_logic := '0';  
   
signal clk_mb_o : std_logic := '0';
signal clk_din_o : std_logic := '0';
signal clk_data_o : std_logic := '0';
signal rst_n : std_logic := '0';
  
signal cnt : unsigned(31 downto 0) ; 
signal frame_width_i : unsigned(31 downto 0) := FRAME_WIDTH;
signal frame_height_i : unsigned(31 downto 0) := FRAME_HEIGHT;
signal frame_size_i : unsigned(31 downto 0) :=  resize(FRAME_HEIGHT*FRAME_WIDTH,32);

signal pixel_index : unsigned(15 downto 0);
signal frame_index : unsigned(15 downto 0);
signal cfg_vector                : unsigned(NB_CFG_PARAM*32-1 downto 0);
signal cfg_i                     : frame_buffer_cfg_type;



begin  
   
   -- Assign clock
   CLK_DIN <= clk_din_o;
   CLK_DATA <= clk_data_o;
   CLK_MB <= clk_mb_o;

   ARESETN <= rst_n; 
   
   --! Output Clock generation 
   CLK_DIN_GENERATION: process(clk_din_o)
   begin
   clk_din_o <= not clk_din_o after CLK142_5_PERIOD/2;
   end process;
   
   CLK_DATA_GENERATION: process(clk_data_o)
   begin
   clk_data_o <= not clk_data_o after CLK85_PERIOD/2;
   end process;
   
   CLK_MB_GENERATION: process(clk_mb_o)
   begin
   clk_mb_o <= not clk_mb_o after CLK100_PERIOD/2;
   end process;

  frame_gen : process(clk_din_o)
   begin
      if rising_edge(clk_din_o) then 

         if rst_n = '0' then  
            frame_gen_state <=  Frame_Reset; 
            pixel_index <= (others => '0');
            frame_index <= (others => '0');
            cnt <= (others => '0');
            AXIS_MOSI.TDATA <= (others => '0');
            AXIS_MOSI.TVALID  <= '0';
            AXIS_MOSI.TLAST <= '0';
            AXIS_MOSI.TKEEP <= (others => '1');
            AXIS_MOSI.TDEST <= (others => '0');
            AXIS_MOSI.TUSER   <= (others => '0');
            AXIS_MOSI.TID     <= "0";
                    
         else   
            
            case frame_gen_state is   
            
                  when Frame_Reset =>
                     AXIS_MOSI.TDATA(15 downto 0) <= x"43" & x"54";    --TC
                     AXIS_MOSI.TDATA(31 downto 16) <= x"00" & x"01";   --XML_MINOR_VER & XML_MAJOR_VER
                     AXIS_MOSI.TDATA(47 downto 32) <= (others => '0'); --IMG_HDR_LEN & x"0000"
                     AXIS_MOSI.TDATA(63 downto 48) <= (others => '0');
                     AXIS_MOSI.TVALID  <= '0';
                     AXIS_MOSI.TLAST <= '0';
                     AXIS_MOSI.TKEEP <= (others => '1');
                     AXIS_MOSI.TDEST <= (others => '0');
                     AXIS_MOSI.TUSER   <= (others => '0');
                     AXIS_MOSI.TID     <= (others => '1');
                     frame_index <= to_unsigned(1,16);
                     pixel_index <= to_unsigned(4,16);
                     --pixel_index <= (others => '0');  
                     
                     if transmit = '1' then 
                        frame_gen_state <= transmit_hdr;
                        AXIS_MOSI.TVALID  <= '1';
                     else
                        frame_gen_state <= Frame_Reset;
                        
                     end if; 
                     
                  when transmit_hdr => 
                  
                     AXIS_MOSI.TVALID  <= '1';
                     
 
                  
                        if AXIS_MISO.TREADY = '1' then    
                           
                              
                           case pixel_index is 
                             when to_unsigned(0,16) => -- correspond to first half of 32 bit hdr
                                 AXIS_MOSI.TDATA(15 downto 0) <= x"43" & x"54";    --TC
                                 AXIS_MOSI.TDATA(31 downto 16) <= x"00" & x"01";   --XML_MINOR_VER & XML_MAJOR_VER
                                 AXIS_MOSI.TDATA(47 downto 32) <= (others => '0'); --IMG_HDR_LEN & x"0000"
                                 AXIS_MOSI.TDATA(63 downto 48) <= (others => '0');
                              
                              when to_unsigned(4,16) =>
                                 AXIS_MOSI.TDATA(15 downto 0) <= std_logic_vector(frame_index);
                                 AXIS_MOSI.TDATA(31 downto 16) <= (others => '0');
                                 AXIS_MOSI.TDATA(47 downto 32) <= (others => '0');
                                 AXIS_MOSI.TDATA(63 downto 48) <= (others => '0');
                              when to_unsigned(16,16) =>
                                 AXIS_MOSI.TDATA(31 downto 16) <= (others => '0');
                                 AXIS_MOSI.TDATA(15 downto 0) <= (others => '0');
                                 AXIS_MOSI.TDATA(47 downto 32) <= (others => '0');
                                 AXIS_MOSI.TDATA(63 downto 48) <= (others => '0'); 
                                 
                              when to_unsigned(128,16) =>
                                 AXIS_MOSI.TDATA(31 downto 16) <= (others => '0');
                                 AXIS_MOSI.TDATA(15 downto 0) <= (others => '0');
                                 AXIS_MOSI.TDATA(47 downto 32) <= (others => '0');
                                 AXIS_MOSI.TDATA(63 downto 48) <= (others => '0');
                                 
                              when others =>
                                 AXIS_MOSI.TDATA(15 downto 0)  <= std_logic_vector(pixel_index + 0);
                                 AXIS_MOSI.TDATA(31 downto 16) <= std_logic_vector(pixel_index + 1);
                                 AXIS_MOSI.TDATA(47 downto 32) <= std_logic_vector(pixel_index + 2);
                                 AXIS_MOSI.TDATA(63 downto 48) <= std_logic_vector(pixel_index + 3);              
                        end case;     
                        
                        pixel_index <= pixel_index + 4;
                        
                        if(pixel_index = frame_width_i*2-4) then  
                           cnt <= (others => '0');
                           AXIS_MOSI.TLAST <= '1';
                           if HDR_DLY > 0 then
                              frame_gen_state <= hdr_delay_st; 
                           else 
                              frame_gen_state <= transmit_img;
                           end if;
                           
                        else  
                           AXIS_MOSI.TLAST <= '0';
                           frame_gen_state <= transmit_hdr;
                        end if; 
                     end if;   
                        
                  when hdr_delay_st => 
                     AXIS_MOSI.TLAST <= '0';
                     AXIS_MOSI.TDATA <= (others => '0');
                     AXIS_MOSI.TVALID  <= '0'; 
                     AXIS_MOSI.TID     <= (others => '0');
                     
                     if cnt > HDR_DLY then
                        frame_gen_state <= transmit_img;
                     else
                        cnt <= cnt + 1;
                     end if;
                  
                  when transmit_img => 
                     
                     AXIS_MOSI.TVALID  <= '1';
                                 
                     if AXIS_MISO.TREADY = '1' then  
                        AXIS_MOSI.TID     <= (others => '0');
                        AXIS_MOSI.TDATA(15 downto 0)  <= std_logic_vector(pixel_index + 0);
                        AXIS_MOSI.TDATA(31 downto 16) <= std_logic_vector(pixel_index + 1);
                        AXIS_MOSI.TDATA(47 downto 32) <= std_logic_vector(pixel_index + 2);
                        AXIS_MOSI.TDATA(63 downto 48) <= std_logic_vector(pixel_index + 3);
                        pixel_index <= pixel_index + 4; 
                        
                        if pixel_index = frame_size_i-4 then
                           AXIS_MOSI.TLAST <= '1'; 
                        else
                           AXIS_MOSI.TLAST <= '0';
                        end if;
                        
                        
                        if pixel_index = frame_size_i then                             

                           frame_index <= frame_index + 1;
                           cnt <= to_unsigned(1,32);
                           AXIS_MOSI.TVALID  <= '0';
                           
                           if IMG_DLY > 0 then
                              frame_gen_state <= img_delay_st;
                           else   
                              
                              AXIS_MOSI.TDATA(15 downto 0) <= x"43" & x"54";    --TC
                              AXIS_MOSI.TDATA(31 downto 16) <= x"00" & x"01";   --XML_MINOR_VER & XML_MAJOR_VER
                              AXIS_MOSI.TDATA(47 downto 32) <= (others => '0'); --IMG_HDR_LEN & x"0000"
                              AXIS_MOSI.TDATA(63 downto 48) <= (others => '0');
                              AXIS_MOSI.TVALID  <= '0';
                              AXIS_MOSI.TLAST <= '0';
                              AXIS_MOSI.TKEEP <= (others => '1');
                              AXIS_MOSI.TDEST <= (others => '0');
                              AXIS_MOSI.TUSER   <= (others => '0');
                              AXIS_MOSI.TID     <= (others => '1');
                              pixel_index <= to_unsigned(4,16); 
                              
                              if transmit = '1' then 
                                 frame_gen_state <= transmit_hdr;
                                 AXIS_MOSI.TVALID  <= '1';
                              else
                                 frame_gen_state <= Frame_Reset;
                              end if;                                                

                           end if;
                        else  
                           frame_gen_state <= transmit_img;
                        end if; 
                     end if; 
                        
                  when img_delay_st =>
                     pixel_index <= to_unsigned(4,16);
                     AXIS_MOSI.TLAST <= '0';
                     AXIS_MOSI.TDATA(15 downto 0) <= x"43" & x"54";    --TC
                     AXIS_MOSI.TDATA(31 downto 16) <= x"00" & x"01";   --XML_MINOR_VER & XML_MAJOR_VER
                     AXIS_MOSI.TDATA(47 downto 32) <= (others => '0'); --IMG_HDR_LEN & x"0000"
                     AXIS_MOSI.TDATA(63 downto 48) <= (others => '0');
                     AXIS_MOSI.TVALID  <= '0'; 
                     AXIS_MOSI.TID     <= (others => '1');
                     if cnt >= IMG_DLY then
                        if transmit = '1' then 
                           AXIS_MOSI.TVALID  <= '1';
                           frame_gen_state <= transmit_hdr;
                        else
                           frame_gen_state <= Frame_Reset;
                        end if;
                         
                     else
                        cnt <= cnt + 1;
                     end if;
                     
                     
                  when others =>
                     frame_gen_state <= Frame_Reset;
               end case;
         end if;      
      end if;
   end process;
   
   
   
sim: process is
      
      variable start_pos : integer;
      variable end_pos   : integer;
      
   begin  
      rst_n <= '0';
      transmit <= '0';
      
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
      
      wait for 150 ns;
      rst_n <= '1';
      wait for 1 us; 
      
      frame_width_i  <= FRAME_WIDTH;
      frame_size_i   <= FRAME_SIZE;

      cfg_i.buffer_a_addr   <= BUFFER_A_ADDR;
      cfg_i.buffer_b_addr   <= BUFFER_B_ADDR;
      cfg_i.buffer_c_addr   <= BUFFER_C_ADDR;
      cfg_i.frame_byte_size <= FRAME_BYTE_SIZE; 
      cfg_i.hdr_pix_size    <= HDR_PIX_SIZE;
      cfg_i.img_pix_size    <= IMG_PIX_SIZE;
      cfg_i.lval_pause_min  <= LVAL_PAUSE_MIN;
      cfg_i.fval_pause_min  <= FVAL_PAUSE_MIN;
      wait for 150 ns;


      cfg_vector <= to_intf_cfg(cfg_i);  
      for ii in 0 to NB_CFG_PARAM-1 loop 
         wait until rising_edge(clk_mb_o);      
         start_pos := cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite(clk_mb_o, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      
      wait for 1 us;
      transmit <= '1'; 
      
      wait for 50 us;
      transmit <= '0';
      wait for 10 us;
      
      frame_width_i  <= resize(2*FRAME_WIDTH,32);
      frame_size_i   <= resize(2*FRAME_SIZE,32);
      wait for 100 ns; 
      cfg_i.buffer_a_addr   <= resize(2*BUFFER_A_ADDR,32);
      cfg_i.buffer_b_addr   <= resize(2*BUFFER_B_ADDR,32);
      cfg_i.buffer_c_addr   <= resize(2*BUFFER_C_ADDR,32);
      
      cfg_i.frame_byte_size <= resize(2*frame_size_i,32); 
      cfg_i.hdr_pix_size    <= resize(2*HDR_PIX_SIZE,32);
      cfg_i.img_pix_size    <= resize(2*IMG_PIX_SIZE,32);
      cfg_i.lval_pause_min  <= LVAL_PAUSE_MIN; 
      cfg_i.fval_pause_min  <= FVAL_PAUSE_MIN;
      
      wait for 100 ns;   
      
      cfg_vector <= to_intf_cfg(cfg_i);  
      for ii in 0 to NB_CFG_PARAM-1 loop 
         wait until rising_edge(clk_mb_o);      
         start_pos := cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite(clk_mb_o, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      wait for 100 ns;
      transmit <= '1'; 
      
      wait for 50 us;
      
      
     transmit <= '0';
      wait for 10 us;
      
      frame_width_i  <= resize(4*FRAME_WIDTH,32);
      frame_size_i   <= resize(4*FRAME_SIZE,32);
      wait for 100 ns; 
      cfg_i.buffer_a_addr   <= resize(4*BUFFER_A_ADDR,32);
      cfg_i.buffer_b_addr   <= resize(4*BUFFER_B_ADDR,32);
      cfg_i.buffer_c_addr   <= resize(4*BUFFER_C_ADDR,32);
      
      cfg_i.frame_byte_size <= resize(2*frame_size_i,32); 
      cfg_i.hdr_pix_size    <= resize(4*HDR_PIX_SIZE,32);
      cfg_i.img_pix_size    <= resize(4*IMG_PIX_SIZE,32);
      cfg_i.lval_pause_min  <= LVAL_PAUSE_MIN; 
      cfg_i.fval_pause_min  <= FVAL_PAUSE_MIN;
--      
--      frame_width_i  <= resize(FRAME_WIDTH,32);
--      frame_size_i   <= resize(FRAME_SIZE,32);
--      cfg_i.buffer_a_addr   <= BUFFER_A_ADDR;
--      cfg_i.buffer_b_addr   <= BUFFER_B_ADDR;
--      cfg_i.buffer_c_addr   <= BUFFER_C_ADDR;
--      cfg_i.frame_byte_size <= FRAME_BYTE_SIZE; 
--      cfg_i.hdr_pix_size    <= HDR_PIX_SIZE;
--      cfg_i.img_pix_size    <= IMG_PIX_SIZE;
--      cfg_i.lval_pause_min  <= LVAL_PAUSE_MIN;
      
      wait for 100 ns;   
      
      cfg_vector <= to_intf_cfg(cfg_i);  
      for ii in 0 to NB_CFG_PARAM-1 loop 
         wait until rising_edge(clk_mb_o);      
         start_pos := cfg_vector'length -1 - 32*ii;
         end_pos   := start_pos - 31;
         write_axi_lite(clk_mb_o, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
         wait for 30 ns;
      end loop; 
      wait for 100 ns;
      transmit <= '1'; 
   
      
--
--      
--      cfg_vector <= to_intf_cfg(cfg_i);  
--      for ii in 0 to NB_CFG_PARAM-1 loop 
--         wait until rising_edge(clk_mb_o);      
--         start_pos := cfg_vector'length -1 - 32*ii;
--         end_pos   := start_pos - 31;
--         write_axi_lite(clk_mb_o, std_logic_vector(to_unsigned(4*ii, 32)), std_logic_vector(cfg_vector(start_pos downto end_pos)), MB_MISO,  MB_MOSI);
--         wait for 30 ns;
--      end loop; 
--      wait for 100 ns;      
--      
--     

      
      wait;
      
      report "FCR written"; 
      report "END OF SIMULATION" 
      severity error;
   end process sim;   
   
   
 end;