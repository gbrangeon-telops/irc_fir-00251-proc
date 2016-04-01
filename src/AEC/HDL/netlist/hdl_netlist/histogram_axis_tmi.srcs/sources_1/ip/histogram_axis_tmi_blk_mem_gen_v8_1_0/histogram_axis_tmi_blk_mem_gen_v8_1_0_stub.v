// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
// Date        : Wed Mar 30 13:07:22 2016
// Host        : TELOPS230 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_blk_mem_gen_v8_1_0/histogram_axis_tmi_blk_mem_gen_v8_1_0_stub.v
// Design      : histogram_axis_tmi_blk_mem_gen_v8_1_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k160tfbg676-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module histogram_axis_tmi_blk_mem_gen_v8_1_0(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,wea[0:0],addra[6:0],dina[20:0],douta[20:0],clkb,enb,web[0:0],addrb[6:0],dinb[20:0],doutb[20:0]" */;
  input clka;
  input ena;
  input [0:0]wea;
  input [6:0]addra;
  input [20:0]dina;
  output [20:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [6:0]addrb;
  input [20:0]dinb;
  output [20:0]doutb;
endmodule
