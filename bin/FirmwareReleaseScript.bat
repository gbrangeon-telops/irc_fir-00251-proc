@echo off

call %~dp0\scripts\setEnvironment.bat x x

call %x_xsct% %scriptsDir%\FirmwareReleaseScript.tcl