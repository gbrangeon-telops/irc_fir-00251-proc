library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.FPA_Define.all; 
use work.Proxy_define.all;
use work.tel2000.all;


entity scd_proxy_cropping is
   port(
      ARESET         : in std_logic;
      CLK            : in std_logic;
      
      RX_MOSI        : in t_axi4_stream_mosi64;
      RX_MISO        : out t_axi4_stream_miso;
      
      TX_MOSI        : out t_axi4_stream_mosi64;
      TX_MISO        : in t_axi4_stream_miso;
      
      FPA_INTF_CFG   : in fpa_intf_cfg_type
      
      );
end scd_proxy_cropping;

architecture rtl of scd_proxy_cropping is
   
   component sync_reset
      port (
         ARESET : in STD_LOGIC;
         CLK    : in STD_LOGIC;
         SRESET : out STD_LOGIC := '1'
         );
   end component;
   
   signal sreset       : std_logic; 
   signal pix_i        : unsigned(8 downto 0);  
   signal tlast_i      : std_logic; 
   
   type mosi_pipe_type is array (0 to 1) of t_axi4_stream_mosi64;
   signal pix_mosi_pipe               : mosi_pipe_type;
   signal eol_data_reg                : std_logic_vector(63 downto 0);
   signal eol_dval_reg                : std_logic; 
   signal last_full_line_transaction  : std_logic;
   signal sample_valid_set1           : std_logic;
   signal sample_valid_set2           : std_logic;
   
   constant FULL_LINE_CNT : integer := XSIZE_MAX/4;       -- Nombre de transaction axistream (4 pix de large) pour une ligne complète.
   --constant FULL_LINE_CNT : integer := 16;       -- Nombre de transaction axistream (4 pixels de large) pour une ligne complète.
  
    
       
     attribute dont_touch           : string;
     attribute dont_touch of FPA_INTF_CFG             : signal is "true";
     attribute dont_touch of pix_mosi_pipe                             : signal is "true";
     attribute dont_touch of pix_i                                     : signal is "true";
     attribute dont_touch of sample_valid_set1                                     : signal is "true";
     attribute dont_touch of sample_valid_set2                                     : signal is "true";
     attribute dont_touch of last_full_line_transaction                                     : signal is "true";

     attribute dont_touch of eol_data_reg                                     : signal is "true";

     attribute dont_touch of eol_dval_reg                                     : signal is "true";

            
begin
   
   TX_MOSI <= pix_mosi_pipe(1);
   RX_MISO <= TX_MISO; 
   
   
   ------------------------------------------------------
   -- Sync reset
   ------------------------------------------------------
   U1 : sync_reset
   port map(
      ARESET => ARESET,
      CLK => CLK,
      SRESET => sreset
      );
   
   -----------------------------------------------------
   -- pixels numbering
   -----------------------------------------------------    
   U2: process(CLK)
   begin  
      if rising_edge(CLK) then 
         if sreset = '1' then  
            pix_i <= to_unsigned(1, pix_i'length);
         else 
            if RX_MOSI.TVALID = '1' and TX_MISO.TREADY = '1' then 
               if pix_i = FULL_LINE_CNT then 
                  pix_i <= to_unsigned(1, pix_i'length);
               else
                  pix_i <= pix_i + 1;         
               end if;				  
            end if;
            
         end if;           
      end if;			
   end process;  
    
   ------------------------------------------------------
   -- Cropping core
   ------------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            sample_valid_set1 <= '0'; 
            sample_valid_set2 <= '0';
            pix_mosi_pipe(0).TVALID <= '0';
            pix_mosi_pipe(1).TVALID <= '0';
            pix_mosi_pipe(1).TLAST <= '0';
            tlast_i <= '0';
            eol_data_reg <= (others => '0'); 
            last_full_line_transaction <= '0';
         else
            
            -- SOL check
            if  unsigned(pix_i) >= to_integer(FPA_INTF_CFG.AOI_DATA.SOL_POS) then
               sample_valid_set1 <= RX_MOSI.TVALID;
            else
               sample_valid_set1 <= '0';
            end if;
            
            -- EOL-1 check
            if  unsigned(pix_i) < to_integer(FPA_INTF_CFG.AOI_DATA.EOL_POS) then
               sample_valid_set2 <= RX_MOSI.TVALID;
            else
               sample_valid_set2 <= '0';  
            end if;
            
            -- To reconstruct the Tlast, we delay the EOL transaction until the last full line transaction. 
            if  unsigned(pix_i) = to_integer(FPA_INTF_CFG.AOI_DATA.EOL_POS) then -- Latching the eol transaction
               eol_data_reg <= RX_MOSI.TDATA;
               eol_dval_reg <= RX_MOSI.TVALID;
            end if; 
            
            if  unsigned(pix_i) = FULL_LINE_CNT and RX_MOSI.TVALID = '1' then -- Waiting for the last full line transaction 
               last_full_line_transaction <= '1';
               tlast_i <= RX_MOSI.TLAST; 
            else
               tlast_i <= '0'; 
               last_full_line_transaction <= '0';
            end if;
            
            -- Flow control
            pix_mosi_pipe(0).TDATA  <= RX_MOSI.TDATA; 
            pix_mosi_pipe(0).TUSER  <= RX_MOSI.TUSER;

            if last_full_line_transaction = '1' then
               pix_mosi_pipe(1).TDATA  <= eol_data_reg;
               pix_mosi_pipe(1).TVALID <= eol_dval_reg;
               pix_mosi_pipe(1).TLAST  <= tlast_i;
            else   
               pix_mosi_pipe(1).TDATA  <= pix_mosi_pipe(0).TDATA;
               pix_mosi_pipe(1).TVALID <= sample_valid_set1 and sample_valid_set2;
               pix_mosi_pipe(1).TLAST  <= tlast_i;
            end if;
            
            pix_mosi_pipe(1).TUSER  <= pix_mosi_pipe(0).TUSER;
            pix_mosi_pipe(1).TSTRB <= (others => '1');
            pix_mosi_pipe(1).TKEEP <= (others => '1');

         end if;
         
      end if;   
   end process;
   
   
end rtl;
