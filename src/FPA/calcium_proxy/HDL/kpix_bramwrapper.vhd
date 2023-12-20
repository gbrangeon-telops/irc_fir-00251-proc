----------------------------------------------------------------------------------
-- Company: Telops
-- Engineer: ALA
-- 
-- Create Date: 12/06/2023 02:32:13 PM
-- Design Name: FIR-00251-Proc
-- Module Name: kpix_bramwrapper - Behavioral
-- Project Name: Senseeker
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.MATH_REAL.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;
library XPM;
use XPM.VComponents.all;

entity kpix_bramwrapper is
    Generic (
        DETECTOR_WIDTH  : positive                := 640;
        DETECTOR_HEIGHT : positive                := 512;
        KPIX_LENGTH     : positive range 12 to 13 := 12
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        wdata : in  std_logic_vector(2*KPIX_LENGTH-1 downto 0);
        waddr : in  std_logic_vector(integer(ceil(log2(real(DETECTOR_WIDTH*DETECTOR_HEIGHT/2))))-1 downto 0);
        wena  : in  std_logic;
        rdata : out std_logic_vector(4*KPIX_LENGTH-1 downto 0);
        raddr : in  std_logic_vector(integer(ceil(log2(real(DETECTOR_WIDTH*DETECTOR_HEIGHT/4))))-1 downto 0);
        rena  : in  std_logic
    );
end kpix_bramwrapper;

architecture Behavioral of kpix_bramwrapper is
   signal wena_i : std_logic_vector(0 downto 0);
begin
   wena_i(0) <= wena;
   
   -- xpm_memory_sdpram: Simple Dual Port RAM
   -- Xilinx Parameterized Macro, version 2018.3

   xpm_memory_sdpram_inst : xpm_memory_sdpram
   generic map (
      ADDR_WIDTH_A => waddr'LENGTH,    -- DECIMAL
      ADDR_WIDTH_B => raddr'LENGTH,    -- DECIMAL
      AUTO_SLEEP_TIME => 0,            -- DECIMAL
      BYTE_WRITE_WIDTH_A => wdata'LENGTH, -- DECIMAL
      CLOCKING_MODE => "common_clock", -- String
      ECC_MODE => "no_ecc",            -- String
      MEMORY_INIT_FILE => "none",      -- String
      MEMORY_INIT_PARAM => "0",        -- String
      MEMORY_OPTIMIZATION => "true",   -- String
      MEMORY_PRIMITIVE => "block",     -- String
      MEMORY_SIZE => DETECTOR_WIDTH*DETECTOR_HEIGHT*KPIX_LENGTH, -- DECIMAL
      MESSAGE_CONTROL => 0,            -- DECIMAL
      READ_DATA_WIDTH_B => rdata'LENGTH, -- DECIMAL
      READ_LATENCY_B => 2,             -- DECIMAL
      READ_RESET_VALUE_B => "0",       -- String
      --RST_MODE_A => "SYNC",            -- String
      --RST_MODE_B => "SYNC",            -- String
      USE_EMBEDDED_CONSTRAINT => 0,    -- DECIMAL
      USE_MEM_INIT => 0,               -- DECIMAL
      WAKEUP_TIME => "disable_sleep",  -- String
      WRITE_DATA_WIDTH_A => wdata'LENGTH, -- DECIMAL
      WRITE_MODE_B => "no_change"      -- String
   )
   port map (
      dbiterrb => open,                 -- 1-bit output: Status signal to indicate double bit error occurrence
                                        -- on the data output of port B.

      doutb => rdata,                   -- READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
      sbiterrb => open,                 -- 1-bit output: Status signal to indicate single bit error occurrence
                                        -- on the data output of port B.

      addra => waddr,                   -- ADDR_WIDTH_A-bit input: Address for port A write operations.
      addrb => raddr,                   -- ADDR_WIDTH_B-bit input: Address for port B read operations.
      clka => clk,                      -- 1-bit input: Clock signal for port A. Also clocks port B when
                                        -- parameter CLOCKING_MODE is "common_clock".

      clkb => clk,                      -- 1-bit input: Clock signal for port B when parameter CLOCKING_MODE is
                                        -- "independent_clock". Unused when parameter CLOCKING_MODE is
                                        -- "common_clock".

      dina => wdata,                    -- WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
      ena => wena,                      -- 1-bit input: Memory enable signal for port A. Must be high on clock
                                        -- cycles when write operations are initiated. Pipelined internally.

      enb => rena,                      -- 1-bit input: Memory enable signal for port B. Must be high on clock
                                        -- cycles when read operations are initiated. Pipelined internally.

      injectdbiterra => '0',            -- 1-bit input: Controls double bit error injection on input data when
                                        -- ECC enabled (Error injection capability is not available in
                                        -- "decode_only" mode).

      injectsbiterra => '0',            -- 1-bit input: Controls single bit error injection on input data when
                                        -- ECC enabled (Error injection capability is not available in
                                        -- "decode_only" mode).

      regceb => '1',                    -- 1-bit input: Clock Enable for the last register stage on the output
                                        -- data path.

      rstb => rst,                      -- 1-bit input: Reset signal for the final port B output register
                                        -- stage. Synchronously resets output port doutb to the value specified
                                        -- by parameter READ_RESET_VALUE_B.

      sleep => '0',                     -- 1-bit input: sleep signal to enable the dynamic power saving feature.
      wea => wena_i                     -- WRITE_DATA_WIDTH_A-bit input: Write enable vector for port A input
                                        -- data port dina. 1 bit wide when word-wide writes are used. In
                                        -- byte-wide write configurations, each bit controls the writing one
                                        -- byte of dina to address addra. For example, to synchronously write
                                        -- only bits [15-8] of dina when WRITE_DATA_WIDTH_A is 32, wea would be
                                        -- 4'b0010.

   );

   -- End of xpm_memory_sdpram_inst instantiation
end Behavioral;
