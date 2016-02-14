------------------------------------------------------------------
--!   @file : dfpa_interface
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
use work.fpa_common_pkg.all;
use work.fpa_define.all;

entity dfpa_interface is
   
   port(
      ACQ_TRIG          : in STD_LOGIC;
      ARESETN           : in STD_LOGIC;
      CLK_100M          : in STD_LOGIC;
      DET_FREQ_ID       : in STD_LOGIC;
      DET_SPARE_N0      : in STD_LOGIC;
      DET_SPARE_N1      : in STD_LOGIC;
      DET_SPARE_N2      : in STD_LOGIC;
      DET_SPARE_P0      : in STD_LOGIC;
      DET_SPARE_P1      : in STD_LOGIC;
      DET_SPARE_P2      : in STD_LOGIC;
      DOUT_CLK          : in STD_LOGIC;
      DOUT_MISO         : in t_axi4_stream_miso;
      FPA_CH1_CLK       : in STD_LOGIC;
      FPA_CH1_DATA      : in STD_LOGIC_VECTOR(27 downto 0);
      FPA_CH1_RDY       : in STD_LOGIC;
      FPA_CH2_CLK       : in STD_LOGIC;
      FPA_CH2_DATA      : in STD_LOGIC_VECTOR(27 downto 0);
      FPA_CH2_RDY       : in STD_LOGIC;
      FPA_EXP_INFO      : in exp_info_type;
      HDER_MISO         : in t_axi4_lite_miso;
      INT_FBK_N         : in STD_LOGIC;
      INT_FBK_P         : in STD_LOGIC;
      MB_CLK            : in STD_LOGIC;
      MB_MOSI           : in t_axi4_lite_mosi;
      SER_TFG_N         : in STD_LOGIC;
      SER_TFG_P         : in STD_LOGIC;
      XTRA_TRIG         : in STD_LOGIC;
      DET_CC_N1         : out STD_LOGIC;
      DET_CC_N2         : out STD_LOGIC;
      DET_CC_N3         : out STD_LOGIC;
      DET_CC_N4         : out STD_LOGIC;
      DET_CC_P1         : out STD_LOGIC;
      DET_CC_P2         : out STD_LOGIC;
      DET_CC_P3         : out STD_LOGIC;
      DET_CC_P4         : out STD_LOGIC;
      DET_FPA_ON        : out STD_LOGIC;
      DOUT_MOSI         : out t_axi4_stream_mosi32;
      ERR_FOUND         : out STD_LOGIC;
      FSYNC_N           : out STD_LOGIC;
      FSYNC_P           : out STD_LOGIC;
      HDER_MOSI         : out t_axi4_lite_mosi;
      IMAGE_INFO        : out img_info_type;
      INTF_CFG_FOR_SIM  : out fpa_intf_cfg_type;
      MB_MISO           : out t_axi4_lite_miso;
      RST_CLINK_N       : out STD_LOGIC;
      SER_TC_N          : out STD_LOGIC;
      SER_TC_P          : out STD_LOGIC
      );
end dfpa_interface;

architecture SCH of dfpa_interface is
   
   component PelicanD      
      port (
         ACQ_TRIG          : in STD_LOGIC;
         ARESETN           : in STD_LOGIC;
         CLK_100M          : in STD_LOGIC;
         DET_FREQ_ID       : in STD_LOGIC;
         DET_SPARE_N0      : in STD_LOGIC;
         DET_SPARE_N1      : in STD_LOGIC;
         DET_SPARE_N2      : in STD_LOGIC;
         DET_SPARE_P0      : in STD_LOGIC;
         DET_SPARE_P1      : in STD_LOGIC;
         DET_SPARE_P2      : in STD_LOGIC;
         DOUT_CLK          : in STD_LOGIC;
         DOUT_MISO         : in t_axi4_stream_miso;
         FPA_CH1_CLK       : in STD_LOGIC;
         FPA_CH1_DATA      : in STD_LOGIC_VECTOR(27 downto 0);
         FPA_CH1_RDY       : in STD_LOGIC;
         FPA_CH2_CLK       : in STD_LOGIC;
         FPA_CH2_DATA      : in STD_LOGIC_VECTOR(27 downto 0);
         FPA_CH2_RDY       : in STD_LOGIC;
         FPA_EXP_INFO      : in exp_info_type;
         HDER_MISO         : in t_axi4_lite_miso;
         INT_FBK_N         : in STD_LOGIC;
         INT_FBK_P         : in STD_LOGIC;
         MB_CLK            : in STD_LOGIC;
         MB_MOSI           : in t_axi4_lite_mosi;
         SER_TFG_N         : in STD_LOGIC;
         SER_TFG_P         : in STD_LOGIC;
         XTRA_TRIG         : in STD_LOGIC;
         DET_CC_N1         : out STD_LOGIC;
         DET_CC_N2         : out STD_LOGIC;
         DET_CC_N3         : out STD_LOGIC;
         DET_CC_N4         : out STD_LOGIC;
         DET_CC_P1         : out STD_LOGIC;
         DET_CC_P2         : out STD_LOGIC;
         DET_CC_P3         : out STD_LOGIC;
         DET_CC_P4         : out STD_LOGIC;
         DET_FPA_ON        : out STD_LOGIC;
         DOUT_MOSI         : out t_axi4_stream_mosi32;
         ERR_FOUND         : out STD_LOGIC;
         FSYNC_N           : out STD_LOGIC;
         FSYNC_P           : out STD_LOGIC;
         HDER_MOSI         : out t_axi4_lite_mosi;
         IMAGE_INFO        : out img_info_type;
         INTF_CFG_FOR_SIM  : out fpa_intf_cfg_type;
         MB_MISO           : out t_axi4_lite_miso;
         RST_CLINK_N       : out STD_LOGIC;
         SER_TC_N          : out STD_LOGIC;
         SER_TC_P          : out STD_LOGIC
         );
   end component;
   
   component ScorpioLW      
      port (
         ACQ_TRIG          : in STD_LOGIC;
         ARESETN           : in STD_LOGIC;
         CLK_100M          : in STD_LOGIC;
         DET_FREQ_ID       : in STD_LOGIC;
         DET_SPARE_N0      : in STD_LOGIC;
         DET_SPARE_N1      : in STD_LOGIC;
         DET_SPARE_N2      : in STD_LOGIC;
         DET_SPARE_P0      : in STD_LOGIC;
         DET_SPARE_P1      : in STD_LOGIC;
         DET_SPARE_P2      : in STD_LOGIC;
         DOUT_CLK          : in STD_LOGIC;
         DOUT_MISO         : in t_axi4_stream_miso;
         FPA_CH1_CLK       : in STD_LOGIC;
         FPA_CH1_DATA      : in STD_LOGIC_VECTOR(27 downto 0);
         FPA_CH1_RDY       : in STD_LOGIC;
         FPA_CH2_CLK       : in STD_LOGIC;
         FPA_CH2_DATA      : in STD_LOGIC_VECTOR(27 downto 0);
         FPA_CH2_RDY       : in STD_LOGIC;
         FPA_EXP_INFO      : in exp_info_type;
         HDER_MISO         : in t_axi4_lite_miso;
         INT_FBK_N         : in STD_LOGIC;
         INT_FBK_P         : in STD_LOGIC;
         MB_CLK            : in STD_LOGIC;
         MB_MOSI           : in t_axi4_lite_mosi;
         SER_TFG_N         : in STD_LOGIC;
         SER_TFG_P         : in STD_LOGIC;
         XTRA_TRIG         : in STD_LOGIC;
         DET_CC_N1         : out STD_LOGIC;
         DET_CC_N2         : out STD_LOGIC;
         DET_CC_N3         : out STD_LOGIC;
         DET_CC_N4         : out STD_LOGIC;
         DET_CC_P1         : out STD_LOGIC;
         DET_CC_P2         : out STD_LOGIC;
         DET_CC_P3         : out STD_LOGIC;
         DET_CC_P4         : out STD_LOGIC;
         DET_FPA_ON        : out STD_LOGIC;
         DOUT_MOSI         : out t_axi4_stream_mosi32;
         ERR_FOUND         : out STD_LOGIC;
         FSYNC_N           : out STD_LOGIC;
         FSYNC_P           : out STD_LOGIC;
         HDER_MOSI         : out t_axi4_lite_mosi;
         IMAGE_INFO        : out img_info_type;
         INTF_CFG_FOR_SIM  : out fpa_intf_cfg_type;
         MB_MISO           : out t_axi4_lite_miso;
         RST_CLINK_N       : out STD_LOGIC;
         SER_TC_N          : out STD_LOGIC;
         SER_TC_P          : out STD_LOGIC
         );
   end component;
   
begin
   
   ---------------------------------------------------------
   -- PelicanD                                               
   ---------------------------------------------------------
   pelicanD_gen: if DEFINE_FPA_ROIC = FPA_ROIC_PELICAND generate	
      begin      
      U1: PelicanD
      port map (
         ACQ_TRIG         =>    ACQ_TRIG,          
         ARESETN          =>    ARESETN,           
         CLK_100M         =>    CLK_100M,          
         DET_FREQ_ID      =>    DET_FREQ_ID,       
         DET_SPARE_N0     =>    DET_SPARE_N0,      
         DET_SPARE_N1     =>    DET_SPARE_N1,      
         DET_SPARE_N2     =>    DET_SPARE_N2,      
         DET_SPARE_P0     =>    DET_SPARE_P0,      
         DET_SPARE_P1     =>    DET_SPARE_P1,      
         DET_SPARE_P2     =>    DET_SPARE_P2,      
         DOUT_CLK         =>    DOUT_CLK,          
         DOUT_MISO        =>    DOUT_MISO,         
         FPA_CH1_CLK      =>    FPA_CH1_CLK,       
         FPA_CH1_DATA     =>    FPA_CH1_DATA,      
         FPA_CH1_RDY      =>    FPA_CH1_RDY,       
         FPA_CH2_CLK      =>    FPA_CH2_CLK,       
         FPA_CH2_DATA     =>    FPA_CH2_DATA,      
         FPA_CH2_RDY      =>    FPA_CH2_RDY,       
         FPA_EXP_INFO     =>    FPA_EXP_INFO,      
         HDER_MISO        =>    HDER_MISO,         
         INT_FBK_N        =>    INT_FBK_N,         
         INT_FBK_P        =>    INT_FBK_P,         
         MB_CLK           =>    MB_CLK,            
         MB_MOSI          =>    MB_MOSI,           
         SER_TFG_N        =>    SER_TFG_N,         
         SER_TFG_P        =>    SER_TFG_P,         
         XTRA_TRIG        =>    XTRA_TRIG,         
         DET_CC_N1        =>    DET_CC_N1,         
         DET_CC_N2        =>    DET_CC_N2,         
         DET_CC_N3        =>    DET_CC_N3,         
         DET_CC_N4        =>    DET_CC_N4,         
         DET_CC_P1        =>    DET_CC_P1,         
         DET_CC_P2        =>    DET_CC_P2,         
         DET_CC_P3        =>    DET_CC_P3,         
         DET_CC_P4        =>    DET_CC_P4,         
         DET_FPA_ON       =>    DET_FPA_ON,        
         DOUT_MOSI        =>    DOUT_MOSI,         
         ERR_FOUND        =>    ERR_FOUND,         
         FSYNC_N          =>    FSYNC_N,           
         FSYNC_P          =>    FSYNC_P,           
         HDER_MOSI        =>    HDER_MOSI,         
         IMAGE_INFO       =>    IMAGE_INFO,        
         INTF_CFG_FOR_SIM =>    INTF_CFG_FOR_SIM,  
         MB_MISO          =>    MB_MISO,           
         RST_CLINK_N      =>    RST_CLINK_N,       
         SER_TC_N         =>    SER_TC_N,          
         SER_TC_P         =>    SER_TC_P  
         );
   end generate;
   
   ---------------------------------------------------------
   -- ScorpioLW                                               
   ---------------------------------------------------------
   ScorpioLW_gen: if DEFINE_FPA_ROIC = FPA_ROIC_SCORPIO_LW generate	
      begin      
      U1: scorpioLW
      port map (
         ACQ_TRIG         =>    ACQ_TRIG,          
         ARESETN          =>    ARESETN,           
         CLK_100M         =>    CLK_100M,          
         DET_FREQ_ID      =>    DET_FREQ_ID,       
         DET_SPARE_N0     =>    DET_SPARE_N0,      
         DET_SPARE_N1     =>    DET_SPARE_N1,      
         DET_SPARE_N2     =>    DET_SPARE_N2,      
         DET_SPARE_P0     =>    DET_SPARE_P0,      
         DET_SPARE_P1     =>    DET_SPARE_P1,      
         DET_SPARE_P2     =>    DET_SPARE_P2,      
         DOUT_CLK         =>    DOUT_CLK,          
         DOUT_MISO        =>    DOUT_MISO,         
         FPA_CH1_CLK      =>    FPA_CH1_CLK,       
         FPA_CH1_DATA     =>    FPA_CH1_DATA,      
         FPA_CH1_RDY      =>    FPA_CH1_RDY,       
         FPA_CH2_CLK      =>    FPA_CH2_CLK,       
         FPA_CH2_DATA     =>    FPA_CH2_DATA,      
         FPA_CH2_RDY      =>    FPA_CH2_RDY,       
         FPA_EXP_INFO     =>    FPA_EXP_INFO,      
         HDER_MISO        =>    HDER_MISO,         
         INT_FBK_N        =>    INT_FBK_N,         
         INT_FBK_P        =>    INT_FBK_P,         
         MB_CLK           =>    MB_CLK,            
         MB_MOSI          =>    MB_MOSI,           
         SER_TFG_N        =>    SER_TFG_N,         
         SER_TFG_P        =>    SER_TFG_P,         
         XTRA_TRIG        =>    XTRA_TRIG,         
         DET_CC_N1        =>    DET_CC_N1,         
         DET_CC_N2        =>    DET_CC_N2,         
         DET_CC_N3        =>    DET_CC_N3,         
         DET_CC_N4        =>    DET_CC_N4,         
         DET_CC_P1        =>    DET_CC_P1,         
         DET_CC_P2        =>    DET_CC_P2,         
         DET_CC_P3        =>    DET_CC_P3,         
         DET_CC_P4        =>    DET_CC_P4,         
         DET_FPA_ON       =>    DET_FPA_ON,        
         DOUT_MOSI        =>    DOUT_MOSI,         
         ERR_FOUND        =>    ERR_FOUND,         
         FSYNC_N          =>    FSYNC_N,           
         FSYNC_P          =>    FSYNC_P,           
         HDER_MOSI        =>    HDER_MOSI,         
         IMAGE_INFO       =>    IMAGE_INFO,        
         INTF_CFG_FOR_SIM =>    INTF_CFG_FOR_SIM,  
         MB_MISO          =>    MB_MISO,           
         RST_CLINK_N      =>    RST_CLINK_N,       
         SER_TC_N         =>    SER_TC_N,          
         SER_TC_P         =>    SER_TC_P  
         );
   end generate;
end SCH;