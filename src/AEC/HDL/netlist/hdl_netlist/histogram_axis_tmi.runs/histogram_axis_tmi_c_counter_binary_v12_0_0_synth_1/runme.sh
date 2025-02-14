#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=D:/Xilinx/SDK/2013.4/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/lib/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/lib/nt64:D:/Xilinx/Vivado/2013.4/bin
else
  PATH=D:/Xilinx/SDK/2013.4/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/lib/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/lib/nt64:D:/Xilinx/Vivado/2013.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD=`dirname "$0"`
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log histogram_axis_tmi_c_counter_binary_v12_0_0.rds -m64 -mode batch -messageDb vivado.pb -source histogram_axis_tmi_c_counter_binary_v12_0_0.tcl
