------------------------------------------------------------------
--!   @file : scorpiomwA_window_reg
--!   @brief
--!   @details
--!
--!   $Rev: 26862 $
--!   $Author: enofodjie $
--!   $Date: 2021-10-18 11:19:42 -0400 (lun., 18 oct. 2021) $
--!   $Id: scorpiomwA_window_reg.vhd 26862 2021-10-18 15:19:42Z enofodjie $
--!   $URL: http://einstein/svn/firmware/FIR-00272-FleG/trunk/src/FPA/scorpiomwA/HDL/scorpiomwA_window_reg.vhd $
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.fpa_common_pkg.all;
use work.FPA_define.all;

entity scorpiomwA_window_reg is
   port(
      ARESET         : in std_logic;
      CLK            : in std_logic;
      
      FPA_INTF_CFG   : in fpa_intf_cfg_type;
      
      -- spi
      SPI_EN         : out std_logic;
      SPI_DATA       : out std_logic_vector(39 downto 0);  -- en fait 33 downro 0 seulement utilis�
      SPI_DONE       : in std_logic;
      
      -- io 
      UPROW_UPCOL    : out std_logic;
      SIZEA_SIZEB    : out std_logic;
      ITR            : out std_logic;
      
      --
      FPA_ERROR      : in std_logic;
      PROG_ERR       : out std_logic;
      
      -- from main ctrler
      DONE           : out std_logic;
      RQST           : out std_logic;
      EN             : in std_logic
      
      );
end scorpiomwA_window_reg;

architecture rtl of scorpiomwA_window_reg is
   
   component sync_reset
      port (
         ARESET : in std_logic;
         CLK : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   component double_sync_vector
      port(
         D : in std_logic_vector;
         Q : out std_logic_vector;
         CLK : in std_logic
         );
   end component;
   
   component gh_gray2binary
	   GENERIC (size: INTEGER := 8);
	   PORT(	
		   G   : IN STD_LOGIC_VECTOR(size-1 DOWNTO 0);	-- gray code in
		   B   : out STD_LOGIC_VECTOR(size-1 DOWNTO 0) -- binary value out
		);
   end component;
   
   type   roic_cfg_fsm_type is (idle, check_done_st, rqst_st, cfg_io_st, check_init_st, send_cfg_st, wait_err_st, check_roic_err_st, wait_end_st, update_reg_st, pause_st);
   signal roic_cfg_fsm        : roic_cfg_fsm_type;  
   signal spi_en_i            : std_logic;
   signal spi_data_i          : std_logic_vector(39 downto 0);
   signal new_cfg             : std_logic_vector(39 downto 0);
   signal sreset              : std_logic;
   signal present_cfg         : std_logic_vector(39 downto 0);
   signal cfg_changed         : std_logic_vector(4 downto 0);
   signal new_cfg_pending     : std_logic;
   signal done_i              : std_logic;
   signal rqst_i              : std_logic;
   signal pause_cnt           : unsigned(7 downto 0);
   signal en_i                : std_logic;
   signal uprow_upcol_i       : std_logic;
   signal sizea_sizeb_i       : std_logic;
   signal itr_i               : std_logic;
   signal reprog_cnt          : unsigned(3 downto 0);
   signal error_i             : std_logic;
   signal fpa_error_i         : std_logic;
   signal new_cfg_num         : unsigned(FPA_INTF_CFG.CFG_NUM'LENGTH-1 downto 0) := (others=>'0');
   signal present_cfg_num     : unsigned(FPA_INTF_CFG.CFG_NUM'LENGTH-1 downto 0) := (others=>'0');
   signal new_cfg_num_gray    : std_logic_vector(FPA_INTF_CFG.CFG_NUM'LENGTH-1 downto 0) := (others=>'0');
   signal new_cfg_num_bin     : std_logic_vector(FPA_INTF_CFG.CFG_NUM'LENGTH-1 downto 0);
   signal new_cfg_num_pending : std_logic;
   --0-signal 
   
   --   attribute KEEP : string;
   --   attribute KEEP of new_cfg_num : signal is "TRUE";
   --   attribute KEEP of present_cfg_num : signal is "TRUE";
   --   attribute KEEP of new_cfg_num_pending : signal is "TRUE";
   --   attribute KEEP of new_cfg : signal is "TRUE";
   --   attribute KEEP of present_cfg : signal is "TRUE";
   --   attribute KEEP of new_cfg_pending : signal is "TRUE";
   --   attribute KEEP of roic_cfg_fsm : signal is "TRUE";
   --   attribute KEEP of fpa_error_i : signal is "TRUE";
   
begin
   
   SPI_EN <= spi_en_i;
   SPI_DATA <= spi_data_i;
   UPROW_UPCOL <= uprow_upcol_i;
   SIZEA_SIZEB <= sizea_sizeb_i;
   ITR <= itr_i;
   PROG_ERR <=  error_i;
   
   DONE  <= done_i;
   RQST <= rqst_i;
   
   --------------------------------------------------
   -- Sync reset
   -------------------------------------------------- 
   U1A : sync_reset
   port map(ARESET => ARESET, CLK => CLK, SRESET => sreset);
   
   --------------------------------------------------
   -- Sync Gray cfg_num 
   --------------------------------------------------
   U1B : double_sync_vector  
   port map(
      D => std_logic_vector(FPA_INTF_CFG.CFG_NUM),
      Q => new_cfg_num_gray,
      CLK => CLK); 

   --------------------------------------------------
   -- Decodage Gray de cfg_num
   --------------------------------------------------
   U1C : gh_gray2binary
      generic map (size => FPA_INTF_CFG.CFG_NUM'length) 
	   port map (G => new_cfg_num_gray, B => new_cfg_num_bin);
   
   --------------------------------------------------
   --  cfg_num
   --------------------------------------------------
   -- ENO: 26 nov 2018: Pour eviter bugs , reprogrammer le ROIC, d�s qu'une config est re�ue du MB.    
   U2C : process(CLK)
   begin
      if rising_edge(CLK) then 
         
         new_cfg_num <= unsigned(new_cfg_num_bin);
         
         -- detection du changement
         if present_cfg_num /= new_cfg_num then
            new_cfg_num_pending <= '1';
         else
            new_cfg_num_pending <= '0';
         end if;         
         
      end if;
   end process;       
   
   --------------------------------------------------
   --  bistream builder
   --------------------------------------------------
   U2 : process(CLK)
   begin
      if rising_edge(CLK) then        
         
         -- juste pour new_cfg � 40 bits
         new_cfg(39 downto 37) <= (others => '0');
         
         -- mode du window et readout(� ne pas envoyer via spi)
         new_cfg(36) <= FPA_INTF_CFG.ROIC.ITR; 
         new_cfg(35) <= FPA_INTF_CFG.ROIC.UPROW_UPCOL; 
         new_cfg(34) <= FPA_INTF_CFG.ROIC.SIZEA_SIZEB;
         
         -- taille et position du window (� envoyer via spi)
         new_cfg(33 downto 25) <= std_logic_vector(FPA_INTF_CFG.ROIC.WINDCFG_PART1(8 downto 0));    
         new_cfg(24 downto 16) <= std_logic_vector(FPA_INTF_CFG.ROIC.WINDCFG_PART2(8 downto 0));    
         new_cfg(15 downto 8)  <= std_logic_vector(FPA_INTF_CFG.ROIC.WINDCFG_PART3(7 downto 0));    
         new_cfg(7 downto 0)   <= std_logic_vector(FPA_INTF_CFG.ROIC.WINDCFG_PART4(7 downto 0));
         
         -- detection du changement
         for ii in 0 to 4 loop
            cfg_changed(ii) <= '0';
            if present_cfg(8*ii + 7 downto 8*ii) /= new_cfg(8*ii + 7 downto 8*ii) then
               cfg_changed(ii) <= '1';
            end if;
         end loop;
         
         -- new_cfg_pending 
         new_cfg_pending <= '0';
         if cfg_changed /= "00000" then 
            new_cfg_pending <= '1';
         end if; 
         
      end if;
   end process;   
   
   ------------------------------------------------
   -- Voir s'il faut programmer le d�tecteur
   ------------------------------------------------
   U3 : process(CLK)
   begin
      if rising_edge(CLK) then 
         if sreset = '1' then
            spi_en_i <= '0';
            done_i <= '0'; 
            rqst_i <= '0';
            roic_cfg_fsm <= idle;
            itr_i <= FPA_INTF_CFG.ROIC.ITR;                  -- on s'assure ainsi qu'au bootup et donc apr�s reception de la config d'initialisation, c'est cette derniere qui est prise en compte
            uprow_upcol_i <= FPA_INTF_CFG.ROIC.UPROW_UPCOL;  -- on s'assure ainsi qu'au bootup et donc apr�s reception de la config d'initialisation, c'est cette derniere qui est prise en compte
            sizea_sizeb_i <= '1';                       -- FPA_INTF_CFG.ROIC.SIZEA_SIZEB;  -- on s'assure ainsi qu'au bootup et donc apr�s reception de la config d'initialisation, c'est cette derniere qui est prise en compte
            present_cfg(39) <= '1';   -- le bit 39 seul forc� � '1'. Cela suffit pour eviter des bugs en power management. En fait cela force la reprogrammation apr�s un reset
            error_i <= '0';
            present_cfg_num <= not new_cfg_num;
            
         else    
            
            fpa_error_i <= FPA_ERROR and not sizea_sizeb_i;  -- utilis� seulemnent en mode windowing
            en_i <= EN;
            
            -- configuration du detecteur	
            case roic_cfg_fsm is            
               
               when idle =>                -- en attente que le programmateur soit � l'�coute
                  error_i <= '0';
                  spi_en_i <= '0';
                  done_i <= '1'; 
                  rqst_i <= '0';
                  pause_cnt <= (others => '0');
                  reprog_cnt <= (others => '0');
                  if new_cfg_pending = '1' or new_cfg_num_pending = '1'then
                     roic_cfg_fsm <= check_done_st;  
                  end if;   
               
               when check_done_st =>
                  if SPI_DONE = '1'  then
                     roic_cfg_fsm <= rqst_st;
                  end if;                  
               
               when rqst_st =>     
                  rqst_i <= '1';
                  if en_i = '1' then 
                     roic_cfg_fsm <= cfg_io_st;  
                  end if;
               
               when cfg_io_st => 
                  rqst_i <= '0';
                  done_i <= '0';
                  itr_i <= new_cfg(36);
                  uprow_upcol_i <= new_cfg(35);
                  sizea_sizeb_i <= new_cfg(34); 
                  spi_data_i <= "000000" & new_cfg(33 downto 0);   -- assign� un clk plus t�t                   
                  roic_cfg_fsm <= send_cfg_st;
               
               when send_cfg_st =>                   
                  spi_en_i <= '1';
                  if SPI_DONE = '0'  then 
                     roic_cfg_fsm <= wait_end_st;
                  end if;                  
               
               when wait_end_st =>
                  spi_en_i <= '0';
                  pause_cnt <= (others => '0');
                  if SPI_DONE = '1' then
                     roic_cfg_fsm <= wait_err_st;
                  end if;  
               
               when wait_err_st =>
                  pause_cnt <= pause_cnt + 1;
                  if fpa_error_i = '1' then 
                     error_i <= '1';                   -- ne doit jamais arriver
                  end if;  
                  if pause_cnt = 255 then              -- delai largement suffisant pour que ERROR soit g�n�r�
                     roic_cfg_fsm <= check_roic_err_st;
                  end if;                  
               
               when check_roic_err_st =>                   
                  if error_i = '1' then
                     reprog_cnt <= reprog_cnt + 1;
                     roic_cfg_fsm <= cfg_io_st;   -- si erreur on renvoie la config        
                  else
                     roic_cfg_fsm <= update_reg_st; 
                  end if;                       
                  if reprog_cnt(2) = '1' then
                     roic_cfg_fsm <= update_reg_st;
                  end if;              
               
               when update_reg_st =>
                  present_cfg <= "000" & itr_i & uprow_upcol_i & sizea_sizeb_i & spi_data_i(33 downto 0);
                  roic_cfg_fsm <= pause_st; 
               
               when  pause_st =>
                  pause_cnt <= pause_cnt + 1;
                  present_cfg_num <= new_cfg_num;
                  if pause_cnt = 7 then   --  largenment le temps pour que new_cfg_pending retombe avant d'aller � idle
                     roic_cfg_fsm <= idle;
                  end if;
               
               when others => 
               
            end case;
            
         end if;
      end if;
   end process;
   
   
end rtl;
