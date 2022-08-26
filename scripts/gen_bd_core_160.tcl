
################################################################
# This is a generated script based on design: core
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source core_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7k160tfbg676-1
}


# CHANGE DESIGN NAME HERE
set design_name core

# This script was generated for a remote BD. To create a non-remote design,
# change the variable <run_remote_bd_flow> to <0>.

set run_remote_bd_flow 0
if { $run_remote_bd_flow == 1 } {
  # Set the reference directory for source file relative paths (by default 
  # the value is script directory path)
  set origin_dir ./bd

  # Use origin directory path location variable, if specified in the tcl shell
  if { [info exists ::origin_dir_loc] } {
     set origin_dir $::origin_dir_loc
  }

  set str_bd_folder [file normalize ${origin_dir}]
  set str_bd_filepath ${str_bd_folder}/${design_name}/${design_name}.bd

  # Check if remote design exists on disk
  if { [file exists $str_bd_filepath ] == 1 } {
     catch {common::send_msg_id "BD_TCL-110" "ERROR" "The remote BD file path <$str_bd_filepath> already exists!"}
     common::send_msg_id "BD_TCL-008" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0>."
     common::send_msg_id "BD_TCL-009" "INFO" "Also make sure there is no design <$design_name> existing in your current project."

     return 1
  }

  # Check if design exists in memory
  set list_existing_designs [get_bd_designs -quiet $design_name]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-111" "ERROR" "The design <$design_name> already exists in this project! Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-010" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Check if design exists on disk within project
  set list_existing_designs [get_files */${design_name}.bd]
  if { $list_existing_designs ne "" } {
     catch {common::send_msg_id "BD_TCL-112" "ERROR" "The design <$design_name> already exists in this project at location:
    $list_existing_designs"}
     catch {common::send_msg_id "BD_TCL-113" "ERROR" "Will not create the remote BD <$design_name> at the folder <$str_bd_folder>."}

     common::send_msg_id "BD_TCL-011" "INFO" "To create a non-remote BD, change the variable <run_remote_bd_flow> to <0> or please set a different value to variable <design_name>."

     return 1
  }

  # Now can create the remote BD
  # NOTE - usage of <-dir> will create <$str_bd_folder/$design_name/$design_name.bd>
  create_bd_design -dir $str_bd_folder $design_name
} else {

  # Create regular design
  if { [catch {create_bd_design $design_name} errmsg] } {
     common::send_msg_id "BD_TCL-012" "INFO" "Please set a different value to variable <design_name>."

     return 1
  }
}

current_bd_design $design_name


##################################################################
# MIG PRJ FILE TCL PROCs
##################################################################

proc write_mig_file_core_CAL_DDR_MIG_0 { str_mig_prj_filepath } {

   set mig_prj_file [open $str_mig_prj_filepath  w+]

   puts $mig_prj_file {<?xml version='1.0' encoding='UTF-8'?>}
   puts $mig_prj_file {<!-- IMPORTANT: This is an internal file that has been generated by the MIG software. Any direct editing or changes made to this file may result in unpredictable behavior or data corruption. It is strongly advised that users do not edit the contents of this file. Re-run the MIG GUI with the required settings if any of the options provided below need to be altered. -->}
   puts $mig_prj_file {<Project NoOfControllers="1" >}
   puts $mig_prj_file {    <ModuleName>core_mig_7series_0_2</ModuleName>}
   puts $mig_prj_file {    <dci_inouts_inputs>1</dci_inouts_inputs>}
   puts $mig_prj_file {    <dci_inputs>1</dci_inputs>}
   puts $mig_prj_file {    <Debug_En>OFF</Debug_En>}
   puts $mig_prj_file {    <DataDepth_En>1024</DataDepth_En>}
   puts $mig_prj_file {    <LowPower_En>ON</LowPower_En>}
   puts $mig_prj_file {    <XADC_En>Disabled</XADC_En>}
   puts $mig_prj_file {    <TargetFPGA>xc7k160t-fbg676/-1</TargetFPGA>}
   puts $mig_prj_file {    <Version>4.0</Version>}
   puts $mig_prj_file {    <SystemClock>Differential</SystemClock>}
   puts $mig_prj_file {    <ReferenceClock>Use System Clock</ReferenceClock>}
   puts $mig_prj_file {    <SysResetPolarity>ACTIVE HIGH</SysResetPolarity>}
   puts $mig_prj_file {    <BankSelectionFlag>FALSE</BankSelectionFlag>}
   puts $mig_prj_file {    <InternalVref>0</InternalVref>}
   puts $mig_prj_file {    <dci_hr_inouts_inputs>60 Ohms</dci_hr_inouts_inputs>}
   puts $mig_prj_file {    <dci_cascade>0</dci_cascade>}
   puts $mig_prj_file {    <Controller number="0" >}
   puts $mig_prj_file {        <MemoryDevice>DDR3_SDRAM/Components/MT41K256M16XX-125</MemoryDevice>}
   puts $mig_prj_file {        <TimePeriod>2500</TimePeriod>}
   puts $mig_prj_file {        <VccAuxIO>1.8V</VccAuxIO>}
   puts $mig_prj_file {        <PHYRatio>4:1</PHYRatio>}
   puts $mig_prj_file {        <InputClkFreq>200</InputClkFreq>}
   puts $mig_prj_file {        <UIExtraClocks>0</UIExtraClocks>}
   puts $mig_prj_file {        <MMCM_VCO>800</MMCM_VCO>}
   puts $mig_prj_file {        <MMCMClkOut0> 1.000</MMCMClkOut0>}
   puts $mig_prj_file {        <MMCMClkOut1>1</MMCMClkOut1>}
   puts $mig_prj_file {        <MMCMClkOut2>1</MMCMClkOut2>}
   puts $mig_prj_file {        <MMCMClkOut3>1</MMCMClkOut3>}
   puts $mig_prj_file {        <MMCMClkOut4>1</MMCMClkOut4>}
   puts $mig_prj_file {        <DataWidth>32</DataWidth>}
   puts $mig_prj_file {        <DeepMemory>1</DeepMemory>}
   puts $mig_prj_file {        <DataMask>1</DataMask>}
   puts $mig_prj_file {        <ECC>Disabled</ECC>}
   puts $mig_prj_file {        <Ordering>Normal</Ordering>}
   puts $mig_prj_file {        <BankMachineCnt>4</BankMachineCnt>}
   puts $mig_prj_file {        <CustomPart>FALSE</CustomPart>}
   puts $mig_prj_file {        <NewPartName></NewPartName>}
   puts $mig_prj_file {        <RowAddress>15</RowAddress>}
   puts $mig_prj_file {        <ColAddress>10</ColAddress>}
   puts $mig_prj_file {        <BankAddress>3</BankAddress>}
   puts $mig_prj_file {        <MemoryVoltage>1.5V</MemoryVoltage>}
   puts $mig_prj_file {        <C0_MEM_SIZE>1073741824</C0_MEM_SIZE>}
   puts $mig_prj_file {        <UserMemoryAddressMap>BANK_ROW_COLUMN</UserMemoryAddressMap>}
   puts $mig_prj_file {        <PinSelection>}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AC8" SLEW="" name="ddr3_addr[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="Y7" SLEW="" name="ddr3_addr[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="W10" SLEW="" name="ddr3_addr[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="W9" SLEW="" name="ddr3_addr[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="V8" SLEW="" name="ddr3_addr[13]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="V7" SLEW="" name="ddr3_addr[14]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AD8" SLEW="" name="ddr3_addr[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AA8" SLEW="" name="ddr3_addr[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AA7" SLEW="" name="ddr3_addr[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AE7" SLEW="" name="ddr3_addr[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AF7" SLEW="" name="ddr3_addr[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="V9" SLEW="" name="ddr3_addr[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="Y11" SLEW="" name="ddr3_addr[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="Y10" SLEW="" name="ddr3_addr[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="Y8" SLEW="" name="ddr3_addr[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AC12" SLEW="" name="ddr3_ba[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AB12" SLEW="" name="ddr3_ba[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AA12" SLEW="" name="ddr3_ba[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="Y13" SLEW="" name="ddr3_cas_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="AB9" SLEW="" name="ddr3_ck_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="AA9" SLEW="" name="ddr3_ck_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AC7" SLEW="" name="ddr3_cke[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AD13" SLEW="" name="ddr3_cs_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="V4" SLEW="" name="ddr3_dm[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AA2" SLEW="" name="ddr3_dm[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AD5" SLEW="" name="ddr3_dm[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AF3" SLEW="" name="ddr3_dm[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="U5" SLEW="" name="ddr3_dq[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="V2" SLEW="" name="ddr3_dq[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="V1" SLEW="" name="ddr3_dq[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="Y1" SLEW="" name="ddr3_dq[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="W1" SLEW="" name="ddr3_dq[13]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AC2" SLEW="" name="ddr3_dq[14]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AB2" SLEW="" name="ddr3_dq[15]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AB4" SLEW="" name="ddr3_dq[16]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AA4" SLEW="" name="ddr3_dq[17]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AC3" SLEW="" name="ddr3_dq[18]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AC4" SLEW="" name="ddr3_dq[19]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="U6" SLEW="" name="ddr3_dq[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AC6" SLEW="" name="ddr3_dq[20]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AB6" SLEW="" name="ddr3_dq[21]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="Y5" SLEW="" name="ddr3_dq[22]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="Y6" SLEW="" name="ddr3_dq[23]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AF2" SLEW="" name="ddr3_dq[24]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AD4" SLEW="" name="ddr3_dq[25]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AD1" SLEW="" name="ddr3_dq[26]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AE1" SLEW="" name="ddr3_dq[27]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AE3" SLEW="" name="ddr3_dq[28]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AE2" SLEW="" name="ddr3_dq[29]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="U2" SLEW="" name="ddr3_dq[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AE6" SLEW="" name="ddr3_dq[30]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="AE5" SLEW="" name="ddr3_dq[31]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="U1" SLEW="" name="ddr3_dq[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="V3" SLEW="" name="ddr3_dq[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="W3" SLEW="" name="ddr3_dq[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="U7" SLEW="" name="ddr3_dq[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="V6" SLEW="" name="ddr3_dq[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="Y3" SLEW="" name="ddr3_dq[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15_T_DCI" PADName="Y2" SLEW="" name="ddr3_dq[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="W5" SLEW="" name="ddr3_dqs_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AC1" SLEW="" name="ddr3_dqs_n[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AB5" SLEW="" name="ddr3_dqs_n[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AF4" SLEW="" name="ddr3_dqs_n[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="W6" SLEW="" name="ddr3_dqs_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AB1" SLEW="" name="ddr3_dqs_p[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AA5" SLEW="" name="ddr3_dqs_p[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15_T_DCI" PADName="AF5" SLEW="" name="ddr3_dqs_p[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AB10" SLEW="" name="ddr3_odt[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="AC9" SLEW="" name="ddr3_ras_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="LVCMOS15" PADName="AD9" SLEW="" name="ddr3_reset_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="Y12" SLEW="" name="ddr3_we_n" IN_TERM="" />}
   puts $mig_prj_file {        </PinSelection>}
   puts $mig_prj_file {        <System_Clock>}
   puts $mig_prj_file {            <Pin PADName="AB11/AC11(CC_P/N)" Bank="33" name="sys_clk_p/n" />}
   puts $mig_prj_file {        </System_Clock>}
   puts $mig_prj_file {        <System_Control>}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="sys_rst" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="init_calib_complete" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="tg_compare_error" />}
   puts $mig_prj_file {        </System_Control>}
   puts $mig_prj_file {        <TimingParameters>}
   puts $mig_prj_file {            <Parameters twtr="7.5" trrd="7.5" trefi="7.8" tfaw="40" trtp="7.5" tcke="5" trfc="260" trp="13.75" tras="35" trcd="13.75" />}
   puts $mig_prj_file {        </TimingParameters>}
   puts $mig_prj_file {        <mrBurstLength name="Burst Length" >8 - Fixed</mrBurstLength>}
   puts $mig_prj_file {        <mrBurstType name="Read Burst Type and Length" >Sequential</mrBurstType>}
   puts $mig_prj_file {        <mrCasLatency name="CAS Latency" >6</mrCasLatency>}
   puts $mig_prj_file {        <mrMode name="Mode" >Normal</mrMode>}
   puts $mig_prj_file {        <mrDllReset name="DLL Reset" >No</mrDllReset>}
   puts $mig_prj_file {        <mrPdMode name="DLL control for precharge PD" >Slow Exit</mrPdMode>}
   puts $mig_prj_file {        <emrDllEnable name="DLL Enable" >Enable</emrDllEnable>}
   puts $mig_prj_file {        <emrOutputDriveStrength name="Output Driver Impedance Control" >RZQ/7</emrOutputDriveStrength>}
   puts $mig_prj_file {        <emrMirrorSelection name="Address Mirroring" >Disable</emrMirrorSelection>}
   puts $mig_prj_file {        <emrCSSelection name="Controller Chip Select Pin" >Enable</emrCSSelection>}
   puts $mig_prj_file {        <emrRTT name="RTT (nominal) - On Die Termination (ODT)" >RZQ/6</emrRTT>}
   puts $mig_prj_file {        <emrPosted name="Additive Latency (AL)" >0</emrPosted>}
   puts $mig_prj_file {        <emrOCD name="Write Leveling Enable" >Disabled</emrOCD>}
   puts $mig_prj_file {        <emrDQS name="TDQS enable" >Enabled</emrDQS>}
   puts $mig_prj_file {        <emrRDQS name="Qoff" >Output Buffer Enabled</emrRDQS>}
   puts $mig_prj_file {        <mr2PartialArraySelfRefresh name="Partial-Array Self Refresh" >Full Array</mr2PartialArraySelfRefresh>}
   puts $mig_prj_file {        <mr2CasWriteLatency name="CAS write latency" >5</mr2CasWriteLatency>}
   puts $mig_prj_file {        <mr2AutoSelfRefresh name="Auto Self Refresh" >Enabled</mr2AutoSelfRefresh>}
   puts $mig_prj_file {        <mr2SelfRefreshTempRange name="High Temparature Self Refresh Rate" >Normal</mr2SelfRefreshTempRange>}
   puts $mig_prj_file {        <mr2RTTWR name="RTT_WR - Dynamic On Die Termination (ODT)" >Dynamic ODT off</mr2RTTWR>}
   puts $mig_prj_file {        <PortInterface>AXI</PortInterface>}
   puts $mig_prj_file {        <AXIParameters>}
   puts $mig_prj_file {            <C0_C_RD_WR_ARB_ALGORITHM>RD_PRI_REG</C0_C_RD_WR_ARB_ALGORITHM>}
   puts $mig_prj_file {            <C0_S_AXI_ADDR_WIDTH>30</C0_S_AXI_ADDR_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_DATA_WIDTH>256</C0_S_AXI_DATA_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_ID_WIDTH>6</C0_S_AXI_ID_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_SUPPORTS_NARROW_BURST>0</C0_S_AXI_SUPPORTS_NARROW_BURST>}
   puts $mig_prj_file {        </AXIParameters>}
   puts $mig_prj_file {    </Controller>}
   puts $mig_prj_file {</Project>}

   close $mig_prj_file
}
# End of write_mig_file_core_CAL_DDR_MIG_0()


proc write_mig_file_core_mig_7series_0_0 { str_mig_prj_filepath } {

   set mig_prj_file [open $str_mig_prj_filepath  w+]

   puts $mig_prj_file {<?xml version='1.0' encoding='UTF-8'?>}
   puts $mig_prj_file {<!-- IMPORTANT: This is an internal file that has been generated by the MIG software. Any direct editing or changes made to this file may result in unpredictable behavior or data corruption. It is strongly advised that users do not edit the contents of this file. Re-run the MIG GUI with the required settings if any of the options provided below need to be altered. -->}
   puts $mig_prj_file {<Project NoOfControllers="1" >}
   puts $mig_prj_file {    <ModuleName>core_mig_7series_0_0</ModuleName>}
   puts $mig_prj_file {    <dci_inouts_inputs>1</dci_inouts_inputs>}
   puts $mig_prj_file {    <dci_inputs>1</dci_inputs>}
   puts $mig_prj_file {    <Debug_En>OFF</Debug_En>}
   puts $mig_prj_file {    <DataDepth_En>1024</DataDepth_En>}
   puts $mig_prj_file {    <LowPower_En>ON</LowPower_En>}
   puts $mig_prj_file {    <XADC_En>Disabled</XADC_En>}
   puts $mig_prj_file {    <TargetFPGA>xc7k160t-fbg676/-1</TargetFPGA>}
   puts $mig_prj_file {    <Version>4.0</Version>}
   puts $mig_prj_file {    <SystemClock>Differential</SystemClock>}
   puts $mig_prj_file {    <ReferenceClock>Use System Clock</ReferenceClock>}
   puts $mig_prj_file {    <SysResetPolarity>ACTIVE HIGH</SysResetPolarity>}
   puts $mig_prj_file {    <BankSelectionFlag>FALSE</BankSelectionFlag>}
   puts $mig_prj_file {    <InternalVref>0</InternalVref>}
   puts $mig_prj_file {    <dci_hr_inouts_inputs>60 Ohms</dci_hr_inouts_inputs>}
   puts $mig_prj_file {    <dci_cascade>0</dci_cascade>}
   puts $mig_prj_file {    <Controller number="0" >}
   puts $mig_prj_file {        <MemoryDevice>DDR3_SDRAM/Components/MT41K128M16XX-15E</MemoryDevice>}
   puts $mig_prj_file {        <TimePeriod>2500</TimePeriod>}
   puts $mig_prj_file {        <VccAuxIO>1.8V</VccAuxIO>}
   puts $mig_prj_file {        <PHYRatio>4:1</PHYRatio>}
   puts $mig_prj_file {        <InputClkFreq>200</InputClkFreq>}
   puts $mig_prj_file {        <UIExtraClocks>1</UIExtraClocks>}
   puts $mig_prj_file {        <MMCM_VCO>800</MMCM_VCO>}
   puts $mig_prj_file {        <MMCMClkOut0> 4.000</MMCMClkOut0>}
   puts $mig_prj_file {        <MMCMClkOut1>16</MMCMClkOut1>}
   puts $mig_prj_file {        <MMCMClkOut2>40</MMCMClkOut2>}
   puts $mig_prj_file {        <MMCMClkOut3>1</MMCMClkOut3>}
   puts $mig_prj_file {        <MMCMClkOut4>1</MMCMClkOut4>}
   puts $mig_prj_file {        <DataWidth>16</DataWidth>}
   puts $mig_prj_file {        <DeepMemory>1</DeepMemory>}
   puts $mig_prj_file {        <DataMask>1</DataMask>}
   puts $mig_prj_file {        <ECC>Disabled</ECC>}
   puts $mig_prj_file {        <Ordering>Normal</Ordering>}
   puts $mig_prj_file {        <BankMachineCnt>4</BankMachineCnt>}
   puts $mig_prj_file {        <CustomPart>FALSE</CustomPart>}
   puts $mig_prj_file {        <NewPartName></NewPartName>}
   puts $mig_prj_file {        <RowAddress>14</RowAddress>}
   puts $mig_prj_file {        <ColAddress>10</ColAddress>}
   puts $mig_prj_file {        <BankAddress>3</BankAddress>}
   puts $mig_prj_file {        <MemoryVoltage>1.5V</MemoryVoltage>}
   puts $mig_prj_file {        <C0_MEM_SIZE>268435456</C0_MEM_SIZE>}
   puts $mig_prj_file {        <UserMemoryAddressMap>BANK_ROW_COLUMN</UserMemoryAddressMap>}
   puts $mig_prj_file {        <PinSelection>}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="D8" SLEW="" name="ddr3_addr[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="D11" SLEW="" name="ddr3_addr[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="E11" SLEW="" name="ddr3_addr[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="C11" SLEW="" name="ddr3_addr[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="C12" SLEW="" name="ddr3_addr[13]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="D9" SLEW="" name="ddr3_addr[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="F8" SLEW="" name="ddr3_addr[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="F9" SLEW="" name="ddr3_addr[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="D13" SLEW="" name="ddr3_addr[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="D14" SLEW="" name="ddr3_addr[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="F12" SLEW="" name="ddr3_addr[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="G12" SLEW="" name="ddr3_addr[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="F13" SLEW="" name="ddr3_addr[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="F14" SLEW="" name="ddr3_addr[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="C9" SLEW="" name="ddr3_ba[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="A8" SLEW="" name="ddr3_ba[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="A9" SLEW="" name="ddr3_ba[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="G11" SLEW="" name="ddr3_cas_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="E12" SLEW="" name="ddr3_ck_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="E13" SLEW="" name="ddr3_ck_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="E10" SLEW="" name="ddr3_cke[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="H14" SLEW="" name="ddr3_dm[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="B15" SLEW="" name="ddr3_dm[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="H9" SLEW="" name="ddr3_dq[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="B12" SLEW="" name="ddr3_dq[10]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="B11" SLEW="" name="ddr3_dq[11]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="A13" SLEW="" name="ddr3_dq[12]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="A15" SLEW="" name="ddr3_dq[13]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="B10" SLEW="" name="ddr3_dq[14]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="A10" SLEW="" name="ddr3_dq[15]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="H8" SLEW="" name="ddr3_dq[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="G10" SLEW="" name="ddr3_dq[2]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="G9" SLEW="" name="ddr3_dq[3]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="H12" SLEW="" name="ddr3_dq[4]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="G14" SLEW="" name="ddr3_dq[5]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="J11" SLEW="" name="ddr3_dq[6]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="J10" SLEW="" name="ddr3_dq[7]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="C14" SLEW="" name="ddr3_dq[8]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="A12" SLEW="" name="ddr3_dq[9]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="H13" SLEW="" name="ddr3_dqs_n[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="A14" SLEW="" name="ddr3_dqs_n[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="J13" SLEW="" name="ddr3_dqs_p[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="DIFF_SSTL15" PADName="B14" SLEW="" name="ddr3_dqs_p[1]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="D10" SLEW="" name="ddr3_odt[0]" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="B9" SLEW="" name="ddr3_ras_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="LVCMOS15" PADName="J8" SLEW="" name="ddr3_reset_n" IN_TERM="" />}
   puts $mig_prj_file {            <Pin VCCAUX_IO="" IOSTANDARD="SSTL15" PADName="F10" SLEW="" name="ddr3_we_n" IN_TERM="" />}
   puts $mig_prj_file {        </PinSelection>}
   puts $mig_prj_file {        <System_Clock>}
   puts $mig_prj_file {            <Pin PADName="R21/P21(CC_P/N)" Bank="13" name="sys_clk_p/n" />}
   puts $mig_prj_file {        </System_Clock>}
   puts $mig_prj_file {        <System_Control>}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="sys_rst" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="init_calib_complete" />}
   puts $mig_prj_file {            <Pin PADName="No connect" Bank="Select Bank" name="tg_compare_error" />}
   puts $mig_prj_file {        </System_Control>}
   puts $mig_prj_file {        <TimingParameters>}
   puts $mig_prj_file {            <Parameters twtr="7.5" trrd="7.5" trefi="7.8" tfaw="45" trtp="7.5" tcke="5.625" trfc="160" trp="13.5" tras="36" trcd="13.5" />}
   puts $mig_prj_file {        </TimingParameters>}
   puts $mig_prj_file {        <mrBurstLength name="Burst Length" >8 - Fixed</mrBurstLength>}
   puts $mig_prj_file {        <mrBurstType name="Read Burst Type and Length" >Sequential</mrBurstType>}
   puts $mig_prj_file {        <mrCasLatency name="CAS Latency" >6</mrCasLatency>}
   puts $mig_prj_file {        <mrMode name="Mode" >Normal</mrMode>}
   puts $mig_prj_file {        <mrDllReset name="DLL Reset" >No</mrDllReset>}
   puts $mig_prj_file {        <mrPdMode name="DLL control for precharge PD" >Slow Exit</mrPdMode>}
   puts $mig_prj_file {        <emrDllEnable name="DLL Enable" >Enable</emrDllEnable>}
   puts $mig_prj_file {        <emrOutputDriveStrength name="Output Driver Impedance Control" >RZQ/7</emrOutputDriveStrength>}
   puts $mig_prj_file {        <emrMirrorSelection name="Address Mirroring" >Disable</emrMirrorSelection>}
   puts $mig_prj_file {        <emrCSSelection name="Controller Chip Select Pin" >Disable</emrCSSelection>}
   puts $mig_prj_file {        <emrRTT name="RTT (nominal) - On Die Termination (ODT)" >RZQ/6</emrRTT>}
   puts $mig_prj_file {        <emrPosted name="Additive Latency (AL)" >0</emrPosted>}
   puts $mig_prj_file {        <emrOCD name="Write Leveling Enable" >Disabled</emrOCD>}
   puts $mig_prj_file {        <emrDQS name="TDQS enable" >Enabled</emrDQS>}
   puts $mig_prj_file {        <emrRDQS name="Qoff" >Output Buffer Enabled</emrRDQS>}
   puts $mig_prj_file {        <mr2PartialArraySelfRefresh name="Partial-Array Self Refresh" >Full Array</mr2PartialArraySelfRefresh>}
   puts $mig_prj_file {        <mr2CasWriteLatency name="CAS write latency" >5</mr2CasWriteLatency>}
   puts $mig_prj_file {        <mr2AutoSelfRefresh name="Auto Self Refresh" >Enabled</mr2AutoSelfRefresh>}
   puts $mig_prj_file {        <mr2SelfRefreshTempRange name="High Temparature Self Refresh Rate" >Normal</mr2SelfRefreshTempRange>}
   puts $mig_prj_file {        <mr2RTTWR name="RTT_WR - Dynamic On Die Termination (ODT)" >Dynamic ODT off</mr2RTTWR>}
   puts $mig_prj_file {        <PortInterface>AXI</PortInterface>}
   puts $mig_prj_file {        <AXIParameters>}
   puts $mig_prj_file {            <C0_C_RD_WR_ARB_ALGORITHM>RD_PRI_REG</C0_C_RD_WR_ARB_ALGORITHM>}
   puts $mig_prj_file {            <C0_S_AXI_ADDR_WIDTH>28</C0_S_AXI_ADDR_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_DATA_WIDTH>128</C0_S_AXI_DATA_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_ID_WIDTH>1</C0_S_AXI_ID_WIDTH>}
   puts $mig_prj_file {            <C0_S_AXI_SUPPORTS_NARROW_BURST>0</C0_S_AXI_SUPPORTS_NARROW_BURST>}
   puts $mig_prj_file {        </AXIParameters>}
   puts $mig_prj_file {    </Controller>}
   puts $mig_prj_file {</Project>}

   close $mig_prj_file
}
# End of write_mig_file_core_mig_7series_0_0()



##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_1_local_memory
proc create_hier_cell_microblaze_1_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_microblaze_1_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 lmb_bram ]
  set_property -dict [ list \
CONFIG.Memory_Type {True_Dual_Port_RAM} \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_1_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_1_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_1_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_1_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_1_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_1_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_1_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: axi_peripheral
proc create_hier_cell_axi_peripheral { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_axi_peripheral() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_ADC_READOUT_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AECCTRL_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_BUFFERING_CTRL
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_BUF_TABLE
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_BULK_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_CALIBCONFIG_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_CALIB_RAM_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_CLINKUART_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_COOLER_UART
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_DDRCAL_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_EHDRI_CTRL
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_EXPTIMECTRL_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FAN_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FLASHINTF_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FLASHRESET_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FPACTRL_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FPGAOUT_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FW_UART_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_GPS_UART
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_HEADERCTRL_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_ICU_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_INTC_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_IRIG_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_LEDGPIO_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_LENS_UART_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_MDM_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_MGT_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_OEMUART_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_PLEORA_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_POWER_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_QSPI_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_RQC_LUT_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_SFWCTRL_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_TIMER_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_TRIGGERCTRL_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_USBUART_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_XADC_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 INTERCONNECT_ARESETN
  create_bd_pin -dir I -from 0 -to 0 -type rst PERIPHERAL_ARESETN
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type clk m_axi_aclk

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {16} \
CONFIG.S00_HAS_DATA_FIFO {0} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
CONFIG.M00_HAS_DATA_FIFO {0} \
CONFIG.M01_HAS_DATA_FIFO {0} \
CONFIG.M11_HAS_DATA_FIFO {0} \
CONFIG.M12_HAS_DATA_FIFO {0} \
CONFIG.M15_HAS_DATA_FIFO {0} \
CONFIG.NUM_MI {15} \
CONFIG.S00_HAS_DATA_FIFO {0} \
 ] $axi_interconnect_1

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_2 ]
  set_property -dict [ list \
CONFIG.NUM_MI {10} \
 ] $axi_interconnect_2

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M_ICU_AXI] [get_bd_intf_pins axi_interconnect_0/M15_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins M_BUFFERING_CTRL] [get_bd_intf_pins axi_interconnect_2/M03_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins M_BUF_TABLE] [get_bd_intf_pins axi_interconnect_2/M04_AXI]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins M_EHDRI_CTRL] [get_bd_intf_pins axi_interconnect_2/M05_AXI]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins M09_AXI] [get_bd_intf_pins axi_interconnect_2/M09_AXI]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect_1/S00_AXI]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins axi_interconnect_1/M11_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins M_FAN_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins M_FPGAOUT_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins M_LEDGPIO_AXI] [get_bd_intf_pins axi_interconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins M_IRIG_AXI] [get_bd_intf_pins axi_interconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins M_MGT_AXI] [get_bd_intf_pins axi_interconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M05_AXI [get_bd_intf_pins M_AXI] [get_bd_intf_pins axi_interconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M06_AXI [get_bd_intf_pins M_POWER_AXI] [get_bd_intf_pins axi_interconnect_0/M06_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M07_AXI [get_bd_intf_pins M_TRIGGERCTRL_AXI] [get_bd_intf_pins axi_interconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M08_AXI [get_bd_intf_pins M_FPACTRL_AXI] [get_bd_intf_pins axi_interconnect_0/M08_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M09_AXI [get_bd_intf_pins M_AECCTRL_AXI] [get_bd_intf_pins axi_interconnect_0/M09_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M10_AXI [get_bd_intf_pins M_CALIB_RAM_AXI] [get_bd_intf_pins axi_interconnect_0/M10_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M11_AXI [get_bd_intf_pins M_RQC_LUT_AXI] [get_bd_intf_pins axi_interconnect_0/M11_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M12_AXI [get_bd_intf_pins M_TIMER_AXI] [get_bd_intf_pins axi_interconnect_0/M12_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M13_AXI [get_bd_intf_pins M_HEADERCTRL_AXI] [get_bd_intf_pins axi_interconnect_0/M13_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M14_AXI [get_bd_intf_pins M_USBUART_AXI] [get_bd_intf_pins axi_interconnect_0/M14_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins M_DDRCAL_AXI] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins M_FLASHINTF_AXI] [get_bd_intf_pins axi_interconnect_1/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M02_AXI [get_bd_intf_pins M_BULK_AXI] [get_bd_intf_pins axi_interconnect_1/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M03_AXI [get_bd_intf_pins M_XADC_AXI] [get_bd_intf_pins axi_interconnect_1/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M04_AXI [get_bd_intf_pins M_QSPI_AXI] [get_bd_intf_pins axi_interconnect_1/M04_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M05_AXI [get_bd_intf_pins M_MDM_AXI] [get_bd_intf_pins axi_interconnect_1/M05_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M06_AXI [get_bd_intf_pins M_OEMUART_AXI] [get_bd_intf_pins axi_interconnect_1/M06_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M07_AXI [get_bd_intf_pins M_CLINKUART_AXI] [get_bd_intf_pins axi_interconnect_1/M07_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M08_AXI [get_bd_intf_pins M_GPS_UART] [get_bd_intf_pins axi_interconnect_1/M08_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M09_AXI [get_bd_intf_pins M_PLEORA_AXI] [get_bd_intf_pins axi_interconnect_1/M09_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M10_AXI [get_bd_intf_pins M_SFWCTRL_AXI] [get_bd_intf_pins axi_interconnect_1/M10_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M12_AXI [get_bd_intf_pins axi_interconnect_1/M12_AXI] [get_bd_intf_pins axi_interconnect_2/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M13_AXI [get_bd_intf_pins M_FW_UART_AXI] [get_bd_intf_pins axi_interconnect_1/M13_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M14_AXI [get_bd_intf_pins M_LENS_UART_AXI] [get_bd_intf_pins axi_interconnect_1/M14_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M00_AXI [get_bd_intf_pins M_CALIBCONFIG_AXI] [get_bd_intf_pins axi_interconnect_2/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M01_AXI [get_bd_intf_pins M_EXPTIMECTRL_AXI] [get_bd_intf_pins axi_interconnect_2/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M02_AXI [get_bd_intf_pins M_INTC_AXI] [get_bd_intf_pins axi_interconnect_2/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M06_AXI [get_bd_intf_pins M_COOLER_UART] [get_bd_intf_pins axi_interconnect_2/M06_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M07_AXI [get_bd_intf_pins M_ADC_READOUT_AXI] [get_bd_intf_pins axi_interconnect_2/M07_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M08_AXI [get_bd_intf_pins M_FLASHRESET_AXI] [get_bd_intf_pins axi_interconnect_2/M08_AXI]

  # Create port connections
  connect_bd_net -net ARESETN_2 [get_bd_pins INTERCONNECT_ARESETN] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_2/ARESETN]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_pins aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/M03_ACLK] [get_bd_pins axi_interconnect_0/M04_ACLK] [get_bd_pins axi_interconnect_0/M06_ACLK] [get_bd_pins axi_interconnect_0/M07_ACLK] [get_bd_pins axi_interconnect_0/M08_ACLK] [get_bd_pins axi_interconnect_0/M09_ACLK] [get_bd_pins axi_interconnect_0/M10_ACLK] [get_bd_pins axi_interconnect_0/M12_ACLK] [get_bd_pins axi_interconnect_0/M13_ACLK] [get_bd_pins axi_interconnect_0/M14_ACLK] [get_bd_pins axi_interconnect_0/M15_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/M01_ACLK] [get_bd_pins axi_interconnect_1/M02_ACLK] [get_bd_pins axi_interconnect_1/M03_ACLK] [get_bd_pins axi_interconnect_1/M04_ACLK] [get_bd_pins axi_interconnect_1/M05_ACLK] [get_bd_pins axi_interconnect_1/M06_ACLK] [get_bd_pins axi_interconnect_1/M07_ACLK] [get_bd_pins axi_interconnect_1/M08_ACLK] [get_bd_pins axi_interconnect_1/M09_ACLK] [get_bd_pins axi_interconnect_1/M10_ACLK] [get_bd_pins axi_interconnect_1/M11_ACLK] [get_bd_pins axi_interconnect_1/M12_ACLK] [get_bd_pins axi_interconnect_1/M13_ACLK] [get_bd_pins axi_interconnect_1/M14_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axi_interconnect_2/M01_ACLK] [get_bd_pins axi_interconnect_2/M02_ACLK] [get_bd_pins axi_interconnect_2/M03_ACLK] [get_bd_pins axi_interconnect_2/M04_ACLK] [get_bd_pins axi_interconnect_2/M05_ACLK] [get_bd_pins axi_interconnect_2/M06_ACLK] [get_bd_pins axi_interconnect_2/M07_ACLK] [get_bd_pins axi_interconnect_2/M08_ACLK] [get_bd_pins axi_interconnect_2/M09_ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK]
  connect_bd_net -net m_axi_aclk_1 [get_bd_pins m_axi_aclk] [get_bd_pins axi_interconnect_0/M05_ACLK] [get_bd_pins axi_interconnect_0/M11_ACLK]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins PERIPHERAL_ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/M03_ARESETN] [get_bd_pins axi_interconnect_0/M04_ARESETN] [get_bd_pins axi_interconnect_0/M05_ARESETN] [get_bd_pins axi_interconnect_0/M06_ARESETN] [get_bd_pins axi_interconnect_0/M07_ARESETN] [get_bd_pins axi_interconnect_0/M08_ARESETN] [get_bd_pins axi_interconnect_0/M09_ARESETN] [get_bd_pins axi_interconnect_0/M10_ARESETN] [get_bd_pins axi_interconnect_0/M11_ARESETN] [get_bd_pins axi_interconnect_0/M12_ARESETN] [get_bd_pins axi_interconnect_0/M13_ARESETN] [get_bd_pins axi_interconnect_0/M14_ARESETN] [get_bd_pins axi_interconnect_0/M15_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/M01_ARESETN] [get_bd_pins axi_interconnect_1/M02_ARESETN] [get_bd_pins axi_interconnect_1/M03_ARESETN] [get_bd_pins axi_interconnect_1/M04_ARESETN] [get_bd_pins axi_interconnect_1/M05_ARESETN] [get_bd_pins axi_interconnect_1/M06_ARESETN] [get_bd_pins axi_interconnect_1/M07_ARESETN] [get_bd_pins axi_interconnect_1/M08_ARESETN] [get_bd_pins axi_interconnect_1/M09_ARESETN] [get_bd_pins axi_interconnect_1/M10_ARESETN] [get_bd_pins axi_interconnect_1/M11_ARESETN] [get_bd_pins axi_interconnect_1/M12_ARESETN] [get_bd_pins axi_interconnect_1/M13_ARESETN] [get_bd_pins axi_interconnect_1/M14_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axi_interconnect_2/M01_ARESETN] [get_bd_pins axi_interconnect_2/M02_ARESETN] [get_bd_pins axi_interconnect_2/M03_ARESETN] [get_bd_pins axi_interconnect_2/M04_ARESETN] [get_bd_pins axi_interconnect_2/M05_ARESETN] [get_bd_pins axi_interconnect_2/M06_ARESETN] [get_bd_pins axi_interconnect_2/M07_ARESETN] [get_bd_pins axi_interconnect_2/M08_ARESETN] [get_bd_pins axi_interconnect_2/M09_ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: MIG_Code
proc create_hier_cell_MIG_Code { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_MIG_Code() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR3
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_DC
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_IC

  # Create pins
  create_bd_pin -dir I CLK_MB
  create_bd_pin -dir I -from 0 -to 0 INTERCONNECT_ARESETN
  create_bd_pin -dir I -from 0 -to 0 -type rst PERIPHERAL_ARESETN
  create_bd_pin -dir O -type clk clk20
  create_bd_pin -dir O -type clk clk50
  create_bd_pin -dir O -type clk clk200
  create_bd_pin -dir I -from 11 -to 0 device_temp_i
  create_bd_pin -dir O mmcm_locked
  create_bd_pin -dir I -from 0 -to 0 -type rst sys_rst
  create_bd_pin -dir O -type clk ui_clk

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
 ] $axi_interconnect_0

  # Create instance: mig_7series_0, and set properties
  set mig_7series_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.0 mig_7series_0 ]

  # Generate the PRJ File for MIG
  set str_mig_folder [get_property IP_DIR [ get_ips [ get_property CONFIG.Component_Name $mig_7series_0 ] ] ]
  set str_mig_file_name mig_a.prj
  set str_mig_file_path ${str_mig_folder}/${str_mig_file_name}

  write_mig_file_core_mig_7series_0_0 $str_mig_file_path

  set_property -dict [ list \
CONFIG.BOARD_MIG_PARAM {Custom} \
CONFIG.MIG_DONT_TOUCH_PARAM {Custom} \
CONFIG.RESET_BOARD_INTERFACE {Custom} \
CONFIG.XML_INPUT_FILE {mig_a.prj} \
 ] $mig_7series_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S_DC] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins S_IC] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net SYS_CLK_0_1 [get_bd_intf_pins SYS_CLK] [get_bd_intf_pins mig_7series_0/SYS_CLK]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins mig_7series_0/S_AXI]
  connect_bd_intf_net -intf_net mig_7series_0_DDR4 [get_bd_intf_pins DDR3] [get_bd_intf_pins mig_7series_0/DDR3]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins CLK_MB] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins INTERCONNECT_ARESETN] [get_bd_pins axi_interconnect_0/ARESETN]
  connect_bd_net -net ext_reset_in_1 [get_bd_pins sys_rst] [get_bd_pins mig_7series_0/sys_rst]
  connect_bd_net -net mig_7series_0_mmcm_locked [get_bd_pins mmcm_locked] [get_bd_pins mig_7series_0/mmcm_locked]
  connect_bd_net -net mig_7series_0_ui_addn_clk_0 [get_bd_pins clk200] [get_bd_pins mig_7series_0/ui_addn_clk_0]
  connect_bd_net -net mig_7series_0_ui_addn_clk_1 [get_bd_pins clk50] [get_bd_pins mig_7series_0/ui_addn_clk_1]
  connect_bd_net -net mig_7series_0_ui_addn_clk_2 [get_bd_pins clk20] [get_bd_pins mig_7series_0/ui_addn_clk_2]
  connect_bd_net -net mig_7series_0_ui_clk [get_bd_pins ui_clk] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins mig_7series_0/ui_clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins PERIPHERAL_ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins mig_7series_0/aresetn]
  connect_bd_net -net xadc_wiz_1_temp_out [get_bd_pins device_temp_i] [get_bd_pins mig_7series_0/device_temp_i]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: MIG_Calibration
proc create_hier_cell_MIG_Calibration { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_MIG_Calibration() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR3
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_CALDDR_MM2S
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_CALDDR_MM2S_STS
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_MM2S_BUF
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_MM2S_STS_BUF
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_S2MM_STS_BUF
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_CAL_MM2S_CMD
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_MM2S_CMD_BUF
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_S2MM_BUF
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_S2MM_CMD_BUF
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_DP

  # Create pins
  create_bd_pin -dir I CLK_CAL
  create_bd_pin -dir I CLK_DATA
  create_bd_pin -dir I CLK_MB
  create_bd_pin -dir I -from 0 -to 0 INTERCONNECT_ARESETN
  create_bd_pin -dir I -from 0 -to 0 -type rst PERIPHERAL_ARESETN
  create_bd_pin -dir I -from 11 -to 0 device_temp_i
  create_bd_pin -dir I -from 0 -to 0 -type rst sys_rst

  # Create instance: CAL_DDR_MIG, and set properties
  set CAL_DDR_MIG [ create_bd_cell -type ip -vlnv xilinx.com:ip:mig_7series:4.0 CAL_DDR_MIG ]

  # Generate the PRJ File for MIG
  set str_mig_folder [get_property IP_DIR [ get_ips [ get_property CONFIG.Component_Name $CAL_DDR_MIG ] ] ]
  set str_mig_file_name mig_a.prj
  set str_mig_file_path ${str_mig_folder}/${str_mig_file_name}

  write_mig_file_core_CAL_DDR_MIG_0 $str_mig_file_path

  set_property -dict [ list \
CONFIG.BOARD_MIG_PARAM {Custom} \
CONFIG.RESET_BOARD_INTERFACE {Custom} \
CONFIG.XML_INPUT_FILE {mig_a.prj} \
 ] $CAL_DDR_MIG

  # Create instance: axi_datamover_ddrcal, and set properties
  set axi_datamover_ddrcal [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_datamover:5.1 axi_datamover_ddrcal ]
  set_property -dict [ list \
CONFIG.c_enable_mm2s {1} \
CONFIG.c_enable_s2mm {0} \
CONFIG.c_m_axi_mm2s_data_width {256} \
CONFIG.c_m_axis_mm2s_tdata_width {128} \
CONFIG.c_mm2s_burst_size {128} \
 ] $axi_datamover_ddrcal

  # Create instance: axi_dm_buffer, and set properties
  set axi_dm_buffer [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_datamover:5.1 axi_dm_buffer ]
  set_property -dict [ list \
CONFIG.c_m_axi_mm2s_data_width {256} \
CONFIG.c_m_axi_s2mm_data_width {256} \
CONFIG.c_m_axis_mm2s_tdata_width {16} \
CONFIG.c_mm2s_btt_used {23} \
CONFIG.c_mm2s_burst_size {16} \
CONFIG.c_s2mm_btt_used {23} \
CONFIG.c_s2mm_burst_size {64} \
 ] $axi_dm_buffer

  # Create instance: axi_interconnect_ddrcal, and set properties
  set axi_interconnect_ddrcal [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_ddrcal ]
  set_property -dict [ list \
CONFIG.M00_HAS_DATA_FIFO {0} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {4} \
CONFIG.S00_HAS_DATA_FIFO {0} \
CONFIG.S01_HAS_DATA_FIFO {0} \
CONFIG.S02_HAS_DATA_FIFO {0} \
CONFIG.S03_HAS_DATA_FIFO {0} \
CONFIG.S04_HAS_DATA_FIFO {2} \
CONFIG.STRATEGY {0} \
 ] $axi_interconnect_ddrcal

  # Create instance: axis_clock_converter_0, and set properties
  set axis_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_0 ]

  # Create instance: axis_clock_converter_1, and set properties
  set axis_clock_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_1 ]

  # Create instance: axis_clock_converter_2, and set properties
  set axis_clock_converter_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_2 ]

  # Create instance: axis_clock_converter_3, and set properties
  set axis_clock_converter_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_3 ]

  # Create instance: axis_clock_converter_4, and set properties
  set axis_clock_converter_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_4 ]

  # Create interface connections
  connect_bd_intf_net -intf_net CAL_DDR_MIG_DDR3 [get_bd_intf_pins DDR3] [get_bd_intf_pins CAL_DDR_MIG/DDR3]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins S_AXIS_MM2S_CMD_BUF] [get_bd_intf_pins axi_dm_buffer/S_AXIS_MM2S_CMD]
  connect_bd_intf_net -intf_net Conn8 [get_bd_intf_pins S_AXIS_S2MM_CMD_BUF] [get_bd_intf_pins axi_dm_buffer/S_AXIS_S2MM_CMD]
  connect_bd_intf_net -intf_net Conn10 [get_bd_intf_pins M_AXIS_MM2S_STS_BUF] [get_bd_intf_pins axi_dm_buffer/M_AXIS_MM2S_STS]
  connect_bd_intf_net -intf_net Conn11 [get_bd_intf_pins M_AXIS_S2MM_STS_BUF] [get_bd_intf_pins axi_dm_buffer/M_AXIS_S2MM_STS]
  connect_bd_intf_net -intf_net SYS_CLK_1 [get_bd_intf_pins SYS_CLK] [get_bd_intf_pins CAL_DDR_MIG/SYS_CLK]
  connect_bd_intf_net -intf_net S_AXIS_CAL_MM2S_CMD_1 [get_bd_intf_pins S_AXIS_CAL_MM2S_CMD] [get_bd_intf_pins axis_clock_converter_3/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_S2MM_BUF_1 [get_bd_intf_pins S_AXIS_S2MM_BUF] [get_bd_intf_pins axis_clock_converter_1/S_AXIS]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI_DP] [get_bd_intf_pins axi_interconnect_ddrcal/S00_AXI]
  connect_bd_intf_net -intf_net axi_datamover_0_M_AXI_MM2S [get_bd_intf_pins axi_datamover_ddrcal/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_ddrcal/S01_AXI]
  connect_bd_intf_net -intf_net axi_datamover_ddrcal_M_AXIS_MM2S [get_bd_intf_pins axi_datamover_ddrcal/M_AXIS_MM2S] [get_bd_intf_pins axis_clock_converter_0/S_AXIS]
  connect_bd_intf_net -intf_net axi_datamover_ddrcal_M_AXIS_MM2S_STS [get_bd_intf_pins axi_datamover_ddrcal/M_AXIS_MM2S_STS] [get_bd_intf_pins axis_clock_converter_4/S_AXIS]
  connect_bd_intf_net -intf_net axi_dm_buffer_M_AXIS_MM2S [get_bd_intf_pins axi_dm_buffer/M_AXIS_MM2S] [get_bd_intf_pins axis_clock_converter_2/S_AXIS]
  connect_bd_intf_net -intf_net axi_dm_buffer_M_AXI_MM2S [get_bd_intf_pins axi_dm_buffer/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_ddrcal/S03_AXI]
  connect_bd_intf_net -intf_net axi_dm_buffer_M_AXI_S2MM [get_bd_intf_pins axi_dm_buffer/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_ddrcal/S02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_ddrcal_M00_AXI [get_bd_intf_pins CAL_DDR_MIG/S_AXI] [get_bd_intf_pins axi_interconnect_ddrcal/M00_AXI]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins M_AXIS_CALDDR_MM2S] [get_bd_intf_pins axis_clock_converter_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_1_M_AXIS [get_bd_intf_pins axi_dm_buffer/S_AXIS_S2MM] [get_bd_intf_pins axis_clock_converter_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_2_M_AXIS [get_bd_intf_pins M_AXIS_MM2S_BUF] [get_bd_intf_pins axis_clock_converter_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_3_M_AXIS [get_bd_intf_pins axi_datamover_ddrcal/S_AXIS_MM2S_CMD] [get_bd_intf_pins axis_clock_converter_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_clock_converter_4_M_AXIS [get_bd_intf_pins M_AXIS_CALDDR_MM2S_STS] [get_bd_intf_pins axis_clock_converter_4/M_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins CLK_MB] [get_bd_pins axi_interconnect_ddrcal/S00_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins INTERCONNECT_ARESETN] [get_bd_pins axi_interconnect_ddrcal/ARESETN]
  connect_bd_net -net CAL_DDR_MIG_ui_clk [get_bd_pins CAL_DDR_MIG/ui_clk] [get_bd_pins axi_datamover_ddrcal/m_axi_mm2s_aclk] [get_bd_pins axi_datamover_ddrcal/m_axis_mm2s_cmdsts_aclk] [get_bd_pins axi_dm_buffer/m_axi_mm2s_aclk] [get_bd_pins axi_dm_buffer/m_axi_s2mm_aclk] [get_bd_pins axi_interconnect_ddrcal/ACLK] [get_bd_pins axi_interconnect_ddrcal/M00_ACLK] [get_bd_pins axi_interconnect_ddrcal/S01_ACLK] [get_bd_pins axi_interconnect_ddrcal/S02_ACLK] [get_bd_pins axi_interconnect_ddrcal/S03_ACLK] [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_clock_converter_1/m_axis_aclk] [get_bd_pins axis_clock_converter_2/s_axis_aclk] [get_bd_pins axis_clock_converter_3/m_axis_aclk] [get_bd_pins axis_clock_converter_4/s_axis_aclk]
  connect_bd_net -net S02_ACLK_1 [get_bd_pins CLK_DATA] [get_bd_pins axi_dm_buffer/m_axis_mm2s_cmdsts_aclk] [get_bd_pins axi_dm_buffer/m_axis_s2mm_cmdsts_awclk] [get_bd_pins axis_clock_converter_1/s_axis_aclk] [get_bd_pins axis_clock_converter_2/m_axis_aclk]
  connect_bd_net -net device_temp_i_1 [get_bd_pins device_temp_i] [get_bd_pins CAL_DDR_MIG/device_temp_i]
  connect_bd_net -net m_axi_mm2s_aclk_1 [get_bd_pins CLK_CAL] [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_clock_converter_3/s_axis_aclk] [get_bd_pins axis_clock_converter_4/m_axis_aclk]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins PERIPHERAL_ARESETN] [get_bd_pins CAL_DDR_MIG/aresetn] [get_bd_pins axi_datamover_ddrcal/m_axi_mm2s_aresetn] [get_bd_pins axi_datamover_ddrcal/m_axis_mm2s_cmdsts_aresetn] [get_bd_pins axi_dm_buffer/m_axi_mm2s_aresetn] [get_bd_pins axi_dm_buffer/m_axi_s2mm_aresetn] [get_bd_pins axi_dm_buffer/m_axis_mm2s_cmdsts_aresetn] [get_bd_pins axi_dm_buffer/m_axis_s2mm_cmdsts_aresetn] [get_bd_pins axi_interconnect_ddrcal/M00_ARESETN] [get_bd_pins axi_interconnect_ddrcal/S00_ARESETN] [get_bd_pins axi_interconnect_ddrcal/S01_ARESETN] [get_bd_pins axi_interconnect_ddrcal/S02_ARESETN] [get_bd_pins axi_interconnect_ddrcal/S03_ARESETN] [get_bd_pins axis_clock_converter_0/m_axis_aresetn] [get_bd_pins axis_clock_converter_0/s_axis_aresetn] [get_bd_pins axis_clock_converter_1/m_axis_aresetn] [get_bd_pins axis_clock_converter_1/s_axis_aresetn] [get_bd_pins axis_clock_converter_2/m_axis_aresetn] [get_bd_pins axis_clock_converter_2/s_axis_aresetn] [get_bd_pins axis_clock_converter_3/m_axis_aresetn] [get_bd_pins axis_clock_converter_3/s_axis_aresetn] [get_bd_pins axis_clock_converter_4/m_axis_aresetn] [get_bd_pins axis_clock_converter_4/s_axis_aresetn]
  connect_bd_net -net sys_rst_1 [get_bd_pins sys_rst] [get_bd_pins CAL_DDR_MIG/sys_rst]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: MCU
proc create_hier_cell_MCU { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" create_hier_cell_MCU() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 AXIS_USART_RX
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 AXIS_USART_TX
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_DC
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_DP
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_IC
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_mdm_axi
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_intc_axi

  # Create pins
  create_bd_pin -dir I -type clk Clk
  create_bd_pin -dir O Debug_SYS_Rst
  create_bd_pin -dir O -type intr Interrupt
  create_bd_pin -dir I -from 0 -to 0 LMB_Rst
  create_bd_pin -dir I -type rst Reset
  create_bd_pin -dir I S_AXI_ACLK
  create_bd_pin -dir I -from 15 -to 0 intr
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]
  set_property -dict [ list \
CONFIG.C_USE_UART {1} \
 ] $mdm_1

  # Create instance: microblaze_1, and set properties
  set microblaze_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:10.0 microblaze_1 ]
  set_property -dict [ list \
CONFIG.C_CACHE_BYTE_SIZE {16384} \
CONFIG.C_DCACHE_BYTE_SIZE {16384} \
CONFIG.C_DEBUG_ENABLED {1} \
CONFIG.C_D_AXI {1} \
CONFIG.C_D_LMB {1} \
CONFIG.C_FSL_LINKS {1} \
CONFIG.C_I_LMB {1} \
CONFIG.C_NUMBER_OF_PC_BRK {2} \
CONFIG.C_NUMBER_OF_RD_ADDR_BRK {1} \
CONFIG.C_NUMBER_OF_WR_ADDR_BRK {1} \
CONFIG.C_USE_DCACHE {1} \
CONFIG.C_USE_FPU {1} \
CONFIG.C_USE_HW_MUL {1} \
CONFIG.C_USE_ICACHE {1} \
CONFIG.C_USE_STACK_PROTECTION {1} \
CONFIG.G_USE_EXCEPTIONS {0} \
 ] $microblaze_1

  # Create instance: microblaze_1_axi_intc, and set properties
  set microblaze_1_axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 microblaze_1_axi_intc ]
  set_property -dict [ list \
CONFIG.C_HAS_FAST {1} \
 ] $microblaze_1_axi_intc

  # Create instance: microblaze_1_local_memory
  create_hier_cell_microblaze_1_local_memory $hier_obj microblaze_1_local_memory

  # Create interface connections
  connect_bd_intf_net -intf_net AXIS_USART_RX_1 [get_bd_intf_pins AXIS_USART_RX] [get_bd_intf_pins microblaze_1/S0_AXIS]
  connect_bd_intf_net -intf_net S_mdm_axi_1 [get_bd_intf_pins S_mdm_axi] [get_bd_intf_pins mdm_1/S_AXI]
  connect_bd_intf_net -intf_net mdm_1_MBDEBUG_0 [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_1/DEBUG]
  connect_bd_intf_net -intf_net microblaze_1_M0_AXIS [get_bd_intf_pins AXIS_USART_TX] [get_bd_intf_pins microblaze_1/M0_AXIS]
  connect_bd_intf_net -intf_net microblaze_1_M_AXI_DC [get_bd_intf_pins M_AXI_DC] [get_bd_intf_pins microblaze_1/M_AXI_DC]
  connect_bd_intf_net -intf_net microblaze_1_M_AXI_DP [get_bd_intf_pins M_AXI_DP] [get_bd_intf_pins microblaze_1/M_AXI_DP]
  connect_bd_intf_net -intf_net microblaze_1_M_AXI_IC [get_bd_intf_pins M_AXI_IC] [get_bd_intf_pins microblaze_1/M_AXI_IC]
  connect_bd_intf_net -intf_net microblaze_1_dlmb_1 [get_bd_intf_pins microblaze_1/DLMB] [get_bd_intf_pins microblaze_1_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_1_ilmb_1 [get_bd_intf_pins microblaze_1/ILMB] [get_bd_intf_pins microblaze_1_local_memory/ILMB]
  connect_bd_intf_net -intf_net microblaze_1_interrupt [get_bd_intf_pins microblaze_1/INTERRUPT] [get_bd_intf_pins microblaze_1_axi_intc/interrupt]
  connect_bd_intf_net -intf_net s_intc_axi_1 [get_bd_intf_pins s_intc_axi] [get_bd_intf_pins microblaze_1_axi_intc/s_axi]

  # Create port connections
  connect_bd_net -net LMB_Rst_1 [get_bd_pins LMB_Rst] [get_bd_pins microblaze_1_local_memory/SYS_Rst]
  connect_bd_net -net Reset_1 [get_bd_pins Reset] [get_bd_pins microblaze_1/Reset] [get_bd_pins microblaze_1_axi_intc/processor_rst]
  connect_bd_net -net S_AXI_ACLK_1 [get_bd_pins S_AXI_ACLK] [get_bd_pins mdm_1/S_AXI_ACLK] [get_bd_pins microblaze_1_axi_intc/s_axi_aclk]
  connect_bd_net -net intr_1 [get_bd_pins intr] [get_bd_pins microblaze_1_axi_intc/intr]
  connect_bd_net -net mdm_1_Debug_SYS_Rst [get_bd_pins Debug_SYS_Rst] [get_bd_pins mdm_1/Debug_SYS_Rst]
  connect_bd_net -net mdm_1_Interrupt [get_bd_pins Interrupt] [get_bd_pins mdm_1/Interrupt]
  connect_bd_net -net microblaze_1_Clk [get_bd_pins Clk] [get_bd_pins microblaze_1/Clk] [get_bd_pins microblaze_1_axi_intc/processor_clk] [get_bd_pins microblaze_1_local_memory/LMB_Clk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins mdm_1/S_AXI_ARESETN] [get_bd_pins microblaze_1_axi_intc/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set ADC_READOUT_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 ADC_READOUT_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $ADC_READOUT_CTRL
  set AEC_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 AEC_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $AEC_CTRL
  set CALIBCONFIG_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 CALIBCONFIG_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $CALIBCONFIG_AXI
  set CALIB_RAM_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 CALIB_RAM_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $CALIB_RAM_AXI
  set CAL_DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 CAL_DDR ]
  set CODE_DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 CODE_DDR ]
  set EXPTIME_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 EXPTIME_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $EXPTIME_CTRL
  set FAN_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 FAN_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $FAN_CTRL
  set FPA_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 FPA_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $FPA_CTRL
  set HEADER_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 HEADER_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $HEADER_CTRL
  set IRIG_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 IRIG_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $IRIG_CTRL
  set LED_GPIO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 LED_GPIO ]
  set MGT_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 MGT_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $MGT_CTRL
  set MUX_ADDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 MUX_ADDR ]
  set M_AXIS_CALDDR_MM2S [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_CALDDR_MM2S ]
  set M_AXIS_CALDDR_MM2S_STS [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_CALDDR_MM2S_STS ]
  set M_AXIS_MM2S_BUF [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_MM2S_BUF ]
  set M_AXIS_MM2S_STS_BUF [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_MM2S_STS_BUF ]
  set M_AXIS_S2MM_STS_BUF [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_S2MM_STS_BUF ]
  set M_AXIS_USART [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_USART ]
  set M_BUFFERING_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_BUFFERING_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $M_BUFFERING_CTRL
  set M_BUF_TABLE [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_BUF_TABLE ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $M_BUF_TABLE
  set M_BULK_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_BULK_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $M_BULK_AXI
  set M_EHDRI_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_EHDRI_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4} \
 ] $M_EHDRI_CTRL
  set M_FLASHINTF_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FLASHINTF_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4} \
 ] $M_FLASHINTF_AXI
  set M_FRAME_BUFFER_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_FRAME_BUFFER_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.HAS_BURST {0} \
CONFIG.HAS_CACHE {0} \
CONFIG.HAS_LOCK {0} \
CONFIG.HAS_QOS {0} \
CONFIG.HAS_REGION {0} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $M_FRAME_BUFFER_CTRL
  set M_ICU_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_ICU_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $M_ICU_AXI
  set NLC_LUT_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 NLC_LUT_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.HAS_BURST {0} \
CONFIG.HAS_CACHE {0} \
CONFIG.HAS_LOCK {0} \
CONFIG.HAS_QOS {0} \
CONFIG.HAS_REGION {0} \
CONFIG.NUM_READ_OUTSTANDING {2} \
CONFIG.NUM_WRITE_OUTSTANDING {2} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $NLC_LUT_AXI
  set POWER_GPIO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 POWER_GPIO ]
  set QSPI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 QSPI ]
  set REV_GPIO [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 REV_GPIO ]
  set RQC_LUT_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 RQC_LUT_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $RQC_LUT_AXI
  set SFW_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 SFW_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $SFW_CTRL
  set SYS_CLK_0 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK_0 ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {200000000} \
 ] $SYS_CLK_0
  set SYS_CLK_1 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 SYS_CLK_1 ]
  set_property -dict [ list \
CONFIG.FREQ_HZ {200000000} \
 ] $SYS_CLK_1
  set S_AXIS_CALDDR_MM2S_CMD [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_CALDDR_MM2S_CMD ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {0} \
CONFIG.HAS_TREADY {1} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {9} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {0} \
 ] $S_AXIS_CALDDR_MM2S_CMD
  set S_AXIS_MM2S_CMD_BUF [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_MM2S_CMD_BUF ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {0} \
CONFIG.HAS_TREADY {1} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {9} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {0} \
 ] $S_AXIS_MM2S_CMD_BUF
  set S_AXIS_S2MM_BUF [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_S2MM_BUF ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {1} \
CONFIG.HAS_TLAST {1} \
CONFIG.HAS_TREADY {1} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {8} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {0} \
 ] $S_AXIS_S2MM_BUF
  set S_AXIS_S2MM_CMD_BUF [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_S2MM_CMD_BUF ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {0} \
CONFIG.HAS_TREADY {1} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {9} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {0} \
 ] $S_AXIS_S2MM_CMD_BUF
  set S_AXIS_USART [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_USART ]
  set_property -dict [ list \
CONFIG.HAS_TKEEP {0} \
CONFIG.HAS_TLAST {1} \
CONFIG.HAS_TREADY {1} \
CONFIG.HAS_TSTRB {0} \
CONFIG.LAYERED_METADATA {undef} \
CONFIG.TDATA_NUM_BYTES {4} \
CONFIG.TDEST_WIDTH {0} \
CONFIG.TID_WIDTH {0} \
CONFIG.TUSER_WIDTH {0} \
 ] $S_AXIS_USART
  set TRIGGER_CTRL [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 TRIGGER_CTRL ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $TRIGGER_CTRL
  set USB_UART [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 USB_UART ]

  # Create ports
  set AEC_INTC [ create_bd_port -dir I -type intr AEC_INTC ]
  set_property -dict [ list \
CONFIG.SENSITIVITY {EDGE_RISING} \
 ] $AEC_INTC
  set ARESETN [ create_bd_port -dir O -from 0 -to 0 -type rst ARESETN ]
  set BUTTON [ create_bd_port -dir I BUTTON ]
  set CLINK_UART_rxd [ create_bd_port -dir I CLINK_UART_rxd ]
  set CLINK_UART_txd [ create_bd_port -dir O CLINK_UART_txd ]
  set FPGA_UART_rxd [ create_bd_port -dir I FPGA_UART_rxd ]
  set FPGA_UART_txd [ create_bd_port -dir O FPGA_UART_txd ]
  set FW_UART_rxd [ create_bd_port -dir I FW_UART_rxd ]
  set FW_UART_txd [ create_bd_port -dir O FW_UART_txd ]
  set GPS_UART_rxd [ create_bd_port -dir I GPS_UART_rxd ]
  set GPS_UART_txd [ create_bd_port -dir O GPS_UART_txd ]
  set LENS_UART_SIN [ create_bd_port -dir I LENS_UART_SIN ]
  set LENS_UART_SOUT [ create_bd_port -dir O LENS_UART_SOUT ]
  set NDF_UART_rxd [ create_bd_port -dir I NDF_UART_rxd ]
  set NDF_UART_txd [ create_bd_port -dir O NDF_UART_txd ]
  set OEM_UART_rxd [ create_bd_port -dir I OEM_UART_rxd ]
  set OEM_UART_txd [ create_bd_port -dir O OEM_UART_txd ]
  set PLEORA_UART_SIN [ create_bd_port -dir I PLEORA_UART_SIN ]
  set PLEORA_UART_SOUT [ create_bd_port -dir O PLEORA_UART_SOUT ]
  set bulk_interrupt [ create_bd_port -dir I -from 0 -to 0 -type intr bulk_interrupt ]
  set_property -dict [ list \
CONFIG.PortWidth {1} \
CONFIG.SENSITIVITY {EDGE_RISING} \
 ] $bulk_interrupt
  set clk_200 [ create_bd_port -dir O -type clk clk_200 ]
  set clk_cal [ create_bd_port -dir O -type clk clk_cal ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {S_AXIS_CALDDR_MM2S_CMD:M_AXIS_CALDDR_MM2S_STS:M_AXIS_CALDDR_MM2S:NLC_LUT_AXI:RQC_LUT_AXI} \
 ] $clk_cal
  set clk_data [ create_bd_port -dir O -type clk clk_data ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {S_AXIS_MM2S_CMD_BUF:S_AXIS_S2MM_BUF:S_AXIS_S2MM_CMD_BUF:M_AXIS_S2MM_STS_BUF:M_AXIS_MM2S_STS_BUF:M_AXIS_MM2S_BUF} \
 ] $clk_data
  set clk_irig [ create_bd_port -dir O -type clk clk_irig ]
  set clk_mb [ create_bd_port -dir O -type clk clk_mb ]
  set_property -dict [ list \
CONFIG.ASSOCIATED_BUSIF {FPA_CTRL:HEADER_CTRL:EXPTIME_CTRL:TRIGGER_CTRL:CALIB_RAM_AXI:AEC_CTRL:SFW_CTRL:CALIBCONFIG_AXI:FAN_CTRL:MGT_CTRL:IRIG_CTRL:M_BULK_AXI:M_FLASHINTF_AXI:M_ICU_AXI:M_BUF_TABLE:M_BUFFERING_CTRL:M_EHDRI_CTRL:M_AXIS_USART:S_AXIS_USART:ADC_READOUT_CTRL:M_FRAME_BUFFER_CTRL} \
 ] $clk_mb
  set clk_mgt_init [ create_bd_port -dir O -type clk clk_mgt_init ]
  set vn_in [ create_bd_port -dir I vn_in ]
  set vp_in [ create_bd_port -dir I vp_in ]

  # Create instance: FlashReset_0, and set properties
  set FlashReset_0 [ create_bd_cell -type ip -vlnv Telops:user:FlashReset:1.0 FlashReset_0 ]

  # Create instance: GND, and set properties
  set GND [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 GND ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $GND

  # Create instance: MCU
  create_hier_cell_MCU [current_bd_instance .] MCU

  # Create instance: MIG_Calibration
  create_hier_cell_MIG_Calibration [current_bd_instance .] MIG_Calibration

  # Create instance: MIG_Code
  create_hier_cell_MIG_Code [current_bd_instance .] MIG_Code

  # Create instance: axi_gpio_0, and set properties
  set axi_gpio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_0 ]
  set_property -dict [ list \
CONFIG.C_ALL_INPUTS_2 {1} \
CONFIG.C_ALL_OUTPUTS {1} \
CONFIG.C_GPIO2_WIDTH {4} \
CONFIG.C_GPIO_WIDTH {4} \
CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_0

  # Create instance: axi_gps_uart, and set properties
  set axi_gps_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_gps_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_gps_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_gps_uart

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
 ] $axi_interconnect_0

  # Create instance: axi_lens_uart, and set properties
  set axi_lens_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_lens_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_lens_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_lens_uart

  # Create instance: axi_ndf_uart, and set properties
  set axi_ndf_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_ndf_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_ndf_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_ndf_uart

  # Create instance: axi_peripheral
  create_hier_cell_axi_peripheral [current_bd_instance .] axi_peripheral

  # Create instance: axi_quad_spi_0, and set properties
  set axi_quad_spi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0 ]
  set_property -dict [ list \
CONFIG.C_SPI_MEMORY {2} \
CONFIG.C_SPI_MODE {2} \
 ] $axi_quad_spi_0

  # Create instance: axi_timer_0, and set properties
  set axi_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timer:2.0 axi_timer_0 ]

  # Create instance: axi_usb_uart, and set properties
  set axi_usb_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_usb_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_usb_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_usb_uart

  # Create instance: clink_uart, and set properties
  set clink_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 clink_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $clink_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $clink_uart

  # Create instance: clk_wiz_1, and set properties
  set clk_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz_1 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_JITTER {220.112} \
CONFIG.CLKOUT1_PHASE_ERROR {300.046} \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {170.000} \
CONFIG.CLKOUT2_JITTER {242.325} \
CONFIG.CLKOUT2_PHASE_ERROR {300.046} \
CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {85.000} \
CONFIG.CLKOUT2_USED {true} \
CONFIG.MMCM_CLKFBOUT_MULT_F {51.000} \
CONFIG.MMCM_CLKIN1_PERIOD {10.0} \
CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
CONFIG.MMCM_CLKOUT0_DIVIDE_F {6.000} \
CONFIG.MMCM_CLKOUT1_DIVIDE {12} \
CONFIG.MMCM_COMPENSATION {ZHOLD} \
CONFIG.MMCM_DIVCLK_DIVIDE {5} \
CONFIG.NUM_OUT_CLKS {2} \
CONFIG.PRIM_SOURCE {No_buffer} \
CONFIG.RESET_PORT {resetn} \
CONFIG.RESET_TYPE {ACTIVE_LOW} \
 ] $clk_wiz_1

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.MMCM_CLKIN1_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_CLKIN2_PERIOD.VALUE_SRC {DEFAULT} \
CONFIG.MMCM_COMPENSATION.VALUE_SRC {DEFAULT} \
 ] $clk_wiz_1

  # Create instance: fpga_output_uart, and set properties
  set fpga_output_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 fpga_output_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $fpga_output_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $fpga_output_uart

  # Create instance: fw_uart, and set properties
  set fw_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 fw_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $fw_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $fw_uart

  # Create instance: intr_concact, and set properties
  set intr_concact [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 intr_concact ]
  set_property -dict [ list \
CONFIG.NUM_PORTS {16} \
 ] $intr_concact

  # Create instance: oem_uart, and set properties
  set oem_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 oem_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $oem_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $oem_uart

  # Create instance: pleora_uart, and set properties
  set pleora_uart [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 pleora_uart ]
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ {25000000} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $pleora_uart

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_EXTERNAL_XIN_CLK_HZ.VALUE_SRC {DEFAULT} \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $pleora_uart

  # Create instance: power_management, and set properties
  set power_management [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 power_management ]
  set_property -dict [ list \
CONFIG.C_ALL_OUTPUTS {0} \
CONFIG.C_ALL_OUTPUTS_2 {1} \
CONFIG.C_GPIO2_WIDTH {5} \
CONFIG.C_GPIO_WIDTH {8} \
CONFIG.C_INTERRUPT_PRESENT {0} \
CONFIG.C_IS_DUAL {1} \
CONFIG.C_TRI_DEFAULT {0xFFFFF000} \
 ] $power_management

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]
  set_property -dict [ list \
CONFIG.C_AUX_RESET_HIGH {1} \
CONFIG.C_AUX_RST_WIDTH {1} \
 ] $proc_sys_reset_1

  # Create instance: vcc, and set properties
  set vcc [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 vcc ]

  # Create instance: xadc_wiz_1, and set properties
  set xadc_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz:3.3 xadc_wiz_1 ]
  set_property -dict [ list \
CONFIG.ADC_CONVERSION_RATE {1000} \
CONFIG.CHANNEL_ENABLE_CALIBRATION {true} \
CONFIG.CHANNEL_ENABLE_TEMPERATURE {true} \
CONFIG.CHANNEL_ENABLE_VBRAM {true} \
CONFIG.CHANNEL_ENABLE_VCCAUX {true} \
CONFIG.CHANNEL_ENABLE_VCCINT {true} \
CONFIG.CHANNEL_ENABLE_VP_VN {true} \
CONFIG.CHANNEL_ENABLE_VREFN {true} \
CONFIG.CHANNEL_ENABLE_VREFP {true} \
CONFIG.DCLK_FREQUENCY {100} \
CONFIG.ENABLE_EXTERNAL_MUX {true} \
CONFIG.ENABLE_RESET {false} \
CONFIG.ENABLE_TEMP_BUS {true} \
CONFIG.INTERFACE_SELECTION {Enable_AXI} \
CONFIG.SEQUENCER_MODE {Continuous} \
CONFIG.XADC_STARUP_SELECTION {channel_sequencer} \
 ] $xadc_wiz_1

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.ADC_CONVERSION_RATE.VALUE_SRC {DEFAULT} \
CONFIG.DCLK_FREQUENCY.VALUE_SRC {DEFAULT} \
CONFIG.ENABLE_RESET.VALUE_SRC {DEFAULT} \
CONFIG.INTERFACE_SELECTION.VALUE_SRC {DEFAULT} \
CONFIG.SEQUENCER_MODE.VALUE_SRC {DEFAULT} \
 ] $xadc_wiz_1

  # Create interface connections
  connect_bd_intf_net -intf_net FlashReset_0_m_axi [get_bd_intf_pins FlashReset_0/m_axi] [get_bd_intf_pins axi_interconnect_0/S01_AXI]
  connect_bd_intf_net -intf_net MCU_M0_AXIS [get_bd_intf_ports M_AXIS_USART] [get_bd_intf_pins MCU/AXIS_USART_TX]
  connect_bd_intf_net -intf_net MIG_Calibration_M_AXIS_MM2S [get_bd_intf_ports M_AXIS_CALDDR_MM2S] [get_bd_intf_pins MIG_Calibration/M_AXIS_CALDDR_MM2S]
  connect_bd_intf_net -intf_net MIG_Calibration_M_AXIS_MM2S1 [get_bd_intf_ports M_AXIS_MM2S_BUF] [get_bd_intf_pins MIG_Calibration/M_AXIS_MM2S_BUF]
  connect_bd_intf_net -intf_net MIG_Calibration_M_AXIS_MM2S_STS [get_bd_intf_ports M_AXIS_CALDDR_MM2S_STS] [get_bd_intf_pins MIG_Calibration/M_AXIS_CALDDR_MM2S_STS]
  connect_bd_intf_net -intf_net MIG_Calibration_M_AXIS_MM2S_STS1 [get_bd_intf_ports M_AXIS_MM2S_STS_BUF] [get_bd_intf_pins MIG_Calibration/M_AXIS_MM2S_STS_BUF]
  connect_bd_intf_net -intf_net MIG_Calibration_M_AXIS_S2MM_STS1 [get_bd_intf_ports M_AXIS_S2MM_STS_BUF] [get_bd_intf_pins MIG_Calibration/M_AXIS_S2MM_STS_BUF]
  connect_bd_intf_net -intf_net RQC_LUT_AXI [get_bd_intf_ports RQC_LUT_AXI] [get_bd_intf_pins axi_peripheral/M_RQC_LUT_AXI]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins MCU/M_AXI_DC] [get_bd_intf_pins MIG_Code/S_DC]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins axi_peripheral/M_QSPI_AXI]
  connect_bd_intf_net -intf_net S01_AXI_1 [get_bd_intf_pins MCU/M_AXI_IC] [get_bd_intf_pins MIG_Code/S_IC]
  connect_bd_intf_net -intf_net S0_AXIS_1 [get_bd_intf_ports S_AXIS_USART] [get_bd_intf_pins MCU/AXIS_USART_RX]
  connect_bd_intf_net -intf_net SYS_CLK_0_1 [get_bd_intf_ports SYS_CLK_0] [get_bd_intf_pins MIG_Code/SYS_CLK]
  connect_bd_intf_net -intf_net SYS_CLK_1 [get_bd_intf_ports SYS_CLK_1] [get_bd_intf_pins MIG_Calibration/SYS_CLK]
  connect_bd_intf_net -intf_net S_AXIS_MM2S_CMD_1 [get_bd_intf_ports S_AXIS_CALDDR_MM2S_CMD] [get_bd_intf_pins MIG_Calibration/S_AXIS_CAL_MM2S_CMD]
  connect_bd_intf_net -intf_net S_AXIS_MM2S_CMD_2 [get_bd_intf_ports S_AXIS_MM2S_CMD_BUF] [get_bd_intf_pins MIG_Calibration/S_AXIS_MM2S_CMD_BUF]
  connect_bd_intf_net -intf_net S_AXIS_S2MM_2 [get_bd_intf_ports S_AXIS_S2MM_BUF] [get_bd_intf_pins MIG_Calibration/S_AXIS_S2MM_BUF]
  connect_bd_intf_net -intf_net S_AXIS_S2MM_CMD_2 [get_bd_intf_ports S_AXIS_S2MM_CMD_BUF] [get_bd_intf_pins MIG_Calibration/S_AXIS_S2MM_CMD_BUF]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO2 [get_bd_intf_ports REV_GPIO] [get_bd_intf_pins axi_gpio_0/GPIO2]
  connect_bd_intf_net -intf_net axi_gpio_0_gpio [get_bd_intf_ports LED_GPIO] [get_bd_intf_pins axi_gpio_0/GPIO]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI1 [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins axi_quad_spi_0/AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_0_m00_axi [get_bd_intf_pins axi_peripheral/M_TIMER_AXI] [get_bd_intf_pins axi_timer_0/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_m00_axi [get_bd_intf_pins axi_peripheral/M_XADC_AXI] [get_bd_intf_pins xadc_wiz_1/s_axi_lite]
  connect_bd_intf_net -intf_net axi_interconnect_1_m01_axi [get_bd_intf_pins axi_peripheral/M_OEMUART_AXI] [get_bd_intf_pins oem_uart/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_m02_axi [get_bd_intf_pins axi_peripheral/M_CLINKUART_AXI] [get_bd_intf_pins clink_uart/S_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_m12_axi [get_bd_intf_pins axi_gpio_0/S_AXI] [get_bd_intf_pins axi_peripheral/M_LEDGPIO_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M03_AXI [get_bd_intf_ports M_BUFFERING_CTRL] [get_bd_intf_pins axi_peripheral/M_BUFFERING_CTRL]
  connect_bd_intf_net -intf_net axi_peripheral_M04_AXI [get_bd_intf_ports FAN_CTRL] [get_bd_intf_pins axi_peripheral/M_FAN_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M04_AXI1 [get_bd_intf_ports M_BUF_TABLE] [get_bd_intf_pins axi_peripheral/M_BUF_TABLE]
  connect_bd_intf_net -intf_net axi_peripheral_M05_AXI [get_bd_intf_ports MGT_CTRL] [get_bd_intf_pins axi_peripheral/M_MGT_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M05_AXI1 [get_bd_intf_ports M_EHDRI_CTRL] [get_bd_intf_pins axi_peripheral/M_EHDRI_CTRL]
  connect_bd_intf_net -intf_net axi_peripheral_M06_AXI [get_bd_intf_ports IRIG_CTRL] [get_bd_intf_pins axi_peripheral/M_IRIG_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M08_AXI [get_bd_intf_pins axi_peripheral/M_POWER_AXI] [get_bd_intf_pins power_management/S_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M09_AXI [get_bd_intf_ports M_FRAME_BUFFER_CTRL] [get_bd_intf_pins axi_peripheral/M09_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M14_AXI1 [get_bd_intf_pins axi_gps_uart/S_AXI] [get_bd_intf_pins axi_peripheral/M_GPS_UART]
  connect_bd_intf_net -intf_net axi_peripheral_M15_AXI [get_bd_intf_ports M_ICU_AXI] [get_bd_intf_pins axi_peripheral/M_ICU_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_ADC_READOUT_AXI [get_bd_intf_ports ADC_READOUT_CTRL] [get_bd_intf_pins axi_peripheral/M_ADC_READOUT_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_AXI [get_bd_intf_ports NLC_LUT_AXI] [get_bd_intf_pins axi_peripheral/M_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_BULK_AXI [get_bd_intf_ports M_BULK_AXI] [get_bd_intf_pins axi_peripheral/M_BULK_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_CALIB_RAM_AXI [get_bd_intf_ports CALIB_RAM_AXI] [get_bd_intf_pins axi_peripheral/M_CALIB_RAM_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_COOLER_UART [get_bd_intf_pins axi_ndf_uart/S_AXI] [get_bd_intf_pins axi_peripheral/M_COOLER_UART]
  connect_bd_intf_net -intf_net axi_peripheral_M_DDRMIG_AXI [get_bd_intf_pins MIG_Calibration/S_AXI_DP] [get_bd_intf_pins axi_peripheral/M_DDRCAL_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_FLASHINTF_AXI [get_bd_intf_ports M_FLASHINTF_AXI] [get_bd_intf_pins axi_peripheral/M_FLASHINTF_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_FLASHRESET_AXI [get_bd_intf_pins FlashReset_0/s_axi] [get_bd_intf_pins axi_peripheral/M_FLASHRESET_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_FW_UART_AXI [get_bd_intf_pins axi_peripheral/M_FW_UART_AXI] [get_bd_intf_pins fw_uart/S_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_M_LENS_UART_AXI [get_bd_intf_pins axi_lens_uart/S_AXI] [get_bd_intf_pins axi_peripheral/M_LENS_UART_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_m_fpgaout_axi [get_bd_intf_pins axi_peripheral/M_FPGAOUT_AXI] [get_bd_intf_pins fpga_output_uart/S_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_m_pleora_axi [get_bd_intf_pins axi_peripheral/M_PLEORA_AXI] [get_bd_intf_pins pleora_uart/S_AXI]
  connect_bd_intf_net -intf_net axi_peripheral_m_usbuart_axi [get_bd_intf_pins axi_peripheral/M_USBUART_AXI] [get_bd_intf_pins axi_usb_uart/S_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_0_m_axi [get_bd_intf_ports FPA_CTRL] [get_bd_intf_pins axi_peripheral/M_FPACTRL_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_1_m_axi [get_bd_intf_ports HEADER_CTRL] [get_bd_intf_pins axi_peripheral/M_HEADERCTRL_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_2_m_axi [get_bd_intf_ports EXPTIME_CTRL] [get_bd_intf_pins axi_peripheral/M_EXPTIMECTRL_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_3_m_axi [get_bd_intf_ports AEC_CTRL] [get_bd_intf_pins axi_peripheral/M_AECCTRL_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_4_m_axi [get_bd_intf_ports TRIGGER_CTRL] [get_bd_intf_pins axi_peripheral/M_TRIGGERCTRL_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_7_m_axi [get_bd_intf_ports CALIBCONFIG_AXI] [get_bd_intf_pins axi_peripheral/M_CALIBCONFIG_AXI]
  connect_bd_intf_net -intf_net axi_protocol_converter_8_m_axi [get_bd_intf_ports SFW_CTRL] [get_bd_intf_pins axi_peripheral/M_SFWCTRL_AXI]
  connect_bd_intf_net -intf_net axi_quad_spi_0_SPI_0 [get_bd_intf_ports QSPI] [get_bd_intf_pins axi_quad_spi_0/SPI_0]
  connect_bd_intf_net -intf_net axi_usb_uart_uart [get_bd_intf_ports USB_UART] [get_bd_intf_pins axi_usb_uart/UART]
  connect_bd_intf_net -intf_net mcu_m_axi_dp [get_bd_intf_pins MCU/M_AXI_DP] [get_bd_intf_pins axi_peripheral/S00_AXI]
  connect_bd_intf_net -intf_net mig_7series_0_DDR3 [get_bd_intf_ports CAL_DDR] [get_bd_intf_pins MIG_Calibration/DDR3]
  connect_bd_intf_net -intf_net mig_7series_0_DDR4 [get_bd_intf_ports CODE_DDR] [get_bd_intf_pins MIG_Code/DDR3]
  connect_bd_intf_net -intf_net power_management_GPIO [get_bd_intf_ports POWER_GPIO] [get_bd_intf_pins power_management/GPIO]
  connect_bd_intf_net -intf_net power_management_GPIO2 [get_bd_intf_ports MUX_ADDR] [get_bd_intf_pins power_management/GPIO2]
  connect_bd_intf_net -intf_net s_axi1_1 [get_bd_intf_pins MCU/S_mdm_axi] [get_bd_intf_pins axi_peripheral/M_MDM_AXI]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins MCU/s_intc_axi] [get_bd_intf_pins axi_peripheral/M_INTC_AXI]

  # Create port connections
  connect_bd_net -net AEC_INTC_1 [get_bd_ports AEC_INTC] [get_bd_pins intr_concact/In4]
  connect_bd_net -net BUTTON_1 [get_bd_ports BUTTON] [get_bd_pins FlashReset_0/button]
  connect_bd_net -net CLINK_UART_rxd_1 [get_bd_ports CLINK_UART_rxd] [get_bd_pins clink_uart/sin]
  connect_bd_net -net FPGA_UART_rxd_1 [get_bd_ports FPGA_UART_rxd] [get_bd_pins fpga_output_uart/sin]
  connect_bd_net -net FW_UART_rxd_1 [get_bd_ports FW_UART_rxd] [get_bd_pins fw_uart/sin]
  connect_bd_net -net FlashReset_0_ip2intc_irpt [get_bd_pins FlashReset_0/ip2intc_irpt] [get_bd_pins intr_concact/In1]
  connect_bd_net -net LENS_UART_SIN_1 [get_bd_ports LENS_UART_SIN] [get_bd_pins axi_lens_uart/sin]
  connect_bd_net -net MCU_Interrupt [get_bd_pins MCU/Interrupt] [get_bd_pins intr_concact/In14]
  connect_bd_net -net MIG_Code_clk20 [get_bd_ports clk_irig] [get_bd_pins MIG_Code/clk20]
  connect_bd_net -net MIG_Code_clk200 [get_bd_ports clk_200] [get_bd_pins MIG_Code/clk200]
  connect_bd_net -net MIG_Code_mmcm_locked [get_bd_pins MIG_Code/mmcm_locked] [get_bd_pins clk_wiz_1/resetn]
  connect_bd_net -net NDF_UART_rxd_1 [get_bd_ports NDF_UART_rxd] [get_bd_pins axi_ndf_uart/sin]
  connect_bd_net -net OEM_UART_rxd_1 [get_bd_ports OEM_UART_rxd] [get_bd_pins oem_uart/sin]
  connect_bd_net -net axi_gps_uart_sout [get_bd_ports GPS_UART_txd] [get_bd_pins axi_gps_uart/sout]
  connect_bd_net -net axi_lens_uart_sout [get_bd_ports LENS_UART_SOUT] [get_bd_pins axi_lens_uart/sout]
  connect_bd_net -net axi_ndf_uart1_ip2intc_irpt [get_bd_pins axi_lens_uart/ip2intc_irpt] [get_bd_pins intr_concact/In15]
  connect_bd_net -net axi_ndf_uart_sout [get_bd_ports NDF_UART_txd] [get_bd_pins axi_ndf_uart/sout]
  connect_bd_net -net axi_quad_spi_0_ip2intc_irpt [get_bd_pins axi_quad_spi_0/ip2intc_irpt] [get_bd_pins intr_concact/In5]
  connect_bd_net -net axi_timer_0_interrupt [get_bd_pins axi_timer_0/interrupt] [get_bd_pins intr_concact/In10]
  connect_bd_net -net axi_uart16550_0_ip2intc_irpt [get_bd_pins axi_gps_uart/ip2intc_irpt] [get_bd_pins intr_concact/In3]
  connect_bd_net -net axi_usb_uart_ip2intc_irpt [get_bd_pins axi_usb_uart/ip2intc_irpt] [get_bd_pins intr_concact/In7]
  connect_bd_net -net bulk_interrupt_1 [get_bd_ports bulk_interrupt] [get_bd_pins intr_concact/In6]
  connect_bd_net -net clink_uart_ip2intc_irpt [get_bd_pins clink_uart/ip2intc_irpt] [get_bd_pins intr_concact/In12]
  connect_bd_net -net clink_uart_sout [get_bd_ports CLINK_UART_txd] [get_bd_pins clink_uart/sout]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_ports clk_mgt_init] [get_bd_pins MIG_Code/clk50] [get_bd_pins axi_quad_spi_0/ext_spi_clk] [get_bd_pins proc_sys_reset_1/slowest_sync_clk]
  connect_bd_net -net clk_wiz_1_clk_out1 [get_bd_ports clk_cal] [get_bd_pins MIG_Calibration/CLK_CAL] [get_bd_pins axi_peripheral/m_axi_aclk] [get_bd_pins clk_wiz_1/clk_out1]
  connect_bd_net -net clk_wiz_1_clk_out2 [get_bd_ports clk_data] [get_bd_pins MIG_Calibration/CLK_DATA] [get_bd_pins clk_wiz_1/clk_out2]
  connect_bd_net -net clk_wiz_2_locked [get_bd_pins clk_wiz_1/locked] [get_bd_pins proc_sys_reset_1/dcm_locked]
  connect_bd_net -net cooler_uart_ip2intc_irpt [get_bd_pins axi_ndf_uart/ip2intc_irpt] [get_bd_pins intr_concact/In0]
  connect_bd_net -net ext_reset_in_1 [get_bd_pins GND/dout] [get_bd_pins MIG_Calibration/sys_rst] [get_bd_pins MIG_Code/sys_rst] [get_bd_pins proc_sys_reset_1/aux_reset_in]
  connect_bd_net -net fpga_output_uart_ip2intc_irpt [get_bd_pins fpga_output_uart/ip2intc_irpt] [get_bd_pins intr_concact/In8]
  connect_bd_net -net fpga_output_uart_sout [get_bd_ports FPGA_UART_txd] [get_bd_pins fpga_output_uart/sout]
  connect_bd_net -net fw_uart_ip2intc_irpt [get_bd_pins fw_uart/ip2intc_irpt] [get_bd_pins intr_concact/In2]
  connect_bd_net -net fw_uart_sout [get_bd_ports FW_UART_txd] [get_bd_pins fw_uart/sout]
  connect_bd_net -net mcu_debug_sys_rst [get_bd_pins MCU/Debug_SYS_Rst] [get_bd_pins proc_sys_reset_1/mb_debug_sys_rst]
  create_bd_net microblaze_1_Clk
  connect_bd_net -net [get_bd_nets microblaze_1_Clk] [get_bd_ports clk_mb] [get_bd_pins FlashReset_0/m_axi_aclk] [get_bd_pins FlashReset_0/s_axi_aclk] [get_bd_pins MCU/Clk] [get_bd_pins MCU/S_AXI_ACLK] [get_bd_pins MIG_Calibration/CLK_MB] [get_bd_pins MIG_Code/CLK_MB] [get_bd_pins MIG_Code/ui_clk] [get_bd_pins axi_gpio_0/s_axi_aclk] [get_bd_pins axi_gps_uart/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_0/S01_ACLK] [get_bd_pins axi_lens_uart/s_axi_aclk] [get_bd_pins axi_ndf_uart/s_axi_aclk] [get_bd_pins axi_peripheral/aclk] [get_bd_pins axi_quad_spi_0/s_axi_aclk] [get_bd_pins axi_timer_0/s_axi_aclk] [get_bd_pins axi_usb_uart/s_axi_aclk] [get_bd_pins clink_uart/s_axi_aclk] [get_bd_pins clk_wiz_1/clk_in1] [get_bd_pins fpga_output_uart/s_axi_aclk] [get_bd_pins fw_uart/s_axi_aclk] [get_bd_pins oem_uart/s_axi_aclk] [get_bd_pins pleora_uart/s_axi_aclk] [get_bd_pins power_management/s_axi_aclk] [get_bd_pins xadc_wiz_1/s_axi_aclk]
  connect_bd_net -net microblaze_1_xlconcat_dout [get_bd_pins MCU/intr] [get_bd_pins intr_concact/dout]
  connect_bd_net -net oem_uart_ip2intc_irpt [get_bd_pins intr_concact/In13] [get_bd_pins oem_uart/ip2intc_irpt]
  connect_bd_net -net oem_uart_sout [get_bd_ports OEM_UART_txd] [get_bd_pins oem_uart/sout]
  connect_bd_net -net pleora_uart_ip2intc_irpt [get_bd_pins intr_concact/In9] [get_bd_pins pleora_uart/ip2intc_irpt]
  connect_bd_net -net pleora_uart_sout [get_bd_ports PLEORA_UART_SOUT] [get_bd_pins pleora_uart/sout]
  connect_bd_net -net proc_sys_reset_1_bus_struct_reset [get_bd_pins MCU/LMB_Rst] [get_bd_pins proc_sys_reset_1/bus_struct_reset]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins MIG_Calibration/INTERCONNECT_ARESETN] [get_bd_pins MIG_Code/INTERCONNECT_ARESETN] [get_bd_pins axi_peripheral/INTERCONNECT_ARESETN] [get_bd_pins proc_sys_reset_1/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_1_mb_reset [get_bd_pins MCU/Reset] [get_bd_pins proc_sys_reset_1/mb_reset]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_ports ARESETN] [get_bd_pins FlashReset_0/m_axi_aresetn] [get_bd_pins FlashReset_0/s_axi_aresetn] [get_bd_pins MCU/s_axi_aresetn] [get_bd_pins MIG_Calibration/PERIPHERAL_ARESETN] [get_bd_pins MIG_Code/PERIPHERAL_ARESETN] [get_bd_pins axi_gpio_0/s_axi_aresetn] [get_bd_pins axi_gps_uart/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_interconnect_0/S01_ARESETN] [get_bd_pins axi_lens_uart/s_axi_aresetn] [get_bd_pins axi_ndf_uart/s_axi_aresetn] [get_bd_pins axi_peripheral/PERIPHERAL_ARESETN] [get_bd_pins axi_quad_spi_0/s_axi_aresetn] [get_bd_pins axi_timer_0/s_axi_aresetn] [get_bd_pins axi_usb_uart/s_axi_aresetn] [get_bd_pins clink_uart/s_axi_aresetn] [get_bd_pins fpga_output_uart/s_axi_aresetn] [get_bd_pins fw_uart/s_axi_aresetn] [get_bd_pins oem_uart/s_axi_aresetn] [get_bd_pins pleora_uart/s_axi_aresetn] [get_bd_pins power_management/s_axi_aresetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn] [get_bd_pins xadc_wiz_1/s_axi_aresetn]
  connect_bd_net -net sin_1 [get_bd_ports GPS_UART_rxd] [get_bd_pins axi_gps_uart/sin]
  connect_bd_net -net sin_2 [get_bd_ports PLEORA_UART_SIN] [get_bd_pins pleora_uart/sin]
  connect_bd_net -net vcc_const [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins vcc/dout]
  connect_bd_net -net vn_in_1 [get_bd_ports vn_in] [get_bd_pins xadc_wiz_1/vn_in]
  connect_bd_net -net vp_in_1 [get_bd_ports vp_in] [get_bd_pins xadc_wiz_1/vp_in]
  connect_bd_net -net xadc_wiz_1_ip2intc_irpt [get_bd_pins intr_concact/In11] [get_bd_pins xadc_wiz_1/ip2intc_irpt]
  connect_bd_net -net xadc_wiz_1_temp_out [get_bd_pins MIG_Calibration/device_temp_i] [get_bd_pins MIG_Code/device_temp_i] [get_bd_pins xadc_wiz_1/temp_out]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x44B60000 [get_bd_addr_spaces FlashReset_0/m_axi] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs ADC_READOUT_CTRL/Reg] SEG_ADC_READOUT_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs AEC_CTRL/Reg] SEG_AEC_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A20000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs CALIBCONFIG_AXI/Reg] SEG_CALIBCONFIG_AXI_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A30000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs CALIB_RAM_AXI/Reg] SEG_CALIB_RAM_AXI_Reg
  create_bd_addr_seg -range 0x40000000 -offset 0x80000000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs MIG_Calibration/CAL_DDR_MIG/memmap/memaddr] SEG_CAL_DDR_MIG_memaddr
  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs EXPTIME_CTRL/Reg] SEG_EXPTIME_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs FAN_CTRL/Reg] SEG_FAN_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A60000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs FPA_CTRL/Reg] SEG_FPA_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44BF0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs FlashReset_0/s_axi/reg0] SEG_FlashReset_0_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A70000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs HEADER_CTRL/Reg] SEG_HEADER_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A80000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs IRIG_CTRL/Reg] SEG_IRIG_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A90000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs MGT_CTRL/Reg] SEG_MGT_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44AA0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs M_BUFFERING_CTRL/Reg] SEG_M_BUFFERING_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44AB0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs M_BUF_TABLE/Reg] SEG_M_BUF_TABLE_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44AC0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs M_BULK_AXI/Reg] SEG_M_BULK_AXI_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44AD0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs M_EHDRI_CTRL/Reg] SEG_M_EHDRI_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44AE0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs M_FLASHINTF_AXI/Reg] SEG_M_FLASHINTF_AXI_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44AF0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs M_FRAME_BUFFER_CTRL/Reg] SEG_M_FRAME_BUFFER_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B00000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs M_ICU_AXI/Reg] SEG_M_ICU_AXI_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B10000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs NLC_LUT_AXI/Reg] SEG_NLC_LUT_AXI_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B20000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs RQC_LUT_AXI/Reg] SEG_RQC_LUT_AXI_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B30000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs SFW_CTRL/Reg] SEG_SFW_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44C00000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs TRIGGER_CTRL/Reg] SEG_TRIGGER_CTRL_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs axi_gpio_0/S_AXI/Reg] SEG_axi_gpio_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B40000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs axi_gps_uart/S_AXI/Reg] SEG_axi_gps_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44BE0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs axi_lens_uart/S_AXI/Reg] SEG_axi_lens_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B50000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs axi_ndf_uart/S_AXI/Reg] SEG_axi_ndf_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B60000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41C00000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs axi_timer_0/S_AXI/Reg] SEG_axi_timer_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B70000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs axi_usb_uart/S_AXI/Reg] SEG_axi_usb_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44B80000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs clink_uart/S_AXI/Reg] SEG_clink_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00000000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs MCU/microblaze_1_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x44B90000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs fpga_output_uart/S_AXI/Reg] SEG_fpga_output_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44BA0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs fw_uart/S_AXI/Reg] SEG_fw_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x00000000 [get_bd_addr_spaces MCU/microblaze_1/Instruction] [get_bd_addr_segs MCU/microblaze_1_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00001000 -offset 0x41400000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs MCU/mdm_1/S_AXI/Reg] SEG_mdm_1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs MCU/microblaze_1_axi_intc/S_AXI/Reg] SEG_microblaze_1_axi_intc_Reg
  create_bd_addr_seg -range 0x10000000 -offset 0x70000000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs MIG_Code/mig_7series_0/memmap/memaddr] SEG_mig_7series_0_memaddr
  create_bd_addr_seg -range 0x10000000 -offset 0x70000000 [get_bd_addr_spaces MCU/microblaze_1/Instruction] [get_bd_addr_segs MIG_Code/mig_7series_0/memmap/memaddr] SEG_mig_7series_0_memaddr
  create_bd_addr_seg -range 0x00010000 -offset 0x44BB0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs oem_uart/S_AXI/Reg] SEG_oem_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44BC0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs pleora_uart/S_AXI/Reg] SEG_pleora_uart_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40010000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs power_management/S_AXI/Reg] SEG_power_management_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44BD0000 [get_bd_addr_spaces MCU/microblaze_1/Data] [get_bd_addr_segs xadc_wiz_1/s_axi_lite/Reg] SEG_xadc_wiz_1_Reg
  create_bd_addr_seg -range 0x40000000 -offset 0x80000000 [get_bd_addr_spaces MIG_Calibration/axi_datamover_ddrcal/Data_MM2S] [get_bd_addr_segs MIG_Calibration/CAL_DDR_MIG/memmap/memaddr] SEG_CAL_DDR_MIG_memaddr
  create_bd_addr_seg -range 0x40000000 -offset 0x80000000 [get_bd_addr_spaces MIG_Calibration/axi_dm_buffer/Data_MM2S] [get_bd_addr_segs MIG_Calibration/CAL_DDR_MIG/memmap/memaddr] SEG_CAL_DDR_MIG_memaddr
  create_bd_addr_seg -range 0x40000000 -offset 0x80000000 [get_bd_addr_spaces MIG_Calibration/axi_dm_buffer/Data_S2MM] [get_bd_addr_segs MIG_Calibration/CAL_DDR_MIG/memmap/memaddr] SEG_CAL_DDR_MIG_memaddr

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port EXPTIME_CTRL -pg 1 -y 1160 -defaultsOSRD
preplace port MUX_ADDR -pg 1 -y 1910 -defaultsOSRD
preplace port clk_data -pg 1 -y 3060 -defaultsOSRD
preplace port GPS_UART_txd -pg 1 -y 600 -defaultsOSRD
preplace port vp_in -pg 1 -y 2910 -defaultsOSRD
preplace port CLINK_UART_txd -pg 1 -y 960 -defaultsOSRD
preplace port USB_UART -pg 1 -y 3130 -defaultsOSRD
preplace port M_BUFFERING_CTRL -pg 1 -y 1140 -defaultsOSRD
preplace port vn_in -pg 1 -y 2890 -defaultsOSRD
preplace port BUTTON -pg 1 -y 1390 -defaultsOSRD
preplace port CLINK_UART_rxd -pg 1 -y 940 -defaultsOSRD
preplace port S_AXIS_S2MM_BUF -pg 1 -y 2250 -defaultsOSRD
preplace port M_AXIS_CALDDR_MM2S -pg 1 -y 2280 -defaultsOSRD
preplace port S_AXIS_USART -pg 1 -y 1980 -defaultsOSRD
preplace port M_FRAME_BUFFER_CTRL -pg 1 -y 1870 -defaultsOSRD
preplace port CALIBCONFIG_AXI -pg 1 -y 1370 -defaultsOSRD
preplace port TRIGGER_CTRL -pg 1 -y 1960 -defaultsOSRD
preplace port clk_mb -pg 1 -y 3220 -defaultsOSRD
preplace port FPGA_UART_rxd -pg 1 -y 1080 -defaultsOSRD
preplace port clk_irig -pg 1 -y 3450 -defaultsOSRD
preplace port LENS_UART_SIN -pg 1 -y 20 -defaultsOSRD
preplace port clk_cal -pg 1 -y 2710 -defaultsOSRD
preplace port POWER_GPIO -pg 1 -y 1890 -defaultsOSRD
preplace port AEC_CTRL -pg 1 -y 1100 -defaultsOSRD
preplace port GPS_UART_rxd -pg 1 -y 510 -defaultsOSRD
preplace port SYS_CLK_0 -pg 1 -y 2520 -defaultsOSRD
preplace port clk_mgt_init -pg 1 -y 3430 -defaultsOSRD
preplace port SYS_CLK_1 -pg 1 -y 2190 -defaultsOSRD
preplace port S_AXIS_S2MM_CMD_BUF -pg 1 -y 2270 -defaultsOSRD
preplace port M_BULK_AXI -pg 1 -y 1240 -defaultsOSRD
preplace port REV_GPIO -pg 1 -y 240 -defaultsOSRD
preplace port CODE_DDR -pg 1 -y 2570 -defaultsOSRD
preplace port MGT_CTRL -pg 1 -y 1450 -defaultsOSRD
preplace port M_AXIS_MM2S_BUF -pg 1 -y 2320 -defaultsOSRD
preplace port FAN_CTRL -pg 1 -y 1200 -defaultsOSRD
preplace port clk_200 -pg 1 -y 3410 -defaultsOSRD
preplace port CALIB_RAM_AXI -pg 1 -y 510 -defaultsOSRD
preplace port SFW_CTRL -pg 1 -y 2010 -defaultsOSRD
preplace port CAL_DDR -pg 1 -y 2260 -defaultsOSRD
preplace port OEM_UART_txd -pg 1 -y 1750 -defaultsOSRD
preplace port PLEORA_UART_SOUT -pg 1 -y 1580 -defaultsOSRD
preplace port RQC_LUT_AXI -pg 1 -y 2070 -defaultsOSRD
preplace port NDF_UART_rxd -pg 1 -y 1510 -defaultsOSRD
preplace port S_AXIS_CALDDR_MM2S_CMD -pg 1 -y 2210 -defaultsOSRD
preplace port M_AXIS_S2MM_STS_BUF -pg 1 -y 2360 -defaultsOSRD
preplace port AEC_INTC -pg 1 -y 1540 -defaultsOSRD
preplace port OEM_UART_rxd -pg 1 -y 1930 -defaultsOSRD
preplace port M_BUF_TABLE -pg 1 -y 1180 -defaultsOSRD
preplace port FPGA_UART_txd -pg 1 -y 1120 -defaultsOSRD
preplace port M_AXIS_MM2S_STS_BUF -pg 1 -y 2240 -defaultsOSRD
preplace port M_AXIS_USART -pg 1 -y 2050 -defaultsOSRD
preplace port S_AXIS_MM2S_CMD_BUF -pg 1 -y 2230 -defaultsOSRD
preplace port NLC_LUT_AXI -pg 1 -y 2340 -defaultsOSRD
preplace port M_ICU_AXI -pg 1 -y 1410 -defaultsOSRD
preplace port FPA_CTRL -pg 1 -y 1220 -defaultsOSRD
preplace port IRIG_CTRL -pg 1 -y 1430 -defaultsOSRD
preplace port LED_GPIO -pg 1 -y 220 -defaultsOSRD
preplace port LENS_UART_SOUT -pg 1 -y 110 -defaultsOSRD
preplace port ADC_READOUT_CTRL -pg 1 -y 490 -defaultsOSRD
preplace port M_AXIS_CALDDR_MM2S_STS -pg 1 -y 2300 -defaultsOSRD
preplace port NDF_UART_txd -pg 1 -y 1540 -defaultsOSRD
preplace port M_FLASHINTF_AXI -pg 1 -y 1280 -defaultsOSRD
preplace port QSPI -pg 1 -y 3280 -defaultsOSRD
preplace port M_EHDRI_CTRL -pg 1 -y 1260 -defaultsOSRD
preplace port FW_UART_txd -pg 1 -y 1490 -defaultsOSRD
preplace port FW_UART_rxd -pg 1 -y 1460 -defaultsOSRD
preplace port HEADER_CTRL -pg 1 -y 1390 -defaultsOSRD
preplace port PLEORA_UART_SIN -pg 1 -y 1870 -defaultsOSRD
preplace portBus bulk_interrupt -pg 1 -y 1580 -defaultsOSRD
preplace portBus ARESETN -pg 1 -y 470 -defaultsOSRD
preplace inst MCU -pg 1 -lvl 3 -y 2062 -defaultsOSRD
preplace inst FlashReset_0 -pg 1 -lvl 3 -y 1420 -defaultsOSRD
preplace inst vcc -pg 1 -lvl 1 -y 2340 -defaultsOSRD
preplace inst intr_concact -pg 1 -lvl 2 -y 1610 -defaultsOSRD
preplace inst axi_lens_uart -pg 1 -lvl 5 -y -480 -defaultsOSRD
preplace inst MIG_Calibration -pg 1 -lvl 5 -y 1550 -defaultsOSRD
preplace inst GND -pg 1 -lvl 1 -y 2430 -defaultsOSRD
preplace inst xadc_wiz_1 -pg 1 -lvl 5 -y 4740 -defaultsOSRD
preplace inst axi_ndf_uart -pg 1 -lvl 5 -y 520 -defaultsOSRD
preplace inst oem_uart -pg 1 -lvl 5 -y 800 -defaultsOSRD
preplace inst axi_timer_0 -pg 1 -lvl 5 -y -200 -defaultsOSRD
preplace inst axi_peripheral -pg 1 -lvl 4 -y 1404 -defaultsOSRD
preplace inst axi_gpio_0 -pg 1 -lvl 5 -y -350 -defaultsOSRD
preplace inst proc_sys_reset_1 -pg 1 -lvl 2 -y 2360 -defaultsOSRD
preplace inst axi_gps_uart -pg 1 -lvl 5 -y -40 -defaultsOSRD
preplace inst fw_uart -pg 1 -lvl 5 -y 380 -defaultsOSRD
preplace inst fpga_output_uart -pg 1 -lvl 5 -y 240 -defaultsOSRD
preplace inst axi_usb_uart -pg 1 -lvl 5 -y 4982 -defaultsOSRD
preplace inst MIG_Code -pg 1 -lvl 5 -y 4454 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 3 -y 1150 -defaultsOSRD
preplace inst clink_uart -pg 1 -lvl 5 -y 100 -defaultsOSRD
preplace inst pleora_uart -pg 1 -lvl 5 -y 660 -defaultsOSRD
preplace inst clk_wiz_1 -pg 1 -lvl 4 -y 10516 -defaultsOSRD
preplace inst power_management -pg 1 -lvl 5 -y 930 -defaultsOSRD
preplace inst axi_quad_spi_0 -pg 1 -lvl 5 -y 5142 -defaultsOSRD
preplace netloc axi_peripheral_M04_AXI1 1 4 2 NJ 1124 9260J
preplace netloc S_AXIS_MM2S_CMD_1 1 0 5 NJ 2210 NJ 2210 NJ 2210 NJ 2210 3070J
preplace netloc S00_AXI_2 1 2 3 540 1840 NJ 1840 2690
preplace netloc axi_ndf_uart_sout 1 5 1 9270
preplace netloc mig_7series_0_DDR3 1 5 1 9110J
preplace netloc S_AXIS_MM2S_CMD_2 1 0 5 NJ 2230 NJ 2230 NJ 2230 NJ 2230 3080J
preplace netloc axi_quad_spi_0_ip2intc_irpt 1 1 5 10 3860 NJ 3860 NJ 3860 NJ 3860 8900
preplace netloc microblaze_1_Clk 1 2 4 530 3220 1000 3220 2970 3220 8920J
preplace netloc mig_7series_0_DDR4 1 5 1 9010J
preplace netloc axi_peripheral_M_LENS_UART_AXI 1 4 1 2730
preplace netloc axi_peripheral_M14_AXI1 1 4 1 2780
preplace netloc axi_timer_0_interrupt 1 1 5 0 -170 NJ -170 NJ -170 2750J 1940 9010
preplace netloc axi_quad_spi_0_SPI_0 1 5 1 9340J
preplace netloc axi_peripheral_M_COOLER_UART 1 4 1 2770
preplace netloc MIG_Code_mmcm_locked 1 3 3 1010 4330 NJ 4330 8850
preplace netloc clk_wiz_2_locked 1 1 4 70 3880 NJ 3880 NJ 3880 2690
preplace netloc MIG_Code_clk20 1 5 1 9260
preplace netloc cooler_uart_ip2intc_irpt 1 1 5 60 550 NJ 550 NJ 550 3020J 1890 8890
preplace netloc clink_uart_sout 1 5 1 9300
preplace netloc OEM_UART_rxd_1 1 0 6 -260J 1920 NJ 1920 NJ 1920 NJ 1920 NJ 1920 8850
preplace netloc power_management_GPIO2 1 5 1 9180J
preplace netloc fpga_output_uart_ip2intc_irpt 1 1 5 30 270 NJ 270 NJ 270 3030J 1960 8990
preplace netloc axi_gpio_0_gpio 1 5 1 9330J
preplace netloc axi_protocol_converter_8_m_axi 1 4 2 2870J 1730 9080J
preplace netloc MIG_Calibration_M_AXIS_MM2S 1 5 1 9100J
preplace netloc axi_protocol_converter_2_m_axi 1 4 2 2830J 1170 9140J
preplace netloc axi_peripheral_m_pleora_axi 1 4 1 2890
preplace netloc axi_peripheral_M09_AXI 1 4 2 2950J 1060 9200J
preplace netloc axi_interconnect_0_M00_AXI1 1 3 2 980J 5112 NJ
preplace netloc xadc_wiz_1_temp_out 1 4 2 3140 4580 8850
preplace netloc vn_in_1 1 0 5 -270J 4730 NJ 4730 NJ 4730 NJ 4730 NJ
preplace netloc vp_in_1 1 0 5 -280J 4750 NJ 4750 NJ 4750 NJ 4750 NJ
preplace netloc axi_peripheral_M06_AXI 1 4 2 2940J 1320 9230J
preplace netloc axi_interconnect_1_m12_axi 1 4 1 2810
preplace netloc axi_peripheral_M_BULK_AXI 1 4 2 2920J 1240 NJ
preplace netloc axi_gpio_0_GPIO2 1 5 1 9320J
preplace netloc S_AXIS_S2MM_CMD_2 1 0 5 -260J 2240 NJ 2240 NJ 2240 NJ 2240 3100J
preplace netloc vcc_const 1 1 1 NJ
preplace netloc S01_AXI_1 1 3 2 NJ 2072 2710J
preplace netloc MIG_Calibration_M_AXIS_MM2S_STS1 1 5 1 9090J
preplace netloc mcu_debug_sys_rst 1 1 3 70 2270 NJ 2270 950
preplace netloc proc_sys_reset_1_bus_struct_reset 1 2 1 510
preplace netloc axi_peripheral_M05_AXI1 1 4 2 NJ 1264 9170J
preplace netloc NDF_UART_rxd_1 1 0 6 -260J 1880 NJ 1880 NJ 1880 NJ 1880 NJ 1880 8900
preplace netloc axi_usb_uart_ip2intc_irpt 1 1 5 20 3870 NJ 3870 NJ 3870 NJ 3870 8890
preplace netloc fw_uart_sout 1 5 1 9280
preplace netloc axi_usb_uart_uart 1 5 1 9160J
preplace netloc axi_peripheral_m_usbuart_axi 1 4 1 2740
preplace netloc axi_peripheral_M_FLASHRESET_AXI 1 2 3 550 1850 NJ 1850 2720
preplace netloc axi_peripheral_M_FLASHINTF_AXI 1 4 2 2850J 1280 NJ
preplace netloc axi_interconnect_0_m00_axi 1 4 1 2860
preplace netloc proc_sys_reset_1_mb_reset 1 2 1 520
preplace netloc axi_ndf_uart1_ip2intc_irpt 1 1 5 -10 -450 NJ -450 NJ -450 3050J 1930 9020
preplace netloc AEC_INTC_1 1 0 2 NJ 1540 NJ
preplace netloc axi_interconnect_1_m02_axi 1 4 1 2720
preplace netloc axi_peripheral_M15_AXI 1 4 2 3010J 1370 8860J
preplace netloc SYS_CLK_1 1 0 5 NJ 2190 NJ 2190 NJ 2190 NJ 2190 3060J
preplace netloc MIG_Calibration_M_AXIS_MM2S1 1 5 1 9050J
preplace netloc proc_sys_reset_1_interconnect_aresetn 1 2 3 NJ 2380 970 2380 3130
preplace netloc oem_uart_sout 1 5 1 9240
preplace netloc axi_peripheral_M_CALIB_RAM_AXI 1 4 2 NJ 1184 9130J
preplace netloc S_AXIS_S2MM_2 1 0 5 NJ 2250 NJ 2250 NJ 2250 NJ 2250 3090J
preplace netloc sin_1 1 0 6 NJ 510 NJ 510 NJ 510 NJ 510 2960J 1030 8950
preplace netloc MCU_Interrupt 1 1 3 70 2200 NJ 2200 940
preplace netloc fpga_output_uart_sout 1 5 1 9290
preplace netloc sin_2 1 0 6 -280J 1900 NJ 1900 NJ 1900 NJ 1900 NJ 1900 8880
preplace netloc axi_peripheral_M_FW_UART_AXI 1 4 1 2820
preplace netloc fw_uart_ip2intc_irpt 1 1 5 50 410 NJ 410 NJ 410 3000J 1970 8980
preplace netloc CLINK_UART_rxd_1 1 0 6 NJ 940 NJ 940 NJ 940 NJ 940 3060J 1000 8910
preplace netloc ext_reset_in_1 1 1 4 -10 4524 NJ 4524 NJ 4524 3120
preplace netloc axi_lens_uart_sout 1 5 1 9340J
preplace netloc axi_peripheral_M_AXI 1 4 2 N 1084 9120J
preplace netloc S0_AXIS_1 1 0 3 -280J 1982 NJ 1982 NJ
preplace netloc LENS_UART_SIN_1 1 0 6 NJ 20 NJ 20 NJ 20 NJ 20 3080J 1020 8970
preplace netloc power_management_GPIO 1 5 1 9210J
preplace netloc MCU_M0_AXIS 1 3 3 NJ 2012 NJ 2012 9040J
preplace netloc clink_uart_ip2intc_irpt 1 1 5 50 1860 NJ 1860 NJ 1860 NJ 1860 8930
preplace netloc RQC_LUT_AXI 1 4 2 2800J 2070 NJ
preplace netloc FlashReset_0_ip2intc_irpt 1 1 3 70 1310 NJ 1310 940
preplace netloc axi_gps_uart_sout 1 5 1 9310J
preplace netloc mcu_m_axi_dp 1 3 1 960
preplace netloc axi_peripheral_M05_AXI 1 4 2 2770J 1340 9190J
preplace netloc SYS_CLK_0_1 1 0 5 -260J 4384 NJ 4384 NJ 4384 NJ 4384 NJ
preplace netloc axi_uart16550_0_ip2intc_irpt 1 1 5 10 -10 NJ -10 NJ -10 3040J 1950 9000
preplace netloc axi_protocol_converter_4_m_axi 1 4 2 NJ 1744 9070J
preplace netloc axi_peripheral_m_fpgaout_axi 1 4 1 2790
preplace netloc FlashReset_0_m_axi 1 2 2 530 1000 950
preplace netloc s_axi1_1 1 2 3 510 950 NJ 950 2690
preplace netloc axi_protocol_converter_3_m_axi 1 4 2 2940J 1100 NJ
preplace netloc FW_UART_rxd_1 1 0 6 -280J 370 NJ 370 NJ 370 NJ 370 2700J 1870 8920
preplace netloc pleora_uart_sout 1 5 1 9250J
preplace netloc MIG_Calibration_M_AXIS_S2MM_STS1 1 5 1 9030J
preplace netloc oem_uart_ip2intc_irpt 1 1 5 60 1890 NJ 1890 NJ 1890 2780J 1980 8940
preplace netloc xadc_wiz_1_ip2intc_irpt 1 1 5 0 3890 NJ 3890 NJ 3890 NJ 3890 8880
preplace netloc microblaze_1_xlconcat_dout 1 2 1 490
preplace netloc axi_peripheral_M03_AXI 1 4 2 2930J 1140 NJ
preplace netloc FPGA_UART_rxd_1 1 0 6 -260J 920 NJ 920 NJ 920 NJ 920 3070J 1010 8870
preplace netloc clk_wiz_1_clk_out1 1 3 3 1010 960 2760 10496 9080J
preplace netloc axi_protocol_converter_1_m_axi 1 4 2 2950J 1350 9220J
preplace netloc axi_peripheral_M04_AXI 1 4 2 NJ 1304 9160J
preplace netloc MIG_Calibration_M_AXIS_MM2S_STS 1 5 1 9060J
preplace netloc clk_wiz_1_clk_out2 1 4 2 3110 10536 9280J
preplace netloc proc_sys_reset_1_peripheral_aresetn 1 2 4 500 2400 990 2400 2980 2400 9150J
preplace netloc axi_peripheral_M08_AXI 1 4 1 2990
preplace netloc axi_interconnect_1_m00_axi 1 4 1 2730
preplace netloc MIG_Code_clk200 1 5 1 9210
preplace netloc BUTTON_1 1 0 3 NJ 1390 NJ 1390 N
preplace netloc axi_protocol_converter_0_m_axi 1 4 2 2840J 1220 NJ
preplace netloc axi_peripheral_M_DDRMIG_AXI 1 4 1 2910
preplace netloc clk_wiz_0_clk_out3 1 1 5 60 4310 NJ 4310 NJ 4310 2840 4310 9230J
preplace netloc bulk_interrupt_1 1 0 2 NJ 1580 NJ
preplace netloc pleora_uart_ip2intc_irpt 1 1 5 40 690 NJ 690 NJ 690 2880J 1990 8960
preplace netloc s_axi_1 1 2 3 550 1910 NJ 1910 2710
preplace netloc axi_protocol_converter_7_m_axi 1 4 2 2800J 1160 8870J
preplace netloc axi_peripheral_M_ADC_READOUT_AXI 1 4 2 NJ 1044 9120J
preplace netloc axi_interconnect_1_m01_axi 1 4 1 2900
preplace netloc S00_AXI_1 1 3 2 NJ 2032 2750J
levelinfo -pg 1 -300 -70 330 800 2500 8633 10730 -top -550 -bot 11210
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


