------------------------------------------------------------------
--!   @file : flagging_mblaze_intf
--!   @brief
--!   @details
--!
--!   $Rev$
--!   $Author$
--!   $Date$
--!   $Id$
--!   $URL$
------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 
use work.tel2000.all;
use work.flag_define.all;
use work.img_header_define.all;

entity flagging_SM is
   port(
      ARESET                    : in std_logic;
      CLK                       : in std_logic;
      
      -- Hder AXI signals
      Hder_Axil_Mosi : out t_axi4_lite_mosi;
      Hder_Axil_Miso : in t_axi4_lite_miso;
      HDER_EN        : out std_logic;
      
      SOFT_TRIG                 : in std_logic;
      HARD_TRIG                 : in std_logic;
      
      FLAG_CFG                  : in flag_cfg_type;
      IMG_INFO                  : in img_info_type
      
      );
end flagging_SM;

architecture rtl of flagging_SM is
   attribute KEEP: string;
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;      
   
   signal sreset                    : std_logic; 
   signal soft_trig_i               : std_logic; 
   signal soft_trig_last            : std_logic; 
   signal flag_cfg_dval_last        : std_logic; 
   signal enable_softtrig_i         : std_logic; 
   signal wait_for_init_i           : std_logic; 
   signal trig_i                    : std_logic; 
   signal trig_last_i               : std_logic; 
   signal trig_delay_i              : std_logic; 
   signal mixed_trig_i              : std_logic; 
   signal mixed_trig_last_i         : std_logic; 
   signal flag_enable_i             : std_logic;
   signal flag_hder_enable          : std_logic;
   signal exp_feedbk_last           : std_logic;  
   
   signal clk_counter_rising        : unsigned(31 downto 0); 
   signal clk_counter_falling       : unsigned(31 downto 0); 
   signal frame_count               : unsigned(31 downto 0); 
   
   signal axil_mosi_i : t_axi4_lite_mosi;
   signal axil_miso_i : t_axi4_lite_miso;
   
   type HEADERWRITE_STATE_TYPE is (WRITE_STANDBY, WRITE_DATA, WAIT_WRITE_COMPLETED, WAIT_NEXT_FEEDBACK);
   signal writing_state       : HEADERWRITE_STATE_TYPE;
   
   constant FLAGGED_VALUE     : unsigned(31 downto 0) := x"00000001";
   constant NOTFLAGGED_VALUE  : unsigned(31 downto 0) := x"00000000";
   
   signal img_info_i                   : img_info_type;
   signal flag_cfg_i                   : flag_cfg_type;
   signal hard_trig_i                  : std_logic;
   signal ublaze_soft_trig_i           : std_logic;
   signal initcfg_proc_sreset          : std_logic := '1';
   signal soft_trig_proc_sreset        : std_logic := '1';
   signal delay_proc_sreset            : std_logic := '1';
   signal flagging_proc_sreset         : std_logic := '1';
   
begin
   
   img_info_i <= IMG_INFO;
   flag_cfg_i <= FLAG_CFG;
   
   ----------------------------------------------------------------------------
   --  synchro reset
   ----------------------------------------------------------------------------
   U1: sync_reset
   port map(
      ARESET => ARESET,
      CLK    => CLK,
      SRESET => sreset
      );
   
   INITCFG_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         
         initcfg_proc_sreset <= sreset or not FLAG_CFG.dval; 
         
         --
         if initcfg_proc_sreset = '1' then
            flag_cfg_dval_last <= '0';
            wait_for_init_i <= '1';
         else			
            flag_cfg_dval_last <= FLAG_CFG.dval;
            
            if FLAG_CFG.dval = '1' and flag_cfg_dval_last = '0' then
               wait_for_init_i <= '1';
            else
               -- attend un coup de clock pour l'initialisation de mixed_trig_i afin de ne pas prendre l'edge d'initialisation comme une transaction
               wait_for_init_i <= '0';
            end if;
         end if;
      end if;
   end process INITCFG_PROC;
   
   -- active la gestion du signal SOFT_TRIG   
   enable_softtrig_i <= FLAG_CFG.trig_source and FLAG_CFG.dval;
   
   -- Genere le signal soft_trig_i pour pouvoir s'en servir comme d'un signal hardware
   -- Sur config de type LEVEL le signal soft_trig_i toggle a l'ecriture du registre ublaze
   -- Sur config de type EDGE on lance le flagging a l'ecriture du registre ublaze peu importe le type de config EDGE
   SOFT_TRIG_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         
         soft_trig_proc_sreset <= sreset or not enable_softtrig_i;
         
         --
         if soft_trig_proc_sreset = '1' then
            soft_trig_i <= '0';
            soft_trig_last <= '0';
         else			
            soft_trig_last <= SOFT_TRIG;
            
            case FLAG_CFG.mode is
               when DISABLE =>
                  soft_trig_i <= '0';
               
               when LEVELHIGH =>
                  if FLAG_CFG.dval = '1' and flag_cfg_dval_last = '0' then
                     -- Changement de configuration, desactiver le flagging par defaut
                     soft_trig_i <= '0';
                  else
                     if SOFT_TRIG = '1' and soft_trig_last = '0' then
                        -- L'ecriture du registre ublaze toggle l'etat
                        soft_trig_i <= not soft_trig_i;
                     else
                        soft_trig_i <= soft_trig_i;
                     end if;
                  end if;
               
               when LEVELLOW =>
                  if FLAG_CFG.dval = '1' and flag_cfg_dval_last = '0' then
                     -- Changement de configuration, desactiver le flagging par defaut
                     soft_trig_i <= '1';
                  else
                     if SOFT_TRIG = '1' and soft_trig_last = '0' then
                        -- L'ecriture du registre ublaze toggle l'etat
                        soft_trig_i <= not soft_trig_i;
                     else
                        soft_trig_i <= soft_trig_i;
                     end if;
                  end if;
               
               when RISINGEDGE =>
                  if FLAG_CFG.dval = '1' and flag_cfg_dval_last = '0' then
                     -- Changement de configuration
                     soft_trig_i <= '0';
                  else
                     -- SOFT_TRIG genere un rising edge a chaque trig
                     soft_trig_i <= SOFT_TRIG;
                  end if;
               
               when FALLINGEDGE =>
                  if FLAG_CFG.dval = '1' and flag_cfg_dval_last = '0' then
                     -- Changement de configuration
                     soft_trig_i <= '0';
                  else
                     -- not SOFT_TRIG genere un falling edge a chaque trig
                     soft_trig_i <= not SOFT_TRIG;
                  end if;
               
               when ANYEDGE =>
                  if FLAG_CFG.dval = '1' and flag_cfg_dval_last = '0' then
                     -- Changement de configuration, desactiver le flagging par defaut
                     soft_trig_i <= '0';
                  else
                     if SOFT_TRIG = '1' and soft_trig_last = '0' then
                        -- L'ecriture du registre ublaze toggle l'etat
                        soft_trig_i <= not soft_trig_i;
                     else
                        soft_trig_i <= soft_trig_i;
                     end if;
                  end if;
               
               when others =>
                  soft_trig_i <= '0';
               
            end case;
         end if;
      end if;
   end process SOFT_TRIG_PROC;
   
   mixed_trig_i <= soft_trig_i when (enable_softtrig_i = '1') else HARD_TRIG;
   
   DELAY_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         mixed_trig_last_i <= mixed_trig_i;
         
         delay_proc_sreset <= sreset or wait_for_init_i or not FLAG_CFG.dval;
         --
         
         if delay_proc_sreset = '1' then
            clk_counter_rising <= (others => '0');
            clk_counter_falling <= (others => '0');
            trig_delay_i <= mixed_trig_i;
         else
            
            if FLAG_CFG.delay /= to_unsigned(0, FLAG_CFG.delay'length) then
               -- Active les compteurs lors de detection de edge
               if mixed_trig_i = '1' and mixed_trig_last_i = '0' and clk_counter_rising = to_unsigned(0, clk_counter_rising'length) then  -- rising edge et aucun rising edge est presentement en traitement
                  clk_counter_rising <= clk_counter_rising + 1;
               elsif mixed_trig_i = '0' and mixed_trig_last_i = '1'  and clk_counter_falling = to_unsigned(0, clk_counter_falling'length) then  -- falling edge et aucun falling edge est presentement en traitement
                  clk_counter_falling <= clk_counter_falling + 1;
               end if;
               
               -- rising edge en delai
               if clk_counter_rising /= to_unsigned(0, clk_counter_rising'length) then
                  if clk_counter_rising = (FLAG_CFG.delay - 1) then -- (FLAG_CFG.delay - 1) evite d'avoir un coup de clock de retard dans FLAGGING_PROC
                     trig_delay_i <= '1';
                     clk_counter_rising <= (others => '0');
                  else
                     clk_counter_rising <= clk_counter_rising + 1;
                  end if;
               end if;
               
               -- falling edge en delai
               if clk_counter_falling /= to_unsigned(0, clk_counter_falling'length) then
                  if clk_counter_falling = (FLAG_CFG.delay - 1) then -- (FLAG_CFG.delay - 1) evite d'avoir un coup de clock de retard dans FLAGGING_PROC
                     trig_delay_i <= '0';
                     clk_counter_falling <= (others => '0');
                  else
                     clk_counter_falling <= clk_counter_falling + 1;
                  end if;
               end if;
               
            end if;
         end if;
      end if;
   end process DELAY_PROC;
   
   trig_i <= trig_delay_i when FLAG_CFG.delay /= to_unsigned(0, FLAG_CFG.delay'length) else mixed_trig_i;
   
   Hder_Axil_Mosi <= axil_mosi_i;
   axil_miso_i <= Hder_Axil_Miso;
   
   FLAGGING_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         trig_last_i <= trig_i;
         exp_feedbk_last <= IMG_INFO.exp_feedbk;
         
         flagging_proc_sreset <= sreset or wait_for_init_i or not FLAG_CFG.dval;
         
         if flagging_proc_sreset = '1' then
            flag_enable_i <= '0';
            frame_count <= (others => '0');
         else
            
            case FLAG_CFG.mode is
               when DISABLE =>
                  flag_enable_i <= '0';
               
               when LEVELHIGH =>
                  flag_enable_i <= trig_i;
               
               when LEVELLOW =>
                  flag_enable_i <= not trig_i;
               
               when RISINGEDGE =>
                  if (trig_i = '1' and trig_last_i = '0') then
                     flag_enable_i <= '1';
                     frame_count <= (others => '0');
                  end if;
                  
                  if (flag_enable_i = '1' and IMG_INFO.exp_feedbk = '1' and exp_feedbk_last = '0') then
                     -- New frame
                     frame_count <= frame_count + 1;
                     
                     if (frame_count = (FLAG_CFG.frame_count - 1)) then
                        flag_enable_i <= '0';
                        frame_count <= (others => '0');
                     else
                        flag_enable_i <= '1';
                     end if;
                  end if;
               
               when FALLINGEDGE =>
                  if (trig_i = '0' and trig_last_i = '1') then
                     flag_enable_i <= '1';
                     frame_count <= (others => '0');
                  end if;
                  
                  if (flag_enable_i = '1' and IMG_INFO.exp_feedbk = '1' and exp_feedbk_last = '0') then
                     -- New frame
                     frame_count <= frame_count + 1;
                     
                     if (frame_count = (FLAG_CFG.frame_count - 1)) then
                        flag_enable_i <= '0';
                        frame_count <= (others => '0');
                     else
                        flag_enable_i <= '1';
                     end if;
                  end if;
               
               when ANYEDGE =>
                  if (trig_i /= trig_last_i) then
                     flag_enable_i <= '1';
                     frame_count <= (others => '0');
                  end if;
                  
                  if (flag_enable_i = '1' and IMG_INFO.exp_feedbk = '1' and exp_feedbk_last = '0') then
                     -- New frame
                     frame_count <= frame_count + 1;
                     
                     if (frame_count = (FLAG_CFG.frame_count - 1)) then
                        flag_enable_i <= '0';
                        frame_count <= (others => '0');
                     else
                        flag_enable_i <= '1';
                     end if;
                  end if;
               
               when others =>
            end case;
         end if;
      end if;
   end process FLAGGING_PROC;
   
   flag_hder_enable <= '1' when (FLAG_CFG.mode /= DISABLE and FLAG_CFG.dval = '1') else '0';
   HDER_EN <= flag_hder_enable;
   
   HEADER_PROC : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then
            axil_mosi_i.awvalid <= '0';
            axil_mosi_i.wvalid <= '0';
            axil_mosi_i.wstrb <= (others => '0');
            axil_mosi_i.bready <= '1';
            writing_state <= WRITE_STANDBY;
         else
            
            case writing_state is
               when WRITE_STANDBY =>
                  if (IMG_INFO.exp_feedbk = '1' and exp_feedbk_last = '0' and flag_hder_enable = '1') then -- flagging activer
                     -- New frame
                     axil_mosi_i.awaddr <= x"FFFF" &  std_logic_vector(IMG_INFO.frame_id(7 downto 0)) &  std_logic_vector(resize(FrameFlagAdd32, 8));
                     if (flag_enable_i = '1') then
                        axil_mosi_i.wdata <= std_logic_vector(shift_left(FLAGGED_VALUE, FrameFlagShift));
                     else
                        axil_mosi_i.wdata <= std_logic_vector(shift_left(NOTFLAGGED_VALUE, FrameFlagShift));
                     end if;
                     
                     axil_mosi_i.wstrb <= FrameFlagBWE;
                     
                     writing_state <= WRITE_DATA;
                  end if;
               
               when WRITE_DATA =>
                  if axil_miso_i.awready = '1' and axil_miso_i.wready = '1' then
                     axil_mosi_i.awvalid <= '1';
                     axil_mosi_i.wvalid <= '1';
                     writing_state <= WAIT_WRITE_COMPLETED;
                  end if;
               
               when WAIT_WRITE_COMPLETED =>
                  axil_mosi_i.awvalid <= '0';
                  axil_mosi_i.wvalid <= '0';
                  axil_mosi_i.wstrb <= (others => '0');
                  
                  if axil_miso_i.bvalid = '1' then
                     writing_state <= WAIT_NEXT_FEEDBACK;
                  end if;
               
               when WAIT_NEXT_FEEDBACK =>
                  if IMG_INFO.exp_feedbk = '0' then
                     writing_state <= WRITE_STANDBY;
                  end if;
               
               when others =>
            end case;
            
         end if;
      end if;
   end process HEADER_PROC;
end rtl;
