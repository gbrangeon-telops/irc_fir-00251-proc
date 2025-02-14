//
// Vivado(TM)
// rundef.js: a Vivado-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.
//

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "D:/Xilinx/SDK/2013.4/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/lib/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/lib/nt64;D:/Xilinx/Vivado/2013.4/bin;";
} else {
  PathVal = "D:/Xilinx/SDK/2013.4/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/EDK/lib/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/bin/nt64;D:/Xilinx/Vivado/2013.4/ids_lite/ISE/lib/nt64;D:/Xilinx/Vivado/2013.4/bin;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


ISEStep( "vivado",
         "-log histogram_axis_tmi_c_counter_binary_v12_0_0.rds -m64 -mode batch -messageDb vivado.pb -source histogram_axis_tmi_c_counter_binary_v12_0_0.tcl" );



function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
