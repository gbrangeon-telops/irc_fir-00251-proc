#savealltabs
#SetActiveLib -work
#clearlibrary 	

#packages
acom -incr -nowarn DAGGEN_0523 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\proxy_define.vhd

#utilities
do D:\Telops\FIR-00251-Proc\src\compil_utilities.do

#uarts
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\RS232\uarts.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\uart_block_tel2000.bde 

# sources FPa common 
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_trig_controller.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\dfpa_hardw_stat_gen.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_intf_sequencer.vhd \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_status_gen.vhd

# sources scd_data_ctrl 
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\Common_HDL\Common_Projects\TEL2000\FPA_common\src\fpa_diag_line_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_fifo_writer.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_diag_data_gen.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_data_dispatcher.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_data_ctrl.bde 

# sources scd_hw_driver
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\dfpa_cfg_dpram.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_prog_ctrler.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_serial_module.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_hw_driver.bde 

# top level intf
acom -incr -nowarn DAGGEN_0523 \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_mblaze_intf.vhd \
 D:\Telops\FIR-00251-Common\VHDL\Fifo\t_axi4_stream32_fifo.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_io_interface.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\fpa_trig_precontroller.vhd \
 d:\Telops\FIR-00251-Proc\src\FPA\scd_proxy\HDL\scd_proxy_intf.bde
