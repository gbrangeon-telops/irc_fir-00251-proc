-------------------------------------------------------------------------------
--
-- Title       : AEC_Ctrl
-- Author      : Jean-Alexis Boulet
-- Company     : Telops
--
-------------------------------------------------------------------------------
-- $Author$
-- $LastChangedDate$
-- $Revision$ 
-------------------------------------------------------------------------------
--
-- Description : This file implement the axi_lite communication and interrupt gen to the micro blaze
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.ALL;

entity AEC_CUMSUM is
   generic(
      ADD_WITDH : integer := 7
      );
   port(     
      --------------------------------
      -- CTRL Interface
      --------------------------------                       
      CUMSUM_READY         : out  std_logic;
      LOWERCUMSUM          : out  std_logic_vector(23 downto 0);
      UPPERCUMSUM          : out  std_logic_vector(23 downto 0);
      LOWERBINID           : out  std_logic_vector(15 downto 0);
      IMAGE_FRACTION_FBCK  : out  std_logic_vector(23 downto 0); -- in pixel
      NB_PIXEL             : out  std_logic_vector(23 downto 0);
      
      IMAGE_FRACTION       : in std_logic_vector(23 downto 0); -- in pixel
      NB_BIN               : in std_logic_vector(15 downto 0);
      AEC_MODE             : in std_logic_vector(1 downto 0);
      AEC_CTRL_CLEARMEM    : in std_logic;
      
      CUMSUM_ERROR         : out std_logic;
      
      --------------------------------
      -- Histogram Interface
      -------------------------------- 
      HIST_RDY       : in std_logic;   
      HIST_CLEARMEM  : out std_logic;
      AEC_RESET      : out std_logic;   
      
      --------------------------------
      -- TMI INTERFACE
      --------------------------------   
      TMI_MOSI_ADD	   : out std_logic_vector(ADD_WITDH-1 downto 0);
      TMI_MOSI_RNW	   : out std_logic;
      TMI_MOSI_DVAL	   : out std_logic;
      TMI_MOSI_WR_DATA  : out std_logic_vector(20 downto 0);
      
      TMI_MISO_BUSY     : in std_logic;
      TMI_MISO_RD_DATA  : in std_logic_vector(20 downto 0);           
      TMI_MISO_RD_DVAL  : in std_logic;
      TMI_MISO_IDLE     : in std_logic;
      TMI_MISO_ERROR    : in std_logic;
      
      --------------------------------
      -- MISC
      --------------------------------   
      CLK_DATA       : in  std_logic;
      ARESET        : in  std_logic 
      
      );
end AEC_CUMSUM;

architecture RTL of AEC_CUMSUM is
   
   component sync_reset
      port(
         ARESET                 : in std_logic;
         SRESET                 : out std_logic;
         CLK                    : in std_logic);
   end component;
   
   constant HistRegLen        : integer := 2;
   
   type AECState_type   is (RESET, IDLE, PROC_CUMSUM, DONE, HIST_RESET);
   type cumsum_acc_type is array(HistRegLen-1 downto 0) of unsigned(NB_PIXEL'left downto 0);
   
   signal sreset         : std_logic;
   signal aec_sm_reset   : std_logic := '1';
   
   -- Internal Histogram Ports 
   signal H_ready             : std_logic;
   signal H_clearmem          : std_logic;
   
   -- Cumsum internal signals
   signal if_maxfound         : std_logic;
   signal Cumsum_valid        : std_logic;
   signal cumsum_ready_s      : std_logic;
   signal CumSum_Acc          : cumsum_acc_type;
   
   -- TMI SIGNAL
   signal tmi_add_s     : std_logic_vector(9 downto 0);
   signal tmi_dval_s    : std_logic;
   
   signal tmi_busy_s       : std_logic;
   signal tmi_rddata_s     : unsigned(20 downto 0);
   signal tmi_rddval_s     : std_logic;
   signal tmi_idle_s       : std_logic;
   signal tmi_error_s      : std_logic;
   
   
   -- INTERNAL ctrl intf signal
   signal image_fraction_s       : unsigned(23 downto 0);
   signal image_fraction_fbck_s  : unsigned(23 downto 0);   --feedback
   signal lowerbin_id_s          : unsigned(9 downto 0);
   signal lowercumsum_value      : unsigned(23 downto 0);
   signal uppercumsum_value      : unsigned(23 downto 0);
   signal hist_nb_pix_s          : unsigned(23 downto 0);
   
   
   -- Internal AEC status - DATA
   signal AEC_state           : AECState_type := RESET;
   signal AEC_reseti          : std_logic;
   
   -- TMI addr gen signal
   signal TMI_add             : unsigned( 9 downto 0);
   signal TMI_add_done        : std_logic;
   signal TMI_add_out         : unsigned( 9 downto 0);
   signal TMI_add_out_started : std_logic;
   signal TMI_add_max         : unsigned(12 downto 0) := (others => '1');
   
   attribute KEEP: string;
   attribute KEEP of TMI_add : signal is "TRUE";
   attribute KEEP of TMI_add_done : signal is "TRUE";
   attribute KEEP of TMI_add_out : signal is "TRUE";
   attribute KEEP of tmi_add_s : signal is "TRUE";
   attribute KEEP of tmi_dval_s : signal is "TRUE";
   attribute KEEP of tmi_busy_s : signal is "TRUE";
   attribute KEEP of tmi_rddata_s : signal is "TRUE";
   attribute KEEP of tmi_idle_s : signal is "TRUE";
   attribute KEEP of tmi_error_s : signal is "TRUE";
   
   attribute KEEP of AEC_state : signal is "TRUE";
   attribute KEEP of Cumsum_valid : signal is "TRUE";
   attribute KEEP of cumsum_ready_s : signal is "TRUE";
   attribute KEEP of CumSum_Acc : signal is "TRUE";
   
   attribute KEEP of image_fraction_s : signal is "TRUE";
   attribute KEEP of lowerbin_id_s : signal is "TRUE";
   attribute KEEP of lowercumsum_value : signal is "TRUE";
   attribute KEEP of hist_nb_pix_s : signal is "TRUE";
   
begin
   
   ----------------------------------------
   -- CLK DATA
   ----------------------------------------
   sreset_data_gen : sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK_DATA,
      SRESET => sreset
      );
   
   ----------------------------------------
   -- TMI ASSIGNATION
   ----------------------------------------
   TMI_MOSI_WR_DATA <= (others => '0');
   TMI_MOSI_RNW   <= '1';
   
   ------------------------------
   -- Histogram assignation
   ------------------------------
   H_ready        <= HIST_RDY;
   HIST_CLEARMEM  <= H_clearmem;
   AEC_RESET      <= AEC_reseti;
   
   ------------------------------
   -- CTRL Intf assignation
   ------------------------------
   
   CUMSUM_READY         <= cumsum_ready_s;
   LOWERBINID           <= std_logic_vector(resize(lowerbin_id_s, LOWERBINID'length));
   LOWERCUMSUM          <= std_logic_vector(resize(lowercumsum_value, LOWERCUMSUM'length));
   UPPERCUMSUM          <= std_logic_vector(resize(uppercumsum_value, UPPERCUMSUM'length));
   IMAGE_FRACTION_FBCK  <= std_logic_vector(resize(image_fraction_fbck_s, IMAGE_FRACTION_FBCK'length));
   NB_PIXEL             <= std_logic_vector(resize(hist_nb_pix_s, NB_PIXEL'length));    
   
   
   AEC_SM : process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         
         ----------------
         if sreset = '1' or AEC_mode = "00" then
            aec_sm_reset <= '1';
         else
            aec_sm_reset <= '0';
         end if;                  
         ----------------
         
         if aec_sm_reset = '1' then -- Reset or AEC Stopped
            AEC_state      <= RESET;
            cumsum_ready_s <= '0';
            H_clearmem     <= '1';
            CUMSUM_ERROR      <= '0';
            AEC_reseti <= '1'; -- Hold histogram generator in reset
         else
            
            -- Assure que l'histogrammes soient effacés après un reset
            if AEC_state = RESET then
               H_clearmem  <= '1';
            else
               H_clearmem  <= '0';
            end if;
            
            AEC_reseti <= '0';
            
            case AEC_state is
               when RESET =>
                  AEC_state         <= IDLE;
                  cumsum_ready_s    <= '0';
                  CUMSUM_ERROR      <= '0';
               
               when IDLE =>
                  if H_ready = '1' then
                     AEC_state   <= PROC_CUMSUM;
                     cumsum_ready_s    <= '0';                        
                  end if;
                  CUMSUM_ERROR      <= '0';
               
               when PROC_CUMSUM =>
                  if Cumsum_valid = '1' then
                     cumsum_ready_s    <= '1';
                     AEC_state   <= DONE;
                     --                     if( if_maxfound = '0') then
                     CUMSUM_ERROR      <= not if_maxfound;    
                     --                     else
                     --                        CUMSUM_ERROR      <= '0';   
                     --                     end if;
                  else
                     cumsum_ready_s    <= '0';
                     CUMSUM_ERROR      <= '0';
                  end if;
                  
               
               when DONE => -- GEN interrupt and wait for clear mem
                  if AEC_CTRL_CLEARMEM = '1' then
                     cumsum_ready_s   <= '0';
                     H_clearmem <= '1';
                     AEC_state   <= HIST_RESET;
                  else
                     cumsum_ready_s   <= '1';
                     H_clearmem <= '0';
                  end if;
                  
               
               when HIST_RESET => -- GEN interrupt and wait for clear mem
                  if H_ready = '0' then
                     AEC_state   <= IDLE;
                  end if;
                  
               
               when others =>
               AEC_state <= RESET;
            end case;
            
         end if;
      end if;
   end process;
   
   
   
   CUMSUM_SM : process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         if sreset = '1' then
            lowerbin_id_s     <= (others => '0');
            lowercumsum_value <= (others => '0');
            uppercumsum_value <= (others => '0');
            hist_nb_pix_s     <= (others => '0');
            image_fraction_s  <= (others => '1');
            image_fraction_fbck_s <= (others => '1');
            TMI_add_max       <= (others => '1');
            if_maxfound       <= '0';
            Cumsum_valid      <= '0';
            tmi_dval_s        <= '0';
            tmi_add_s         <= (others => '0');
            CumSum_Acc        <= (others => (others => '0'));
            TMI_add_out       <= (others => '0');
            
         else
            -- Check if we are processing an histogram
            if AEC_state = IDLE then
               
               image_fraction_s  <= unsigned(IMAGE_FRACTION);
               if_maxfound       <= '0';
               Cumsum_valid      <= '0';
               CumSum_Acc        <= (others => (others => '0'));
               
               tmi_dval_s        <= '0';
               tmi_add_s         <= (others => '0');
               TMI_add_max       <= unsigned(NB_BIN(TMI_add_max'range)) - 1;
               TMI_add           <= (others => '0');
               TMI_add_done      <= '0';
               TMI_add_out       <= (others => '0');
               TMI_add_out_started <= '0';
               
               
               
            elsif AEC_state = PROC_CUMSUM then
               if (AEC_mode(0) = '1' and Cumsum_valid ='0' and tmi_busy_s = '0' )then -- AEC IS ON and processing result is not valid yet
                  -- Generate TMI adress
                  if tmi_busy_s = '0' then
                     tmi_dval_s   <= '0';
                     if TMI_add_done = '0' then
                        if TMI_add = TMI_add_max then
                           TMI_add_done <= '1';
                        end if;
                        tmi_add_s    <= std_logic_vector(TMI_add);
                        TMI_add      <= TMI_add + 1;
                        tmi_dval_s   <= '1';
                     end if;
                  end if;
                  
                  -- Cumsum calculation
                  if tmi_rddval_s = '1' then
                     CumSum_Acc(0)     <= CumSum_Acc(0) + tmi_rddata_s;
                     CumSum_Acc(1)     <= CumSum_Acc(0); -- we shift the actual cum sum to the other register
                     if TMI_add_out_started = '1' then
                        -- TMI_add_out is started one cycle after to correspond to the bin id of what is already in CumSum_Acc(0)
                        TMI_add_out    <= TMI_add_out + 1;
                     end if;
                     TMI_add_out_started <= '1';
                  end if;
                  
                  -- Find Image Fraction Bin information
                  if (CumSum_Acc(0) >= image_fraction_s and if_maxfound = '0' ) then
                     lowerbin_id_s     <= TMI_add_out ; -- lower bin is the preceding bin. Bin  id 0 = no pixel at start 
                     uppercumsum_value  <= CumSum_Acc(0);
                     lowercumsum_value  <= CumSum_Acc(1);
                     image_fraction_fbck_s <= image_fraction_s;
                     if_maxfound <= '1';                        
                  end if;
                  
                  -- Find Last bin value
                  if(TMI_add_out >= TMI_add_max) then
                     hist_nb_pix_s <= CumSum_Acc(0);
                     Cumsum_valid <= '1';
                  end if;
                  
               end if; -- end AECMODE(0) = '1'               
            end if; -- end AEC_state = IDLE
         end if; --sreset = '1'
      end if; -- rising_edge(CLK_DATA)
   end process;     
   
   
   -- TMI_SYNC
   TMI_SYNC : process(CLK_DATA)
   begin
      if rising_edge(CLK_DATA) then
         -- TMI SIGNAL
         
         TMI_MOSI_ADD   <= tmi_add_s(ADD_WITDH-1 downto 0);
         TMI_MOSI_DVAL  <= tmi_dval_s;
         
         tmi_busy_s     <= TMI_MISO_BUSY;   
         tmi_rddata_s   <= unsigned(TMI_MISO_RD_DATA);
         tmi_rddval_s   <= TMI_MISO_RD_DVAL;
         tmi_idle_s     <= TMI_MISO_IDLE ;  
         tmi_error_s    <= TMI_MISO_ERROR;  
      end if;
      
   end process;
   
   
end RTL;
