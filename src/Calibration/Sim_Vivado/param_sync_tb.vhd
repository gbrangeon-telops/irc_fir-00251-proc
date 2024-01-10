library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.all;
use IEEE.MATH_REAL.ALL;

library work;
use work.TEL2000.all;

-- impure function rand_slv(len : integer) return std_logic_vector is
--   variable r : real;
--   variable slv : std_logic_vector(len - 1 downto 0);
--   variable seed1, seed2 : integer := 999;
-- begin
--   for i in slv'range loop
--     uniform(seed1, seed2, r);
--     slv(i) := '1' when r > 0.5 else '0';
--   end loop;
--   return slv;
-- end function;

entity param_sync_tb is
    generic (
        FORCE_SYNC : boolean := false
    );
end param_sync_tb;

architecture TB_ARCHITECTURE of param_sync_tb is
    component param_sync_to_axis32
        generic (
            -- Input width. Output MSBs are padded with 0's up to 32-bit
            PARAM_WIDTH     : integer range 1 to 32 := 32;
            -- Number of parameters that can be received simultaneously.
            PARAM_FIFO_SIZE : integer range 2 to 8 := 3;
            -- FORCE_SYNC = true force la synchronisation du flux AXIS de sortie au flux SYNC (TVALID/TREADY en même temps)
            -- FORCE_SYNC = false gère les liens axis séparément avec une latence de 2 clock entre sync et axis.
            -- FORCE_SYNC = true utilise moins de ressources FPGA mais ignore AXIS_MISO.TREADY en supposant qu'il sera toujours ready lorsque SYNC_MISO.TREADY=1 (paramètre prêt en premier requis pour garantir la synchronisation)
            FORCE_SYNC    : boolean := true
        );
        port(
            ARESET        : in std_logic;
            CLK_DATA      : in std_logic;      

            PARAM_IN_DATA : in std_logic_vector(PARAM_WIDTH-1 downto 0);
            PARAM_IN_VLD  : in std_logic;

            SYNC_MOSI     : in t_axi4_stream_mosi32;
            SYNC_MISO     : in t_axi4_stream_miso;

            AXIS_MOSI     : out t_axi4_stream_mosi32;
            AXIS_MISO     : in t_axi4_stream_miso;

            -- Overflow error
            ERR           : out std_logic
        );
    end component;
    
    component axis32_randommiso
        generic(
          random_seed : std_logic_vector(3 downto 0) := x"1");
       
       port(     
          RX_MOSI  : in  t_axi4_stream_mosi32; 
          RX_MISO  : out t_axi4_stream_miso;
          
          TX_MOSI  : out t_axi4_stream_mosi32;
          TX_MISO  : in  t_axi4_stream_miso; 
          
          RANDOM   : in  std_logic;
          FALL     : in  std_logic;
          
          ARESET   : in  std_logic;
          CLK      : in  std_logic
          );
    end component;  
    
    constant CLK_PERIOD : time := 10 ns;

    signal CLK : std_logic := '0';
    signal ARESET   : std_logic := '0';
    
    signal param_data       : std_logic_vector(31 downto 0) := (others => '0');
    signal param_vld        : std_logic := '0';
    signal data_in_mosi     : t_axi4_stream_mosi32;
    signal data_in_miso     : t_axi4_stream_miso;
    signal axis_param_mosi  : t_axi4_stream_mosi32;
    signal axis_param_miso  : t_axi4_stream_miso;
    
    signal dataCount  : integer := 0;
    signal axisCount  : integer := 0;

begin

   -- reset
   process
   begin
      ARESET <= '1'; 
      wait for 250 ns;
      ARESET <= '0';
      wait;
   end process;

   -- clk
   process(CLK)
   begin
      CLK <= not CLK after CLK_PERIOD/2; 
   end process;
   
   process
   begin
      data_in_mosi.TVALID <= '0';
      data_in_mosi.TLAST <= '0';
      if FORCE_SYNC then
       -- axis_param_miso.TREADY <= '1';
      end if;
      wait until ARESET = '0';
      data_in_mosi.TVALID <= '1';
      wait for 100 ns;
      wait until falling_edge(CLK);
      param_data <= x"A5A54242";
      param_vld <= '1';
      wait until falling_edge(CLK);
      param_vld <= '0';
      wait for 1000 ns;
      wait until falling_edge(CLK);
      param_data <= x"01234567";
      param_vld <= '1';
      wait until falling_edge(CLK);
      param_vld <= '0';
      wait for 100 ns;
      wait until falling_edge(CLK);
      data_in_mosi.TLAST <= '1';
      wait until rising_edge(CLK) and data_in_miso.TREADY='1';
      wait until falling_edge(CLK);
      data_in_mosi.TLAST <= '0';
      wait for 500 ns;
      wait until falling_edge(CLK);
      data_in_mosi.TLAST <= '1';
      wait until rising_edge(CLK) and data_in_miso.TREADY='1';
      wait until falling_edge(CLK);
      data_in_mosi.TLAST <= '0';
      wait for 200 ns;
      wait until falling_edge(CLK);
      param_data <= x"98765432";
      param_vld <= '1';
      wait until falling_edge(CLK);
      param_vld <= '0';
      wait for 500 ns;
      wait until falling_edge(CLK);
      data_in_mosi.TLAST <= '1';
      wait until rising_edge(CLK) and data_in_miso.TREADY='1';
      wait until falling_edge(CLK);
      data_in_mosi.TLAST <= '0';
      wait for 200 ns;
      
   end process;
   
   counters: process(CLK)
    variable dataCounter  : integer := 0;
    variable axisCounter  : integer := 0;
   begin
     if ARESET = '1' then
        dataCounter := 0;
        axisCounter := 0;
     elsif rising_edge(CLK) then
       if data_in_mosi.TVALID='1' and data_in_miso.TREADY='1' then
         dataCounter := dataCounter + 1;
         if data_in_mosi.TLAST='1' then
           dataCount <= dataCounter;
         end if;
       end if;

       if axis_param_mosi.TVALID='1' and axis_param_miso.TREADY='1' then
         axisCounter := axisCounter + 1;
         if axis_param_mosi.TLAST='1' then
           axisCount <= axisCounter;
         end if;
       end if;
     end if;
   end process;
   
   -- param to axis
   U0 : param_sync_to_axis32
    generic map(
        PARAM_WIDTH     => 32,
        PARAM_FIFO_SIZE => 3,
        FORCE_SYNC      => FORCE_SYNC
    )
    port map(
        ARESET        => ARESET,
        CLK_DATA      => CLK,

        PARAM_IN_DATA => param_data,
        PARAM_IN_VLD  => param_vld,

        SYNC_MOSI     => data_in_mosi,
        SYNC_MISO     => data_in_miso,

        AXIS_MOSI     => axis_param_mosi,
        AXIS_MISO     => axis_param_miso,

        ERR           => open
    );
   
   -- TREADY
   U1a : axis32_randommiso
     generic map(
       random_seed => "1010" --rand_slv(4)
     )
     port map(
      ARESET   => ARESET,
      CLK      => CLK,

      RX_MOSI  => data_in_mosi,
      RX_MISO  => data_in_miso,
      
      TX_MOSI  => open,
      TX_MISO  => data_in_miso,
      
      RANDOM   => '1',
      FALL     => '1'
      
     );

   genAxisRnd: if FORCE_SYNC = false generate
       U1b : axis32_randommiso
         generic map(
           random_seed => "0101" --rand_slv(4)
         )
         port map(
          ARESET   => ARESET,
          CLK      => CLK,
    
          RX_MOSI  => axis_param_mosi,
          RX_MISO  => axis_param_miso,
          
          TX_MOSI  => open,
          TX_MISO  => data_in_miso,
          
          RANDOM   => '0',
          FALL     => '1'
          
         );
   end generate genAxisRnd;

end TB_ARCHITECTURE; -- param_sync_tb

