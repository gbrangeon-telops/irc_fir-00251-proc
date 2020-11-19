-------------------------------------------------------------------------------
--
-- Title       : moi_flag_gen
-- Author      : Philippe Couture
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.Tel2000.all;
use work.BufferingDefine.all;

entity moi_flag_gen is
   
   port(
   
      SEQ_WRITE_DONE           : in  STD_LOGIC;
      EXTERNAL_SEQ_WRITE_DONE  : in  STD_LOGIC;
      BUFFER_SWITCH            : in  std_logic_vector(3 downto 0); 
      BUFFER_MODE              : in  BufferMode;
      ACQ_STOP                 : in  STD_LOGIC; 
      
      MOI_SIGNAL               : in STD_LOGIC;      
      
      BUFFERING_FLAG           : out buffering_flag_type;
      BUFFERING_FLAG_UPDATE_DONE : in  std_logic;
      ARESETN                  : in  std_logic;
      CLK                      : in  std_logic     
      );
end moi_flag_gen;


architecture RTL of moi_flag_gen is 

   component SYNC_RESET is
      port(
         --clk and reset
         CLK    : in std_logic;
         ARESET : in std_logic;
         SRESET : out std_logic
         );
   end component;
   
   component double_sync
      generic(
         INIT_VALUE : bit := '0'
      );
   	port(
   		D : in STD_LOGIC;
   		Q : out STD_LOGIC := '0';
   		RESET : in STD_LOGIC;
   		CLK : in STD_LOGIC
      );
   end component;
   
   component gh_edge_det
      port(
         clk   : in STD_LOGIC;
         rst   : in STD_LOGIC;
         D     : in STD_LOGIC;
         re    : out STD_LOGIC;
         fe    : out STD_LOGIC;
         sre   : out STD_LOGIC;
         sfe   : out STD_LOGIC);
   end component;
   
   type   flag_status_sm_type is (idle_st, wait_moi_flag_update_st, seq_write_end_st);
   signal flag_status_sm                    : flag_status_sm_type;
   type   flag_update_sm_type is (idle_st, wait_flag_update_st, reset_st);
   signal flag_update_sm                    : flag_update_sm_type;

   
   signal areset                             : std_logic;
   signal sreset                             : std_logic;
   signal seq_write_done_i                   : std_logic;
   signal seq_write_done_re                  : std_logic;
   signal external_seq_write_done_sync       : std_logic;
   signal buffering_flag_new                 : buffering_flag_type;
   signal buffering_flag_old                 : buffering_flag_type;
   
   signal update_done                        : std_logic;
   signal update_done_last                   : std_logic;
   
   signal buffering_flag_update_done_re      : std_logic;
   signal buffering_flag_update_done_fe      : std_logic;
   signal reset_o                            : std_logic;
   
begin    
   
   areset <= not ARESETN;
   seq_write_done_i <= SEQ_WRITE_DONE when BUFFER_SWITCH(1) = '1' else external_seq_write_done_sync;
   BUFFERING_FLAG <= buffering_flag_new; 
   --------------------------------------------------
   -- synchro reset 
   --------------------------------------------------   
   U1: sync_reset
   port map(
      ARESET => areset,
      CLK    => CLK,
      SRESET => sreset
   );
   
   U2 : double_sync 
   port map(
      D => EXTERNAL_SEQ_WRITE_DONE,
      Q => external_seq_write_done_sync,
      RESET => sreset,
      CLK => CLK
   );
    
   U3 : gh_edge_det port map(clk => CLK, rst => sreset, D => BUFFERING_FLAG_UPDATE_DONE, sre => buffering_flag_update_done_re, re => open, fe => open, sfe => buffering_flag_update_done_fe);
   U4 : gh_edge_det port map(clk => CLK, rst => sreset, D => seq_write_done_i, sre => seq_write_done_re, re => open, fe => open, sfe => open);
   
   ---------------------------------------------------------------------
   -- Process to handle the buffering flag status.
   ---------------------------------------------------------------------
   U5 : process(CLK)
   begin
      if rising_edge(CLK) then
         if sreset = '1' then            
         
            flag_status_sm <= idle_st;
            buffering_flag_new.val <= NONE_FLAG;
            reset_o <= '0';   
            
         else  
            
            case flag_status_sm is
            
               when idle_st =>  
               
                  if update_done = '1' then
                  
                     reset_o <= '0'; 
                     
                     if  ACQ_STOP = '1' or BUFFER_MODE /= BUF_WR_SEQ then
                        buffering_flag_new.val <= NONE_FLAG;
                     elsif MOI_SIGNAL = '1'  then
                        buffering_flag_new.val <= MOI_FLAG;
                        flag_status_sm <= wait_moi_flag_update_st;
                     else
                        buffering_flag_new.val <= PRE_MOI_FLAG;
                     end if;
                  
                  end if;
               
               when wait_moi_flag_update_st => 
               
                  if seq_write_done_re = '1'  or ACQ_STOP = '1' or BUFFER_MODE /= BUF_WR_SEQ then
                     reset_o <= '1';
                     flag_status_sm <= idle_st; 
                  elsif update_done = '1' and update_done_last = '0' then 
                     buffering_flag_new.val <= POST_MOI_FLAG;
                     flag_status_sm <= seq_write_end_st;
                  end if;
               
               when seq_write_end_st => 
               
                  if seq_write_done_re = '1' or ACQ_STOP = '1' or BUFFER_MODE /= BUF_WR_SEQ then
                     flag_status_sm <= idle_st;
                  end if;
               
               when others =>
            
            end case;
         end if;
      end if;
   end process;      
   
   ------------------------------------------------------------------------------
   -- Process to handle the buffering flag transmission the trig stamper module.
   ------------------------------------------------------------------------------
   U6 : process(CLK)
   begin
     if rising_edge(CLK) then
        if sreset = '1' then 
           
            flag_update_sm <= idle_st;
            buffering_flag_new.dval <= '0';
            buffering_flag_old.val <= NONE_FLAG;
            buffering_flag_old.dval <= '0';
            update_done <= '1'; 
            
        else     
           
            update_done_last <= update_done;
            buffering_flag_old.val <= buffering_flag_new.val;
            
            case flag_update_sm is
             
               when idle_st => 
               
                  update_done <= '1';

                  if buffering_flag_old.val /= buffering_flag_new.val then
                     update_done <= '0';
                     buffering_flag_new.dval <= '1';           
                     flag_update_sm <= wait_flag_update_st;
                  end if;
                 
               when wait_flag_update_st => 
               
                    if reset_o = '1' then                      
                       flag_update_sm <= reset_st; 
                    elsif buffering_flag_update_done_fe = '1' then
                       buffering_flag_new.dval <= '0';
                    elsif buffering_flag_update_done_re = '1' then
                       flag_update_sm <= idle_st; 
                    end if;
                    

               when reset_st =>  
               
                  buffering_flag_new.dval <= '1';
                  if buffering_flag_update_done_re = '1' then
                     buffering_flag_new.dval <= '0';
                     flag_update_sm <= idle_st; 
                  end if;
                    
               when others =>
                 
             end case;

         end if;
     end if;
   end process;  
   
   end RTL;
   