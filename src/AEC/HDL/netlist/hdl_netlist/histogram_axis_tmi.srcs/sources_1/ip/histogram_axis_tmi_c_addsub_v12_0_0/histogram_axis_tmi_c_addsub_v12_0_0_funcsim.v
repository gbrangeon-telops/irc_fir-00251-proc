// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2013.4 (win64) Build 353583 Mon Dec  9 17:49:19 MST 2013
// Date        : Tue Jun 21 14:04:42 2016
// Host        : TELOPS177 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode funcsim
//               D:/Telops/FIR-00251-Proc/src/AEC/HDL/netlist/hdl_netlist/histogram_axis_tmi.srcs/sources_1/ip/histogram_axis_tmi_c_addsub_v12_0_0/histogram_axis_tmi_c_addsub_v12_0_0_funcsim.v
// Design      : histogram_axis_tmi_c_addsub_v12_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k160tfbg676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0,Vivado 2013.4" *) (* CHECK_LICENSE_TYPE = "histogram_axis_tmi_c_addsub_v12_0_0,c_addsub_v12_0,{}" *) 
(* core_generation_info = "histogram_axis_tmi_c_addsub_v12_0_0,c_addsub_v12_0,{x_ipProduct=Vivado 2013.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=c_addsub,x_ipVersion=12.0,x_ipCoreRevision=3,x_ipLanguage=VHDL,C_VERBOSITY=0,C_XDEVICEFAMILY=kintex7,C_IMPLEMENTATION=0,C_A_WIDTH=22,C_B_WIDTH=22,C_OUT_WIDTH=22,C_CE_OVERRIDES_SCLR=0,C_A_TYPE=1,C_B_TYPE=1,C_LATENCY=0,C_ADD_MODE=0,C_B_CONSTANT=0,C_B_VALUE=0000000000000000000000,C_AINIT_VAL=0,C_SINIT_VAL=0,C_CE_OVERRIDES_BYPASS=1,C_BYPASS_LOW=0,C_SCLR_OVERRIDES_SSET=1,C_HAS_C_IN=0,C_HAS_C_OUT=0,C_BORROW_LOW=1,C_HAS_CE=0,C_HAS_BYPASS=0,C_HAS_SCLR=0,C_HAS_SSET=0,C_HAS_SINIT=0}" *) 
(* NotValidForBitStream *)
module histogram_axis_tmi_c_addsub_v12_0_0
   (A,
    B,
    S);
  input [21:0]A;
  input [21:0]B;
  output [21:0]S;

  wire [21:0]A;
  wire [21:0]B;
  wire [21:0]S;

histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0__parameterized0 U0
       (.A(A),
        .B(B),
        .S(S));
endmodule

(* ORIG_REF_NAME = "c_addsub_v12_0" *) 
module histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0__parameterized0
   (S,
    A,
    B);
  output [21:0]S;
  input [21:0]A;
  input [21:0]B;

  wire \<const0> ;
  wire \<const1> ;
  wire [21:0]A;
  wire [21:0]B;
  wire [21:0]S;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

GND GND
       (.G(\<const0> ));
VCC VCC
       (.P(\<const1> ));
(* C_ADD_MODE = "0" *) 
   (* C_AINIT_VAL = "0" *) 
   (* C_A_TYPE = "1" *) 
   (* C_A_WIDTH = "22" *) 
   (* C_BORROW_LOW = "1" *) 
   (* C_BYPASS_LOW = "0" *) 
   (* C_B_CONSTANT = "0" *) 
   (* C_B_TYPE = "1" *) 
   (* C_B_VALUE = "0000000000000000000000" *) 
   (* C_B_WIDTH = "22" *) 
   (* C_CE_OVERRIDES_BYPASS = "1" *) 
   (* C_CE_OVERRIDES_SCLR = "0" *) 
   (* C_HAS_BYPASS = "0" *) 
   (* C_HAS_CE = "0" *) 
   (* C_HAS_C_IN = "0" *) 
   (* C_HAS_C_OUT = "0" *) 
   (* C_HAS_SCLR = "0" *) 
   (* C_HAS_SINIT = "0" *) 
   (* C_HAS_SSET = "0" *) 
   (* C_IMPLEMENTATION = "0" *) 
   (* C_LATENCY = "0" *) 
   (* C_OUT_WIDTH = "22" *) 
   (* C_SCLR_OVERRIDES_SSET = "1" *) 
   (* C_SINIT_VAL = "0" *) 
   (* C_VERBOSITY = "0" *) 
   (* C_XDEVICEFAMILY = "kintex7" *) 
   (* downgradeipidentifiedwarnings = "yes" *) 
   histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0 xst_addsub
       (.A(A),
        .ADD(\<const1> ),
        .B(B),
        .BYPASS(\<const0> ),
        .CE(\<const1> ),
        .CLK(\<const0> ),
        .C_IN(\<const0> ),
        .C_OUT(NLW_xst_addsub_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(\<const0> ),
        .SINIT(\<const0> ),
        .SSET(\<const0> ));
endmodule

(* ORIG_REF_NAME = "c_addsub_v12_0_fabric_legacy" *) 
module histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_fabric_legacy__parameterized0
   (S,
    A,
    B);
  output [21:0]S;
  input [21:0]A;
  input [21:0]B;

  wire [21:0]A;
  wire [21:0]B;
  wire [21:0]S;

histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_lut6_legacy__parameterized0 \i_lut6.i_lut6_addsub 
       (.A(A),
        .B(B),
        .S(S));
endmodule

(* ORIG_REF_NAME = "c_addsub_v12_0_legacy" *) 
module histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_legacy__parameterized0
   (S,
    A,
    B);
  output [21:0]S;
  input [21:0]A;
  input [21:0]B;

  wire [21:0]A;
  wire [21:0]B;
  wire [21:0]S;

histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_fabric_legacy__parameterized0 \no_pipelining.the_addsub 
       (.A(A),
        .B(B),
        .S(S));
endmodule

(* ORIG_REF_NAME = "c_addsub_v12_0_lut6_legacy" *) 
module histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_lut6_legacy__parameterized0
   (S,
    A,
    B);
  output [21:0]S;
  input [21:0]A;
  input [21:0]B;

  wire \<const0> ;
  wire [21:0]A;
  wire [21:0]B;
  wire CI;
  wire LI;
  wire [21:0]S;
  wire S_0;
  wire lopt;
  wire lopt_1;
  wire lopt_2;
  wire lopt_3;
  wire lopt_4;
  wire lopt_5;
  wire \n_0_i_simple_model.carryxor0_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[10].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[11].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[12].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[13].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[14].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[15].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[16].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[17].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[18].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[19].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[1].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[2].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[3].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[4].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[5].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[6].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[7].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[8].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1 ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[9].carrymux ;
  wire \n_0_i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1 ;
  wire [3:0]\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_CO_UNCONNECTED ;
  wire [3:1]\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_DI_UNCONNECTED ;
  wire [3:2]\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_O_UNCONNECTED ;
  wire [3:2]\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_S_UNCONNECTED ;

GND GND
       (.G(\<const0> ));
(* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   (* box_type = "PRIMITIVE" *) 
   CARRY4 \i_simple_model.carrymux0_CARRY4 
       (.CI(lopt),
        .CO({\n_0_i_simple_model.i_gt_1.carrychaingen[3].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[2].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[1].carrymux ,CI}),
        .CYINIT(\<const0> ),
        .DI(A[3:0]),
        .O(S[3:0]),
        .S({\n_0_i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1 ,S_0,\n_0_i_simple_model.carryxor0_i_1 }));
GND \i_simple_model.carrymux0_CARRY4_GND 
       (.G(lopt));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.carryxor0_i_1 
       (.I0(A[0]),
        .I1(B[0]),
        .O(\n_0_i_simple_model.carryxor0_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1 
       (.I0(A[10]),
        .I1(B[10]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1 
       (.I0(A[11]),
        .I1(B[11]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1 ));
(* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   (* box_type = "PRIMITIVE" *) 
   CARRY4 \i_simple_model.i_gt_1.carrychaingen[12].carrymux_CARRY4 
       (.CI(\n_0_i_simple_model.i_gt_1.carrychaingen[11].carrymux ),
        .CO({\n_0_i_simple_model.i_gt_1.carrychaingen[15].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[14].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[13].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[12].carrymux }),
        .CYINIT(lopt_3),
        .DI(A[15:12]),
        .O(S[15:12]),
        .S({\n_0_i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1 }));
GND \i_simple_model.i_gt_1.carrychaingen[12].carrymux_CARRY4_GND 
       (.G(lopt_3));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1 
       (.I0(A[12]),
        .I1(B[12]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[12].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1 
       (.I0(A[13]),
        .I1(B[13]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[13].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1 
       (.I0(A[14]),
        .I1(B[14]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[14].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1 
       (.I0(A[15]),
        .I1(B[15]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[15].carryxor_i_1 ));
(* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   (* box_type = "PRIMITIVE" *) 
   CARRY4 \i_simple_model.i_gt_1.carrychaingen[16].carrymux_CARRY4 
       (.CI(\n_0_i_simple_model.i_gt_1.carrychaingen[15].carrymux ),
        .CO({\n_0_i_simple_model.i_gt_1.carrychaingen[19].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[18].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[17].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[16].carrymux }),
        .CYINIT(lopt_4),
        .DI(A[19:16]),
        .O(S[19:16]),
        .S({\n_0_i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1 }));
GND \i_simple_model.i_gt_1.carrychaingen[16].carrymux_CARRY4_GND 
       (.G(lopt_4));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1 
       (.I0(A[16]),
        .I1(B[16]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[16].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1 
       (.I0(A[17]),
        .I1(B[17]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[17].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1 
       (.I0(A[18]),
        .I1(B[18]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[18].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1 
       (.I0(A[19]),
        .I1(B[19]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[19].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[1].carryxor_i_1 
       (.I0(A[1]),
        .I1(B[1]),
        .O(S_0));
(* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   (* box_type = "PRIMITIVE" *) 
   CARRY4 \i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4 
       (.CI(\n_0_i_simple_model.i_gt_1.carrychaingen[19].carrymux ),
        .CO(\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_CO_UNCONNECTED [3:0]),
        .CYINIT(lopt_5),
        .DI({\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_DI_UNCONNECTED [3:1],A[20]}),
        .O({\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_O_UNCONNECTED [3:2],S[21:20]}),
        .S({\NLW_i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_S_UNCONNECTED [3:2],LI,\n_0_i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1 }));
GND \i_simple_model.i_gt_1.carrychaingen[20].carrymux_CARRY4_GND 
       (.G(lopt_5));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1 
       (.I0(A[20]),
        .I1(B[20]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[20].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1 
       (.I0(A[2]),
        .I1(B[2]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[2].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1 
       (.I0(A[3]),
        .I1(B[3]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[3].carryxor_i_1 ));
(* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   (* box_type = "PRIMITIVE" *) 
   CARRY4 \i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4 
       (.CI(\n_0_i_simple_model.i_gt_1.carrychaingen[3].carrymux ),
        .CO({\n_0_i_simple_model.i_gt_1.carrychaingen[7].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[6].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[5].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[4].carrymux }),
        .CYINIT(lopt_1),
        .DI(A[7:4]),
        .O(S[7:4]),
        .S({\n_0_i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1 }));
GND \i_simple_model.i_gt_1.carrychaingen[4].carrymux_CARRY4_GND 
       (.G(lopt_1));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1 
       (.I0(A[4]),
        .I1(B[4]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[4].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1 
       (.I0(A[5]),
        .I1(B[5]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[5].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1 
       (.I0(A[6]),
        .I1(B[6]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[6].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1 
       (.I0(A[7]),
        .I1(B[7]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[7].carryxor_i_1 ));
(* XILINX_LEGACY_PRIM = "(MUXCY,XORCY)" *) 
   (* box_type = "PRIMITIVE" *) 
   CARRY4 \i_simple_model.i_gt_1.carrychaingen[8].carrymux_CARRY4 
       (.CI(\n_0_i_simple_model.i_gt_1.carrychaingen[7].carrymux ),
        .CO({\n_0_i_simple_model.i_gt_1.carrychaingen[11].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[10].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[9].carrymux ,\n_0_i_simple_model.i_gt_1.carrychaingen[8].carrymux }),
        .CYINIT(lopt_2),
        .DI(A[11:8]),
        .O(S[11:8]),
        .S({\n_0_i_simple_model.i_gt_1.carrychaingen[11].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[10].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1 ,\n_0_i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1 }));
GND \i_simple_model.i_gt_1.carrychaingen[8].carrymux_CARRY4_GND 
       (.G(lopt_2));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1 
       (.I0(A[8]),
        .I1(B[8]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[8].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1 
       (.I0(A[9]),
        .I1(B[9]),
        .O(\n_0_i_simple_model.i_gt_1.carrychaingen[9].carryxor_i_1 ));
LUT2 #(
    .INIT(4'h6)) 
     \i_simple_model.i_gt_1.carryxortop_i_1 
       (.I0(A[21]),
        .I1(B[21]),
        .O(LI));
endmodule

(* ORIG_REF_NAME = "c_addsub_v12_0_viv" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintex7" *) 
(* C_IMPLEMENTATION = "0" *) (* C_A_WIDTH = "22" *) (* C_B_WIDTH = "22" *) 
(* C_OUT_WIDTH = "22" *) (* C_CE_OVERRIDES_SCLR = "0" *) (* C_A_TYPE = "1" *) 
(* C_B_TYPE = "1" *) (* C_LATENCY = "0" *) (* C_ADD_MODE = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_VALUE = "0000000000000000000000" *) (* C_AINIT_VAL = "0" *) 
(* C_SINIT_VAL = "0" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_SCLR_OVERRIDES_SSET = "1" *) (* C_HAS_C_IN = "0" *) (* C_HAS_C_OUT = "0" *) 
(* C_BORROW_LOW = "1" *) (* C_HAS_CE = "0" *) (* C_HAS_BYPASS = "0" *) 
(* C_HAS_SCLR = "0" *) (* C_HAS_SSET = "0" *) (* C_HAS_SINIT = "0" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_viv__parameterized0
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [21:0]A;
  input [21:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [21:0]S;

  wire \<const0> ;
  wire [21:0]A;
  wire [21:0]B;
  wire [21:0]S;

  assign C_OUT = \<const0> ;
GND GND
       (.G(\<const0> ));
histogram_axis_tmi_c_addsub_v12_0_0c_addsub_v12_0_legacy__parameterized0 \i_baseblox.i_baseblox_addsub 
       (.A(A),
        .B(B),
        .S(S));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;

    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
