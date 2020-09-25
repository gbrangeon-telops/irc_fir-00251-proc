-------------------------------------------------------------------------------
--
-- Title       : ad798x_driver.vhd
-- Design      : FIR-00251-Proc
-- Author      : Jean-Alexis Boulet
-- Company     : Telops Inc.
--
--  $Revision:
--  $Author:
--  $LastChangedDate:
-------------------------------------------------------------------------------
--
-- Description : Modifier par JBO de AD747x à AD7980
-- Support le mode 3 Wire CS avec Busy

-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use work.tel2000.all;

entity ad798x_driver is
   generic(
      ADC_SCLK_FACTOR   : integer := 32;
      ADC_NBITS         : integer := 16; -- legal values are 14, 16, 18
      FIRST_CLK_EDGE_IS_FE : boolean := true;
      CHAIN_MODE         : boolean := false;
      WIRE_3_MODE        : boolean := true;
      BUSY_INDICATOR     : boolean := true
      );
   port (
      -- CLK AND CONTROL
      CLK                   : in std_logic;
      ARESET 				: in std_logic;
      START_ADC 			: in std_logic;

      -- ADC INTF
      ADC_CNV               : out std_logic;
      ADC_SDO				: in std_logic;
      ADC_SCLK		        : out std_logic;
      ADC_SDI				: out std_logic;

      --DATA INTF
      ADC_DATA_RDY		    : out std_logic;
      ADC_DATA 			    : out std_logic_vector(ADC_NBITS-1 downto 0);
      ADC_BUSY				: out std_logic;
      ADC_ERR               : out std_logic
      );
end ad798x_driver;

architecture RTL of ad798x_driver is

   constant NB_BIT_CLK_CNT  : integer := log2(ADC_SCLK_FACTOR)-1;
   constant NBIT_TO_ACQ     : integer := ADC_NBITS+1; -- nombre de bits total à acquerir lors d'une acquisition incluant le busy signal(BUSY_INDICATOR)
   constant NBIT_TO_ACQ_P_1 : integer := NBIT_TO_ACQ + 1;
   constant DEBUG_VALUE     : std_logic_vector(15 downto 0) := x"AAAA";

   type acq_fsm_type is (idle, conv_st, acq_st, end_st);

   signal acq_fsm                         : acq_fsm_type;
   signal start_adc_i                  	: std_logic;
   signal data_rdy_i    						: std_logic;
   signal busy_i							   	: std_logic;
   signal master_clk_i							: std_logic;
   signal sclk_i   								: std_logic;
   signal div_clk_cnt						   : unsigned(NB_BIT_CLK_CNT downto 0);

   signal adc_conv_i				         	: std_logic;
   signal acq_window   			            : std_logic;

   signal data_register							: std_logic_vector(NBIT_TO_ACQ-1 downto 0);

   signal sreset                          : std_logic;
   signal adc_din_reg                     : std_logic;
   signal master_clk_i_last               : std_logic;
   signal master_clk_acq_edge             : std_logic;
   signal master_clk_cnt                  : unsigned(log2(NBIT_TO_ACQ)+1 downto 0);
   signal sclk_iob                        : std_logic;
   signal adc_conv_iob                        : std_logic;

   component sync_reset is
      port(
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic);
   end component;

   --attribute IOB : string;
   --attribute IOB of sclk_iob                         : signal is "FORCE";
   --attribute IOB of cs_n_iob                         : signal is "FORCE";
   --attribute IOB of adc_din_reg                    : signal is "FORCE";


begin

   --------------------------------------------------
   -- qque sorties
   --------------------------------------------------
   ADC_BUSY <= busy_i;
   ADC_SCLK <= sclk_iob;
   ADC_CNV  <= adc_conv_iob;
   ADC_SDI  <= '1'; --Set in 3 wire operation

   process(CLK)
   begin
      if rising_edge(CLK) then
         sclk_iob <= sclk_i;
         adc_conv_iob <= adc_conv_i;
      end if;
   end process;

   --------------------------------------------------
   -- sync reset
   --------------------------------------------------
   U0 : sync_reset
   port map(ARESET => ARESET, SRESET => sreset, CLK => CLK);

--------------------------------------------------
-- generation clk spi
--------------------------------------------------
U4 : process(CLK)
begin
    if rising_edge(CLK) then
        if (sreset = '1') then
            sclk_i <= '0';
        else
            if acq_fsm /= acq_st then             -- etat de SCLK avant abaissement de CS_N
                if FIRST_CLK_EDGE_IS_FE then
                    sclk_i <= '1';
                else
                    sclk_i <= '0';
                end if;
            else                              -- etat de SCLK après abaissement de CS_N
                sclk_i <= master_clk_i;
            end if;
        end if;
    end if;
end process;

   -------------------------------------------------
   -- compteur pour division d'horloge
   --------------------------------------------------
   -- Clk_divider (par puissance de 2)
   U1 : process(CLK)
   begin
      if rising_edge(CLK) then
         if (sreset = '1' or acq_fsm /= acq_st) then
            div_clk_cnt <= (others => '0');
         else
            div_clk_cnt <= div_clk_cnt + 1;
         end if;
      end if;
   end process;


   --------------------------------------------------
   -- master_clk generation
   --------------------------------------------------
   --  horloge principale divisàe par un facteur puissance de 2
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then
         if (sreset = '1' or acq_fsm /= acq_st) then
            master_clk_i <= '0';
            master_clk_i_last <= '0';
            master_clk_acq_edge <= '0';
         else
            -- division de l'horloge par une puissance de 2
            master_clk_i <= div_clk_cnt(NB_BIT_CLK_CNT);
            master_clk_i_last <= master_clk_i;

            -- adc clk edge detection
            if FIRST_CLK_EDGE_IS_FE then                    -- si premiere transition d'horloge lorsque cs_n abaissé doit etre Falling edge
               master_clk_acq_edge <= not master_clk_i_last and master_clk_i;   -- alors les données sont à acquerir sur le rising_edge
            else
               master_clk_acq_edge <= master_clk_i_last and not master_clk_i;   -- alors les données sont à acquerir sur le falling_edge
            end if;

         end if;
      end if;
   end process;

--------------------------------------------------
-- generation de State machine acquisition SPI
--------------------------------------------------
U3 : process(CLK)
begin
    if rising_edge(CLK) then
        if (sreset = '1') then

        else
            start_adc_i <= START_ADC;

            case acq_fsm is
                when idle =>
                    master_clk_cnt <= (others => '0');
                    data_rdy_i <= '0';
                    busy_i <= '0';
                    adc_conv_i <= '0';
                    acq_window <= '0';
                    if start_adc_i = '1' then
                      acq_fsm <= conv_st;
                      adc_conv_i <= '1'; --Valid si Periond min de CLK est de 10ns voir Specsheet Tcnv min = 10ns
                    end if;

                when conv_st =>  --Envoie du signal de conversion
                    busy_i <= '1';
                    acq_window <= '1';
                    if ADC_SDO = '1' then
                        adc_conv_i <= '0';   
                    end if;
                    if (adc_conv_i = '0' and ADC_SDO = '0') then
                        acq_fsm <= acq_st;
                    end if;

                when acq_st => --Acquisition du nombre de bit de l'ADC
                   if master_clk_acq_edge = '1' then
                      master_clk_cnt <= master_clk_cnt + 1;
                   end if;

                   if master_clk_cnt = NBIT_TO_ACQ then
                      acq_fsm <= end_st;
                      data_rdy_i <= '1';
                   end if;

                when end_st =>
                   adc_conv_i <= '0';
                   acq_window <= '0';
                   data_rdy_i <= '0';
                   acq_fsm <= idle;

                when others =>
            end case;
        end if;
    end if;
end process;



--------------------------------------------------
-- Data Capture SPI
--------------------------------------------------
U5 : process(CLK)
begin
    if rising_edge(CLK) then
        if (sreset = '1' or acq_fsm = idle) then
            data_register <= (others => '0');
        else
            adc_din_reg <=  ADC_SDO; -- pour visualisation dans chipscope.
            if  acq_window = '1' and master_clk_acq_edge = '1' then
                data_register(NBIT_TO_ACQ-1 downto 1) <= data_register(NBIT_TO_ACQ-2 downto 0);
                data_register(0) <= adc_din_reg;
            end if;
        end if;
    end if;
end process;

--------------------------------------------------
-- Data readout extraction
--------------------------------------------------
U6 : process(CLK)
begin
    if rising_edge(CLK) then
        if (sreset = '1') then
            ADC_ERR <= '0';
            ADC_DATA_RDY <= '0';
            -- translate_off
            ADC_DATA <= DEBUG_VALUE(ADC_NBITS-1 downto 0);
            -- translate_on
        else
            if data_rdy_i = '1' then
               ADC_DATA <=  data_register(ADC_NBITS-1 downto 0);
               ADC_DATA_RDY <= '1';
               if data_register(NBIT_TO_ACQ-1) /= '0' then
                  ADC_ERR <= '1';
               end if;
            else
               ADC_DATA_RDY <= '0';
            end if;
        end if;
    end if;
end process;


end RTL;
