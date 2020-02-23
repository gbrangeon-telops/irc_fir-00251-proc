library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.tel2000.all;

entity afpa_single_div_ip is
   port (
      aclk                   : IN STD_LOGIC;
      aresetn                : IN STD_LOGIC;
      
      s_axis_divisor_tvalid  : IN STD_LOGIC;
      s_axis_divisor_tready  : OUT STD_LOGIC;
      s_axis_divisor_tdata   : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
      
      s_axis_dividend_tvalid : IN STD_LOGIC;
      s_axis_dividend_tready : OUT STD_LOGIC;
      s_axis_dividend_tuser  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      s_axis_dividend_tlast  : IN STD_LOGIC;
      s_axis_dividend_tdata  : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
      
      m_axis_dout_tvalid     : OUT STD_LOGIC;
      m_axis_dout_tuser      : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      m_axis_dout_tlast      : OUT STD_LOGIC;
      m_axis_dout_tdata      : OUT STD_LOGIC_VECTOR(39 DOWNTO 0)
      );
end afpa_single_div_ip;


architecture sim of afpa_single_div_ip is 
   
   
   
begin   
   
   s_axis_divisor_tready <= '1';
   s_axis_dividend_tready <= '1';
   
   U1: process(aclk)
   begin
      if rising_edge(aclk) then
         if s_axis_dividend_tvalid = '1' then
            if to_integer(signed(s_axis_divisor_tdata)) /= 0 then
               m_axis_dout_tdata  <=  resize(std_logic_vector(to_signed(to_integer(signed(s_axis_dividend_tdata)) / to_integer(signed(s_axis_divisor_tdata)), 18)), 40);
            else
               m_axis_dout_tdata  <=  std_logic_vector(resize(signed(s_axis_dividend_tdata), 40));
            end if;
         end if;
         m_axis_dout_tvalid <= s_axis_dividend_tvalid;
         m_axis_dout_tuser  <= s_axis_dividend_tuser;
         m_axis_dout_tlast <= s_axis_dividend_tlast;
         
      end if;        
   end process;
   
   
end sim;
