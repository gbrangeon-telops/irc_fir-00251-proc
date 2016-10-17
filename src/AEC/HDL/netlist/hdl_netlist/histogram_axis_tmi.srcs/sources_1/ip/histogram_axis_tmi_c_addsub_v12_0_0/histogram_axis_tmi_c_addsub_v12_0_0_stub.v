// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
// Date        : Tue Jun 21 14:04:42 2016
// Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_c_addsub_v12_0_0/histogram_axis_tmi_c_addsub_v12_0_0_stub.v
// Design      : histogram_axis_tmi_c_addsub_v12_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tfbg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module histogram_axis_tmi_c_addsub_v12_0_0(A, B, S)
/* synthesis syn_black_box black_box_pad_pin="A[21:0],B[21:0],S[21:0]" */;
  input [21:0]A;
  input [21:0]B;
  output [21:0]S;
endmodule
