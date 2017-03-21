acom -O3 -work flagging_tb -2002  $dsn/../HDL/flag_define.vhd $dsn/../HDL/flagging_mblaze_intf.vhd $dsn/../HDL/flagging_SM.vhd $dsn/../HDL/flagging_top.bde $dsn/../../../../FIR-00251-Common/VHDL/tel2000pkg.vhd $dsn/../../../../Common_HDL/Utilities/double_sync.vhd $dsn/../../../../Common_HDL/Utilities/double_sync_vector.vhd $dsn/../../../../Common_HDL/Utilities/sync_reset.vhd $dsn/src/flagging_tb.bde $dsn/src/ublaze_sim.vhd
asim -O5 +access +r +m+flagging_tb flagging_tb flagging_tb
do waveform.do
run 5 s
