-------------------------------------------------------------------------------
--
-- Title       : bd_wrapper
-- Design      : FIR_00251
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : d:\Telops\FIR-00251-Proc\aldec\src\bd_wrapper.vhd
-- Generated   : Mon Jan  6 13:43:39 2014
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
use work.TEL2000.all;

entity bd_wrapper is
   generic(
      G_4DDR     : boolean := false
      );
   port(
      ADC_READOUT_CTRL_MOSI : out t_axi4_lite_mosi;
      ADC_READOUT_CTRL_MISO : in t_axi4_lite_miso;
      AEC_CTRL_MOSI : out t_axi4_lite_mosi;
      AEC_CTRL_MISO : in t_axi4_lite_miso;
      CALIB_RAM_MOSI : out t_axi4_lite_mosi;
      CALIB_RAM_MISO : in t_axi4_lite_miso;
      CALIBCONFIG_MOSI : out t_axi4_lite_mosi;
      CALIBCONFIG_MISO : in t_axi4_lite_miso;
      NLC_LUT_MOSI : out t_axi4_lite_mosi;
      NLC_LUT_MISO : in t_axi4_lite_miso;
      RQC_LUT_MOSI : out t_axi4_lite_mosi;
      RQC_LUT_MISO : in t_axi4_lite_miso;
      EXPTIME_CTRL_MOSI : out t_axi4_lite_mosi;
      EXPTIME_CTRL_MISO : in t_axi4_lite_miso;
      BUFFERING_CTRL_MOSI : out t_axi4_lite_mosi;
      BUFFERING_CTRL_MISO : in t_axi4_lite_miso;
      BUFTABLE_MOSI : out t_axi4_lite_mosi;
      BUFTABLE_MISO : in t_axi4_lite_miso;
      FPA_CTRL_MOSI : out t_axi4_lite_mosi;
      FPA_CTRL_MISO : in t_axi4_lite_miso;
      HEADER_CTRL_MOSI : out t_axi4_lite_mosi;
      HEADER_CTRL_MISO : in t_axi4_lite_miso;
      SFW_CTRL_MOSI : out t_axi4_lite_mosi;
      SFW_CTRL_MISO : in t_axi4_lite_miso;
      TRIGGER_CTRL_MOSI : out t_axi4_lite_mosi;
      TRIGGER_CTRL_MISO : in t_axi4_lite_miso;
      FAN_CTRL_MOSI : out t_axi4_lite_mosi;
      FAN_CTRL_MISO : in t_axi4_lite_miso;
      MGT_CTRL_MOSI : out t_axi4_lite_mosi;
      MGT_CTRL_MISO : in t_axi4_lite_miso;
      IRIG_CTRL_MOSI : out t_axi4_lite_mosi;
      IRIG_CTRL_MISO : in t_axi4_lite_miso;
      BULK_AXI_MISO : in t_axi4_lite_miso;
      BULK_AXI_MOSI : out t_axi4_lite_mosi;
      FLASHINTF_AXI_MOSI : out t_axi4_a32_d32_mosi; 
      FLASHINTF_AXI_MISO : in t_axi4_a32_d32_miso;
      AXIL_ICU_MOSI : out t_axi4_lite_mosi; 
      AXIL_ICU_MISO : in t_axi4_lite_miso; 
      EHDRI_CTRL_MOSI : out t_axi4_lite_mosi;
      EHDRI_CTRL_MISO : in t_axi4_lite_miso;
	  
      FB_CTRL_MOSI                  : out t_axi4_lite_mosi;
      FB_CTRL_MISO                  : in t_axi4_lite_miso;
      AXIS_MM2S_CMD_MOSI_FB         : in t_axi4_stream_mosi_cmd32;
      AXIS_MM2S_CMD_MISO_FB         : out t_axi4_stream_miso;
      AXIS_MM2S_STS_MOSI_FB         : out t_axi4_stream_mosi_status;
      AXIS_MM2S_STS_MISO_FB         : in t_axi4_stream_miso;
      AXIS_MM2S_DATA_MOSI_FB        : out t_axi4_stream_mosi64;
      AXIS_MM2S_DATA_MISO_FB        : in t_axi4_stream_miso;
      AXIS_S2MM_CMD_MOSI_FB         : in t_axi4_stream_mosi_cmd32;   
      AXIS_S2MM_CMD_MISO_FB         : out t_axi4_stream_miso;
      AXIS_S2MM_STS_MOSI_FB         : out t_axi4_stream_mosi_status;
      AXIS_S2MM_STS_MISO_FB         : in t_axi4_stream_miso;
      AXIS_S2MM_DATA_MOSI_FB        : in t_axi4_stream_mosi128;
      AXIS_S2MM_DATA_MISO_FB        : out t_axi4_stream_miso;
      
      UART_CLINK_TX : out STD_LOGIC;
      UART_CLINK_RX : in STD_LOGIC;
	   
      UART_OUTPUT_RX : in STD_LOGIC;
      UART_OUTPUT_TX : out STD_LOGIC;
	  
      UART_OEM_RX : in STD_LOGIC;
      UART_OEM_TX : out STD_LOGIC;
      
      UART_PLEORA_RX : in STD_LOGIC;
      UART_PLEORA_TX : out STD_LOGIC;
      
      USB_TO_UART : in t_uartns550_in;
      UART_TO_USB : out t_uartns550_out;
      LENS_UART_SOUT : out STD_LOGIC;
      LENS_UART_SIN : in STD_LOGIC;
      
      UART_GPS_RX : in STD_LOGIC;
      UART_GPS_TX : out STD_LOGIC;
      
      UART_FW_RX : in STD_LOGIC;
      UART_FW_TX : out STD_LOGIC;
 
      UART_NDF_RX : in STD_LOGIC;
      UART_NDF_TX : out STD_LOGIC;
      
      LED_GPIO_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
      POWER_GPIO : inout STD_LOGIC_VECTOR ( 7 downto 0 );
      BUTTON : in STD_LOGIC;
      
      MUX_ADDR : out std_logic_vector(4 downto 0);
      
      REV_GPIO : in std_logic_vector(7 downto 0);
      
      Code_mem_addr : out STD_LOGIC_VECTOR ( 13 downto 0 );
      Code_mem_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
      Code_mem_cas_n : out STD_LOGIC;
      Code_mem_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
      Code_mem_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
      Code_mem_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
      Code_mem_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
      Code_mem_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
      Code_mem_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
      Code_mem_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
      Code_mem_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
      Code_mem_ras_n : out STD_LOGIC;
      Code_mem_reset_n : out STD_LOGIC;
      Code_mem_we_n : out STD_LOGIC;
      
      ARESETN : out STD_LOGIC;
      clk_mb : out STD_LOGIC;
      clk_cal : out STD_LOGIC;
      clk_irig : out STD_LOGIC;
      clk_200 : out STD_LOGIC;
      clk_mgt_init : out STD_LOGIC;
      clk_data : out STD_LOGIC;   
      clk_din : in STD_LOGIC;
      ext_reset_in : in STD_LOGIC;
      vn_in : in STD_LOGIC;
      vp_in : in STD_LOGIC;
      SYS_CLK_0_P : in STD_LOGIC;
      SYS_CLK_0_N : in STD_LOGIC;
      SYS_CLK_1_P : in STD_LOGIC;
      SYS_CLK_1_N : in STD_LOGIC;
      
      --INTERUPT PORT
      bulk_interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
      AEC_INTC : in std_logic;
      
      CAL_DDR_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
      CAL_DDR_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
      CAL_DDR_cas_n : out STD_LOGIC;
      CAL_DDR_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
      CAL_DDR_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
      CAL_DDR_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
      CAL_DDR_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
      CAL_DDR_dm : out STD_LOGIC_VECTOR ( 7 downto 0 );
      CAL_DDR_dq : inout STD_LOGIC_VECTOR ( 63 downto 0 );
      CAL_DDR_dqs_n : inout STD_LOGIC_VECTOR ( 7 downto 0 );
      CAL_DDR_dqs_p : inout STD_LOGIC_VECTOR ( 7 downto 0 );
      CAL_DDR_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
      CAL_DDR_ras_n : out STD_LOGIC;
      CAL_DDR_reset_n : out STD_LOGIC;
      CAL_DDR_we_n : out STD_LOGIC;
      
      AXI4_STREAM_DATA_MOSI : out t_axi4_stream_mosi128;
      AXI4_STREAM_DATA_MISO : in t_axi4_stream_miso;
      AXI4_STREAM_ADD_MOSI : in t_axi4_stream_mosi72;
      AXI4_STREAM_ADD_MISO : out t_axi4_stream_miso;
      
      
      AXIS_BUF_S2MM_MOSI : in t_axi4_stream_mosi64;
      AXIS_BUF_S2MM_MISO : out t_axi4_stream_miso;
      
      AXIS_BUF_S2MM_CMD_MOSI : in t_axi4_stream_mosi_cmd32;
      AXIS_BUF_S2MM_CMD_MISO : out t_axi4_stream_miso;
      
      AXIS_BUF_S2MM_STS_MOSI : out t_axi4_stream_mosi_status;
      AXIS_BUF_S2MM_STS_MISO : in t_axi4_stream_miso;
      
      AXIS_BUF_MM2S_MOSI : out t_axi4_stream_mosi64;
      AXIS_BUF_MM2S_MISO : in t_axi4_stream_miso;
      
      AXIS_BUF_MM2S_CMD_MOSI : in t_axi4_stream_mosi_cmd32;
      AXIS_BUF_MM2S_CMD_MISO : out t_axi4_stream_miso;
      
      AXIS_BUF_MM2S_STS_MOSI : out t_axi4_stream_mosi_status;
      AXIS_BUF_MM2S_STS_MISO : in t_axi4_stream_miso;
      
      AXIS_USART_RX_MOSI : in t_axi4_stream_mosi32;
      AXIS_USART_RX_MISO : out t_axi4_stream_miso;
      
      AXIS_USART_TX_MOSI : out t_axi4_stream_mosi32;
      AXIS_USART_TX_MISO : in t_axi4_stream_miso;		  	   
      
      --QSPI
      qspi_io0_io : inout STD_LOGIC;
      qspi_io1_io : inout STD_LOGIC;
      qspi_io2_io : inout STD_LOGIC;
      qspi_io3_io : inout STD_LOGIC;
      qspi_ss_io : inout STD_LOGIC
);
end bd_wrapper;




architecture bd_wrapper of bd_wrapper is
       
   component IOBUFDS_DIFF_OUT_DCIEN is
      generic(
         DIFF_TERM        : string  := "TRUE";
         IBUF_LOW_PWR     : string  :=  "TRUE";
         IOSTANDARD       : string  :=  "DIFF_SSTL15_T_DCI";
         USE_IBUFDISABLE  : string  := "TRUE"
         );    
      port(
         O               : out std_ulogic;
         OB              : out std_ulogic;
         IO              : inout std_ulogic; 
         IOB             : inout std_ulogic;
         DCITERMDISABLE  : in std_ulogic;
         I               : in std_ulogic;
         IBUFDISABLE     : in std_ulogic;
         TM              : in std_ulogic;
         TS              : in std_ulogic
         );      
   end component;

   component core_wrapper is
      port (
            ADC_READOUT_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            ADC_READOUT_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            ADC_READOUT_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            ADC_READOUT_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            ADC_READOUT_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            ADC_READOUT_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            ADC_READOUT_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            ADC_READOUT_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            ADC_READOUT_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            ADC_READOUT_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            ADC_READOUT_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            AEC_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            AEC_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            AEC_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            AEC_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            AEC_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            AEC_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            AEC_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            AEC_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            AEC_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            AEC_INTC : in STD_LOGIC;
            ARESETN : out STD_LOGIC_VECTOR ( 0 to 0 );
            BUTTON : in STD_LOGIC;
            CALIBCONFIG_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIBCONFIG_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            CALIBCONFIG_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIBCONFIG_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            CALIBCONFIG_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            CALIBCONFIG_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIBCONFIG_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            CALIBCONFIG_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIBCONFIG_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIBCONFIG_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            CALIBCONFIG_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIB_RAM_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            CALIB_RAM_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIB_RAM_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            CALIB_RAM_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            CALIB_RAM_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIB_RAM_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            CALIB_RAM_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            CALIB_RAM_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            CALIB_RAM_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            CALIB_RAM_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            CAL_DDR_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
            CAL_DDR_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
            CAL_DDR_cas_n : out STD_LOGIC;
            CAL_DDR_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
            CAL_DDR_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
            CAL_DDR_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
            CAL_DDR_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
            CAL_DDR_dm : out STD_LOGIC_VECTOR ( 3 downto 0 );
            CAL_DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
            CAL_DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
            CAL_DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
            CAL_DDR_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
            CAL_DDR_ras_n : out STD_LOGIC;
            CAL_DDR_reset_n : out STD_LOGIC;
            CAL_DDR_we_n : out STD_LOGIC;
            CLINK_UART_rxd : in STD_LOGIC;
            CLINK_UART_txd : out STD_LOGIC;
            CODE_DDR_addr : out STD_LOGIC_VECTOR ( 13 downto 0 );
            CODE_DDR_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
            CODE_DDR_cas_n : out STD_LOGIC;
            CODE_DDR_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
            CODE_DDR_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
            CODE_DDR_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
            CODE_DDR_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
            CODE_DDR_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
            CODE_DDR_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
            CODE_DDR_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
            CODE_DDR_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
            CODE_DDR_ras_n : out STD_LOGIC;
            CODE_DDR_reset_n : out STD_LOGIC;
            CODE_DDR_we_n : out STD_LOGIC;
            EXPTIME_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            EXPTIME_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            EXPTIME_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            EXPTIME_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            EXPTIME_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            EXPTIME_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            EXPTIME_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            EXPTIME_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            EXPTIME_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            EXPTIME_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            EXPTIME_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            FAN_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            FAN_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            FAN_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            FAN_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            FAN_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            FAN_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            FAN_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            FAN_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            FAN_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            FAN_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            FPA_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            FPA_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            FPA_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            FPA_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            FPA_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            FPA_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            FPA_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            FPA_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            FPA_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            FPA_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            FPGA_UART_rxd : in STD_LOGIC;
            FPGA_UART_txd : out STD_LOGIC;
            FW_UART_rxd : in STD_LOGIC;
            FW_UART_txd : out STD_LOGIC;
            GPS_UART_rxd : in STD_LOGIC;
            GPS_UART_txd : out STD_LOGIC;
            HEADER_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            HEADER_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            HEADER_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            HEADER_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            HEADER_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            HEADER_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            HEADER_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            HEADER_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            HEADER_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            HEADER_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            HEADER_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            IRIG_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            IRIG_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            IRIG_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            IRIG_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            IRIG_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            IRIG_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            IRIG_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            IRIG_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            IRIG_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            IRIG_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            LENS_UART_SIN : in STD_LOGIC;
            LENS_UART_SOUT : out STD_LOGIC;
            MGT_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            MGT_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            MGT_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            MGT_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            MGT_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            MGT_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            MGT_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            MGT_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            MGT_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            MGT_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            MGT_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_AXIS_CALDDR_MM2S_STS_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_AXIS_CALDDR_MM2S_STS_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_AXIS_CALDDR_MM2S_STS_tlast : out STD_LOGIC;
            M_AXIS_CALDDR_MM2S_STS_tready : in STD_LOGIC;
            M_AXIS_CALDDR_MM2S_STS_tvalid : out STD_LOGIC;
            M_AXIS_CALDDR_MM2S_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
            M_AXIS_CALDDR_MM2S_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
            M_AXIS_CALDDR_MM2S_tlast : out STD_LOGIC;
            M_AXIS_CALDDR_MM2S_tready : in STD_LOGIC;
            M_AXIS_CALDDR_MM2S_tvalid : out STD_LOGIC;
            M_AXIS_MM2S_BUF_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
            M_AXIS_MM2S_BUF_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_AXIS_MM2S_BUF_tlast : out STD_LOGIC;
            M_AXIS_MM2S_BUF_tready : in STD_LOGIC;
            M_AXIS_MM2S_BUF_tvalid : out STD_LOGIC;
            M_AXIS_MM2S_STS_BUF_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_AXIS_MM2S_STS_BUF_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_AXIS_MM2S_STS_BUF_tlast : out STD_LOGIC;
            M_AXIS_MM2S_STS_BUF_tready : in STD_LOGIC;
            M_AXIS_MM2S_STS_BUF_tvalid : out STD_LOGIC;
            M_AXIS_S2MM_STS_BUF_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_AXIS_S2MM_STS_BUF_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_AXIS_S2MM_STS_BUF_tlast : out STD_LOGIC;
            M_AXIS_S2MM_STS_BUF_tready : in STD_LOGIC;
            M_AXIS_S2MM_STS_BUF_tvalid : out STD_LOGIC;
            M_AXIS_USART_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_AXIS_USART_tlast : out STD_LOGIC;
            M_AXIS_USART_tready : in STD_LOGIC;
            M_AXIS_USART_tvalid : out STD_LOGIC;
            M_BUFFERING_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUFFERING_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_BUFFERING_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUFFERING_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_BUFFERING_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_BUFFERING_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUFFERING_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_BUFFERING_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUFFERING_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUFFERING_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_BUFFERING_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUF_TABLE_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_BUF_TABLE_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUF_TABLE_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_BUF_TABLE_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_BUF_TABLE_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUF_TABLE_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_BUF_TABLE_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BUF_TABLE_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BUF_TABLE_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_BUF_TABLE_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BULK_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_BULK_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BULK_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_BULK_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_BULK_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BULK_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_BULK_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_BULK_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_BULK_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_BULK_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_EHDRI_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_EHDRI_CTRL_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
            M_EHDRI_CTRL_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_EHDRI_CTRL_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_EHDRI_CTRL_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_EHDRI_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_EHDRI_CTRL_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_EHDRI_CTRL_arready : in STD_LOGIC;
            M_EHDRI_CTRL_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_EHDRI_CTRL_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_EHDRI_CTRL_arvalid : out STD_LOGIC;
            M_EHDRI_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_EHDRI_CTRL_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
            M_EHDRI_CTRL_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_EHDRI_CTRL_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_EHDRI_CTRL_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_EHDRI_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_EHDRI_CTRL_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_EHDRI_CTRL_awready : in STD_LOGIC;
            M_EHDRI_CTRL_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_EHDRI_CTRL_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_EHDRI_CTRL_awvalid : out STD_LOGIC;
            M_EHDRI_CTRL_bready : out STD_LOGIC;
            M_EHDRI_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_EHDRI_CTRL_bvalid : in STD_LOGIC;
            M_EHDRI_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            M_EHDRI_CTRL_rlast : in STD_LOGIC;
            M_EHDRI_CTRL_rready : out STD_LOGIC;
            M_EHDRI_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_EHDRI_CTRL_rvalid : in STD_LOGIC;
            M_EHDRI_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_EHDRI_CTRL_wlast : out STD_LOGIC;
            M_EHDRI_CTRL_wready : in STD_LOGIC;
            M_EHDRI_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_EHDRI_CTRL_wvalid : out STD_LOGIC;
            M_FLASHINTF_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_FLASHINTF_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
            M_FLASHINTF_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_FLASHINTF_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_FLASHINTF_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_FLASHINTF_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_FLASHINTF_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_FLASHINTF_AXI_arready : in STD_LOGIC;
            M_FLASHINTF_AXI_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_FLASHINTF_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_FLASHINTF_AXI_arvalid : out STD_LOGIC;
            M_FLASHINTF_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_FLASHINTF_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
            M_FLASHINTF_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_FLASHINTF_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
            M_FLASHINTF_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_FLASHINTF_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_FLASHINTF_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_FLASHINTF_AXI_awready : in STD_LOGIC;
            M_FLASHINTF_AXI_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_FLASHINTF_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_FLASHINTF_AXI_awvalid : out STD_LOGIC;
            M_FLASHINTF_AXI_bready : out STD_LOGIC;
            M_FLASHINTF_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_FLASHINTF_AXI_bvalid : in STD_LOGIC;
            M_FLASHINTF_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            M_FLASHINTF_AXI_rlast : in STD_LOGIC;
            M_FLASHINTF_AXI_rready : out STD_LOGIC;
            M_FLASHINTF_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_FLASHINTF_AXI_rvalid : in STD_LOGIC;
            M_FLASHINTF_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_FLASHINTF_AXI_wlast : out STD_LOGIC;
            M_FLASHINTF_AXI_wready : in STD_LOGIC;
            M_FLASHINTF_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_FLASHINTF_AXI_wvalid : out STD_LOGIC;
            M_ICU_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_ICU_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_ICU_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_ICU_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            M_ICU_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_ICU_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            M_ICU_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            M_ICU_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            M_ICU_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            M_ICU_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            M_ICU_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            NDF_UART_rxd : in STD_LOGIC;
            NDF_UART_txd : out STD_LOGIC;
            NLC_LUT_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            NLC_LUT_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            NLC_LUT_AXI_arready : in STD_LOGIC;
            NLC_LUT_AXI_arvalid : out STD_LOGIC;
            NLC_LUT_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            NLC_LUT_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            NLC_LUT_AXI_awready : in STD_LOGIC;
            NLC_LUT_AXI_awvalid : out STD_LOGIC;
            NLC_LUT_AXI_bready : out STD_LOGIC;
            NLC_LUT_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            NLC_LUT_AXI_bvalid : in STD_LOGIC;
            NLC_LUT_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            NLC_LUT_AXI_rready : out STD_LOGIC;
            NLC_LUT_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            NLC_LUT_AXI_rvalid : in STD_LOGIC;
            NLC_LUT_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            NLC_LUT_AXI_wready : in STD_LOGIC;
            NLC_LUT_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            NLC_LUT_AXI_wvalid : out STD_LOGIC;
            OEM_UART_rxd : in STD_LOGIC;
            OEM_UART_txd : out STD_LOGIC;
            PLEORA_UART_SIN : in STD_LOGIC;
            PLEORA_UART_SOUT : out STD_LOGIC;
            RQC_LUT_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            RQC_LUT_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            RQC_LUT_AXI_arready : in STD_LOGIC;
            RQC_LUT_AXI_arvalid : out STD_LOGIC;
            RQC_LUT_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            RQC_LUT_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            RQC_LUT_AXI_awready : in STD_LOGIC;
            RQC_LUT_AXI_awvalid : out STD_LOGIC;
            RQC_LUT_AXI_bready : out STD_LOGIC;
            RQC_LUT_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            RQC_LUT_AXI_bvalid : in STD_LOGIC;
            RQC_LUT_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            RQC_LUT_AXI_rready : out STD_LOGIC;
            RQC_LUT_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            RQC_LUT_AXI_rvalid : in STD_LOGIC;
            RQC_LUT_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            RQC_LUT_AXI_wready : in STD_LOGIC;
            RQC_LUT_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            RQC_LUT_AXI_wvalid : out STD_LOGIC;
            SFW_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            SFW_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            SFW_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            SFW_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            SFW_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            SFW_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            SFW_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            SFW_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            SFW_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            SFW_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            SFW_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            SYS_CLK_0_clk_n : in STD_LOGIC;
            SYS_CLK_0_clk_p : in STD_LOGIC;
            SYS_CLK_1_clk_n : in STD_LOGIC;
            SYS_CLK_1_clk_p : in STD_LOGIC;
            S_AXIS_CALDDR_MM2S_CMD_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
            S_AXIS_CALDDR_MM2S_CMD_tready : out STD_LOGIC;
            S_AXIS_CALDDR_MM2S_CMD_tvalid : in STD_LOGIC;
            S_AXIS_MM2S_CMD_BUF_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
            S_AXIS_MM2S_CMD_BUF_tready : out STD_LOGIC;
            S_AXIS_MM2S_CMD_BUF_tvalid : in STD_LOGIC;
            S_AXIS_S2MM_BUF_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
            S_AXIS_S2MM_BUF_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
            S_AXIS_S2MM_BUF_tlast : in STD_LOGIC;
            S_AXIS_S2MM_BUF_tready : out STD_LOGIC;
            S_AXIS_S2MM_BUF_tvalid : in STD_LOGIC;
            S_AXIS_S2MM_CMD_BUF_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
            S_AXIS_S2MM_CMD_BUF_tready : out STD_LOGIC;
            S_AXIS_S2MM_CMD_BUF_tvalid : in STD_LOGIC;
            S_AXIS_USART_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            S_AXIS_USART_tlast : in STD_LOGIC;
            S_AXIS_USART_tready : out STD_LOGIC;
            S_AXIS_USART_tvalid : in STD_LOGIC;
            TRIGGER_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            TRIGGER_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            TRIGGER_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
            TRIGGER_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
            TRIGGER_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            TRIGGER_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
            TRIGGER_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
            TRIGGER_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
            TRIGGER_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
            TRIGGER_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
            TRIGGER_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
            USB_UART_baudoutn : out STD_LOGIC;
            USB_UART_ctsn : in STD_LOGIC;
            USB_UART_dcdn : in STD_LOGIC;
            USB_UART_ddis : out STD_LOGIC;
            USB_UART_dsrn : in STD_LOGIC;
            USB_UART_dtrn : out STD_LOGIC;
            USB_UART_out1n : out STD_LOGIC;
            USB_UART_out2n : out STD_LOGIC;
            USB_UART_ri : in STD_LOGIC;
            USB_UART_rtsn : out STD_LOGIC;
            USB_UART_rxd : in STD_LOGIC;
            USB_UART_rxrdyn : out STD_LOGIC;
            USB_UART_txd : out STD_LOGIC;
            USB_UART_txrdyn : out STD_LOGIC;
            bulk_interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
            clk_200 : out STD_LOGIC;
            clk_cal : out STD_LOGIC;
            clk_data : out STD_LOGIC;
            clk_irig : out STD_LOGIC;
            clk_mb : out STD_LOGIC;
            clk_mgt_init : out STD_LOGIC;
            led_gpio_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
            mux_addr_tri_o : out STD_LOGIC_VECTOR ( 4 downto 0 );
            power_gpio_tri_io : inout STD_LOGIC_VECTOR ( 7 downto 0 );
            qspi_io0_io : inout STD_LOGIC;
            qspi_io1_io : inout STD_LOGIC;
            qspi_io2_io : inout STD_LOGIC;
            qspi_io3_io : inout STD_LOGIC;
            qspi_ss_io : inout STD_LOGIC_VECTOR ( 0 to 0 );
            rev_gpio_tri_i : in STD_LOGIC_VECTOR ( 7 downto 0 );
            vn_in : in STD_LOGIC;
            vp_in : in STD_LOGIC
         );
   end component;
   
   component core_4DDR_wrapper is
      port (
         ADC_READOUT_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         ADC_READOUT_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         ADC_READOUT_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         ADC_READOUT_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         ADC_READOUT_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         ADC_READOUT_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         ADC_READOUT_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         ADC_READOUT_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         ADC_READOUT_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         ADC_READOUT_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         ADC_READOUT_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         AEC_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         AEC_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         AEC_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         AEC_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         AEC_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         AEC_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         AEC_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         AEC_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         AEC_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         AEC_INTC : in STD_LOGIC;
         ARESETN : out STD_LOGIC_VECTOR ( 0 to 0 );
         BUTTON : in STD_LOGIC;
         CALIBCONFIG_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIBCONFIG_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         CALIBCONFIG_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIBCONFIG_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         CALIBCONFIG_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         CALIBCONFIG_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIBCONFIG_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         CALIBCONFIG_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIBCONFIG_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIBCONFIG_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         CALIBCONFIG_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIB_RAM_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         CALIB_RAM_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIB_RAM_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         CALIB_RAM_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         CALIB_RAM_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIB_RAM_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         CALIB_RAM_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         CALIB_RAM_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         CALIB_RAM_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         CALIB_RAM_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         CAL_DDR_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
         CAL_DDR_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
         CAL_DDR_cas_n : out STD_LOGIC;
         CAL_DDR_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
         CAL_DDR_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
         CAL_DDR_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
         CAL_DDR_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
         CAL_DDR_dm : out STD_LOGIC_VECTOR ( 7 downto 0 );
         CAL_DDR_dq : inout STD_LOGIC_VECTOR ( 63 downto 0 );
         CAL_DDR_dqs_n : inout STD_LOGIC_VECTOR ( 7 downto 0 );
         CAL_DDR_dqs_p : inout STD_LOGIC_VECTOR ( 7 downto 0 );
         CAL_DDR_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
         CAL_DDR_ras_n : out STD_LOGIC;
         CAL_DDR_reset_n : out STD_LOGIC;
         CAL_DDR_we_n : out STD_LOGIC;
         CLINK_UART_rxd : in STD_LOGIC;
         CLINK_UART_txd : out STD_LOGIC;
         CODE_DDR_addr : out STD_LOGIC_VECTOR ( 13 downto 0 );
         CODE_DDR_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
         CODE_DDR_cas_n : out STD_LOGIC;
         CODE_DDR_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
         CODE_DDR_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
         CODE_DDR_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
         CODE_DDR_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
         CODE_DDR_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
         CODE_DDR_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
         CODE_DDR_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
         CODE_DDR_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
         CODE_DDR_ras_n : out STD_LOGIC;
         CODE_DDR_reset_n : out STD_LOGIC;
         CODE_DDR_we_n : out STD_LOGIC;
         EXPTIME_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         EXPTIME_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         EXPTIME_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         EXPTIME_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         EXPTIME_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         EXPTIME_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         EXPTIME_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         EXPTIME_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         EXPTIME_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         EXPTIME_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         EXPTIME_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         FAN_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         FAN_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         FAN_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         FAN_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         FAN_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         FAN_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         FAN_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         FAN_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         FAN_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         FAN_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         FPA_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         FPA_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         FPA_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         FPA_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         FPA_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         FPA_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         FPA_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         FPA_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         FPA_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         FPA_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         FPGA_UART_rxd : in STD_LOGIC;
         FPGA_UART_txd : out STD_LOGIC;
         FW_UART_rxd : in STD_LOGIC;
         FW_UART_txd : out STD_LOGIC;
         GPS_UART_rxd : in STD_LOGIC;
         GPS_UART_txd : out STD_LOGIC;
         HEADER_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         HEADER_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         HEADER_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         HEADER_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         HEADER_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         HEADER_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         HEADER_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         HEADER_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         HEADER_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         HEADER_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         HEADER_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         IRIG_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         IRIG_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         IRIG_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         IRIG_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         IRIG_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         IRIG_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         IRIG_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         IRIG_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         IRIG_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         IRIG_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         LENS_UART_SIN : in STD_LOGIC;
         LENS_UART_SOUT : out STD_LOGIC;
         MGT_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         MGT_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         MGT_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         MGT_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         MGT_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         MGT_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         MGT_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         MGT_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         MGT_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         MGT_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         MGT_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_AXIS_CALDDR_MM2S_STS_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_AXIS_CALDDR_MM2S_STS_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_AXIS_CALDDR_MM2S_STS_tlast : out STD_LOGIC;
         M_AXIS_CALDDR_MM2S_STS_tready : in STD_LOGIC;
         M_AXIS_CALDDR_MM2S_STS_tvalid : out STD_LOGIC;
         M_AXIS_CALDDR_MM2S_tdata : out STD_LOGIC_VECTOR ( 127 downto 0 );
         M_AXIS_CALDDR_MM2S_tkeep : out STD_LOGIC_VECTOR ( 15 downto 0 );
         M_AXIS_CALDDR_MM2S_tlast : out STD_LOGIC;
         M_AXIS_CALDDR_MM2S_tready : in STD_LOGIC;
         M_AXIS_CALDDR_MM2S_tvalid : out STD_LOGIC;
         M_AXIS_MM2S_BUF_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
         M_AXIS_MM2S_BUF_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_AXIS_MM2S_BUF_tlast : out STD_LOGIC;
         M_AXIS_MM2S_BUF_tready : in STD_LOGIC;
         M_AXIS_MM2S_BUF_tvalid : out STD_LOGIC;
         M_AXIS_MM2S_FB_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
         M_AXIS_MM2S_FB_tkeep : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_AXIS_MM2S_FB_tlast : out STD_LOGIC;
         M_AXIS_MM2S_FB_tready : in STD_LOGIC;
         M_AXIS_MM2S_FB_tvalid : out STD_LOGIC;
         M_AXIS_MM2S_STS_BUF_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_AXIS_MM2S_STS_BUF_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_AXIS_MM2S_STS_BUF_tlast : out STD_LOGIC;
         M_AXIS_MM2S_STS_BUF_tready : in STD_LOGIC;
         M_AXIS_MM2S_STS_BUF_tvalid : out STD_LOGIC;
         M_AXIS_MM2S_STS_FB_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_AXIS_MM2S_STS_FB_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_AXIS_MM2S_STS_FB_tlast : out STD_LOGIC;
         M_AXIS_MM2S_STS_FB_tready : in STD_LOGIC;
         M_AXIS_MM2S_STS_FB_tvalid : out STD_LOGIC;
         M_AXIS_S2MM_STS_BUF_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_AXIS_S2MM_STS_BUF_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_AXIS_S2MM_STS_BUF_tlast : out STD_LOGIC;
         M_AXIS_S2MM_STS_BUF_tready : in STD_LOGIC;
         M_AXIS_S2MM_STS_BUF_tvalid : out STD_LOGIC;
         M_AXIS_S2MM_STS_FB_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_AXIS_S2MM_STS_FB_tkeep : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_AXIS_S2MM_STS_FB_tlast : out STD_LOGIC;
         M_AXIS_S2MM_STS_FB_tready : in STD_LOGIC;
         M_AXIS_S2MM_STS_FB_tvalid : out STD_LOGIC;
         M_AXIS_USART_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_AXIS_USART_tlast : out STD_LOGIC;
         M_AXIS_USART_tready : in STD_LOGIC;
         M_AXIS_USART_tvalid : out STD_LOGIC;
         M_BUFFERING_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUFFERING_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_BUFFERING_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUFFERING_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_BUFFERING_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_BUFFERING_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUFFERING_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_BUFFERING_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUFFERING_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUFFERING_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_BUFFERING_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUF_TABLE_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_BUF_TABLE_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUF_TABLE_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_BUF_TABLE_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_BUF_TABLE_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUF_TABLE_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_BUF_TABLE_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BUF_TABLE_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BUF_TABLE_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_BUF_TABLE_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BULK_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_BULK_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BULK_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_BULK_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_BULK_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BULK_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_BULK_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_BULK_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_BULK_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_BULK_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_EHDRI_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_EHDRI_CTRL_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
         M_EHDRI_CTRL_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_EHDRI_CTRL_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_EHDRI_CTRL_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_EHDRI_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_EHDRI_CTRL_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_EHDRI_CTRL_arready : in STD_LOGIC;
         M_EHDRI_CTRL_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_EHDRI_CTRL_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_EHDRI_CTRL_arvalid : out STD_LOGIC;
         M_EHDRI_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_EHDRI_CTRL_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
         M_EHDRI_CTRL_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_EHDRI_CTRL_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_EHDRI_CTRL_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_EHDRI_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_EHDRI_CTRL_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_EHDRI_CTRL_awready : in STD_LOGIC;
         M_EHDRI_CTRL_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_EHDRI_CTRL_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_EHDRI_CTRL_awvalid : out STD_LOGIC;
         M_EHDRI_CTRL_bready : out STD_LOGIC;
         M_EHDRI_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_EHDRI_CTRL_bvalid : in STD_LOGIC;
         M_EHDRI_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         M_EHDRI_CTRL_rlast : in STD_LOGIC;
         M_EHDRI_CTRL_rready : out STD_LOGIC;
         M_EHDRI_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_EHDRI_CTRL_rvalid : in STD_LOGIC;
         M_EHDRI_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_EHDRI_CTRL_wlast : out STD_LOGIC;
         M_EHDRI_CTRL_wready : in STD_LOGIC;
         M_EHDRI_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_EHDRI_CTRL_wvalid : out STD_LOGIC;
         M_FLASHINTF_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FLASHINTF_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
         M_FLASHINTF_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FLASHINTF_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_FLASHINTF_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_FLASHINTF_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_FLASHINTF_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FLASHINTF_AXI_arready : in STD_LOGIC;
         M_FLASHINTF_AXI_arregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FLASHINTF_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_FLASHINTF_AXI_arvalid : out STD_LOGIC;
         M_FLASHINTF_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FLASHINTF_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
         M_FLASHINTF_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FLASHINTF_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
         M_FLASHINTF_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_FLASHINTF_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_FLASHINTF_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FLASHINTF_AXI_awready : in STD_LOGIC;
         M_FLASHINTF_AXI_awregion : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FLASHINTF_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_FLASHINTF_AXI_awvalid : out STD_LOGIC;
         M_FLASHINTF_AXI_bready : out STD_LOGIC;
         M_FLASHINTF_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_FLASHINTF_AXI_bvalid : in STD_LOGIC;
         M_FLASHINTF_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FLASHINTF_AXI_rlast : in STD_LOGIC;
         M_FLASHINTF_AXI_rready : out STD_LOGIC;
         M_FLASHINTF_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_FLASHINTF_AXI_rvalid : in STD_LOGIC;
         M_FLASHINTF_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FLASHINTF_AXI_wlast : out STD_LOGIC;
         M_FLASHINTF_AXI_wready : in STD_LOGIC;
         M_FLASHINTF_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FLASHINTF_AXI_wvalid : out STD_LOGIC;
         M_FRAME_BUFFER_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FRAME_BUFFER_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_FRAME_BUFFER_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FRAME_BUFFER_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_FRAME_BUFFER_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_FRAME_BUFFER_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FRAME_BUFFER_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_FRAME_BUFFER_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_FRAME_BUFFER_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_FRAME_BUFFER_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_FRAME_BUFFER_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_ICU_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_ICU_AXI_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_ICU_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         M_ICU_AXI_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_ICU_AXI_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         M_ICU_AXI_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         M_ICU_AXI_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         M_ICU_AXI_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         M_ICU_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         M_ICU_AXI_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         NDF_UART_rxd : in STD_LOGIC;
         NDF_UART_txd : out STD_LOGIC;
         NLC_LUT_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         NLC_LUT_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         NLC_LUT_AXI_arready : in STD_LOGIC;
         NLC_LUT_AXI_arvalid : out STD_LOGIC;
         NLC_LUT_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         NLC_LUT_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         NLC_LUT_AXI_awready : in STD_LOGIC;
         NLC_LUT_AXI_awvalid : out STD_LOGIC;
         NLC_LUT_AXI_bready : out STD_LOGIC;
         NLC_LUT_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         NLC_LUT_AXI_bvalid : in STD_LOGIC;
         NLC_LUT_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         NLC_LUT_AXI_rready : out STD_LOGIC;
         NLC_LUT_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         NLC_LUT_AXI_rvalid : in STD_LOGIC;
         NLC_LUT_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         NLC_LUT_AXI_wready : in STD_LOGIC;
         NLC_LUT_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         NLC_LUT_AXI_wvalid : out STD_LOGIC;
         OEM_UART_rxd : in STD_LOGIC;
         OEM_UART_txd : out STD_LOGIC;
         PLEORA_UART_SIN : in STD_LOGIC;
         PLEORA_UART_SOUT : out STD_LOGIC;
         RQC_LUT_AXI_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         RQC_LUT_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         RQC_LUT_AXI_arready : in STD_LOGIC;
         RQC_LUT_AXI_arvalid : out STD_LOGIC;
         RQC_LUT_AXI_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         RQC_LUT_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         RQC_LUT_AXI_awready : in STD_LOGIC;
         RQC_LUT_AXI_awvalid : out STD_LOGIC;
         RQC_LUT_AXI_bready : out STD_LOGIC;
         RQC_LUT_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         RQC_LUT_AXI_bvalid : in STD_LOGIC;
         RQC_LUT_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         RQC_LUT_AXI_rready : out STD_LOGIC;
         RQC_LUT_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         RQC_LUT_AXI_rvalid : in STD_LOGIC;
         RQC_LUT_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         RQC_LUT_AXI_wready : in STD_LOGIC;
         RQC_LUT_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         RQC_LUT_AXI_wvalid : out STD_LOGIC;
         SFW_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         SFW_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         SFW_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         SFW_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         SFW_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         SFW_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         SFW_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         SFW_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         SFW_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         SFW_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         SFW_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         SYS_CLK_0_clk_n : in STD_LOGIC;
         SYS_CLK_0_clk_p : in STD_LOGIC;
         SYS_CLK_1_clk_n : in STD_LOGIC;
         SYS_CLK_1_clk_p : in STD_LOGIC;
         S_AXIS_CALDDR_MM2S_CMD_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
         S_AXIS_CALDDR_MM2S_CMD_tready : out STD_LOGIC;
         S_AXIS_CALDDR_MM2S_CMD_tvalid : in STD_LOGIC;
         S_AXIS_MM2S_CMD_BUF_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
         S_AXIS_MM2S_CMD_BUF_tready : out STD_LOGIC;
         S_AXIS_MM2S_CMD_BUF_tvalid : in STD_LOGIC;
         S_AXIS_MM2S_CMD_FB_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
         S_AXIS_MM2S_CMD_FB_tready : out STD_LOGIC;
         S_AXIS_MM2S_CMD_FB_tvalid : in STD_LOGIC;
         S_AXIS_S2MM_BUF_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
         S_AXIS_S2MM_BUF_tkeep : in STD_LOGIC_VECTOR ( 7 downto 0 );
         S_AXIS_S2MM_BUF_tlast : in STD_LOGIC;
         S_AXIS_S2MM_BUF_tready : out STD_LOGIC;
         S_AXIS_S2MM_BUF_tvalid : in STD_LOGIC;
         S_AXIS_S2MM_CMD_BUF_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
         S_AXIS_S2MM_CMD_BUF_tready : out STD_LOGIC;
         S_AXIS_S2MM_CMD_BUF_tvalid : in STD_LOGIC;
         S_AXIS_S2MM_CMD_FB_tdata : in STD_LOGIC_VECTOR ( 71 downto 0 );
         S_AXIS_S2MM_CMD_FB_tready : out STD_LOGIC;
         S_AXIS_S2MM_CMD_FB_tvalid : in STD_LOGIC;
         S_AXIS_S2MM_FB_tdata : in STD_LOGIC_VECTOR ( 127 downto 0 );
         S_AXIS_S2MM_FB_tkeep : in STD_LOGIC_VECTOR ( 15 downto 0 );
         S_AXIS_S2MM_FB_tlast : in STD_LOGIC;
         S_AXIS_S2MM_FB_tready : out STD_LOGIC;
         S_AXIS_S2MM_FB_tvalid : in STD_LOGIC;
         S_AXIS_USART_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         S_AXIS_USART_tlast : in STD_LOGIC;
         S_AXIS_USART_tready : out STD_LOGIC;
         S_AXIS_USART_tvalid : in STD_LOGIC;
         TRIGGER_CTRL_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         TRIGGER_CTRL_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         TRIGGER_CTRL_arready : in STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_arvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
         TRIGGER_CTRL_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
         TRIGGER_CTRL_awready : in STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_awvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_bready : out STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         TRIGGER_CTRL_bvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
         TRIGGER_CTRL_rready : out STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
         TRIGGER_CTRL_rvalid : in STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
         TRIGGER_CTRL_wready : in STD_LOGIC_VECTOR ( 0 to 0 );
         TRIGGER_CTRL_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
         TRIGGER_CTRL_wvalid : out STD_LOGIC_VECTOR ( 0 to 0 );
         USB_UART_baudoutn : out STD_LOGIC;
         USB_UART_ctsn : in STD_LOGIC;
         USB_UART_dcdn : in STD_LOGIC;
         USB_UART_ddis : out STD_LOGIC;
         USB_UART_dsrn : in STD_LOGIC;
         USB_UART_dtrn : out STD_LOGIC;
         USB_UART_out1n : out STD_LOGIC;
         USB_UART_out2n : out STD_LOGIC;
         USB_UART_ri : in STD_LOGIC;
         USB_UART_rtsn : out STD_LOGIC;
         USB_UART_rxd : in STD_LOGIC;
         USB_UART_rxrdyn : out STD_LOGIC;
         USB_UART_txd : out STD_LOGIC;
         USB_UART_txrdyn : out STD_LOGIC;
         bulk_interrupt : in STD_LOGIC_VECTOR ( 0 to 0 );
         clk_200 : out STD_LOGIC;
         clk_cal : out STD_LOGIC;
         clk_data : out STD_LOGIC;
         clk_din : in STD_LOGIC;
         clk_irig : out STD_LOGIC;
         clk_mb : out STD_LOGIC;
         clk_mgt_init : out STD_LOGIC;
         led_gpio_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
         mux_addr_tri_o : out STD_LOGIC_VECTOR ( 4 downto 0 );
         power_gpio_tri_io : inout STD_LOGIC_VECTOR ( 7 downto 0 );
         qspi_io0_io : inout STD_LOGIC;
         qspi_io1_io : inout STD_LOGIC;
         qspi_io2_io : inout STD_LOGIC;
         qspi_io3_io : inout STD_LOGIC;
         qspi_ss_io : inout STD_LOGIC_VECTOR ( 0 to 0 );
         rev_gpio_tri_i : in STD_LOGIC_VECTOR ( 7 downto 0 );
         vn_in : in STD_LOGIC;
         vp_in : in STD_LOGIC   
         );
   end component;
  
begin
   
   MIG_2DDR : if (G_4DDR = false) generate
   begin  
      core_wrapper_i: component core_wrapper
      port map (	
         --ADC_READOUT CTRL AXI WRAPPER
         ADC_READOUT_CTRL_awvalid(0) => ADC_READOUT_CTRL_MOSI.AWVALID,
         ADC_READOUT_CTRL_awaddr => ADC_READOUT_CTRL_MOSI.AWADDR,
         ADC_READOUT_CTRL_awprot => ADC_READOUT_CTRL_MOSI.AWPROT,
         ADC_READOUT_CTRL_wvalid(0) => ADC_READOUT_CTRL_MOSI.WVALID,
         ADC_READOUT_CTRL_wdata => ADC_READOUT_CTRL_MOSI.WDATA,
         ADC_READOUT_CTRL_wstrb => ADC_READOUT_CTRL_MOSI.WSTRB,
         ADC_READOUT_CTRL_bready(0) => ADC_READOUT_CTRL_MOSI.BREADY,
         ADC_READOUT_CTRL_arvalid(0) => ADC_READOUT_CTRL_MOSI.ARVALID,
         ADC_READOUT_CTRL_araddr => ADC_READOUT_CTRL_MOSI.ARADDR,
         ADC_READOUT_CTRL_arprot => ADC_READOUT_CTRL_MOSI.ARPROT,
         ADC_READOUT_CTRL_rready(0) => ADC_READOUT_CTRL_MOSI.RREADY,
         
         ADC_READOUT_CTRL_awready(0) => ADC_READOUT_CTRL_MISO.AWREADY,
         ADC_READOUT_CTRL_wready(0) => ADC_READOUT_CTRL_MISO.WREADY,
         ADC_READOUT_CTRL_bvalid(0) => ADC_READOUT_CTRL_MISO.BVALID,
         ADC_READOUT_CTRL_bresp => ADC_READOUT_CTRL_MISO.BRESP,
         ADC_READOUT_CTRL_arready(0) => ADC_READOUT_CTRL_MISO.ARREADY,
         ADC_READOUT_CTRL_rvalid(0) => ADC_READOUT_CTRL_MISO.RVALID,
         ADC_READOUT_CTRL_rdata => ADC_READOUT_CTRL_MISO.RDATA,
         ADC_READOUT_CTRL_rresp => ADC_READOUT_CTRL_MISO.RRESP,
         
         --AEC CTRL AXI WRAPPER
         AEC_CTRL_awvalid(0)	=> AEC_CTRL_MOSI.AWVALID,
         AEC_CTRL_awaddr		=> AEC_CTRL_MOSI.AWADDR, 
         AEC_CTRL_awprot		=> AEC_CTRL_MOSI.AWPROT, 
         AEC_CTRL_arvalid(0)	=> AEC_CTRL_MOSI.ARVALID,
         AEC_CTRL_araddr		=> AEC_CTRL_MOSI.ARADDR, 
         AEC_CTRL_arprot		=> AEC_CTRL_MOSI.ARPROT, 
         AEC_CTRL_wvalid(0)		=> AEC_CTRL_MOSI.WVALID, 
         AEC_CTRL_wdata		=> AEC_CTRL_MOSI.WDATA, 
         AEC_CTRL_wstrb		=> AEC_CTRL_MOSI.WSTRB ,
         AEC_CTRL_bready(0)		=> AEC_CTRL_MOSI.BREADY, 
         AEC_CTRL_rready(0)		=> AEC_CTRL_MOSI.RREADY, 
         AEC_CTRL_awready(0)	=> AEC_CTRL_MISO.AWREADY,
         AEC_CTRL_wready(0)		=> AEC_CTRL_MISO.WREADY, 
         AEC_CTRL_bvalid(0)		=> AEC_CTRL_MISO.BVALID, 
         AEC_CTRL_bresp		=> AEC_CTRL_MISO.BRESP, 
         AEC_CTRL_arready(0)	=> AEC_CTRL_MISO.ARREADY,
         AEC_CTRL_rvalid(0)		=> AEC_CTRL_MISO.RVALID, 
         AEC_CTRL_rdata		=> AEC_CTRL_MISO.RDATA, 
         AEC_CTRL_rresp		=> AEC_CTRL_MISO.RRESP, 
         
         -- CALIB_RAM_AXI WRAPPER
         CALIB_RAM_AXI_awvalid(0)	=> CALIB_RAM_MOSI.AWVALID,
         CALIB_RAM_AXI_awaddr		=> CALIB_RAM_MOSI.AWADDR, 
         CALIB_RAM_AXI_awprot		=> CALIB_RAM_MOSI.AWPROT, 
         CALIB_RAM_AXI_arvalid(0)	=> CALIB_RAM_MOSI.ARVALID,
         CALIB_RAM_AXI_araddr		=> CALIB_RAM_MOSI.ARADDR, 
         CALIB_RAM_AXI_arprot		=> CALIB_RAM_MOSI.ARPROT, 
         CALIB_RAM_AXI_wvalid(0)		=> CALIB_RAM_MOSI.WVALID, 
         CALIB_RAM_AXI_wdata		=> CALIB_RAM_MOSI.WDATA, 
         CALIB_RAM_AXI_wstrb		=> CALIB_RAM_MOSI.WSTRB ,
         CALIB_RAM_AXI_bready(0)		=> CALIB_RAM_MOSI.BREADY, 
         CALIB_RAM_AXI_rready(0)		=> CALIB_RAM_MOSI.RREADY, 
         CALIB_RAM_AXI_awready(0)	=> CALIB_RAM_MISO.AWREADY,
         CALIB_RAM_AXI_wready(0)		=> CALIB_RAM_MISO.WREADY, 
         CALIB_RAM_AXI_bvalid(0)		=> CALIB_RAM_MISO.BVALID, 
         CALIB_RAM_AXI_bresp		=> CALIB_RAM_MISO.BRESP, 
         CALIB_RAM_AXI_arready(0)	=> CALIB_RAM_MISO.ARREADY,
         CALIB_RAM_AXI_rvalid(0)		=> CALIB_RAM_MISO.RVALID, 
         CALIB_RAM_AXI_rdata		=> CALIB_RAM_MISO.RDATA, 
         CALIB_RAM_AXI_rresp		=> CALIB_RAM_MISO.RRESP,
         
         --CALIBRATIONL WRAPPER
         CALIBCONFIG_AXI_awvalid(0) => CALIBCONFIG_MOSI.AWVALID,
         CALIBCONFIG_AXI_awaddr => CALIBCONFIG_MOSI.AWADDR,
         CALIBCONFIG_AXI_awprot => CALIBCONFIG_MOSI.AWPROT,
         CALIBCONFIG_AXI_wvalid(0) => CALIBCONFIG_MOSI.WVALID,
         CALIBCONFIG_AXI_wdata => CALIBCONFIG_MOSI.WDATA,
         CALIBCONFIG_AXI_wstrb => CALIBCONFIG_MOSI.WSTRB,
         CALIBCONFIG_AXI_bready(0) => CALIBCONFIG_MOSI.BREADY,
         CALIBCONFIG_AXI_arvalid(0) => CALIBCONFIG_MOSI.ARVALID,
         CALIBCONFIG_AXI_araddr => CALIBCONFIG_MOSI.ARADDR,
         CALIBCONFIG_AXI_arprot => CALIBCONFIG_MOSI.ARPROT,
         CALIBCONFIG_AXI_rready(0) => CALIBCONFIG_MOSI.RREADY,
         
         CALIBCONFIG_AXI_awready(0) => CALIBCONFIG_MISO.AWREADY,
         CALIBCONFIG_AXI_wready(0) => CALIBCONFIG_MISO.WREADY,
         CALIBCONFIG_AXI_bvalid(0) => CALIBCONFIG_MISO.BVALID,
         CALIBCONFIG_AXI_bresp => CALIBCONFIG_MISO.BRESP,
         CALIBCONFIG_AXI_arready(0) => CALIBCONFIG_MISO.ARREADY,
         CALIBCONFIG_AXI_rvalid(0) => CALIBCONFIG_MISO.RVALID,
         CALIBCONFIG_AXI_rdata => CALIBCONFIG_MISO.RDATA,
         CALIBCONFIG_AXI_rresp => CALIBCONFIG_MISO.RRESP,
         
         --ICU WRAPPER
         M_ICU_AXI_awvalid(0) => AXIL_ICU_MOSI.AWVALID,
         M_ICU_AXI_awaddr => AXIL_ICU_MOSI.AWADDR,
         M_ICU_AXI_awprot => AXIL_ICU_MOSI.AWPROT,
         M_ICU_AXI_wvalid(0) => AXIL_ICU_MOSI.WVALID,
         M_ICU_AXI_wdata => AXIL_ICU_MOSI.WDATA,
         M_ICU_AXI_wstrb => AXIL_ICU_MOSI.WSTRB,
         M_ICU_AXI_bready(0) => AXIL_ICU_MOSI.BREADY,
         M_ICU_AXI_arvalid(0) => AXIL_ICU_MOSI.ARVALID,
         M_ICU_AXI_araddr => AXIL_ICU_MOSI.ARADDR,
         M_ICU_AXI_arprot => AXIL_ICU_MOSI.ARPROT,
         M_ICU_AXI_rready(0) => AXIL_ICU_MOSI.RREADY,
         
         M_ICU_AXI_awready(0) => AXIL_ICU_MISO.AWREADY,
         M_ICU_AXI_wready(0) => AXIL_ICU_MISO.WREADY,
         M_ICU_AXI_bvalid(0) => AXIL_ICU_MISO.BVALID,
         M_ICU_AXI_bresp => AXIL_ICU_MISO.BRESP,
         M_ICU_AXI_arready(0) => AXIL_ICU_MISO.ARREADY,
         M_ICU_AXI_rvalid(0) => AXIL_ICU_MISO.RVALID,
         M_ICU_AXI_rdata => AXIL_ICU_MISO.RDATA,
         M_ICU_AXI_rresp => AXIL_ICU_MISO.RRESP,
         
         NLC_LUT_AXI_awvalid => NLC_LUT_MOSI.AWVALID,
         NLC_LUT_AXI_awaddr => NLC_LUT_MOSI.AWADDR,
         NLC_LUT_AXI_awprot => NLC_LUT_MOSI.AWPROT,
         NLC_LUT_AXI_wvalid => NLC_LUT_MOSI.WVALID,
         NLC_LUT_AXI_wdata => NLC_LUT_MOSI.WDATA,
         NLC_LUT_AXI_wstrb => NLC_LUT_MOSI.WSTRB,
         NLC_LUT_AXI_bready => NLC_LUT_MOSI.BREADY,
         NLC_LUT_AXI_arvalid => NLC_LUT_MOSI.ARVALID,
         NLC_LUT_AXI_araddr => NLC_LUT_MOSI.ARADDR,
         NLC_LUT_AXI_arprot => NLC_LUT_MOSI.ARPROT,
         NLC_LUT_AXI_rready => NLC_LUT_MOSI.RREADY,
         
         NLC_LUT_AXI_awready => NLC_LUT_MISO.AWREADY,
         NLC_LUT_AXI_wready => NLC_LUT_MISO.WREADY,
         NLC_LUT_AXI_bvalid => NLC_LUT_MISO.BVALID,
         NLC_LUT_AXI_bresp => NLC_LUT_MISO.BRESP,
         NLC_LUT_AXI_arready => NLC_LUT_MISO.ARREADY,
         NLC_LUT_AXI_rvalid => NLC_LUT_MISO.RVALID,
         NLC_LUT_AXI_rdata => NLC_LUT_MISO.RDATA,
         NLC_LUT_AXI_rresp => NLC_LUT_MISO.RRESP,
         
         RQC_LUT_AXI_awvalid => RQC_LUT_MOSI.AWVALID,
         RQC_LUT_AXI_awaddr => RQC_LUT_MOSI.AWADDR,
         RQC_LUT_AXI_awprot => RQC_LUT_MOSI.AWPROT,
         RQC_LUT_AXI_wvalid => RQC_LUT_MOSI.WVALID,
         RQC_LUT_AXI_wdata => RQC_LUT_MOSI.WDATA,
         RQC_LUT_AXI_wstrb => RQC_LUT_MOSI.WSTRB,
         RQC_LUT_AXI_bready => RQC_LUT_MOSI.BREADY,
         RQC_LUT_AXI_arvalid => RQC_LUT_MOSI.ARVALID,
         RQC_LUT_AXI_araddr => RQC_LUT_MOSI.ARADDR,
         RQC_LUT_AXI_arprot => RQC_LUT_MOSI.ARPROT,
         RQC_LUT_AXI_rready => RQC_LUT_MOSI.RREADY,
         
         RQC_LUT_AXI_awready => RQC_LUT_MISO.AWREADY,
         RQC_LUT_AXI_wready => RQC_LUT_MISO.WREADY,
         RQC_LUT_AXI_bvalid => RQC_LUT_MISO.BVALID,
         RQC_LUT_AXI_bresp => RQC_LUT_MISO.BRESP,
         RQC_LUT_AXI_arready => RQC_LUT_MISO.ARREADY,
         RQC_LUT_AXI_rvalid => RQC_LUT_MISO.RVALID,
         RQC_LUT_AXI_rdata => RQC_LUT_MISO.RDATA,
         RQC_LUT_AXI_rresp => RQC_LUT_MISO.RRESP,
         
         -- EXPTIME CTRL WRAPPER
         EXPTIME_CTRL_awvalid(0)    => EXPTIME_CTRL_MOSI.AWVALID,
         EXPTIME_CTRL_awaddr     => EXPTIME_CTRL_MOSI.AWADDR, 
         EXPTIME_CTRL_awprot     => EXPTIME_CTRL_MOSI.AWPROT, 
         EXPTIME_CTRL_arvalid(0)    => EXPTIME_CTRL_MOSI.ARVALID,
         EXPTIME_CTRL_araddr     => EXPTIME_CTRL_MOSI.ARADDR, 
         EXPTIME_CTRL_arprot     => EXPTIME_CTRL_MOSI.ARPROT, 
         EXPTIME_CTRL_wvalid(0)     => EXPTIME_CTRL_MOSI.WVALID, 
         EXPTIME_CTRL_wdata		=> EXPTIME_CTRL_MOSI.WDATA, 
         EXPTIME_CTRL_wstrb		=> EXPTIME_CTRL_MOSI.WSTRB ,
         EXPTIME_CTRL_bready(0)     => EXPTIME_CTRL_MOSI.BREADY, 
         EXPTIME_CTRL_rready(0)     => EXPTIME_CTRL_MOSI.RREADY, 
         EXPTIME_CTRL_awready(0)	=> EXPTIME_CTRL_MISO.AWREADY,
         EXPTIME_CTRL_wready(0)     => EXPTIME_CTRL_MISO.WREADY, 
         EXPTIME_CTRL_bvalid(0)     => EXPTIME_CTRL_MISO.BVALID, 
         EXPTIME_CTRL_bresp		=> EXPTIME_CTRL_MISO.BRESP, 
         EXPTIME_CTRL_arready(0)	=> EXPTIME_CTRL_MISO.ARREADY,
         EXPTIME_CTRL_rvalid(0)     => EXPTIME_CTRL_MISO.RVALID, 
         EXPTIME_CTRL_rdata		=> EXPTIME_CTRL_MISO.RDATA, 
         EXPTIME_CTRL_rresp		=> EXPTIME_CTRL_MISO.RRESP,
         
         -- EHDRI CTRL WRAPPER
         M_EHDRI_CTRL_awvalid    => EHDRI_CTRL_MOSI.AWVALID,
         M_EHDRI_CTRL_awaddr     => EHDRI_CTRL_MOSI.AWADDR, 
         M_EHDRI_CTRL_awprot     => EHDRI_CTRL_MOSI.AWPROT, 
         M_EHDRI_CTRL_arvalid    => EHDRI_CTRL_MOSI.ARVALID,
         M_EHDRI_CTRL_araddr     => EHDRI_CTRL_MOSI.ARADDR, 
         M_EHDRI_CTRL_arprot     => EHDRI_CTRL_MOSI.ARPROT, 
         M_EHDRI_CTRL_wvalid    => EHDRI_CTRL_MOSI.WVALID, 
         M_EHDRI_CTRL_wdata		=> EHDRI_CTRL_MOSI.WDATA, 
         M_EHDRI_CTRL_wstrb		=> EHDRI_CTRL_MOSI.WSTRB ,
         M_EHDRI_CTRL_bready     => EHDRI_CTRL_MOSI.BREADY, 
         M_EHDRI_CTRL_rready     => EHDRI_CTRL_MOSI.RREADY, 
         M_EHDRI_CTRL_awready	=> EHDRI_CTRL_MISO.AWREADY,
         M_EHDRI_CTRL_wready     => EHDRI_CTRL_MISO.WREADY, 
         M_EHDRI_CTRL_bvalid     => EHDRI_CTRL_MISO.BVALID, 
         M_EHDRI_CTRL_bresp		=> EHDRI_CTRL_MISO.BRESP, 
         M_EHDRI_CTRL_arready	=> EHDRI_CTRL_MISO.ARREADY,
         M_EHDRI_CTRL_rdata		=> EHDRI_CTRL_MISO.RDATA, 
         M_EHDRI_CTRL_rresp		=> EHDRI_CTRL_MISO.RRESP,
         M_EHDRI_CTRL_rlast      => '0',
         M_EHDRI_CTRL_rvalid      => '0',
         
         --FPA CTRL WRAPPER
         FPA_CTRL_awvalid(0)        => FPA_CTRL_MOSI.AWVALID,
         FPA_CTRL_awaddr         => FPA_CTRL_MOSI.AWADDR, 
         FPA_CTRL_awprot         => FPA_CTRL_MOSI.AWPROT, 
         FPA_CTRL_arvalid(0)        => FPA_CTRL_MOSI.ARVALID,
         FPA_CTRL_araddr         => FPA_CTRL_MOSI.ARADDR, 
         FPA_CTRL_arprot         => FPA_CTRL_MOSI.ARPROT, 
         FPA_CTRL_wvalid(0)         => FPA_CTRL_MOSI.WVALID, 
         FPA_CTRL_wdata          => FPA_CTRL_MOSI.WDATA, 
         FPA_CTRL_wstrb		    => FPA_CTRL_MOSI.WSTRB ,
         FPA_CTRL_bready(0)         => FPA_CTRL_MOSI.BREADY, 
         FPA_CTRL_rready(0)         => FPA_CTRL_MOSI.RREADY, 
         FPA_CTRL_awready(0)	    => FPA_CTRL_MISO.AWREADY,
         FPA_CTRL_wready(0)         => FPA_CTRL_MISO.WREADY, 
         FPA_CTRL_bvalid(0)         => FPA_CTRL_MISO.BVALID, 
         FPA_CTRL_bresp		    => FPA_CTRL_MISO.BRESP, 
         FPA_CTRL_arready(0) 	    => FPA_CTRL_MISO.ARREADY,
         FPA_CTRL_rvalid(0)         => FPA_CTRL_MISO.RVALID, 
         FPA_CTRL_rdata		    => FPA_CTRL_MISO.RDATA, 
         FPA_CTRL_rresp		    => FPA_CTRL_MISO.RRESP,
        
         --HEADER CTRL WRAPPER
         HEADER_CTRL_awvalid(0)        => HEADER_CTRL_MOSI.AWVALID,
         HEADER_CTRL_awaddr          => HEADER_CTRL_MOSI.AWADDR, 
         HEADER_CTRL_awprot          => HEADER_CTRL_MOSI.AWPROT, 
         HEADER_CTRL_arvalid(0)         => HEADER_CTRL_MOSI.ARVALID,
         HEADER_CTRL_araddr          => HEADER_CTRL_MOSI.ARADDR, 
         HEADER_CTRL_arprot          => HEADER_CTRL_MOSI.ARPROT, 
         HEADER_CTRL_wvalid(0)          => HEADER_CTRL_MOSI.WVALID, 
         HEADER_CTRL_wdata           => HEADER_CTRL_MOSI.WDATA, 
         HEADER_CTRL_wstrb		    => HEADER_CTRL_MOSI.WSTRB ,
         HEADER_CTRL_bready(0)          => HEADER_CTRL_MOSI.BREADY, 
         HEADER_CTRL_rready(0)          => HEADER_CTRL_MOSI.RREADY, 
         HEADER_CTRL_awready(0)	        => HEADER_CTRL_MISO.AWREADY,
         HEADER_CTRL_wready(0)          => HEADER_CTRL_MISO.WREADY, 
         HEADER_CTRL_bvalid(0)          => HEADER_CTRL_MISO.BVALID, 
         HEADER_CTRL_bresp		    => HEADER_CTRL_MISO.BRESP, 
         HEADER_CTRL_arready(0) 	    => HEADER_CTRL_MISO.ARREADY,
         HEADER_CTRL_rvalid(0)          => HEADER_CTRL_MISO.RVALID, 
         HEADER_CTRL_rdata		    => HEADER_CTRL_MISO.RDATA, 
         HEADER_CTRL_rresp		    => HEADER_CTRL_MISO.RRESP,
         
         --TRIGGER CTRL WRAPPER
         TRIGGER_CTRL_awvalid(0)        => TRIGGER_CTRL_MOSI.AWVALID,
         TRIGGER_CTRL_awaddr         => TRIGGER_CTRL_MOSI.AWADDR, 
         TRIGGER_CTRL_awprot         => TRIGGER_CTRL_MOSI.AWPROT, 
         TRIGGER_CTRL_arvalid(0)        => TRIGGER_CTRL_MOSI.ARVALID,
         TRIGGER_CTRL_araddr         => TRIGGER_CTRL_MOSI.ARADDR, 
         TRIGGER_CTRL_arprot         => TRIGGER_CTRL_MOSI.ARPROT, 
         TRIGGER_CTRL_wvalid(0)         => TRIGGER_CTRL_MOSI.WVALID, 
         TRIGGER_CTRL_wdata          => TRIGGER_CTRL_MOSI.WDATA, 
         TRIGGER_CTRL_wstrb		    => TRIGGER_CTRL_MOSI.WSTRB ,
         TRIGGER_CTRL_bready(0)         => TRIGGER_CTRL_MOSI.BREADY, 
         TRIGGER_CTRL_rready(0)         => TRIGGER_CTRL_MOSI.RREADY, 
         TRIGGER_CTRL_awready(0)	    => TRIGGER_CTRL_MISO.AWREADY,
         TRIGGER_CTRL_wready(0)         => TRIGGER_CTRL_MISO.WREADY, 
         TRIGGER_CTRL_bvalid(0)         => TRIGGER_CTRL_MISO.BVALID, 
         TRIGGER_CTRL_bresp		    => TRIGGER_CTRL_MISO.BRESP, 
         TRIGGER_CTRL_arready(0) 	    => TRIGGER_CTRL_MISO.ARREADY,
         TRIGGER_CTRL_rvalid(0)         => TRIGGER_CTRL_MISO.RVALID, 
         TRIGGER_CTRL_rdata		    => TRIGGER_CTRL_MISO.RDATA, 
         TRIGGER_CTRL_rresp		    => TRIGGER_CTRL_MISO.RRESP,
         
         --SFW CTRL WRAPPER
         SFW_CTRL_awvalid(0)        => SFW_CTRL_MOSI.AWVALID,
         SFW_CTRL_awaddr         => SFW_CTRL_MOSI.AWADDR, 
         SFW_CTRL_awprot         => SFW_CTRL_MOSI.AWPROT, 
         SFW_CTRL_arvalid(0)        => SFW_CTRL_MOSI.ARVALID,
         SFW_CTRL_araddr         => SFW_CTRL_MOSI.ARADDR, 
         SFW_CTRL_arprot         => SFW_CTRL_MOSI.ARPROT, 
         SFW_CTRL_wvalid(0)         => SFW_CTRL_MOSI.WVALID, 
         SFW_CTRL_wdata          => SFW_CTRL_MOSI.WDATA, 
         SFW_CTRL_wstrb		    => SFW_CTRL_MOSI.WSTRB ,
         SFW_CTRL_bready(0)         => SFW_CTRL_MOSI.BREADY, 
         SFW_CTRL_rready(0)         => SFW_CTRL_MOSI.RREADY, 
         SFW_CTRL_awready(0)	    => SFW_CTRL_MISO.AWREADY,
         SFW_CTRL_wready(0)         => SFW_CTRL_MISO.WREADY, 
         SFW_CTRL_bvalid(0)         => SFW_CTRL_MISO.BVALID, 
         SFW_CTRL_bresp		    => SFW_CTRL_MISO.BRESP, 
         SFW_CTRL_arready(0) 	    => SFW_CTRL_MISO.ARREADY,
         SFW_CTRL_rvalid(0)         => SFW_CTRL_MISO.RVALID, 
         SFW_CTRL_rdata		    => SFW_CTRL_MISO.RDATA, 
         SFW_CTRL_rresp		    => SFW_CTRL_MISO.RRESP,
         
         --FAN CTRL WRAPPER
         FAN_CTRL_awvalid(0)        => FAN_CTRL_MOSI.AWVALID,
         FAN_CTRL_awaddr         => FAN_CTRL_MOSI.AWADDR, 
         FAN_CTRL_awprot         => FAN_CTRL_MOSI.AWPROT, 
         FAN_CTRL_arvalid(0)        => FAN_CTRL_MOSI.ARVALID,
         FAN_CTRL_araddr         => FAN_CTRL_MOSI.ARADDR, 
         FAN_CTRL_arprot         => FAN_CTRL_MOSI.ARPROT, 
         FAN_CTRL_wvalid(0)         => FAN_CTRL_MOSI.WVALID, 
         FAN_CTRL_wdata          => FAN_CTRL_MOSI.WDATA, 
         FAN_CTRL_wstrb		      => FAN_CTRL_MOSI.WSTRB ,
         FAN_CTRL_bready(0)         => FAN_CTRL_MOSI.BREADY, 
         FAN_CTRL_rready(0)         => FAN_CTRL_MOSI.RREADY, 
         FAN_CTRL_awready(0)	      => FAN_CTRL_MISO.AWREADY,
         FAN_CTRL_wready(0)         => FAN_CTRL_MISO.WREADY, 
         FAN_CTRL_bvalid(0)         => FAN_CTRL_MISO.BVALID, 
         FAN_CTRL_bresp		      => FAN_CTRL_MISO.BRESP, 
         FAN_CTRL_arready(0) 	      => FAN_CTRL_MISO.ARREADY,
         FAN_CTRL_rvalid(0)         => FAN_CTRL_MISO.RVALID, 
         FAN_CTRL_rdata		      => FAN_CTRL_MISO.RDATA, 
         FAN_CTRL_rresp		      => FAN_CTRL_MISO.RRESP,
         
         --MGT CTRL WRAPPER
         MGT_CTRL_awvalid(0)        => MGT_CTRL_MOSI.AWVALID,
         MGT_CTRL_awaddr            => MGT_CTRL_MOSI.AWADDR, 
         MGT_CTRL_awprot            => MGT_CTRL_MOSI.AWPROT, 
         MGT_CTRL_arvalid(0)        => MGT_CTRL_MOSI.ARVALID,
         MGT_CTRL_araddr            => MGT_CTRL_MOSI.ARADDR, 
         MGT_CTRL_arprot            => MGT_CTRL_MOSI.ARPROT, 
         MGT_CTRL_wvalid(0)         => MGT_CTRL_MOSI.WVALID, 
         MGT_CTRL_wdata             => MGT_CTRL_MOSI.WDATA, 
         MGT_CTRL_wstrb		         => MGT_CTRL_MOSI.WSTRB ,
         MGT_CTRL_bready(0)         => MGT_CTRL_MOSI.BREADY, 
         MGT_CTRL_rready(0)         => MGT_CTRL_MOSI.RREADY, 
         MGT_CTRL_awready(0)	      => MGT_CTRL_MISO.AWREADY,
         MGT_CTRL_wready(0)         => MGT_CTRL_MISO.WREADY, 
         MGT_CTRL_bvalid(0)         => MGT_CTRL_MISO.BVALID, 
         MGT_CTRL_bresp		         => MGT_CTRL_MISO.BRESP, 
         MGT_CTRL_arready(0) 	      => MGT_CTRL_MISO.ARREADY,
         MGT_CTRL_rvalid(0)         => MGT_CTRL_MISO.RVALID, 
         MGT_CTRL_rdata		         => MGT_CTRL_MISO.RDATA, 
         MGT_CTRL_rresp		         => MGT_CTRL_MISO.RRESP,   
         
         --IRIG  
         IRIG_CTRL_awvalid(0)        => IRIG_CTRL_MOSI.AWVALID,
         IRIG_CTRL_awaddr            => IRIG_CTRL_MOSI.AWADDR, 
         IRIG_CTRL_awprot            => IRIG_CTRL_MOSI.AWPROT, 
         IRIG_CTRL_arvalid(0)        => IRIG_CTRL_MOSI.ARVALID,
         IRIG_CTRL_araddr            => IRIG_CTRL_MOSI.ARADDR, 
         IRIG_CTRL_arprot            => IRIG_CTRL_MOSI.ARPROT, 
         IRIG_CTRL_wvalid(0)         => IRIG_CTRL_MOSI.WVALID, 
         IRIG_CTRL_wdata             => IRIG_CTRL_MOSI.WDATA, 
         IRIG_CTRL_wstrb		       => IRIG_CTRL_MOSI.WSTRB ,
         IRIG_CTRL_bready(0)         => IRIG_CTRL_MOSI.BREADY, 
         IRIG_CTRL_rready(0)         => IRIG_CTRL_MOSI.RREADY, 
         IRIG_CTRL_awready(0)	       => IRIG_CTRL_MISO.AWREADY,
         IRIG_CTRL_wready(0)         => IRIG_CTRL_MISO.WREADY, 
         IRIG_CTRL_bvalid(0)         => IRIG_CTRL_MISO.BVALID, 
         IRIG_CTRL_bresp		       => IRIG_CTRL_MISO.BRESP, 
         IRIG_CTRL_arready(0) 	    => IRIG_CTRL_MISO.ARREADY,
         IRIG_CTRL_rvalid(0)         => IRIG_CTRL_MISO.RVALID, 
         IRIG_CTRL_rdata		       => IRIG_CTRL_MISO.RDATA, 
         IRIG_CTRL_rresp		       => IRIG_CTRL_MISO.RRESP,
         
         -- BUFFTABLE 
         M_BUF_TABLE_awvalid(0)         => BUFTABLE_MOSI.AWVALID,
         M_BUF_TABLE_awaddr              => BUFTABLE_MOSI.AWADDR, 
         M_BUF_TABLE_awprot              => BUFTABLE_MOSI.AWPROT, 
         M_BUF_TABLE_arvalid(0)        => BUFTABLE_MOSI.ARVALID,
         M_BUF_TABLE_araddr              => BUFTABLE_MOSI.ARADDR, 
         M_BUF_TABLE_arprot              => BUFTABLE_MOSI.ARPROT, 
         M_BUF_TABLE_wvalid(0)           => BUFTABLE_MOSI.WVALID, 
         M_BUF_TABLE_wdata               => BUFTABLE_MOSI.WDATA, 
         M_BUF_TABLE_wstrb		        => BUFTABLE_MOSI.WSTRB ,
         M_BUF_TABLE_bready(0)           => BUFTABLE_MOSI.BREADY, 
         M_BUF_TABLE_rready(0)          => BUFTABLE_MOSI.RREADY, 
         M_BUF_TABLE_awready(0)	        => BUFTABLE_MISO.AWREADY,
         M_BUF_TABLE_wready(0)         => BUFTABLE_MISO.WREADY, 
         M_BUF_TABLE_bvalid(0)           => BUFTABLE_MISO.BVALID, 
         M_BUF_TABLE_bresp		        => BUFTABLE_MISO.BRESP, 
         M_BUF_TABLE_arready(0) 	        => BUFTABLE_MISO.ARREADY,
         M_BUF_TABLE_rvalid(0)           => BUFTABLE_MISO.RVALID, 
         M_BUF_TABLE_rdata		        => BUFTABLE_MISO.RDATA, 
         M_BUF_TABLE_rresp		        => BUFTABLE_MISO.RRESP,
         
         
         -- BUFFERINT CTRL
         M_BUFFERING_CTRL_awvalid(0)         => BUFFERING_CTRL_MOSI.AWVALID,
         M_BUFFERING_CTRL_awaddr              => BUFFERING_CTRL_MOSI.AWADDR, 
         M_BUFFERING_CTRL_awprot              => BUFFERING_CTRL_MOSI.AWPROT, 
         M_BUFFERING_CTRL_arvalid(0)          => BUFFERING_CTRL_MOSI.ARVALID,
         M_BUFFERING_CTRL_araddr              => BUFFERING_CTRL_MOSI.ARADDR, 
         M_BUFFERING_CTRL_arprot              => BUFFERING_CTRL_MOSI.ARPROT, 
         M_BUFFERING_CTRL_wvalid(0)          => BUFFERING_CTRL_MOSI.WVALID, 
         M_BUFFERING_CTRL_wdata               => BUFFERING_CTRL_MOSI.WDATA, 
         M_BUFFERING_CTRL_wstrb		         => BUFFERING_CTRL_MOSI.WSTRB ,
         M_BUFFERING_CTRL_bready(0)          => BUFFERING_CTRL_MOSI.BREADY, 
         M_BUFFERING_CTRL_rready(0)           => BUFFERING_CTRL_MOSI.RREADY, 
         M_BUFFERING_CTRL_awready(0)	         => BUFFERING_CTRL_MISO.AWREADY,
         M_BUFFERING_CTRL_wready(0)          => BUFFERING_CTRL_MISO.WREADY, 
         M_BUFFERING_CTRL_bvalid(0)           => BUFFERING_CTRL_MISO.BVALID, 
         M_BUFFERING_CTRL_bresp		         => BUFFERING_CTRL_MISO.BRESP, 
         M_BUFFERING_CTRL_arready(0) 	     => BUFFERING_CTRL_MISO.ARREADY,
         M_BUFFERING_CTRL_rvalid(0)          => BUFFERING_CTRL_MISO.RVALID, 
         M_BUFFERING_CTRL_rdata		         => BUFFERING_CTRL_MISO.RDATA, 
         M_BUFFERING_CTRL_rresp		         => BUFFERING_CTRL_MISO.RRESP,
         
         --CLINK UART WRAPPER 
         CLINK_UART_rxd 			=>  UART_CLINK_RX,
         CLINK_UART_txd 			=>  UART_CLINK_TX,

         --FPGA UART WRAPPER
         FPGA_UART_rxd 			=>  UART_OUTPUT_RX,
         FPGA_UART_txd 			=>  UART_OUTPUT_TX,

         --OEM UART WRAPPER
         OEM_UART_rxd 			=>  UART_OEM_RX,
         OEM_UART_txd 			=>  UART_OEM_TX,   

         --FW UART WRAPPER
         FW_UART_rxd 			=>  UART_FW_RX,
         FW_UART_txd 			=>  UART_FW_TX, 

         --PLEORA UART WRAPPER
         PLEORA_UART_SIN 			=>  UART_PLEORA_RX,
         PLEORA_UART_SOUT 			=>  UART_PLEORA_TX,
         
         --LENS UART WRAPPER
         LENS_UART_SIN => LENS_UART_SIN,
         LENS_UART_SOUT => LENS_UART_SOUT,
         
         --USB UART WRAPPER
         USB_UART_baudoutn 	=> UART_TO_USB.BAUDOUTN,
         USB_UART_ddis 		=> UART_TO_USB.DDIS,
         USB_UART_dtrn 		=> UART_TO_USB.DTRN,
         USB_UART_out1n 		=> UART_TO_USB.OUT1N,
         USB_UART_out2n 		=> UART_TO_USB.OUT2N,
         USB_UART_rtsn 		=> UART_TO_USB.RTSN,
         USB_UART_rxrdyn 	=> UART_TO_USB.RXRDYN,
         USB_UART_txd 		=> UART_TO_USB.TXD,
         USB_UART_txrdyn 	=> UART_TO_USB.TXRDYN,
         USB_UART_rxd 		=> USB_TO_UART.RXD,
         USB_UART_ctsn 		=> USB_TO_UART.CTSN,
         USB_UART_dcdn 		=> USB_TO_UART.DCDN,
         USB_UART_dsrn 		=> USB_TO_UART.DSRN,
         USB_UART_ri 		=> USB_TO_UART.RI,
         
         GPS_UART_rxd 			=>  UART_GPS_RX,
         GPS_UART_txd 			=>  UART_GPS_TX, 
         
         --Code Mem
         CODE_DDR_addr => Code_mem_addr,
         CODE_DDR_ba => Code_mem_ba,
         CODE_DDR_cas_n => Code_mem_cas_n,
         CODE_DDR_ck_n => Code_mem_ck_n,
         CODE_DDR_ck_p => Code_mem_ck_p,
         CODE_DDR_cke => Code_mem_cke,
         CODE_DDR_dm => Code_mem_dm,
         CODE_DDR_dq => Code_mem_dq,
         CODE_DDR_dqs_n => Code_mem_dqs_n,
         CODE_DDR_dqs_p => Code_mem_dqs_p,
         CODE_DDR_odt => Code_mem_odt,
         CODE_DDR_ras_n => Code_mem_ras_n,
         CODE_DDR_reset_n => Code_mem_reset_n,
         CODE_DDR_we_n => Code_mem_we_n,
         
         aresetn(0)      => ARESETN,
         clk_mb     => clk_mb,
         clk_cal    => clk_cal,
         clk_200     => clk_200,
         clk_irig      => clk_irig,
         clk_mgt_init  => clk_mgt_init,
         clk_data    => clk_data,
         
         vn_in       => vn_in,
         vp_in       => vp_in,
         LED_GPIO_tri_o => LED_GPIO_tri_o,
         
         SYS_CLK_0_clk_n => SYS_CLK_0_N,
         SYS_CLK_0_clk_p => SYS_CLK_0_P,
         SYS_CLK_1_clk_n => SYS_CLK_1_N,
         SYS_CLK_1_clk_p => SYS_CLK_1_P,
         
         mux_addr_tri_o => MUX_ADDR,
         power_gpio_tri_io => POWER_GPIO,
         BUTTON => BUTTON,
         rev_gpio_tri_i => REV_GPIO,
         
         M_BULK_AXI_araddr => BULK_AXI_MOSI.ARADDR,
         M_BULK_AXI_arprot => BULK_AXI_MOSI.ARPROT,
         M_BULK_AXI_arready(0) => BULK_AXI_MISO.ARREADY,
         M_BULK_AXI_arvalid(0) => BULK_AXI_MOSI.ARVALID,
         M_BULK_AXI_awaddr => BULK_AXI_MOSI.AWADDR,
         M_BULK_AXI_awprot => BULK_AXI_MOSI.AWPROT,
         M_BULK_AXI_awready(0) => BULK_AXI_MISO.AWREADY,
         M_BULK_AXI_awvalid(0) => BULK_AXI_MOSI.AWVALID,
         M_BULK_AXI_bready(0) => BULK_AXI_MOSI.BREADY,
         M_BULK_AXI_bresp => BULK_AXI_MISO.BRESP,
         M_BULK_AXI_bvalid(0) => BULK_AXI_MISO.BVALID,
         M_BULK_AXI_rdata => BULK_AXI_MISO.RDATA,
         M_BULK_AXI_rready(0) => BULK_AXI_MOSI.RREADY,
         M_BULK_AXI_rresp => BULK_AXI_MISO.RRESP,
         M_BULK_AXI_rvalid(0) => BULK_AXI_MISO.RVALID,
         M_BULK_AXI_wdata => BULK_AXI_MOSI.WDATA,
         M_BULK_AXI_wready(0) => BULK_AXI_MISO.WREADY,
         M_BULK_AXI_wstrb => BULK_AXI_MOSI.WSTRB,
         M_BULK_AXI_wvalid(0) => BULK_AXI_MOSI.WVALID,
         bulk_interrupt => bulk_interrupt,
         
         CAL_DDR_addr => CAL_DDR_addr,
         CAL_DDR_ba  => CAL_DDR_ba,
         CAL_DDR_cas_n => CAL_DDR_cas_n,
         CAL_DDR_ck_n => CAL_DDR_ck_n,
         CAL_DDR_ck_p => CAL_DDR_ck_p,
         CAL_DDR_cke => CAL_DDR_cke,
         CAL_DDR_cs_n => CAL_DDR_cs_n,
         CAL_DDR_dm => CAL_DDR_dm(3 downto 0),
         CAL_DDR_dq => CAL_DDR_dq(31 downto 0),
         CAL_DDR_dqs_n => CAL_DDR_dqs_n(3 downto 0),
         CAL_DDR_dqs_p => CAL_DDR_dqs_p(3 downto 0),
         CAL_DDR_odt => CAL_DDR_odt,
         CAL_DDR_ras_n => CAL_DDR_ras_n,
         CAL_DDR_reset_n => CAL_DDR_reset_n,
         CAL_DDR_we_n => CAL_DDR_we_n,
         
         M_AXIS_CALDDR_MM2S_tvalid => AXI4_STREAM_DATA_MOSI.TVALID,
         M_AXIS_CALDDR_MM2S_tdata => AXI4_STREAM_DATA_MOSI.TDATA,
         M_AXIS_CALDDR_MM2S_tkeep => AXI4_STREAM_DATA_MOSI.TKEEP,
         M_AXIS_CALDDR_MM2S_tlast => AXI4_STREAM_DATA_MOSI.TLAST,
         M_AXIS_CALDDR_MM2S_tready => AXI4_STREAM_DATA_MISO.TREADY,
         
         S_AXIS_CALDDR_MM2S_CMD_tdata => AXI4_STREAM_ADD_MOSI.TDATA,
         S_AXIS_CALDDR_MM2S_CMD_tvalid => AXI4_STREAM_ADD_MOSI.TVALID,
         S_AXIS_CALDDR_MM2S_CMD_tready => AXI4_STREAM_ADD_MISO.TREADY,
         
         M_AXIS_CALDDR_MM2S_STS_tready => '1',

         --FLASHINTF
         M_FLASHINTF_AXI_araddr => FLASHINTF_AXI_MOSI.araddr,
         M_FLASHINTF_AXI_arburst => FLASHINTF_AXI_MOSI.arburst,
         M_FLASHINTF_AXI_arcache => FLASHINTF_AXI_MOSI.arcache,
         M_FLASHINTF_AXI_arlen => FLASHINTF_AXI_MOSI.arlen,
         M_FLASHINTF_AXI_arlock => FLASHINTF_AXI_MOSI.arlock,
         M_FLASHINTF_AXI_arprot => FLASHINTF_AXI_MOSI.arprot,
         M_FLASHINTF_AXI_arqos => FLASHINTF_AXI_MOSI.arqos,
         M_FLASHINTF_AXI_arready => FLASHINTF_AXI_MISO.arready,
         M_FLASHINTF_AXI_arregion => FLASHINTF_AXI_MOSI.arregion,
         M_FLASHINTF_AXI_arsize => FLASHINTF_AXI_MOSI.arsize,
         M_FLASHINTF_AXI_arvalid => FLASHINTF_AXI_MOSI.arvalid,
         M_FLASHINTF_AXI_awaddr => FLASHINTF_AXI_MOSI.awaddr,
         M_FLASHINTF_AXI_awburst => FLASHINTF_AXI_MOSI.awburst,
         M_FLASHINTF_AXI_awcache => FLASHINTF_AXI_MOSI.awcache,
         M_FLASHINTF_AXI_awlen => FLASHINTF_AXI_MOSI.awlen,
         M_FLASHINTF_AXI_awlock => FLASHINTF_AXI_MOSI.awlock,
         M_FLASHINTF_AXI_awprot => FLASHINTF_AXI_MOSI.awprot,
         M_FLASHINTF_AXI_awqos => FLASHINTF_AXI_MOSI.awqos,
         M_FLASHINTF_AXI_awready => FLASHINTF_AXI_MISO.awready,
         M_FLASHINTF_AXI_awregion => FLASHINTF_AXI_MOSI.awregion,
         M_FLASHINTF_AXI_awsize => FLASHINTF_AXI_MOSI.awsize,
         M_FLASHINTF_AXI_awvalid => FLASHINTF_AXI_MOSI.awvalid,
         M_FLASHINTF_AXI_bready => FLASHINTF_AXI_MOSI.bready,
         M_FLASHINTF_AXI_bresp => FLASHINTF_AXI_MISO.bresp,
         M_FLASHINTF_AXI_bvalid => FLASHINTF_AXI_MISO.bvalid,
         M_FLASHINTF_AXI_rdata => FLASHINTF_AXI_MISO.rdata,
         M_FLASHINTF_AXI_rlast => FLASHINTF_AXI_MISO.rlast ,
         M_FLASHINTF_AXI_rready => FLASHINTF_AXI_MOSI.rready,
         M_FLASHINTF_AXI_rresp => FLASHINTF_AXI_MISO.rresp,
         M_FLASHINTF_AXI_rvalid => FLASHINTF_AXI_MISO.rvalid,
         M_FLASHINTF_AXI_wdata => FLASHINTF_AXI_MOSI.wdata,
         M_FLASHINTF_AXI_wlast => FLASHINTF_AXI_MOSI.wlast,
         M_FLASHINTF_AXI_wready => FLASHINTF_AXI_MISO.wready,
         M_FLASHINTF_AXI_wstrb => FLASHINTF_AXI_MOSI.wstrb,
         M_FLASHINTF_AXI_wvalid => FLASHINTF_AXI_MOSI.wvalid,
         
         
         -- BUFFERING DM INTERFACE
         M_AXIS_MM2S_BUF_tvalid => AXIS_BUF_MM2S_MOSI.TVALID,
         M_AXIS_MM2S_BUF_tdata => AXIS_BUF_MM2S_MOSI.TDATA,
         M_AXIS_MM2S_BUF_tkeep => AXIS_BUF_MM2S_MOSI.TKEEP,
         M_AXIS_MM2S_BUF_tlast => AXIS_BUF_MM2S_MOSI.TLAST,
         M_AXIS_MM2S_BUF_tready => AXIS_BUF_MM2S_MISO.TREADY,
         
         S_AXIS_MM2S_CMD_BUF_tdata => AXIS_BUF_MM2S_CMD_MOSI.TDATA,
         S_AXIS_MM2S_CMD_BUF_tvalid => AXIS_BUF_MM2S_CMD_MOSI.TVALID,
         S_AXIS_MM2S_CMD_BUF_tready => AXIS_BUF_MM2S_CMD_MISO.TREADY,
         
         M_AXIS_MM2S_STS_BUF_tready => AXIS_BUF_MM2S_STS_MISO.TREADY,
         M_AXIS_MM2S_STS_BUF_tdata => AXIS_BUF_MM2S_STS_MOSI.TDATA,
         M_AXIS_MM2S_STS_BUF_tkeep => AXIS_BUF_MM2S_STS_MOSI.TKEEP,
         M_AXIS_MM2S_STS_BUF_tlast => AXIS_BUF_MM2S_STS_MOSI.TLAST,
         M_AXIS_MM2S_STS_BUF_tvalid => AXIS_BUF_MM2S_STS_MOSI.TVALID,
         
         S_AXIS_S2MM_BUF_tdata => AXIS_BUF_S2MM_MOSI.TDATA,
         S_AXIS_S2MM_BUF_tkeep => AXIS_BUF_S2MM_MOSI.TKEEP,
         S_AXIS_S2MM_BUF_tlast => AXIS_BUF_S2MM_MOSI.TLAST,
         S_AXIS_S2MM_BUF_tvalid => AXIS_BUF_S2MM_MOSI.TVALID,
         S_AXIS_S2MM_BUF_tready => AXIS_BUF_S2MM_MISO.TREADY,
         
         S_AXIS_S2MM_CMD_BUF_tdata => AXIS_BUF_S2MM_CMD_MOSI.TDATA,
         S_AXIS_S2MM_CMD_BUF_tvalid => AXIS_BUF_S2MM_CMD_MOSI.TVALID,
         S_AXIS_S2MM_CMD_BUF_tready => AXIS_BUF_S2MM_CMD_MISO.TREADY,
         
         M_AXIS_S2MM_STS_BUF_tdata => AXIS_BUF_S2MM_STS_MOSI.TDATA,
         M_AXIS_S2MM_STS_BUF_tkeep => AXIS_BUF_S2MM_STS_MOSI.TKEEP,
         M_AXIS_S2MM_STS_BUF_tlast => AXIS_BUF_S2MM_STS_MOSI.TLAST,
         M_AXIS_S2MM_STS_BUF_tvalid => AXIS_BUF_S2MM_STS_MOSI.TVALID,
         M_AXIS_S2MM_STS_BUF_tready => AXIS_BUF_S2MM_STS_MISO.TREADY,
         
         --TEST USART B
         M_AXIS_USART_tdata  => AXIS_USART_TX_MOSI.TDATA,
         M_AXIS_USART_tlast  => AXIS_USART_TX_MOSI.TLAST,
         M_AXIS_USART_tready => AXIS_USART_TX_MISO.TREADY,
         M_AXIS_USART_tvalid => AXIS_USART_TX_MOSI.TVALID,
         
         S_AXIS_USART_tdata  => AXIS_USART_RX_MOSI.TDATA,
         S_AXIS_USART_tlast  => AXIS_USART_RX_MOSI.TLAST,
         S_AXIS_USART_tready => AXIS_USART_RX_MISO.TREADY,
         S_AXIS_USART_tvalid => AXIS_USART_RX_MOSI.TVALID,
         
         --QSPI
         qspi_io0_io => qspi_io0_io,
         qspi_io1_io => qspi_io1_io,
         qspi_io2_io => qspi_io2_io,
         qspi_io3_io => qspi_io3_io,
         qspi_ss_io(0) => qspi_ss_io,
         
         NDF_UART_rxd => UART_NDF_RX,
         NDF_UART_txd => UART_NDF_TX,
         
         --aec intc
         AEC_INTC => AEC_INTC
      );

         
         CAL_DDR_dm(7 downto 4) <= (others => '0');
         CAL_DDR_dq(63 downto 32) <= (others => '0'); 

         IOBUFDS_DIFF_OUT_DCIEN_4 : IOBUFDS_DIFF_OUT_DCIEN
         generic map (
         DIFF_TERM => "TRUE", -- Differential Termination (TRUE/FALSE)
         IBUF_LOW_PWR => "TRUE", -- Low Power - TRUE, High Performance = FALSE
         IOSTANDARD => "DIFF_SSTL15_T_DCI", -- Specify the I/O standard
         USE_IBUFDISABLE => "TRUE") -- Use IBUFDISABLE function, "TRUE" or "FALSE"
         port map (
         O => open, -- Buffer p-side output
         OB => open, -- Buffer n-side output
         IO => CAL_DDR_dqs_p(4), -- Diff_p inout (connect directly to top-level port)
         IOB => CAL_DDR_dqs_n(4), -- Diff_n inout (connect directly to top-level port)
         DCITERMDISABLE => '0', -- DCI Termination enable input
         I => '0', -- Buffer input
         IBUFDISABLE => '0', -- input disable input, low=disable
         TM => '0', -- 3-state enable input, high=input, low=output
         TS => '0' -- 3-state enable input, high=output, low=input
         ); 
         
         IOBUFDS_DIFF_OUT_DCIEN_5 : IOBUFDS_DIFF_OUT_DCIEN
         generic map (
         DIFF_TERM => "TRUE", -- Differential Termination (TRUE/FALSE)
         IBUF_LOW_PWR => "TRUE", -- Low Power - TRUE, High Performance = FALSE
         IOSTANDARD => "DIFF_SSTL15_T_DCI", -- Specify the I/O standard
         USE_IBUFDISABLE => "TRUE") -- Use IBUFDISABLE function, "TRUE" or "FALSE"
         port map (
         O => open, -- Buffer p-side output
         OB => open, -- Buffer n-side output
         IO => CAL_DDR_dqs_p(5), -- Diff_p inout (connect directly to top-level port)
         IOB => CAL_DDR_dqs_n(5), -- Diff_n inout (connect directly to top-level port)
         DCITERMDISABLE => '0', -- DCI Termination enable input
         I => '0', -- Buffer input
         IBUFDISABLE => '0', -- input disable input, low=disable
         TM => '0', -- 3-state enable input, high=input, low=output
         TS => '0' -- 3-state enable input, high=output, low=input
         );
         
         IOBUFDS_DIFF_OUT_DCIEN_6 : IOBUFDS_DIFF_OUT_DCIEN
         generic map (
         DIFF_TERM => "TRUE", -- Differential Termination (TRUE/FALSE)
         IBUF_LOW_PWR => "TRUE", -- Low Power - TRUE, High Performance = FALSE
         IOSTANDARD => "DIFF_SSTL15_T_DCI", -- Specify the I/O standard
         USE_IBUFDISABLE => "TRUE") -- Use IBUFDISABLE function, "TRUE" or "FALSE"
         port map (
         O => open, -- Buffer p-side output
         OB => open, -- Buffer n-side output
         IO => CAL_DDR_dqs_p(6), -- Diff_p inout (connect directly to top-level port)
         IOB => CAL_DDR_dqs_n(6), -- Diff_n inout (connect directly to top-level port)
         DCITERMDISABLE => '0', -- DCI Termination enable input
         I => '0', -- Buffer input
         IBUFDISABLE => '0', -- input disable input, low=disable
         TM => '0', -- 3-state enable input, high=input, low=output
         TS => '0' -- 3-state enable input, high=output, low=input
         );
         
         IOBUFDS_DIFF_OUT_DCIEN_7 : IOBUFDS_DIFF_OUT_DCIEN
         generic map (
         DIFF_TERM => "TRUE", -- Differential Termination (TRUE/FALSE)
         IBUF_LOW_PWR => "TRUE", -- Low Power - TRUE, High Performance = FALSE
         IOSTANDARD => "DIFF_SSTL15_T_DCI", -- Specify the I/O standard
         USE_IBUFDISABLE => "TRUE") -- Use IBUFDISABLE function, "TRUE" or "FALSE"
         port map (
         O => open, -- Buffer p-side output
         OB => open, -- Buffer n-side output
         IO => CAL_DDR_dqs_p(7), -- Diff_p inout (connect directly to top-level port)
         IOB => CAL_DDR_dqs_n(7), -- Diff_n inout (connect directly to top-level port)
         DCITERMDISABLE => '0', -- DCI Termination enable input
         I => '0', -- Buffer input
         IBUFDISABLE => '0', -- input disable input, low=disable
         TM => '0', -- 3-state enable input, high=input, low=output
         TS => '0' -- 3-state enable input, high=output, low=input
         );

   end generate;
   
   MIG_4DDR : if (G_4DDR = true) generate
   begin  
      core_wrapper_i: component core_4DDR_wrapper
      port map (	
         --ADC_READOUT CTRL AXI WRAPPER
         ADC_READOUT_CTRL_awvalid(0) => ADC_READOUT_CTRL_MOSI.AWVALID,
         ADC_READOUT_CTRL_awaddr => ADC_READOUT_CTRL_MOSI.AWADDR,
         ADC_READOUT_CTRL_awprot => ADC_READOUT_CTRL_MOSI.AWPROT,
         ADC_READOUT_CTRL_wvalid(0) => ADC_READOUT_CTRL_MOSI.WVALID,
         ADC_READOUT_CTRL_wdata => ADC_READOUT_CTRL_MOSI.WDATA,
         ADC_READOUT_CTRL_wstrb => ADC_READOUT_CTRL_MOSI.WSTRB,
         ADC_READOUT_CTRL_bready(0) => ADC_READOUT_CTRL_MOSI.BREADY,
         ADC_READOUT_CTRL_arvalid(0) => ADC_READOUT_CTRL_MOSI.ARVALID,
         ADC_READOUT_CTRL_araddr => ADC_READOUT_CTRL_MOSI.ARADDR,
         ADC_READOUT_CTRL_arprot => ADC_READOUT_CTRL_MOSI.ARPROT,
         ADC_READOUT_CTRL_rready(0) => ADC_READOUT_CTRL_MOSI.RREADY,
         
         ADC_READOUT_CTRL_awready(0) => ADC_READOUT_CTRL_MISO.AWREADY,
         ADC_READOUT_CTRL_wready(0) => ADC_READOUT_CTRL_MISO.WREADY,
         ADC_READOUT_CTRL_bvalid(0) => ADC_READOUT_CTRL_MISO.BVALID,
         ADC_READOUT_CTRL_bresp => ADC_READOUT_CTRL_MISO.BRESP,
         ADC_READOUT_CTRL_arready(0) => ADC_READOUT_CTRL_MISO.ARREADY,
         ADC_READOUT_CTRL_rvalid(0) => ADC_READOUT_CTRL_MISO.RVALID,
         ADC_READOUT_CTRL_rdata => ADC_READOUT_CTRL_MISO.RDATA,
         ADC_READOUT_CTRL_rresp => ADC_READOUT_CTRL_MISO.RRESP,
         
         --AEC CTRL AXI WRAPPER
         AEC_CTRL_awvalid(0)	=> AEC_CTRL_MOSI.AWVALID,
         AEC_CTRL_awaddr		=> AEC_CTRL_MOSI.AWADDR, 
         AEC_CTRL_awprot		=> AEC_CTRL_MOSI.AWPROT, 
         AEC_CTRL_arvalid(0)	=> AEC_CTRL_MOSI.ARVALID,
         AEC_CTRL_araddr		=> AEC_CTRL_MOSI.ARADDR, 
         AEC_CTRL_arprot		=> AEC_CTRL_MOSI.ARPROT, 
         AEC_CTRL_wvalid(0)		=> AEC_CTRL_MOSI.WVALID, 
         AEC_CTRL_wdata		=> AEC_CTRL_MOSI.WDATA, 
         AEC_CTRL_wstrb		=> AEC_CTRL_MOSI.WSTRB ,
         AEC_CTRL_bready(0)		=> AEC_CTRL_MOSI.BREADY, 
         AEC_CTRL_rready(0)		=> AEC_CTRL_MOSI.RREADY, 
         AEC_CTRL_awready(0)	=> AEC_CTRL_MISO.AWREADY,
         AEC_CTRL_wready(0)		=> AEC_CTRL_MISO.WREADY, 
         AEC_CTRL_bvalid(0)		=> AEC_CTRL_MISO.BVALID, 
         AEC_CTRL_bresp		=> AEC_CTRL_MISO.BRESP, 
         AEC_CTRL_arready(0)	=> AEC_CTRL_MISO.ARREADY,
         AEC_CTRL_rvalid(0)		=> AEC_CTRL_MISO.RVALID, 
         AEC_CTRL_rdata		=> AEC_CTRL_MISO.RDATA, 
         AEC_CTRL_rresp		=> AEC_CTRL_MISO.RRESP, 
         
         -- CALIB_RAM_AXI WRAPPER
         CALIB_RAM_AXI_awvalid(0)	=> CALIB_RAM_MOSI.AWVALID,
         CALIB_RAM_AXI_awaddr		=> CALIB_RAM_MOSI.AWADDR, 
         CALIB_RAM_AXI_awprot		=> CALIB_RAM_MOSI.AWPROT, 
         CALIB_RAM_AXI_arvalid(0)	=> CALIB_RAM_MOSI.ARVALID,
         CALIB_RAM_AXI_araddr		=> CALIB_RAM_MOSI.ARADDR, 
         CALIB_RAM_AXI_arprot		=> CALIB_RAM_MOSI.ARPROT, 
         CALIB_RAM_AXI_wvalid(0)		=> CALIB_RAM_MOSI.WVALID, 
         CALIB_RAM_AXI_wdata		=> CALIB_RAM_MOSI.WDATA, 
         CALIB_RAM_AXI_wstrb		=> CALIB_RAM_MOSI.WSTRB ,
         CALIB_RAM_AXI_bready(0)		=> CALIB_RAM_MOSI.BREADY, 
         CALIB_RAM_AXI_rready(0)		=> CALIB_RAM_MOSI.RREADY, 
         CALIB_RAM_AXI_awready(0)	=> CALIB_RAM_MISO.AWREADY,
         CALIB_RAM_AXI_wready(0)		=> CALIB_RAM_MISO.WREADY, 
         CALIB_RAM_AXI_bvalid(0)		=> CALIB_RAM_MISO.BVALID, 
         CALIB_RAM_AXI_bresp		=> CALIB_RAM_MISO.BRESP, 
         CALIB_RAM_AXI_arready(0)	=> CALIB_RAM_MISO.ARREADY,
         CALIB_RAM_AXI_rvalid(0)		=> CALIB_RAM_MISO.RVALID, 
         CALIB_RAM_AXI_rdata		=> CALIB_RAM_MISO.RDATA, 
         CALIB_RAM_AXI_rresp		=> CALIB_RAM_MISO.RRESP,
         
         --CALIBRATIONL WRAPPER
         CALIBCONFIG_AXI_awvalid(0) => CALIBCONFIG_MOSI.AWVALID,
         CALIBCONFIG_AXI_awaddr => CALIBCONFIG_MOSI.AWADDR,
         CALIBCONFIG_AXI_awprot => CALIBCONFIG_MOSI.AWPROT,
         CALIBCONFIG_AXI_wvalid(0) => CALIBCONFIG_MOSI.WVALID,
         CALIBCONFIG_AXI_wdata => CALIBCONFIG_MOSI.WDATA,
         CALIBCONFIG_AXI_wstrb => CALIBCONFIG_MOSI.WSTRB,
         CALIBCONFIG_AXI_bready(0) => CALIBCONFIG_MOSI.BREADY,
         CALIBCONFIG_AXI_arvalid(0) => CALIBCONFIG_MOSI.ARVALID,
         CALIBCONFIG_AXI_araddr => CALIBCONFIG_MOSI.ARADDR,
         CALIBCONFIG_AXI_arprot => CALIBCONFIG_MOSI.ARPROT,
         CALIBCONFIG_AXI_rready(0) => CALIBCONFIG_MOSI.RREADY,
         
         CALIBCONFIG_AXI_awready(0) => CALIBCONFIG_MISO.AWREADY,
         CALIBCONFIG_AXI_wready(0) => CALIBCONFIG_MISO.WREADY,
         CALIBCONFIG_AXI_bvalid(0) => CALIBCONFIG_MISO.BVALID,
         CALIBCONFIG_AXI_bresp => CALIBCONFIG_MISO.BRESP,
         CALIBCONFIG_AXI_arready(0) => CALIBCONFIG_MISO.ARREADY,
         CALIBCONFIG_AXI_rvalid(0) => CALIBCONFIG_MISO.RVALID,
         CALIBCONFIG_AXI_rdata => CALIBCONFIG_MISO.RDATA,
         CALIBCONFIG_AXI_rresp => CALIBCONFIG_MISO.RRESP,
         
         --ICU WRAPPER
         M_ICU_AXI_awvalid(0) => AXIL_ICU_MOSI.AWVALID,
         M_ICU_AXI_awaddr => AXIL_ICU_MOSI.AWADDR,
         M_ICU_AXI_awprot => AXIL_ICU_MOSI.AWPROT,
         M_ICU_AXI_wvalid(0) => AXIL_ICU_MOSI.WVALID,
         M_ICU_AXI_wdata => AXIL_ICU_MOSI.WDATA,
         M_ICU_AXI_wstrb => AXIL_ICU_MOSI.WSTRB,
         M_ICU_AXI_bready(0) => AXIL_ICU_MOSI.BREADY,
         M_ICU_AXI_arvalid(0) => AXIL_ICU_MOSI.ARVALID,
         M_ICU_AXI_araddr => AXIL_ICU_MOSI.ARADDR,
         M_ICU_AXI_arprot => AXIL_ICU_MOSI.ARPROT,
         M_ICU_AXI_rready(0) => AXIL_ICU_MOSI.RREADY,
         
         M_ICU_AXI_awready(0) => AXIL_ICU_MISO.AWREADY,
         M_ICU_AXI_wready(0) => AXIL_ICU_MISO.WREADY,
         M_ICU_AXI_bvalid(0) => AXIL_ICU_MISO.BVALID,
         M_ICU_AXI_bresp => AXIL_ICU_MISO.BRESP,
         M_ICU_AXI_arready(0) => AXIL_ICU_MISO.ARREADY,
         M_ICU_AXI_rvalid(0) => AXIL_ICU_MISO.RVALID,
         M_ICU_AXI_rdata => AXIL_ICU_MISO.RDATA,
         M_ICU_AXI_rresp => AXIL_ICU_MISO.RRESP,
         
         NLC_LUT_AXI_awvalid => NLC_LUT_MOSI.AWVALID,
         NLC_LUT_AXI_awaddr => NLC_LUT_MOSI.AWADDR,
         NLC_LUT_AXI_awprot => NLC_LUT_MOSI.AWPROT,
         NLC_LUT_AXI_wvalid => NLC_LUT_MOSI.WVALID,
         NLC_LUT_AXI_wdata => NLC_LUT_MOSI.WDATA,
         NLC_LUT_AXI_wstrb => NLC_LUT_MOSI.WSTRB,
         NLC_LUT_AXI_bready => NLC_LUT_MOSI.BREADY,
         NLC_LUT_AXI_arvalid => NLC_LUT_MOSI.ARVALID,
         NLC_LUT_AXI_araddr => NLC_LUT_MOSI.ARADDR,
         NLC_LUT_AXI_arprot => NLC_LUT_MOSI.ARPROT,
         NLC_LUT_AXI_rready => NLC_LUT_MOSI.RREADY,
         
         NLC_LUT_AXI_awready => NLC_LUT_MISO.AWREADY,
         NLC_LUT_AXI_wready => NLC_LUT_MISO.WREADY,
         NLC_LUT_AXI_bvalid => NLC_LUT_MISO.BVALID,
         NLC_LUT_AXI_bresp => NLC_LUT_MISO.BRESP,
         NLC_LUT_AXI_arready => NLC_LUT_MISO.ARREADY,
         NLC_LUT_AXI_rvalid => NLC_LUT_MISO.RVALID,
         NLC_LUT_AXI_rdata => NLC_LUT_MISO.RDATA,
         NLC_LUT_AXI_rresp => NLC_LUT_MISO.RRESP,
         
         RQC_LUT_AXI_awvalid => RQC_LUT_MOSI.AWVALID,
         RQC_LUT_AXI_awaddr => RQC_LUT_MOSI.AWADDR,
         RQC_LUT_AXI_awprot => RQC_LUT_MOSI.AWPROT,
         RQC_LUT_AXI_wvalid => RQC_LUT_MOSI.WVALID,
         RQC_LUT_AXI_wdata => RQC_LUT_MOSI.WDATA,
         RQC_LUT_AXI_wstrb => RQC_LUT_MOSI.WSTRB,
         RQC_LUT_AXI_bready => RQC_LUT_MOSI.BREADY,
         RQC_LUT_AXI_arvalid => RQC_LUT_MOSI.ARVALID,
         RQC_LUT_AXI_araddr => RQC_LUT_MOSI.ARADDR,
         RQC_LUT_AXI_arprot => RQC_LUT_MOSI.ARPROT,
         RQC_LUT_AXI_rready => RQC_LUT_MOSI.RREADY,
         
         RQC_LUT_AXI_awready => RQC_LUT_MISO.AWREADY,
         RQC_LUT_AXI_wready => RQC_LUT_MISO.WREADY,
         RQC_LUT_AXI_bvalid => RQC_LUT_MISO.BVALID,
         RQC_LUT_AXI_bresp => RQC_LUT_MISO.BRESP,
         RQC_LUT_AXI_arready => RQC_LUT_MISO.ARREADY,
         RQC_LUT_AXI_rvalid => RQC_LUT_MISO.RVALID,
         RQC_LUT_AXI_rdata => RQC_LUT_MISO.RDATA,
         RQC_LUT_AXI_rresp => RQC_LUT_MISO.RRESP,
         
         -- EXPTIME CTRL WRAPPER
         EXPTIME_CTRL_awvalid(0)    => EXPTIME_CTRL_MOSI.AWVALID,
         EXPTIME_CTRL_awaddr     => EXPTIME_CTRL_MOSI.AWADDR, 
         EXPTIME_CTRL_awprot     => EXPTIME_CTRL_MOSI.AWPROT, 
         EXPTIME_CTRL_arvalid(0)    => EXPTIME_CTRL_MOSI.ARVALID,
         EXPTIME_CTRL_araddr     => EXPTIME_CTRL_MOSI.ARADDR, 
         EXPTIME_CTRL_arprot     => EXPTIME_CTRL_MOSI.ARPROT, 
         EXPTIME_CTRL_wvalid(0)     => EXPTIME_CTRL_MOSI.WVALID, 
         EXPTIME_CTRL_wdata		=> EXPTIME_CTRL_MOSI.WDATA, 
         EXPTIME_CTRL_wstrb		=> EXPTIME_CTRL_MOSI.WSTRB ,
         EXPTIME_CTRL_bready(0)     => EXPTIME_CTRL_MOSI.BREADY, 
         EXPTIME_CTRL_rready(0)     => EXPTIME_CTRL_MOSI.RREADY, 
         EXPTIME_CTRL_awready(0)	=> EXPTIME_CTRL_MISO.AWREADY,
         EXPTIME_CTRL_wready(0)     => EXPTIME_CTRL_MISO.WREADY, 
         EXPTIME_CTRL_bvalid(0)     => EXPTIME_CTRL_MISO.BVALID, 
         EXPTIME_CTRL_bresp		=> EXPTIME_CTRL_MISO.BRESP, 
         EXPTIME_CTRL_arready(0)	=> EXPTIME_CTRL_MISO.ARREADY,
         EXPTIME_CTRL_rvalid(0)     => EXPTIME_CTRL_MISO.RVALID, 
         EXPTIME_CTRL_rdata		=> EXPTIME_CTRL_MISO.RDATA, 
         EXPTIME_CTRL_rresp		=> EXPTIME_CTRL_MISO.RRESP,
         
         -- EHDRI CTRL WRAPPER
         M_EHDRI_CTRL_awvalid    => EHDRI_CTRL_MOSI.AWVALID,
         M_EHDRI_CTRL_awaddr     => EHDRI_CTRL_MOSI.AWADDR, 
         M_EHDRI_CTRL_awprot     => EHDRI_CTRL_MOSI.AWPROT, 
         M_EHDRI_CTRL_arvalid    => EHDRI_CTRL_MOSI.ARVALID,
         M_EHDRI_CTRL_araddr     => EHDRI_CTRL_MOSI.ARADDR, 
         M_EHDRI_CTRL_arprot     => EHDRI_CTRL_MOSI.ARPROT, 
         M_EHDRI_CTRL_wvalid    => EHDRI_CTRL_MOSI.WVALID, 
         M_EHDRI_CTRL_wdata		=> EHDRI_CTRL_MOSI.WDATA, 
         M_EHDRI_CTRL_wstrb		=> EHDRI_CTRL_MOSI.WSTRB ,
         M_EHDRI_CTRL_bready     => EHDRI_CTRL_MOSI.BREADY, 
         M_EHDRI_CTRL_rready     => EHDRI_CTRL_MOSI.RREADY, 
         M_EHDRI_CTRL_awready	=> EHDRI_CTRL_MISO.AWREADY,
         M_EHDRI_CTRL_wready     => EHDRI_CTRL_MISO.WREADY, 
         M_EHDRI_CTRL_bvalid     => EHDRI_CTRL_MISO.BVALID, 
         M_EHDRI_CTRL_bresp		=> EHDRI_CTRL_MISO.BRESP, 
         M_EHDRI_CTRL_arready	=> EHDRI_CTRL_MISO.ARREADY,
         M_EHDRI_CTRL_rdata		=> EHDRI_CTRL_MISO.RDATA, 
         M_EHDRI_CTRL_rresp		=> EHDRI_CTRL_MISO.RRESP,
         M_EHDRI_CTRL_rlast      => '0',
         M_EHDRI_CTRL_rvalid      => '0',
         
         --FPA CTRL WRAPPER
         FPA_CTRL_awvalid(0)        => FPA_CTRL_MOSI.AWVALID,
         FPA_CTRL_awaddr         => FPA_CTRL_MOSI.AWADDR, 
         FPA_CTRL_awprot         => FPA_CTRL_MOSI.AWPROT, 
         FPA_CTRL_arvalid(0)        => FPA_CTRL_MOSI.ARVALID,
         FPA_CTRL_araddr         => FPA_CTRL_MOSI.ARADDR, 
         FPA_CTRL_arprot         => FPA_CTRL_MOSI.ARPROT, 
         FPA_CTRL_wvalid(0)         => FPA_CTRL_MOSI.WVALID, 
         FPA_CTRL_wdata          => FPA_CTRL_MOSI.WDATA, 
         FPA_CTRL_wstrb		    => FPA_CTRL_MOSI.WSTRB ,
         FPA_CTRL_bready(0)         => FPA_CTRL_MOSI.BREADY, 
         FPA_CTRL_rready(0)         => FPA_CTRL_MOSI.RREADY, 
         FPA_CTRL_awready(0)	    => FPA_CTRL_MISO.AWREADY,
         FPA_CTRL_wready(0)         => FPA_CTRL_MISO.WREADY, 
         FPA_CTRL_bvalid(0)         => FPA_CTRL_MISO.BVALID, 
         FPA_CTRL_bresp		    => FPA_CTRL_MISO.BRESP, 
         FPA_CTRL_arready(0) 	    => FPA_CTRL_MISO.ARREADY,
         FPA_CTRL_rvalid(0)         => FPA_CTRL_MISO.RVALID, 
         FPA_CTRL_rdata		    => FPA_CTRL_MISO.RDATA, 
         FPA_CTRL_rresp		    => FPA_CTRL_MISO.RRESP,
         
         --FRAME BUFFER CTRL WRAPPER
         M_FRAME_BUFFER_CTRL_araddr  => FB_CTRL_MOSI.araddr,
         M_FRAME_BUFFER_CTRL_arprot  => FB_CTRL_MOSI.arprot,
         M_FRAME_BUFFER_CTRL_arvalid(0)  => FB_CTRL_MOSI.arvalid,
         M_FRAME_BUFFER_CTRL_awaddr  =>  FB_CTRL_MOSI.awaddr,
         M_FRAME_BUFFER_CTRL_awprot  =>  FB_CTRL_MOSI.awprot,
         M_FRAME_BUFFER_CTRL_awvalid(0)  => FB_CTRL_MOSI.awvalid,
         M_FRAME_BUFFER_CTRL_bready(0)  =>  FB_CTRL_MOSI.bready,
         M_FRAME_BUFFER_CTRL_rready(0)  => FB_CTRL_MOSI.rready,
         M_FRAME_BUFFER_CTRL_wdata  => FB_CTRL_MOSI.wdata,
         M_FRAME_BUFFER_CTRL_wstrb  =>  FB_CTRL_MOSI.wstrb,
         M_FRAME_BUFFER_CTRL_wvalid(0)  =>  FB_CTRL_MOSI.wvalid,
         M_FRAME_BUFFER_CTRL_awready(0)  => FB_CTRL_MISO.awready,
         M_FRAME_BUFFER_CTRL_wready(0)  => FB_CTRL_MISO.wready,
         M_FRAME_BUFFER_CTRL_bresp  =>   FB_CTRL_MISO.bresp,
         M_FRAME_BUFFER_CTRL_bvalid(0)  =>  FB_CTRL_MISO.bvalid,
         M_FRAME_BUFFER_CTRL_arready(0)  => FB_CTRL_MISO.arready,
         M_FRAME_BUFFER_CTRL_rdata =>   FB_CTRL_MISO.rdata,  
         M_FRAME_BUFFER_CTRL_rresp  =>  FB_CTRL_MISO.rresp,
         M_FRAME_BUFFER_CTRL_rvalid(0)  => FB_CTRL_MISO.rvalid,

         M_AXIS_MM2S_FB_tdata => AXIS_MM2S_DATA_MOSI_FB.tdata,
         M_AXIS_MM2S_FB_tkeep => AXIS_MM2S_DATA_MOSI_FB.tkeep,
         M_AXIS_MM2S_FB_tlast => AXIS_MM2S_DATA_MOSI_FB.tlast ,
         M_AXIS_MM2S_FB_tready => AXIS_MM2S_DATA_MISO_FB.tready,
         M_AXIS_MM2S_FB_tvalid => AXIS_MM2S_DATA_MOSI_FB.tvalid, 

         M_AXIS_MM2S_STS_FB_tdata => AXIS_MM2S_STS_MOSI_FB.tdata,
         M_AXIS_MM2S_STS_FB_tkeep => AXIS_MM2S_STS_MOSI_FB.tkeep,
         M_AXIS_MM2S_STS_FB_tlast => AXIS_MM2S_STS_MOSI_FB.tlast,
         M_AXIS_MM2S_STS_FB_tready => AXIS_MM2S_STS_MISO_FB.tready,
         M_AXIS_MM2S_STS_FB_tvalid => AXIS_MM2S_STS_MOSI_FB.tvalid,

         S_AXIS_MM2S_CMD_FB_tdata => AXIS_MM2S_CMD_MOSI_FB.tdata,
         S_AXIS_MM2S_CMD_FB_tready => AXIS_MM2S_CMD_MISO_FB.tready,
         S_AXIS_MM2S_CMD_FB_tvalid => AXIS_MM2S_CMD_MOSI_FB.tvalid,

         S_AXIS_S2MM_FB_tdata => AXIS_S2MM_DATA_MOSI_FB.tdata,
         S_AXIS_S2MM_FB_tkeep => AXIS_S2MM_DATA_MOSI_FB.tkeep,
         S_AXIS_S2MM_FB_tlast => AXIS_S2MM_DATA_MOSI_FB.tlast ,
         S_AXIS_S2MM_FB_tready => AXIS_S2MM_DATA_MISO_FB.tready,
         S_AXIS_S2MM_FB_tvalid => AXIS_S2MM_DATA_MOSI_FB.tvalid, 

         M_AXIS_S2MM_STS_FB_tdata => AXIS_S2MM_STS_MOSI_FB.tdata,
         M_AXIS_S2MM_STS_FB_tkeep => AXIS_S2MM_STS_MOSI_FB.tkeep,
         M_AXIS_S2MM_STS_FB_tlast => AXIS_S2MM_STS_MOSI_FB.tlast,
         M_AXIS_S2MM_STS_FB_tready => AXIS_S2MM_STS_MISO_FB.tready,
         M_AXIS_S2MM_STS_FB_tvalid => AXIS_S2MM_STS_MOSI_FB.tvalid,

         S_AXIS_S2MM_CMD_FB_tdata => AXIS_S2MM_CMD_MOSI_FB.tdata,
         S_AXIS_S2MM_CMD_FB_tready => AXIS_S2MM_CMD_MISO_FB.tready,
         S_AXIS_S2MM_CMD_FB_tvalid => AXIS_S2MM_CMD_MOSI_FB.tvalid,
    
    
    
         --HEADER CTRL WRAPPER
         HEADER_CTRL_awvalid(0)        => HEADER_CTRL_MOSI.AWVALID,
         HEADER_CTRL_awaddr          => HEADER_CTRL_MOSI.AWADDR, 
         HEADER_CTRL_awprot          => HEADER_CTRL_MOSI.AWPROT, 
         HEADER_CTRL_arvalid(0)         => HEADER_CTRL_MOSI.ARVALID,
         HEADER_CTRL_araddr          => HEADER_CTRL_MOSI.ARADDR, 
         HEADER_CTRL_arprot          => HEADER_CTRL_MOSI.ARPROT, 
         HEADER_CTRL_wvalid(0)          => HEADER_CTRL_MOSI.WVALID, 
         HEADER_CTRL_wdata           => HEADER_CTRL_MOSI.WDATA, 
         HEADER_CTRL_wstrb		    => HEADER_CTRL_MOSI.WSTRB ,
         HEADER_CTRL_bready(0)          => HEADER_CTRL_MOSI.BREADY, 
         HEADER_CTRL_rready(0)          => HEADER_CTRL_MOSI.RREADY, 
         HEADER_CTRL_awready(0)	        => HEADER_CTRL_MISO.AWREADY,
         HEADER_CTRL_wready(0)          => HEADER_CTRL_MISO.WREADY, 
         HEADER_CTRL_bvalid(0)          => HEADER_CTRL_MISO.BVALID, 
         HEADER_CTRL_bresp		    => HEADER_CTRL_MISO.BRESP, 
         HEADER_CTRL_arready(0) 	    => HEADER_CTRL_MISO.ARREADY,
         HEADER_CTRL_rvalid(0)          => HEADER_CTRL_MISO.RVALID, 
         HEADER_CTRL_rdata		    => HEADER_CTRL_MISO.RDATA, 
         HEADER_CTRL_rresp		    => HEADER_CTRL_MISO.RRESP,
         
         --TRIGGER CTRL WRAPPER
         TRIGGER_CTRL_awvalid(0)        => TRIGGER_CTRL_MOSI.AWVALID,
         TRIGGER_CTRL_awaddr         => TRIGGER_CTRL_MOSI.AWADDR, 
         TRIGGER_CTRL_awprot         => TRIGGER_CTRL_MOSI.AWPROT, 
         TRIGGER_CTRL_arvalid(0)        => TRIGGER_CTRL_MOSI.ARVALID,
         TRIGGER_CTRL_araddr         => TRIGGER_CTRL_MOSI.ARADDR, 
         TRIGGER_CTRL_arprot         => TRIGGER_CTRL_MOSI.ARPROT, 
         TRIGGER_CTRL_wvalid(0)         => TRIGGER_CTRL_MOSI.WVALID, 
         TRIGGER_CTRL_wdata          => TRIGGER_CTRL_MOSI.WDATA, 
         TRIGGER_CTRL_wstrb		    => TRIGGER_CTRL_MOSI.WSTRB ,
         TRIGGER_CTRL_bready(0)         => TRIGGER_CTRL_MOSI.BREADY, 
         TRIGGER_CTRL_rready(0)         => TRIGGER_CTRL_MOSI.RREADY, 
         TRIGGER_CTRL_awready(0)	    => TRIGGER_CTRL_MISO.AWREADY,
         TRIGGER_CTRL_wready(0)         => TRIGGER_CTRL_MISO.WREADY, 
         TRIGGER_CTRL_bvalid(0)         => TRIGGER_CTRL_MISO.BVALID, 
         TRIGGER_CTRL_bresp		    => TRIGGER_CTRL_MISO.BRESP, 
         TRIGGER_CTRL_arready(0) 	    => TRIGGER_CTRL_MISO.ARREADY,
         TRIGGER_CTRL_rvalid(0)         => TRIGGER_CTRL_MISO.RVALID, 
         TRIGGER_CTRL_rdata		    => TRIGGER_CTRL_MISO.RDATA, 
         TRIGGER_CTRL_rresp		    => TRIGGER_CTRL_MISO.RRESP,
         
         --SFW CTRL WRAPPER
         SFW_CTRL_awvalid(0)        => SFW_CTRL_MOSI.AWVALID,
         SFW_CTRL_awaddr         => SFW_CTRL_MOSI.AWADDR, 
         SFW_CTRL_awprot         => SFW_CTRL_MOSI.AWPROT, 
         SFW_CTRL_arvalid(0)        => SFW_CTRL_MOSI.ARVALID,
         SFW_CTRL_araddr         => SFW_CTRL_MOSI.ARADDR, 
         SFW_CTRL_arprot         => SFW_CTRL_MOSI.ARPROT, 
         SFW_CTRL_wvalid(0)         => SFW_CTRL_MOSI.WVALID, 
         SFW_CTRL_wdata          => SFW_CTRL_MOSI.WDATA, 
         SFW_CTRL_wstrb		    => SFW_CTRL_MOSI.WSTRB ,
         SFW_CTRL_bready(0)         => SFW_CTRL_MOSI.BREADY, 
         SFW_CTRL_rready(0)         => SFW_CTRL_MOSI.RREADY, 
         SFW_CTRL_awready(0)	    => SFW_CTRL_MISO.AWREADY,
         SFW_CTRL_wready(0)         => SFW_CTRL_MISO.WREADY, 
         SFW_CTRL_bvalid(0)         => SFW_CTRL_MISO.BVALID, 
         SFW_CTRL_bresp		    => SFW_CTRL_MISO.BRESP, 
         SFW_CTRL_arready(0) 	    => SFW_CTRL_MISO.ARREADY,
         SFW_CTRL_rvalid(0)         => SFW_CTRL_MISO.RVALID, 
         SFW_CTRL_rdata		    => SFW_CTRL_MISO.RDATA, 
         SFW_CTRL_rresp		    => SFW_CTRL_MISO.RRESP,
         
         --FAN CTRL WRAPPER
         FAN_CTRL_awvalid(0)        => FAN_CTRL_MOSI.AWVALID,
         FAN_CTRL_awaddr         => FAN_CTRL_MOSI.AWADDR, 
         FAN_CTRL_awprot         => FAN_CTRL_MOSI.AWPROT, 
         FAN_CTRL_arvalid(0)        => FAN_CTRL_MOSI.ARVALID,
         FAN_CTRL_araddr         => FAN_CTRL_MOSI.ARADDR, 
         FAN_CTRL_arprot         => FAN_CTRL_MOSI.ARPROT, 
         FAN_CTRL_wvalid(0)         => FAN_CTRL_MOSI.WVALID, 
         FAN_CTRL_wdata          => FAN_CTRL_MOSI.WDATA, 
         FAN_CTRL_wstrb		      => FAN_CTRL_MOSI.WSTRB ,
         FAN_CTRL_bready(0)         => FAN_CTRL_MOSI.BREADY, 
         FAN_CTRL_rready(0)         => FAN_CTRL_MOSI.RREADY, 
         FAN_CTRL_awready(0)	      => FAN_CTRL_MISO.AWREADY,
         FAN_CTRL_wready(0)         => FAN_CTRL_MISO.WREADY, 
         FAN_CTRL_bvalid(0)         => FAN_CTRL_MISO.BVALID, 
         FAN_CTRL_bresp		      => FAN_CTRL_MISO.BRESP, 
         FAN_CTRL_arready(0) 	      => FAN_CTRL_MISO.ARREADY,
         FAN_CTRL_rvalid(0)         => FAN_CTRL_MISO.RVALID, 
         FAN_CTRL_rdata		      => FAN_CTRL_MISO.RDATA, 
         FAN_CTRL_rresp		      => FAN_CTRL_MISO.RRESP,
         
         --MGT CTRL WRAPPER
         MGT_CTRL_awvalid(0)        => MGT_CTRL_MOSI.AWVALID,
         MGT_CTRL_awaddr            => MGT_CTRL_MOSI.AWADDR, 
         MGT_CTRL_awprot            => MGT_CTRL_MOSI.AWPROT, 
         MGT_CTRL_arvalid(0)        => MGT_CTRL_MOSI.ARVALID,
         MGT_CTRL_araddr            => MGT_CTRL_MOSI.ARADDR, 
         MGT_CTRL_arprot            => MGT_CTRL_MOSI.ARPROT, 
         MGT_CTRL_wvalid(0)         => MGT_CTRL_MOSI.WVALID, 
         MGT_CTRL_wdata             => MGT_CTRL_MOSI.WDATA, 
         MGT_CTRL_wstrb		         => MGT_CTRL_MOSI.WSTRB ,
         MGT_CTRL_bready(0)         => MGT_CTRL_MOSI.BREADY, 
         MGT_CTRL_rready(0)         => MGT_CTRL_MOSI.RREADY, 
         MGT_CTRL_awready(0)	      => MGT_CTRL_MISO.AWREADY,
         MGT_CTRL_wready(0)         => MGT_CTRL_MISO.WREADY, 
         MGT_CTRL_bvalid(0)         => MGT_CTRL_MISO.BVALID, 
         MGT_CTRL_bresp		         => MGT_CTRL_MISO.BRESP, 
         MGT_CTRL_arready(0) 	      => MGT_CTRL_MISO.ARREADY,
         MGT_CTRL_rvalid(0)         => MGT_CTRL_MISO.RVALID, 
         MGT_CTRL_rdata		         => MGT_CTRL_MISO.RDATA, 
         MGT_CTRL_rresp		         => MGT_CTRL_MISO.RRESP,   
         
         --IRIG  
         IRIG_CTRL_awvalid(0)        => IRIG_CTRL_MOSI.AWVALID,
         IRIG_CTRL_awaddr            => IRIG_CTRL_MOSI.AWADDR, 
         IRIG_CTRL_awprot            => IRIG_CTRL_MOSI.AWPROT, 
         IRIG_CTRL_arvalid(0)        => IRIG_CTRL_MOSI.ARVALID,
         IRIG_CTRL_araddr            => IRIG_CTRL_MOSI.ARADDR, 
         IRIG_CTRL_arprot            => IRIG_CTRL_MOSI.ARPROT, 
         IRIG_CTRL_wvalid(0)         => IRIG_CTRL_MOSI.WVALID, 
         IRIG_CTRL_wdata             => IRIG_CTRL_MOSI.WDATA, 
         IRIG_CTRL_wstrb		       => IRIG_CTRL_MOSI.WSTRB ,
         IRIG_CTRL_bready(0)         => IRIG_CTRL_MOSI.BREADY, 
         IRIG_CTRL_rready(0)         => IRIG_CTRL_MOSI.RREADY, 
         IRIG_CTRL_awready(0)	       => IRIG_CTRL_MISO.AWREADY,
         IRIG_CTRL_wready(0)         => IRIG_CTRL_MISO.WREADY, 
         IRIG_CTRL_bvalid(0)         => IRIG_CTRL_MISO.BVALID, 
         IRIG_CTRL_bresp		       => IRIG_CTRL_MISO.BRESP, 
         IRIG_CTRL_arready(0) 	    => IRIG_CTRL_MISO.ARREADY,
         IRIG_CTRL_rvalid(0)         => IRIG_CTRL_MISO.RVALID, 
         IRIG_CTRL_rdata		       => IRIG_CTRL_MISO.RDATA, 
         IRIG_CTRL_rresp		       => IRIG_CTRL_MISO.RRESP,
         
         -- BUFFTABLE 
         M_BUF_TABLE_awvalid(0)         => BUFTABLE_MOSI.AWVALID,
         M_BUF_TABLE_awaddr              => BUFTABLE_MOSI.AWADDR, 
         M_BUF_TABLE_awprot              => BUFTABLE_MOSI.AWPROT, 
         M_BUF_TABLE_arvalid(0)        => BUFTABLE_MOSI.ARVALID,
         M_BUF_TABLE_araddr              => BUFTABLE_MOSI.ARADDR, 
         M_BUF_TABLE_arprot              => BUFTABLE_MOSI.ARPROT, 
         M_BUF_TABLE_wvalid(0)           => BUFTABLE_MOSI.WVALID, 
         M_BUF_TABLE_wdata               => BUFTABLE_MOSI.WDATA, 
         M_BUF_TABLE_wstrb		        => BUFTABLE_MOSI.WSTRB ,
         M_BUF_TABLE_bready(0)           => BUFTABLE_MOSI.BREADY, 
         M_BUF_TABLE_rready(0)          => BUFTABLE_MOSI.RREADY, 
         M_BUF_TABLE_awready(0)	        => BUFTABLE_MISO.AWREADY,
         M_BUF_TABLE_wready(0)         => BUFTABLE_MISO.WREADY, 
         M_BUF_TABLE_bvalid(0)           => BUFTABLE_MISO.BVALID, 
         M_BUF_TABLE_bresp		        => BUFTABLE_MISO.BRESP, 
         M_BUF_TABLE_arready(0) 	        => BUFTABLE_MISO.ARREADY,
         M_BUF_TABLE_rvalid(0)           => BUFTABLE_MISO.RVALID, 
         M_BUF_TABLE_rdata		        => BUFTABLE_MISO.RDATA, 
         M_BUF_TABLE_rresp		        => BUFTABLE_MISO.RRESP,
         
         -- BUFFERINT CTRL
         M_BUFFERING_CTRL_awvalid(0)         => BUFFERING_CTRL_MOSI.AWVALID,
         M_BUFFERING_CTRL_awaddr              => BUFFERING_CTRL_MOSI.AWADDR, 
         M_BUFFERING_CTRL_awprot              => BUFFERING_CTRL_MOSI.AWPROT, 
         M_BUFFERING_CTRL_arvalid(0)          => BUFFERING_CTRL_MOSI.ARVALID,
         M_BUFFERING_CTRL_araddr              => BUFFERING_CTRL_MOSI.ARADDR, 
         M_BUFFERING_CTRL_arprot              => BUFFERING_CTRL_MOSI.ARPROT, 
         M_BUFFERING_CTRL_wvalid(0)          => BUFFERING_CTRL_MOSI.WVALID, 
         M_BUFFERING_CTRL_wdata               => BUFFERING_CTRL_MOSI.WDATA, 
         M_BUFFERING_CTRL_wstrb		         => BUFFERING_CTRL_MOSI.WSTRB ,
         M_BUFFERING_CTRL_bready(0)          => BUFFERING_CTRL_MOSI.BREADY, 
         M_BUFFERING_CTRL_rready(0)           => BUFFERING_CTRL_MOSI.RREADY, 
         M_BUFFERING_CTRL_awready(0)	         => BUFFERING_CTRL_MISO.AWREADY,
         M_BUFFERING_CTRL_wready(0)          => BUFFERING_CTRL_MISO.WREADY, 
         M_BUFFERING_CTRL_bvalid(0)           => BUFFERING_CTRL_MISO.BVALID, 
         M_BUFFERING_CTRL_bresp		         => BUFFERING_CTRL_MISO.BRESP, 
         M_BUFFERING_CTRL_arready(0) 	     => BUFFERING_CTRL_MISO.ARREADY,
         M_BUFFERING_CTRL_rvalid(0)          => BUFFERING_CTRL_MISO.RVALID, 
         M_BUFFERING_CTRL_rdata		         => BUFFERING_CTRL_MISO.RDATA, 
         M_BUFFERING_CTRL_rresp		         => BUFFERING_CTRL_MISO.RRESP,
         
         --CLINK UART WRAPPER 
         CLINK_UART_rxd 			=>  UART_CLINK_RX,
         CLINK_UART_txd 			=>  UART_CLINK_TX,

         --FPGA UART WRAPPER
         FPGA_UART_rxd 			=>  UART_OUTPUT_RX,
         FPGA_UART_txd 			=>  UART_OUTPUT_TX,

         --OEM UART WRAPPER
         OEM_UART_rxd 			=>  UART_OEM_RX,
         OEM_UART_txd 			=>  UART_OEM_TX,   

         --FW UART WRAPPER
         FW_UART_rxd 			=>  UART_FW_RX,
         FW_UART_txd 			=>  UART_FW_TX, 

         --PLEORA UART WRAPPER
         PLEORA_UART_SIN 			=>  UART_PLEORA_RX,
         PLEORA_UART_SOUT 			=>  UART_PLEORA_TX,
         
         --LENS UART WRAPPER
         LENS_UART_SIN => LENS_UART_SIN,
         LENS_UART_SOUT => LENS_UART_SOUT,
         
         --USB UART WRAPPER
         USB_UART_baudoutn 	=> UART_TO_USB.BAUDOUTN,
         USB_UART_ddis 		=> UART_TO_USB.DDIS,
         USB_UART_dtrn 		=> UART_TO_USB.DTRN,
         USB_UART_out1n 		=> UART_TO_USB.OUT1N,
         USB_UART_out2n 		=> UART_TO_USB.OUT2N,
         USB_UART_rtsn 		=> UART_TO_USB.RTSN,
         USB_UART_rxrdyn 	=> UART_TO_USB.RXRDYN,
         USB_UART_txd 		=> UART_TO_USB.TXD,
         USB_UART_txrdyn 	=> UART_TO_USB.TXRDYN,
         USB_UART_rxd 		=> USB_TO_UART.RXD,
         USB_UART_ctsn 		=> USB_TO_UART.CTSN,
         USB_UART_dcdn 		=> USB_TO_UART.DCDN,
         USB_UART_dsrn 		=> USB_TO_UART.DSRN,
         USB_UART_ri 		=> USB_TO_UART.RI,
         
         GPS_UART_rxd 			=>  UART_GPS_RX,
         GPS_UART_txd 			=>  UART_GPS_TX, 
         
         --Code Mem
         CODE_DDR_addr => Code_mem_addr,
         CODE_DDR_ba => Code_mem_ba,
         CODE_DDR_cas_n => Code_mem_cas_n,
         CODE_DDR_ck_n => Code_mem_ck_n,
         CODE_DDR_ck_p => Code_mem_ck_p,
         CODE_DDR_cke => Code_mem_cke,
         CODE_DDR_dm => Code_mem_dm,
         CODE_DDR_dq => Code_mem_dq,
         CODE_DDR_dqs_n => Code_mem_dqs_n,
         CODE_DDR_dqs_p => Code_mem_dqs_p,
         CODE_DDR_odt => Code_mem_odt,
         CODE_DDR_ras_n => Code_mem_ras_n,
         CODE_DDR_reset_n => Code_mem_reset_n,
         CODE_DDR_we_n => Code_mem_we_n,
         
         aresetn(0)      => ARESETN,
         clk_mb     => clk_mb,
         clk_cal    => clk_cal,
         clk_200     => clk_200,
         clk_din      => clk_din,
         clk_irig      => clk_irig,
         clk_mgt_init  => clk_mgt_init,
         clk_data    => clk_data,
         
         vn_in       => vn_in,
         vp_in       => vp_in,
         LED_GPIO_tri_o => LED_GPIO_tri_o,
         
         SYS_CLK_0_clk_n => SYS_CLK_0_N,
         SYS_CLK_0_clk_p => SYS_CLK_0_P,
         SYS_CLK_1_clk_n => SYS_CLK_1_N,
         SYS_CLK_1_clk_p => SYS_CLK_1_P,
         
         mux_addr_tri_o => MUX_ADDR,
         power_gpio_tri_io => POWER_GPIO,
         BUTTON => BUTTON,
         rev_gpio_tri_i => REV_GPIO,
         
         M_BULK_AXI_araddr => BULK_AXI_MOSI.ARADDR,
         M_BULK_AXI_arprot => BULK_AXI_MOSI.ARPROT,
         M_BULK_AXI_arready(0) => BULK_AXI_MISO.ARREADY,
         M_BULK_AXI_arvalid(0) => BULK_AXI_MOSI.ARVALID,
         M_BULK_AXI_awaddr => BULK_AXI_MOSI.AWADDR,
         M_BULK_AXI_awprot => BULK_AXI_MOSI.AWPROT,
         M_BULK_AXI_awready(0) => BULK_AXI_MISO.AWREADY,
         M_BULK_AXI_awvalid(0) => BULK_AXI_MOSI.AWVALID,
         M_BULK_AXI_bready(0) => BULK_AXI_MOSI.BREADY,
         M_BULK_AXI_bresp => BULK_AXI_MISO.BRESP,
         M_BULK_AXI_bvalid(0) => BULK_AXI_MISO.BVALID,
         M_BULK_AXI_rdata => BULK_AXI_MISO.RDATA,
         M_BULK_AXI_rready(0) => BULK_AXI_MOSI.RREADY,
         M_BULK_AXI_rresp => BULK_AXI_MISO.RRESP,
         M_BULK_AXI_rvalid(0) => BULK_AXI_MISO.RVALID,
         M_BULK_AXI_wdata => BULK_AXI_MOSI.WDATA,
         M_BULK_AXI_wready(0) => BULK_AXI_MISO.WREADY,
         M_BULK_AXI_wstrb => BULK_AXI_MOSI.WSTRB,
         M_BULK_AXI_wvalid(0) => BULK_AXI_MOSI.WVALID,
         bulk_interrupt => bulk_interrupt,
         
         CAL_DDR_addr => CAL_DDR_addr,
         CAL_DDR_ba  => CAL_DDR_ba,
         CAL_DDR_cas_n => CAL_DDR_cas_n,
         CAL_DDR_ck_n => CAL_DDR_ck_n,
         CAL_DDR_ck_p => CAL_DDR_ck_p,
         CAL_DDR_cke => CAL_DDR_cke,
         CAL_DDR_cs_n => CAL_DDR_cs_n,
         CAL_DDR_dm => CAL_DDR_dm,
         CAL_DDR_dq => CAL_DDR_dq,
         CAL_DDR_dqs_n => CAL_DDR_dqs_n,
         CAL_DDR_dqs_p => CAL_DDR_dqs_p,
         CAL_DDR_odt => CAL_DDR_odt,
         CAL_DDR_ras_n => CAL_DDR_ras_n,
         CAL_DDR_reset_n => CAL_DDR_reset_n,
         CAL_DDR_we_n => CAL_DDR_we_n,
         
         M_AXIS_CALDDR_MM2S_tvalid => AXI4_STREAM_DATA_MOSI.TVALID,
         M_AXIS_CALDDR_MM2S_tdata => AXI4_STREAM_DATA_MOSI.TDATA,
         M_AXIS_CALDDR_MM2S_tkeep => AXI4_STREAM_DATA_MOSI.TKEEP,
         M_AXIS_CALDDR_MM2S_tlast => AXI4_STREAM_DATA_MOSI.TLAST,
         M_AXIS_CALDDR_MM2S_tready => AXI4_STREAM_DATA_MISO.TREADY,
         
         S_AXIS_CALDDR_MM2S_CMD_tdata => AXI4_STREAM_ADD_MOSI.TDATA,
         S_AXIS_CALDDR_MM2S_CMD_tvalid => AXI4_STREAM_ADD_MOSI.TVALID,
         S_AXIS_CALDDR_MM2S_CMD_tready => AXI4_STREAM_ADD_MISO.TREADY,
         
         M_AXIS_CALDDR_MM2S_STS_tready => '1',

         --FLASHINTF
         M_FLASHINTF_AXI_araddr => FLASHINTF_AXI_MOSI.araddr,
         M_FLASHINTF_AXI_arburst => FLASHINTF_AXI_MOSI.arburst,
         M_FLASHINTF_AXI_arcache => FLASHINTF_AXI_MOSI.arcache,
         M_FLASHINTF_AXI_arlen => FLASHINTF_AXI_MOSI.arlen,
         M_FLASHINTF_AXI_arlock => FLASHINTF_AXI_MOSI.arlock,
         M_FLASHINTF_AXI_arprot => FLASHINTF_AXI_MOSI.arprot,
         M_FLASHINTF_AXI_arqos => FLASHINTF_AXI_MOSI.arqos,
         M_FLASHINTF_AXI_arready => FLASHINTF_AXI_MISO.arready,
         M_FLASHINTF_AXI_arregion => FLASHINTF_AXI_MOSI.arregion,
         M_FLASHINTF_AXI_arsize => FLASHINTF_AXI_MOSI.arsize,
         M_FLASHINTF_AXI_arvalid => FLASHINTF_AXI_MOSI.arvalid,
         M_FLASHINTF_AXI_awaddr => FLASHINTF_AXI_MOSI.awaddr,
         M_FLASHINTF_AXI_awburst => FLASHINTF_AXI_MOSI.awburst,
         M_FLASHINTF_AXI_awcache => FLASHINTF_AXI_MOSI.awcache,
         M_FLASHINTF_AXI_awlen => FLASHINTF_AXI_MOSI.awlen,
         M_FLASHINTF_AXI_awlock => FLASHINTF_AXI_MOSI.awlock,
         M_FLASHINTF_AXI_awprot => FLASHINTF_AXI_MOSI.awprot,
         M_FLASHINTF_AXI_awqos => FLASHINTF_AXI_MOSI.awqos,
         M_FLASHINTF_AXI_awready => FLASHINTF_AXI_MISO.awready,
         M_FLASHINTF_AXI_awregion => FLASHINTF_AXI_MOSI.awregion,
         M_FLASHINTF_AXI_awsize => FLASHINTF_AXI_MOSI.awsize,
         M_FLASHINTF_AXI_awvalid => FLASHINTF_AXI_MOSI.awvalid,
         M_FLASHINTF_AXI_bready => FLASHINTF_AXI_MOSI.bready,
         M_FLASHINTF_AXI_bresp => FLASHINTF_AXI_MISO.bresp,
         M_FLASHINTF_AXI_bvalid => FLASHINTF_AXI_MISO.bvalid,
         M_FLASHINTF_AXI_rdata => FLASHINTF_AXI_MISO.rdata,
         M_FLASHINTF_AXI_rlast => FLASHINTF_AXI_MISO.rlast ,
         M_FLASHINTF_AXI_rready => FLASHINTF_AXI_MOSI.rready,
         M_FLASHINTF_AXI_rresp => FLASHINTF_AXI_MISO.rresp,
         M_FLASHINTF_AXI_rvalid => FLASHINTF_AXI_MISO.rvalid,
         M_FLASHINTF_AXI_wdata => FLASHINTF_AXI_MOSI.wdata,
         M_FLASHINTF_AXI_wlast => FLASHINTF_AXI_MOSI.wlast,
         M_FLASHINTF_AXI_wready => FLASHINTF_AXI_MISO.wready,
         M_FLASHINTF_AXI_wstrb => FLASHINTF_AXI_MOSI.wstrb,
         M_FLASHINTF_AXI_wvalid => FLASHINTF_AXI_MOSI.wvalid,
         
         -- BUFFERING DM INTERFACE
         M_AXIS_MM2S_BUF_tvalid => AXIS_BUF_MM2S_MOSI.TVALID,
         M_AXIS_MM2S_BUF_tdata => AXIS_BUF_MM2S_MOSI.TDATA,
         M_AXIS_MM2S_BUF_tkeep => AXIS_BUF_MM2S_MOSI.TKEEP,
         M_AXIS_MM2S_BUF_tlast => AXIS_BUF_MM2S_MOSI.TLAST,
         M_AXIS_MM2S_BUF_tready => AXIS_BUF_MM2S_MISO.TREADY,
         
         S_AXIS_MM2S_CMD_BUF_tdata => AXIS_BUF_MM2S_CMD_MOSI.TDATA,
         S_AXIS_MM2S_CMD_BUF_tvalid => AXIS_BUF_MM2S_CMD_MOSI.TVALID,
         S_AXIS_MM2S_CMD_BUF_tready => AXIS_BUF_MM2S_CMD_MISO.TREADY,
         
         M_AXIS_MM2S_STS_BUF_tready => AXIS_BUF_MM2S_STS_MISO.TREADY,
         M_AXIS_MM2S_STS_BUF_tdata => AXIS_BUF_MM2S_STS_MOSI.TDATA,
         M_AXIS_MM2S_STS_BUF_tkeep => AXIS_BUF_MM2S_STS_MOSI.TKEEP,
         M_AXIS_MM2S_STS_BUF_tlast => AXIS_BUF_MM2S_STS_MOSI.TLAST,
         M_AXIS_MM2S_STS_BUF_tvalid => AXIS_BUF_MM2S_STS_MOSI.TVALID,
         
         S_AXIS_S2MM_BUF_tdata => AXIS_BUF_S2MM_MOSI.TDATA,
         S_AXIS_S2MM_BUF_tkeep => AXIS_BUF_S2MM_MOSI.TKEEP,
         S_AXIS_S2MM_BUF_tlast => AXIS_BUF_S2MM_MOSI.TLAST,
         S_AXIS_S2MM_BUF_tvalid => AXIS_BUF_S2MM_MOSI.TVALID,
         S_AXIS_S2MM_BUF_tready => AXIS_BUF_S2MM_MISO.TREADY,
         
         S_AXIS_S2MM_CMD_BUF_tdata => AXIS_BUF_S2MM_CMD_MOSI.TDATA,
         S_AXIS_S2MM_CMD_BUF_tvalid => AXIS_BUF_S2MM_CMD_MOSI.TVALID,
         S_AXIS_S2MM_CMD_BUF_tready => AXIS_BUF_S2MM_CMD_MISO.TREADY,
         
         M_AXIS_S2MM_STS_BUF_tdata => AXIS_BUF_S2MM_STS_MOSI.TDATA,
         M_AXIS_S2MM_STS_BUF_tkeep => AXIS_BUF_S2MM_STS_MOSI.TKEEP,
         M_AXIS_S2MM_STS_BUF_tlast => AXIS_BUF_S2MM_STS_MOSI.TLAST,
         M_AXIS_S2MM_STS_BUF_tvalid => AXIS_BUF_S2MM_STS_MOSI.TVALID,
         M_AXIS_S2MM_STS_BUF_tready => AXIS_BUF_S2MM_STS_MISO.TREADY,
         
         --TEST USART B
         M_AXIS_USART_tdata  => AXIS_USART_TX_MOSI.TDATA,
         M_AXIS_USART_tlast  => AXIS_USART_TX_MOSI.TLAST,
         M_AXIS_USART_tready => AXIS_USART_TX_MISO.TREADY,
         M_AXIS_USART_tvalid => AXIS_USART_TX_MOSI.TVALID,
         
         S_AXIS_USART_tdata  => AXIS_USART_RX_MOSI.TDATA,
         S_AXIS_USART_tlast  => AXIS_USART_RX_MOSI.TLAST,
         S_AXIS_USART_tready => AXIS_USART_RX_MISO.TREADY,
         S_AXIS_USART_tvalid => AXIS_USART_RX_MOSI.TVALID,
         
         --QSPI
         qspi_io0_io => qspi_io0_io,
         qspi_io1_io => qspi_io1_io,
         qspi_io2_io => qspi_io2_io,
         qspi_io3_io => qspi_io3_io,
         qspi_ss_io(0) => qspi_ss_io,
         
         NDF_UART_rxd => UART_NDF_RX,
         NDF_UART_txd => UART_NDF_TX,
         
         --aec intc
         AEC_INTC => AEC_INTC
      );  
   end generate;
   
   AXI4_STREAM_DATA_MOSI.TSTRB   <= (others => '1');
   AXI4_STREAM_DATA_MOSI.TID     <= (others => '0');
   AXI4_STREAM_DATA_MOSI.TDEST   <= (others => '0');
   AXI4_STREAM_DATA_MOSI.TUSER   <= (others => '0');
   
   
end bd_wrapper;
