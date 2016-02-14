

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

library v_ccm_v6_0;

entity axis_input_buffer is
  generic (
    C_AXIS_BUFFER_DEPTH          : integer := 16;
    C_AXIS_DATA_WIDTH            : integer := 32 );
  port(
    clk                 :  in STD_LOGIC; 
    ce                  :  in STD_LOGIC;
    sclr                :  in STD_LOGIC;
    -- AXI-Stream Slave input interface
    s_axis_tdata        :  in std_logic_vector( C_AXIS_DATA_WIDTH-1 downto 0 );
    s_axis_tvalid       :  in std_logic;
    s_axis_tlast        :  in std_logic;
    s_axis_tuser_sof    :  in std_logic;
    s_axis_tready       : out std_logic;
       
    -- output interface
    vid_data_out        : out std_logic_vector(C_AXIS_DATA_WIDTH-1 downto 0);
    vid_eol_out         : out std_logic; 
    vid_sof_out         : out std_logic; 
    vid_empty_out       : out std_logic;
    vid_re_in           :  in std_logic);
end axis_input_buffer;

architecture rtl of axis_input_buffer is
  signal axi_fifo_almost_full   : std_logic;
  signal axi_fifo_we            : std_logic;
  signal axi_fifo_d             : std_logic_vector(C_AXIS_DATA_WIDTH+1 downto 0);
  signal axi_fifo_q             : std_logic_vector(C_AXIS_DATA_WIDTH+1 downto 0);
  signal axi_fifo_tlast         : std_logic;
  signal vid_empty              : std_logic;
  signal vid_aempty             : std_logic;

  signal s_axis_tready_int      : std_logic;
 
  begin
  
    axi_fifo_d  <= s_axis_tuser_sof & s_axis_tlast & s_axis_tdata;
    axi_fifo_we <= ce and s_axis_tvalid and s_axis_tready_int and (not sclr);

    -- Write side s_axis_tready guarded with axi_fifo_almost_full
    process(clk) 
    begin
      if rising_edge(clk) then
        if(sclr = '1') then
          s_axis_tready_int <= '0';
        elsif (ce='1') then
          s_axis_tready_int <= not axi_fifo_almost_full;
        end if;
      end if;
    end process;
  
    U_AXIS_SYNC_FIFO: entity v_ccm_v6_0.synch_fifo
      generic map( 
        input_reg      => 0,
        dwidth         => C_AXIS_DATA_WIDTH+2, 
        depth          => C_AXIS_BUFFER_DEPTH,
        aempty_count   => 1, 
        afull_count    => 2, 
        mem_type       => "distributed" )
      port map (
        clk       => clk,
        sclr      => sclr,
        d         => axi_fifo_d,
        we        => axi_fifo_we,
        full      => open,
        afull     => axi_fifo_almost_full, 
        q         => axi_fifo_q,
        re        => vid_re_in,
        empty     => vid_empty,
        aempty    => vid_aempty,
        count     => open );

    vid_empty_out <= vid_empty or (vid_aempty and vid_re_in); --  and not vid_re_in ;
    vid_data_out  <= axi_fifo_q(axi_fifo_q'high-2 downto 0);
    vid_eol_out   <= axi_fifo_q(axi_fifo_q'high-1);
    vid_sof_out   <= axi_fifo_q(axi_fifo_q'high);      
    s_axis_tready <= s_axis_tready_int;

end rtl;
