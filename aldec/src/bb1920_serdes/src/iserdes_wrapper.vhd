
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity iserdes_wrapper is
   
   generic(
      IOBDELAY       : STRING  := "NONE";   -- "IBUF" or "NONE"
      DATA_WIDTH     : INTEGER := 7         -- Q8 est open si DATA_WIDTH = 7
      );
   
   port (
      BITSLIP  : in STD_ULOGIC;
      CLK      : in STD_ULOGIC;
      CLKB     : in STD_ULOGIC;
      CLKDIV   : in STD_ULOGIC;
      D        : in STD_ULOGIC;
      DDLY     : in STD_ULOGIC;
      RST      : in STD_ULOGIC;
      O        : out STD_ULOGIC;
      Q1       : out STD_ULOGIC;
      Q2       : out STD_ULOGIC;
      Q3       : out STD_ULOGIC;
      Q4       : out STD_ULOGIC;
      Q5       : out STD_ULOGIC;
      Q6       : out STD_ULOGIC;
      Q7       : out STD_ULOGIC;
      Q8       : out STD_ULOGIC
      );
end iserdes_wrapper;

architecture rtl of iserdes_wrapper is
   
   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   signal sreset : std_ulogic := '0';
   
   signal q_reg_s, q_reg_out, q_reg_old : std_ulogic_vector(7 downto 0) := (others => '0');
   signal q_reg_slip : std_ulogic_vector(15 downto 0) := (others => '0');
   
   signal bitslip_dir : std_ulogic := '0';
   
   signal data_in : std_ulogic;
   signal d_i, ddly_i : std_ulogic;
   
   signal slip_pos : integer range 0 to 7 := 0;
   
begin
   
   
   ----------------------------------
   --   outputs
   ----------------------------------
   Q8 <= q_reg_out(7);
   Q7 <= q_reg_out(6);
   Q6 <= q_reg_out(5);
   Q5 <= q_reg_out(4);
   Q4 <= q_reg_out(3);
   Q3 <= q_reg_out(2);
   Q2 <= q_reg_out(1);
   Q1 <= q_reg_out(0);
   
   ----------------------------------
   --   reset
   ----------------------------------
   U0 : sync_reset
   port map (
      clk => CLKDIV,
      areset => RST,
      sreset => sreset);
   
   d_i     <= D;
   ddly_i  <= DDLY;   
   
   ----------------------------------
   --  IFD
   ----------------------------------
   ifd_case : if IOBDELAY = "IFD" generate
      data_in <= ddly_i;
      O <= d_i;
   end generate;
   both_case : if IOBDELAY = "BOTH" generate
      data_in <= ddly_i;
      O <= ddly_i;
   end generate;
   ibuf_case : if IOBDELAY = "IBUF" generate
      data_in <= d_i;
      O <= ddly_i;
   end generate;
   none_case : if IOBDELAY = "NONE" generate
      data_in <= d_i;
      O <= d_i;
   end generate;
   
   ----------------------------------
   --  deserializer
   ----------------------------------   
   U1 : process(CLKB, CLK)
   begin
      if rising_edge(CLK) or rising_edge(CLKB) then
         q_reg_slip <= q_reg_slip(q_reg_slip'length-2 downto 0) & data_in;
      end if;
   end process;
   
   ----------------------------------
   --  outputs
   ----------------------------------
   U2 : process(CLKDIV)
   begin
      if rising_edge(CLKDIV) then
         if sreset = '1' then
            q_reg_out <= (others => '0');
         else
            q_reg_out <= q_reg_slip(slip_pos+7 downto slip_pos);
         end if;
      end if;
   end process;
   
   -- simulate the DDR-mode bitslip process. The parallel data becomes ready on the 3rd clk event 
   -- following the sampling of the bitslip signal
   -- see p.158, http://www.xilinx.com/support/documentation/user_guides/ug471_7Series_SelectIO.pdf
   U3 : process(CLKDIV)
      variable state : integer range 0 to 4 := 4;
   begin
      if rising_edge(CLKDIV) then
         if sreset = '1' then
            bitslip_dir <= '0';
            state := 4;
            slip_pos <= 0;
         else
            if bitslip = '1' then
               state := 0;
            end if;
            
            if state <= 2 then
               if state = 2 then
                  if bitslip_dir = '0' then
                     slip_pos <= slip_pos + 1;
                  else
                     if slip_pos >= 3 then
                        slip_pos <= slip_pos - 3;
                     else
                        slip_pos <= 5 + slip_pos; -- 8-(3-slip_pos)
                     end if;
                  end if;
                  bitslip_dir <= not bitslip_dir;
               end if;
               
               state := state + 1;
            end if;
         end if;
      end if;
   end process;
   
end rtl;


