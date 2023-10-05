------------------------------------------------------------------
--!   @file : param_sync_to_axis32
--!   @brief
--!   @details : ce module permet de synchroniser un paramètre natif vers une image axis.
--!              le paramètre est constant pendant toute l'image
--!   $Rev$
--!   $Author$  JDE
--!   $Date$    2023-09
--!   $Id$
--!   $URL$
------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;           
use IEEE.numeric_std.ALL;
use work.Tel2000.all;

entity param_sync_to_axis32 is
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
end param_sync_to_axis32;


architecture rtl of param_sync_to_axis32 is

   component sync_reset
      port (
         ARESET : in std_logic;
         CLK    : in std_logic;
         SRESET : out std_logic := '1'
         );
   end component;
   
   constant all_empty   : std_logic_vector(PARAM_FIFO_SIZE-1 downto 0) := (others => '0');
   constant all_valid   : std_logic_vector(PARAM_FIFO_SIZE-1 downto 0) := (others => '1');
   
   type t_param_array     is array (0 to PARAM_FIFO_SIZE-1) of std_logic_vector(PARAM_WIDTH-1 downto 0);
   
   -- Signaux de synchronisation
   signal sreset : std_logic := '1';
   signal error_0 : std_logic := '0';
   
   -- Signaux pour FIFO de paramètres
   signal param_data    : t_param_array;
   signal param_vld     : std_logic_vector(PARAM_FIFO_SIZE-1 downto 0);
   signal paramDone     : std_logic := '0';

   -- Signaux pour génération de AXIS_MOSI
   signal isSyncValid   : std_logic;

   -- Signaux pour FORCE_SYNC = false
   signal isOutputValid : std_logic;
   signal dataCount     : unsigned(7 downto 0);
   signal dataCount_nxt : unsigned(7 downto 0);
   signal axis_tvalid   : std_logic;
   signal tlastFound    : std_logic;
   signal error_1       : std_logic := '0';

begin

    ERR <= error_0 or error_1;
   
    -----------------------------------------------------
    -- Synchronisation reset
    -----------------------------------------------------
    U0: sync_reset
    Port map(		
        ARESET   => ARESET,		
        SRESET   => sreset,
        CLK   => CLK_DATA);   

    ----------------------------------------------------------------------------
    -- PARAM latch (pipeline FIFO)
    ---------------------------------------------------------------------------- 

    U1: process (CLK_DATA)
    begin
        if rising_edge(CLK_DATA) then 
            if sreset = '1' then
                param_vld <= all_empty;
                error_0 <= '0';
            else
                -- param_data(0) est la sortie du FIFO
                -- param_data(PARAM_FIFO_SIZE-1) est l'entrée du FIFO
                
                
                ----------------------------------------
                -- Logique d'avancement et de sortie des données du FIFO
                ----------------------------------------
                -- Pour aider à comprendre, voir le code équivalent plus bas
                genFifo : for k in 0 to PARAM_FIFO_SIZE-2 loop
                    -- Les données avancent dans le FIFO s'il y a un emplacement vide vers la sortie ou si on sort un élément du FIFO (paramDone)
                    if param_vld(k downto 0) /= all_valid(k downto 0) or paramDone = '1' then
                        param_data(k) <= param_data(k+1);
                        param_vld(k)  <= param_vld(k+1);
                    end if;
                end loop genFifo;
                -- On entre '0' dans le dernier emplacement lorsque les données avancent dans le FIFO
                if param_vld(PARAM_FIFO_SIZE-2 downto 0) /= all_valid(PARAM_FIFO_SIZE-2 downto 0) or paramDone = '1' then
                    param_vld(PARAM_FIFO_SIZE-1)  <= '0';
                end if;

                -- Code équivalent pour PARAM_FIFO_SIZE = 4
                ----------------------------------------
                -- if param_vld(0) = '0' or paramDone = '1' then
                --     param_data(0) <= param_data(1);
                --     param_vld(0)  <= param_vld(1);
                --     param_data(1) <= param_data(2);
                --     param_vld(1)  <= param_vld(2);
                --     param_data(2) <= param_data(3);
                --     param_vld(2)  <= param_vld(3);
                --     param_vld(3)  <= '0';
                -- elsif param_vld(1) = '0' then
                --     param_data(1) <= param_data(2);
                --     param_vld(1)  <= param_vld(2);
                --     param_data(2) <= param_data(3);
                --     param_vld(2)  <= param_vld(3);
                --     param_vld(3)  <= '0';
                -- elsif param_vld(2) = '0' then
                --     param_data(2) <= param_data(3);
                --     param_vld(2)  <= param_vld(3);
                --     param_vld(3)  <= '0';
                -- end if;
                ----------------------------------------

                ----------------------------------------
                -- Logique d'entrée des données placée après la logique de sortie pour remplacer l'assignation précédente dans le process
                ----------------------------------------
                if PARAM_IN_VLD = '1' then
                    -- Assignation directement à la sortie du FIFO lorsque vide pour une latence plus faible
                    if param_vld = all_empty then
                        param_data(0) <= PARAM_IN_DATA;
                        param_vld(0)  <= '1';
                    else
                        -- Assignation à la queue du FIFO
                        param_data(PARAM_FIFO_SIZE-1) <= PARAM_IN_DATA;
                        param_vld(PARAM_FIFO_SIZE-1)  <= '1';
                        -- Erreur d'overflow
                        if param_vld = all_valid then
                            error_0 <= '1';
                        end if;
                    end if;
                end if;

            end if;
        end if;
    end process;

    ----------------------------------------------------------------------------
    -- NATIVE vers AXIS (sync externe)
    ---------------------------------------------------------------------------- 
    axisInSync: if FORCE_SYNC = true generate
    
        isSyncValid <= SYNC_MISO.TREADY and SYNC_MOSI.TVALID;
        paramDone   <= isSyncValid and SYNC_MOSI.TLAST;

        AXIS_MOSI.TVALID <= param_vld(0) and isSyncValid;
        AXIS_MOSI.TSTRB <= (others => '1');
        AXIS_MOSI.TKEEP <= (others => '1');
        AXIS_MOSI.TLAST <= SYNC_MOSI.TLAST;
        AXIS_MOSI.TID   <= (others =>'0'); -- non géré 
        AXIS_MOSI.TDEST <= (others =>'0'); -- non géré 
        AXIS_MOSI.TUSER <= (others =>'0'); -- non géré 
        
        U2: process (param_data)
        begin
            AXIS_MOSI.TDATA <= (others => '0');
            AXIS_MOSI.TDATA(PARAM_WIDTH-1 downto 0) <= param_data(0);
        end process;
        
    end generate axisInSync;
    
    ----------------------------------------------------------------------------
    -- NATIVE vers AXIS (sync interne)
    ---------------------------------------------------------------------------- 
    axisNotInSync: if FORCE_SYNC = false generate
    
        isSyncValid   <= SYNC_MISO.TREADY and SYNC_MOSI.TVALID;
        isOutputValid <= AXIS_MISO.TREADY and axis_tvalid;
    
        U2: process (CLK_DATA)
        begin
            if rising_edge(CLK_DATA) then 
                if sreset = '1' then
                    paramDone       <= '0';
                    dataCount       <= (others => '0');
                    dataCount_nxt   <= (others => '0');
                    axis_tvalid     <= '0';
                    tlastFound      <= '0';
                    error_1         <= '0';
                else
                    paramDone       <= '0';
                    
                    axis_tvalid <= '0';
                    AXIS_MOSI.TDATA <= (others => '0');
                    AXIS_MOSI.TDATA(PARAM_WIDTH-1 downto 0) <= param_data(0);
                    AXIS_MOSI.TLAST <= '0';
                    AXIS_MOSI.TSTRB <= (others => '1');
                    AXIS_MOSI.TKEEP <= (others => '1');
                    AXIS_MOSI.TID   <= (others =>'0'); -- non géré 
                    AXIS_MOSI.TDEST <= (others =>'0'); -- non géré 
                    AXIS_MOSI.TUSER <= (others =>'0'); -- non géré 

                    ----------------------------------------
                    -- Compteur de données entrantes et Latch TLAST
                    ----------------------------------------
                    if paramDone = '1' then
                        -- On perd un clk ici pour charger un nouveau paramètre du FIFO
                        -- dataCount = 0 sur le clock cycle où paramDone = '1'
                        if isSyncValid = '1' then
                            dataCount <= dataCount_nxt + 1;
                        else
                            dataCount <= dataCount_nxt;
                        end if;
                    -- On est en cours d'image (tlastFound = '0')
                    elsif tlastFound = '0' then
                        dataCount_nxt   <= (others => '0');
                        
                        if isSyncValid = '1' then
                            if isOutputValid = '1' then
                                -- dataCount inchangé (1 in, 1 out)
                            else
                                dataCount <= dataCount + 1;
                            end if;
                            
                            if SYNC_MOSI.TLAST = '1' then
                                tlastFound <= '1';
                            end if;
                        elsif isOutputValid = '1' then
                            dataCount <= dataCount - 1;
                        end if;
                    -- La fin de l'image est détectée (tlastFound = '1')
                    else
                        -- On utilise un autres compteur après le sync_tlast (pixels de l'image suivante) en attendant la fin de sortie des paramètres
                        if isSyncValid = '1' then
                            dataCount_nxt <= dataCount_nxt + 1;
                        end if;
                        
                        -- Output data
                        if isOutputValid = '1' then
                            dataCount <= dataCount - 1;
                            -- Pas de nouveau data sur le TLAST, on perd un clk pour valider que le TLAST est bien accepté (TREADY = '1')
                            if dataCount = 1 then
                                -- Début de la prochaine image, on charge le nouveau paramètre
                                tlastFound <= '0';
                                paramDone <= '1';
                            end if;
                        end if;
                    end if;

                    ----------------------------------------
                    -- AXIS TVALID et TLAST
                    ----------------------------------------
                    -- On prend en compte la latence = 2 de mise à jour du compteur dataCount
                    if tlastFound = '0' and (dataCount > 1 or (dataCount = 1 and isOutputValid = '0')) then
                        axis_tvalid <= param_vld(0);
                    -- Dernière données de l'image
                    elsif tlastFound = '1' then
                        -- On continue de sortir le paramètre jusque proche du TLAST
                        if dataCount > 2 then
                            axis_tvalid   <= '1';
                        elsif dataCount = 2 and isOutputValid = '0' then
                            -- Encore 2 paramètres à sortir
                            axis_tvalid   <= '1';
                        elsif (dataCount = 2 and isOutputValid = '1') or (dataCount = 1 and isOutputValid = '0') then
                            -- Dernier paramètre
                            axis_tvalid   <= '1';
                            AXIS_MOSI.TLAST <= '1';
                        end if;
                    end if;

                    ----------------------------------------
                    -- Overflow
                    ----------------------------------------
                    if dataCount = "11111111" then
                        -- Data counter overflow et underflow
                        error_1 <= '1';
                    end if;
                    
                end if;
            end if;
        end process;
        
        AXIS_MOSI.TVALID <= axis_tvalid;
        
    end generate axisNotInSync;
   
end rtl;
