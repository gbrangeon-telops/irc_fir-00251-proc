#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\proxy_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#uarts
acom d:\Telops\Common_HDL\RS232\uarts.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\uart_block_tel2000.bde 

# sources FPa common 
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd

# sources scd_data_ctrl 
acom d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_fifo_writer.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_diag_data_gen.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_data_dispatcher.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_data_ctrl.bde 

# sources scd_hw_driver
acom d:\Telops\FIR-00251-Proc\src\FPA\dfpa_cfg_dpram.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_prog_ctrler.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_serial_module.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_hw_driver.bde 


# sources scd_mblaze_intf
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_mblaze_intf.vhd

# sources dout fifo
acom D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream32_fifo.vhd

# scd_io_interface
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_io_interface.vhd 

# top level fpa Interface
acom d:\Telops\FIR-00251-Proc\src\FPA\fpa_trig_precontroller.vhd
acom d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_proxy_intf.bde