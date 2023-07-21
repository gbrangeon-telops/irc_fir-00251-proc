-------------------------------------------------------------------------------
--
-- Title       : fbuffer_define
-- Design      : tb_frame_buffer
-- Author      : Philippe Couture   
-- Company     : Telops
--
-------------------------------------------------------------------------------
--
-- File        : D:\Telops\FIR-00251-Proc\src\FrameBuffer\HDL\fbuffer_define.vhd
-- Generated   : Mon Aug 10 13:21:40 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use work.tel2000.all; 

package fbuffer_define is    	  

  
      
   constant STREAM_PIXEL_WIDTH   : integer := 4; -- Pixel stream width (TDATA = 64 bits)
   constant NB_PIPE_STAGE        : integer := 2; -- Writer_sm : number of input pipe stages
   constant RD_NB_CMD_QUEUE      : integer := 2;  

   constant LVAL_PAUSE           : unsigned(31 downto 0) := to_unsigned(1,32);
   constant FVAL_PAUSE           : unsigned(31 downto 0) := to_unsigned(3,32);
     
   constant BUFFER_A_TAG         : unsigned(1 downto 0) := to_unsigned(1,2);
   constant BUFFER_B_TAG         : unsigned(1 downto 0) := to_unsigned(2,2);
   constant BUFFER_C_TAG         : unsigned(1 downto 0) := to_unsigned(3,2);
   
   constant RSVD                 : std_logic_vector(3 downto 0) := "0000"; -- Not used 
   constant DRR                  : std_logic := '0'; -- Not used
   constant DSA                  : std_logic_vector(5 downto 0) := "000000"; -- Not used
   constant CTYPE                : std_logic := '1'; -- FIXED=0 , INCR=1 
   
   type frame_buffer_cfg_type is
   record 
      buffer_a_addr	           : unsigned(31 downto 0);                -- buffer a base address 
      buffer_b_addr             : unsigned(31 downto 0);                -- buffer b base address 
      buffer_c_addr             : unsigned(31 downto 0);                -- buffer c base address 
      frame_byte_size           : unsigned(31 downto 0);                -- frame size in bytes
      hdr_pix_size              : unsigned(31 downto 0);                -- header size in bytes 
      img_pix_size              : unsigned(31 downto 0);                -- image size in bytes
      lval_pause_min            : unsigned(31 downto 0);                -- minimum pause between lines 
      fval_pause_min            : unsigned(31 downto 0);                -- minimum pause between frames	   
      bypass                    : std_logic;                            -- bypass frame buffer
      dval                      : std_logic;                            -- config valid flag
   end record frame_buffer_cfg_type;
 
   type buffer_status_type is
   record 
      pbuf           	                    : unsigned(31 downto 0);       -- buffer pointer
      tag                                   : unsigned(1 downto 0);
      valid                                 : std_logic;                           -- pulse generated when full status & pbuf address are updated
   end record buffer_status_type;
 
   signal s_fb_cfg : frame_buffer_cfg_type;
   constant fb_cfg_default : frame_buffer_cfg_type := (
   to_unsigned(0,s_fb_cfg.buffer_a_addr'LENGTH),    
   to_unsigned(2*1920*1538,s_fb_cfg.buffer_b_addr'LENGTH),   
   to_unsigned(2*2*1920*1538,s_fb_cfg.buffer_c_addr'LENGTH),   
   to_unsigned(2*1920*1538,s_fb_cfg.frame_byte_size'LENGTH),   
   to_unsigned(1920*2,s_fb_cfg.hdr_pix_size'LENGTH),          
   to_unsigned(1920*1536,s_fb_cfg.img_pix_size'LENGTH),      
   LVAL_PAUSE,
   FVAL_PAUSE,
   '0',
   '0'
   );  
   
   constant buf_sts_default : buffer_status_type := (
   to_unsigned(0,32),
   to_unsigned(0,2),
   '0'
   );
   type axis128_mosi_pipe is array (natural range 0 to 1) of t_axi4_stream_mosi128;
   
end fbuffer_define;

package body fbuffer_define is
   
end package body fbuffer_define; 