library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;
use work.tel2000.all;

entity flash_process is
  port (
    Sys_clk          : in  std_logic;   -- Sys clock
    Rst              : in  std_logic;   -- sys reset
    
    Start_NANDSM     : in  std_logic_vector(3 downto 0);
    BRAM_PORTB_en    : out std_logic;
    BRAM_PORTB_dout  : in std_logic_vector ( 31 downto 0 );
    BRAM_PORTB_din   : out std_logic_vector ( 31 downto 0 );
    BRAM_PORTB_we    : out std_logic_vector ( 3 downto 0 );
    BRAM_PORTB_addr  : out std_logic_vector ( 31 downto 0 );
    BRAM_PORTB_clk   : out std_logic;
    BRAM_PORTB_rst   : out std_logic;
    
    Flash_Data       : in std_logic_vector ( 7 downto 0 );
    
    NAND_SM_RDENn   : out std_logic;
    NAND_SM_WRENn   : out std_logic;
    NAND_DATA_WRITE_iv8 : out std_logic_vector(7 downto 0);
    NAND_SM_WRITE_BUSY : out std_logic;
    NAND_SM_READ_BUSY : out std_logic
);
end flash_process;

architecture implementation of flash_process is


-------------------------------------------------------------------------------
-- Signal Declarations
-------------------------------------------------------------------------------
TYPE NAND_SM_READ IS   ( idle, 
					     rdenLow,
					     pause1,
					     readByte,
					     pause2,
					     writeDPRAM,
					     incAddress
						);
signal sm_NAND_SM_READ   : NAND_SM_READ;

TYPE NAND_SM_WRITE IS   ( idle,
                          rdenHighDPRAM,
                          writeByte,
                          pause1,
                          pause2,
                          pause3
						);
signal sm_NAND_SM_WRITE   : NAND_SM_WRITE;

signal    DPRAM_ADDR_READ         :  STD_LOGIC_VECTOR ( 31 downto 0 );
signal    DPRAM_ADDR_MAX_READ     :  STD_LOGIC_VECTOR ( 31 downto 0 );
signal    DPRAM_ADDR_MAX_WRITE    :  STD_LOGIC_VECTOR ( 31 downto 0 );
signal    DPRAM_ADDR_WRITE        :  STD_LOGIC_VECTOR ( 31 downto 0 );
signal    DPRAM_DATA_READ         :  STD_LOGIC_VECTOR ( 31 downto 0 );
signal    DPRAM_DATA_WRITE_OUT    :  STD_LOGIC_VECTOR ( 31 downto 0 ); --data output from DPRAM
signal    NAND_DATA_WRITE_OUT     :  STD_LOGIC_VECTOR ( 7 downto 0 );  --data output to NAND
signal    DPRAM_WREN              :  STD_LOGIC_VECTOR ( 3 downto 0 );
signal    DPRAM_EN_READ           :  STD_LOGIC := '0';
signal    DPRAM_EN_WRITE          :  STD_LOGIC := '0';
signal    DPRAM_ADDR              :  STD_LOGIC_VECTOR ( 31 downto 0 );
signal    DPRAM_EN                :  STD_LOGIC := '0';

--signal    NAND_SM_RDENn :  STD_LOGIC := '1';
--signal    NAND_SM_WRENn :  STD_LOGIC := '1';

signal NAND_START_READ          :  STD_LOGIC_VECTOR ( 2 downto 0 );
signal NAND_START_READ_SPARE    :  STD_LOGIC_VECTOR ( 2 downto 0 );
signal NAND_START_WRITE         :  STD_LOGIC_VECTOR ( 2 downto 0 );
signal NAND_START_WRITE_SPARE   :  STD_LOGIC_VECTOR ( 2 downto 0 );

signal    byteCptRead   :  natural;
signal    byteCptWrite  :  natural;
signal    byteCptReadTimer   :  STD_LOGIC_VECTOR ( 3 downto 0 );
signal    byteCptWriteTimer   :  STD_LOGIC_VECTOR ( 3 downto 0 );
signal    NAND_DATA     :  STD_LOGIC_VECTOR ( 7 downto 0 );
signal    nand_data_in  :  STD_LOGIC_VECTOR ( 7 downto 0 );

--signal    nand_sm_write_busy :  STD_LOGIC; 
--signal    nand_sm_read_busy :  STD_LOGIC;  

begin

   BRAM_PORTB_en       <= DPRAM_EN;
   DPRAM_DATA_WRITE_OUT <= BRAM_PORTB_dout;
   BRAM_PORTB_din      <= DPRAM_DATA_READ;
   BRAM_PORTB_we       <= DPRAM_WREN;
   BRAM_PORTB_addr     <= DPRAM_ADDR;
   BRAM_PORTB_clk      <= Sys_clk;
   BRAM_PORTB_rst      <= Rst;
   
--   NAND_SM_RDENn       <= NAND_SM_RDENn;
--   NAND_SM_WRENn       <= NAND_SM_WRENn;
   NAND_DATA_WRITE_iv8 <= NAND_DATA_WRITE_OUT;
--   NAND_SM_WRITE_BUSY  <= nand_sm_write_busy;
--   NAND_SM_READ_BUSY   <= nand_sm_read_busy;

   nand_data_in        <= Flash_Data;
   DPRAM_ADDR          <= DPRAM_ADDR_READ or DPRAM_ADDR_WRITE;
   DPRAM_EN       <= DPRAM_EN_READ or DPRAM_EN_WRITE;
   
NAND_SM_START : process(Sys_clk)
	begin
	   if rising_edge(Sys_clk) then
	       NAND_START_READ(2 downto 0) <= NAND_START_READ(1 downto 0) & Start_NANDSM(0);
	       NAND_START_WRITE(2 downto 0) <= NAND_START_WRITE(1 downto 0) & Start_NANDSM(1);
	       NAND_START_READ_SPARE(2 downto 0) <= NAND_START_READ_SPARE(1 downto 0) & Start_NANDSM(2);
	       NAND_START_WRITE_SPARE(2 downto 0) <= NAND_START_WRITE_SPARE(1 downto 0) & Start_NANDSM(3);
	   end if;
end process;


NAND_SM_INTERFACE_READ : process(Sys_clk)
	begin
	if rising_edge(Sys_clk) then
		if Rst = '1' then	
		    DPRAM_ADDR_MAX_READ <= x"00000000";
		    DPRAM_ADDR_READ     <= x"00000000";
            DPRAM_DATA_READ   <= x"00000000";
            DPRAM_WREN        <= "0000";
            DPRAM_EN_READ     <= '1';
            NAND_SM_RDENn     <= '1';
            byteCptRead       <= 0;
            byteCptReadTimer  <= "0000";
            nand_sm_read_busy <= '0';
		else
			case sm_NAND_SM_READ is
				when idle =>
				    DPRAM_ADDR_READ    <= x"00000000";
                    DPRAM_DATA_READ    <= x"00000000";
                    DPRAM_WREN   <= "0000";
                    DPRAM_EN_READ     <= '0';
                    NAND_SM_RDENn <= '1';
                    byteCptRead      <= 0;
                    byteCptReadTimer  <= "0000";
                    nand_sm_read_busy <= '0';
				    if NAND_START_READ(2) = '0' and  NAND_START_READ(1) = '1' then
				       DPRAM_ADDR_MAX_READ <= x"000007F8";  --Last DPRAM write is 1FC, last byte at 1FF
                       sm_NAND_SM_READ <= rdenLow;
				    elsif  NAND_START_READ_SPARE(2) = '0' and  NAND_START_READ_SPARE(1) = '1' then
				        DPRAM_ADDR_MAX_READ <= x"00000038";  --Last DPRAM write is 3C, last byte at 3F
				        sm_NAND_SM_READ <= rdenLow;
				    else
				        DPRAM_ADDR_MAX_READ <= x"00000000";
				        sm_NAND_SM_READ <= idle;
				    end if;
					
				when rdenLow => 
				        DPRAM_ADDR_MAX_READ     <= DPRAM_ADDR_MAX_READ;
				    	DPRAM_ADDR_READ    <= DPRAM_ADDR_READ;
                        DPRAM_DATA_READ    <= DPRAM_DATA_READ;
                        DPRAM_WREN    <= "0000";
                        DPRAM_EN_READ <= '0';
                        NAND_SM_RDENn <= '0';
                        byteCptRead       <= byteCptRead;
                        byteCptReadTimer  <= "0000";
                        nand_sm_read_busy <= '1';
                        sm_NAND_SM_READ <= pause1;
							
				when pause1 =>
				        DPRAM_ADDR_MAX_READ     <= DPRAM_ADDR_MAX_READ;
				        DPRAM_ADDR_READ    <= DPRAM_ADDR_READ;
                    if byteCptRead = 0 then
                        DPRAM_DATA_READ    <= DPRAM_DATA_READ(31 downto 8) & nand_data_in;
                    elsif byteCptRead = 1 then
                        DPRAM_DATA_READ    <= DPRAM_DATA_READ(31 downto 16) & nand_data_in & DPRAM_DATA_READ(7 downto 0);
                    elsif byteCptRead = 2 then
                        DPRAM_DATA_READ    <= DPRAM_DATA_READ(31 downto 24) & nand_data_in & DPRAM_DATA_READ(15 downto 0);
                    else
                        DPRAM_DATA_READ    <= nand_data_in & DPRAM_DATA_READ(23 downto 0);
                    end if;
                        DPRAM_WREN    <= "0000";
                        DPRAM_EN_READ <= '0';
                        NAND_SM_RDENn <= '0';
                        byteCptRead       <= byteCptRead;
                        nand_sm_read_busy <= '1';
                        if byteCptReadTimer >= 2 then
                           sm_NAND_SM_READ <= readByte;
                           byteCptReadTimer  <= "0000";
                        else
                           sm_NAND_SM_READ <= pause1;
                           byteCptReadTimer  <= byteCptReadTimer + 1;
                        end if;
				
				when readByte =>
				        DPRAM_ADDR_MAX_READ     <= DPRAM_ADDR_MAX_READ;
				        DPRAM_ADDR_READ    <= DPRAM_ADDR_READ;--:  STD_LOGIC_VECTOR ( 31 downto 0 );
				        if byteCptRead = 0 then
				            DPRAM_DATA_READ    <= DPRAM_DATA_READ(31 downto 8) & nand_data_in;
				        elsif byteCptRead = 1 then
				            DPRAM_DATA_READ    <= DPRAM_DATA_READ(31 downto 16) & nand_data_in & DPRAM_DATA_READ(7 downto 0);
				        elsif byteCptRead = 2 then
				            DPRAM_DATA_READ    <= DPRAM_DATA_READ(31 downto 24) & nand_data_in & DPRAM_DATA_READ(15 downto 0);
				        else
				            DPRAM_DATA_READ    <= nand_data_in & DPRAM_DATA_READ(23 downto 0);
				        end if;
                        DPRAM_WREN        <= "0000";
                        DPRAM_EN_READ     <= '0';
                        NAND_SM_RDENn     <= '1';
                        byteCptRead       <= byteCptRead;
                        byteCptReadTimer  <= "0000";
                        nand_sm_read_busy <= '1';
                        sm_NAND_SM_READ   <= pause2;
                 
				
				when pause2 =>
                        if byteCptRead < 3 then
                            DPRAM_ADDR_MAX_READ     <= DPRAM_ADDR_MAX_READ;
                            DPRAM_ADDR_READ    <= DPRAM_ADDR_READ;
                            DPRAM_DATA_READ    <= DPRAM_DATA_READ;
                            DPRAM_WREN         <= "0000";
                            DPRAM_EN_READ      <= '0';
                            NAND_SM_RDENn      <= '1';
                            byteCptRead        <= byteCptRead + 1;
                            byteCptReadTimer  <= "0000";
                            nand_sm_read_busy <= '1';
                            sm_NAND_SM_READ    <= rdenLow;
                         else
                            DPRAM_ADDR_MAX_READ     <= DPRAM_ADDR_MAX_READ;
                            DPRAM_ADDR_READ    <= DPRAM_ADDR_READ;
                            DPRAM_DATA_READ    <= DPRAM_DATA_READ;
                            DPRAM_WREN         <= "0000";
                            DPRAM_EN_READ      <= '1';
                            NAND_SM_RDENn      <= '1';
                            byteCptRead        <= 0;
                            byteCptReadTimer  <= "0000";
                            nand_sm_read_busy <= '1';
                            sm_NAND_SM_READ    <= writeDPRAM;
                         end if;
				
				when writeDPRAM =>
				        DPRAM_ADDR_MAX_READ     <= DPRAM_ADDR_MAX_READ;
				        DPRAM_ADDR_READ    <= DPRAM_ADDR_READ;
                        DPRAM_DATA_READ    <= DPRAM_DATA_READ;
                        DPRAM_WREN         <= "1111";
                        DPRAM_EN_READ      <= '1';
                        NAND_SM_RDENn      <= '1';
                        byteCptRead        <= 0;
                        byteCptReadTimer  <= "0000";
                        nand_sm_read_busy <= '1';
                        if DPRAM_ADDR_READ <= DPRAM_ADDR_MAX_READ then               --Last DPRAM write is 1FC, last byte at 1FF
                            sm_NAND_SM_READ       <= incAddress;
                        else
                            sm_NAND_SM_READ       <= idle;
                        end if;
                        
                 when incAddress =>
                         DPRAM_ADDR_MAX_READ     <= DPRAM_ADDR_MAX_READ;
                         DPRAM_ADDR_READ    <= DPRAM_ADDR_READ + 4;
                         DPRAM_DATA_READ    <= DPRAM_DATA_READ;
                         DPRAM_WREN         <= "0000";
                         DPRAM_EN_READ      <= '0';
                         NAND_SM_RDENn      <= '1';
                         byteCptRead        <= 0;
                         byteCptReadTimer  <= "0000";
                         nand_sm_read_busy <= '1';
                         sm_NAND_SM_READ    <= rdenLow;
                  
			end case;
		end if;
	end if;
end process;


NAND_SM_INTERFACE_WRITE : process(Sys_clk, DPRAM_DATA_WRITE_OUT)
	begin
	if rising_edge(Sys_clk) then
		if Rst = '1' then	
		    DPRAM_ADDR_MAX_WRITE    <= x"00000000";
		    DPRAM_ADDR_WRITE        <= x"00000000";
		    NAND_DATA_WRITE_OUT     <= x"00";
            DPRAM_EN_WRITE        <= '1';
            NAND_SM_WRENn         <= '1';
            byteCptWrite          <= 0;
            byteCptWriteTimer     <= "0000";
            nand_sm_write_busy    <= '0';
		else
			case sm_NAND_SM_WRITE is
				when idle =>
                    DPRAM_ADDR_WRITE      <= x"00000000";
                    NAND_DATA_WRITE_OUT   <= x"00";
                    DPRAM_EN_WRITE        <= '0';
                    NAND_SM_WRENn         <= '1';
                    byteCptWrite          <= 0;
                    byteCptWriteTimer   <= "0000";
                    nand_sm_write_busy    <= '0';
				    if NAND_START_WRITE(2) = '0' and  NAND_START_WRITE(1) = '1' then
				       DPRAM_ADDR_MAX_WRITE      <= x"000007F8";    --Last DPRAM read is 1FC, last byte at 1FF
                       sm_NAND_SM_WRITE      <= rdenHighDPRAM;
				    elsif NAND_START_WRITE_SPARE(2) = '0' and  NAND_START_WRITE_SPARE(1) = '1' then
				        DPRAM_ADDR_MAX_WRITE      <= x"00000038";    --Last DPRAM read is 3C, last byte at 3F
				        sm_NAND_SM_WRITE      <= rdenHighDPRAM;
				    else
				        DPRAM_ADDR_MAX_WRITE  <= x"00000000";    
                    	sm_NAND_SM_WRITE      <= idle;
				    end if;
				    
				 when rdenHighDPRAM =>
				    DPRAM_ADDR_MAX_WRITE      <= DPRAM_ADDR_MAX_WRITE;
				    DPRAM_ADDR_WRITE      <= DPRAM_ADDR_WRITE;
				    NAND_DATA_WRITE_OUT   <=  NAND_DATA_WRITE_OUT;
                    DPRAM_EN_WRITE        <= '1';
                    NAND_SM_WRENn         <= '1';
                    byteCptWrite          <= byteCptWrite;
                    byteCptWriteTimer   <= "0000";
                    nand_sm_write_busy    <= '1';
				    sm_NAND_SM_WRITE      <= writeByte;
				 
				 when writeByte =>
				    DPRAM_ADDR_MAX_WRITE      <= DPRAM_ADDR_MAX_WRITE;
				    DPRAM_ADDR_WRITE    <= DPRAM_ADDR_WRITE;
				    if byteCptWrite = 0 then
				        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(7 downto 0);
				    elsif byteCptWrite = 1 then
				        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(15 downto 8);
				    elsif byteCptWrite = 2 then
				        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(23 downto 16);
				    else
				        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(31 downto 24);
				    end if;	
                    DPRAM_EN_WRITE      <= '1';
                    NAND_SM_WRENn       <= '0';
                    byteCptWrite        <= byteCptWrite;
                    byteCptWriteTimer   <= "0000";
                    nand_sm_write_busy  <= '1';
				    sm_NAND_SM_WRITE    <= pause1;
				 
				 when pause1 =>
				    DPRAM_ADDR_MAX_WRITE      <= DPRAM_ADDR_MAX_WRITE;
				    DPRAM_ADDR_WRITE    <= DPRAM_ADDR_WRITE;
                    if byteCptWrite = 0 then
                        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(7 downto 0);
                    elsif byteCptWrite = 1 then
                        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(15 downto 8);
                    elsif byteCptWrite = 2 then
                        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(23 downto 16);
                    else
                        NAND_DATA_WRITE_OUT <= DPRAM_DATA_WRITE_OUT(31 downto 24);
                    end if;	
                    DPRAM_EN_WRITE      <= '1';	
                    NAND_SM_WRENn       <= '0';
                    byteCptWrite        <= byteCptWrite;	
                    nand_sm_write_busy  <= '1';	
                    if byteCptWriteTimer >= 2 then	    
				           sm_NAND_SM_WRITE    <= pause2;
				           byteCptWriteTimer   <= "0000";
				        else
                       sm_NAND_SM_WRITE    <= pause1;
                       byteCptWriteTimer   <= byteCptWriteTimer + 1;
                    end if;
				    
				 when pause2 =>
				    DPRAM_ADDR_MAX_WRITE      <= DPRAM_ADDR_MAX_WRITE;
                    DPRAM_ADDR_WRITE      <= DPRAM_ADDR_WRITE;
                    NAND_DATA_WRITE_OUT   <= NAND_DATA_WRITE_OUT;	
                    DPRAM_EN_WRITE      <= '1';
                    NAND_SM_WRENn         <= '1';
                    byteCptWrite          <= byteCptWrite;
                    byteCptWriteTimer   <= "0000";
                    nand_sm_write_busy    <= '1';
                    sm_NAND_SM_WRITE      <= pause3;
 
				 when pause3 =>
				    DPRAM_ADDR_MAX_WRITE      <= DPRAM_ADDR_MAX_WRITE;
				    NAND_DATA_WRITE_OUT   <= NAND_DATA_WRITE_OUT;
				    NAND_SM_WRENn         <= '1';
				    nand_sm_write_busy    <= '1';
				    byteCptWriteTimer   <= "0000";
                    if byteCptWrite < 3 then                               --write 4 bytes to NAND
                        DPRAM_ADDR_WRITE      <= DPRAM_ADDR_WRITE;
                        DPRAM_EN_WRITE      <= '1';
                        byteCptWrite          <= byteCptWrite + 1;
                        sm_NAND_SM_WRITE      <= writeByte;
                    else
                        if DPRAM_ADDR_WRITE <= DPRAM_ADDR_MAX_WRITE then                  --Last DPRAM read is 1FC, last byte at 1FF
                            DPRAM_ADDR_WRITE      <= DPRAM_ADDR_WRITE + 4;
                            DPRAM_EN_WRITE        <= '1';
                            byteCptWrite          <= 0;
                            sm_NAND_SM_WRITE      <= rdenHighDPRAM;
                         else
                            DPRAM_ADDR_WRITE      <= x"00000000";
                            DPRAM_EN_WRITE        <= '0';
                            byteCptWrite          <= 0;
                            sm_NAND_SM_WRITE      <= idle;
                         end if;
                    end if;
				 
			    end case;
			end if;
		end if;
	end process;

end implementation;

