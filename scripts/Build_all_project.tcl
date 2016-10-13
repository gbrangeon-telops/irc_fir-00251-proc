set base_dir "d:/Telops/fir-00251-Proc"

#Build project HawkA
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/hawkA_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/hawkA/fir_00251_proc_hawkA_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/hawkA/fir_00251_proc_hawkA_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/hawkA/fir_00251_proc_hawkA_utilization_placed.rpt
report_utilization -file $base_dir/Reports/hawkA/fir_00251_proc_hawkA_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/hawkA/fir_00251_proc_hawkA.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/hawkA/fir_00251_proc_hawkA.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_hawkA
exec $base_dir/scripts/updateHwSvnRev.bat hawkA
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project HerculesD
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/herculesD_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/herculesD/fir_00251_proc_herculesD_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/herculesD/fir_00251_proc_herculesD_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/herculesD/fir_00251_proc_herculesD_utilization_placed.rpt
report_utilization -file $base_dir/Reports/herculesD/fir_00251_proc_herculesD_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/herculesD/fir_00251_proc_herculesD.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/herculesD/fir_00251_proc_herculesD.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_herculesD
exec $base_dir/scripts/updateHwSvnRev.bat herculesD
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project Isc0207A
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/isc0207A_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/isc0207A/fir_00251_proc_isc0207A_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/isc0207A/fir_00251_proc_isc0207A_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/isc0207A/fir_00251_proc_isc0207A_utilization_placed.rpt
report_utilization -file $base_dir/Reports/isc0207A/fir_00251_proc_isc0207A_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/isc0207A/fir_00251_proc_isc0207A.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/isc0207A/fir_00251_proc_isc0207A.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_isc0207A
exec $base_dir/scripts/updateHwSvnRev.bat isc0207A
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project Isc0209A
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/isc0209A_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/isc0209A/fir_00251_proc_isc0209A_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/isc0209A/fir_00251_proc_isc0209A_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/isc0209A/fir_00251_proc_isc0209A_utilization_placed.rpt
report_utilization -file $base_dir/Reports/isc0209A/fir_00251_proc_isc0209A_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/isc0209A/fir_00251_proc_isc0209A.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/isc0209A/fir_00251_proc_isc0209A.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_isc0209A
exec $base_dir/scripts/updateHwSvnRev.bat isc0209A
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project MarsD
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/marsD_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/marsD/fir_00251_proc_marsD_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/marsD/fir_00251_proc_marsD_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/marsD/fir_00251_proc_marsD_utilization_placed.rpt
report_utilization -file $base_dir/Reports/marsD/fir_00251_proc_marsD_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/marsD/fir_00251_proc_marsD.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/marsD/fir_00251_proc_marsD.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_marsD
exec $base_dir/scripts/updateHwSvnRev.bat marsD
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project PelicanD
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/pelicanD_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/pelicanD/fir_00251_proc_pelicanD_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/pelicanD/fir_00251_proc_pelicanD_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/pelicanD/fir_00251_proc_pelicanD_utilization_placed.rpt
report_utilization -file $base_dir/Reports/pelicanD/fir_00251_proc_pelicanD_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/pelicanD/fir_00251_proc_pelicanD.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/pelicanD/fir_00251_proc_pelicanD.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_pelicanD
exec $base_dir/scripts/updateHwSvnRev.bat pelicanD
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project 

#Build project ScorpiolwD
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/scorpiolwD_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/scorpiolwD/fir_00251_proc_scorpiolwD_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/scorpiolwD/fir_00251_proc_scorpiolwD_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiolwD/fir_00251_proc_scorpiolwD_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiolwD/fir_00251_proc_scorpiolwD_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/scorpiolwD/fir_00251_proc_scorpiolwD.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/scorpiolwD/fir_00251_proc_scorpiolwD.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_scorpiolwD
exec $base_dir/scripts/updateHwSvnRev.bat scorpiolwD
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project ScorpiolwD_230Hz
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/scorpiolwD_230Hz_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/scorpiolwD_230Hz/fir_00251_proc_scorpiolwD_230Hz_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/scorpiolwD_230Hz/fir_00251_proc_scorpiolwD_230Hz_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiolwD_230Hz/fir_00251_proc_scorpiolwD_230Hz_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiolwD_230Hz/fir_00251_proc_scorpiolwD_230Hz_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/scorpiolwD_230Hz/fir_00251_proc_scorpiolwD_230Hz.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/scorpiolwD_230Hz/fir_00251_proc_scorpiolwD_230Hz.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_scorpiolwD_230Hz
exec $base_dir/scripts/updateHwSvnRev.bat scorpiolwD_230Hz
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project ScorpiomwA
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/scorpiomwA_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/scorpiomwA/fir_00251_proc_scorpiomwA_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/scorpiomwA/fir_00251_proc_scorpiomwA_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiomwA/fir_00251_proc_scorpiomwA_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiomwA/fir_00251_proc_scorpiomwA_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/scorpiomwA/fir_00251_proc_scorpiomwA.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/scorpiomwA/fir_00251_proc_scorpiomwA.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_scorpiomwA
exec $base_dir/scripts/updateHwSvnRev.bat scorpiomwA
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project

#Build project ScorpiomwD
file attributes $base_dir/xilinx/ -readonly 0
source $base_dir/scripts/scorpiomwD_project.tcl
#Use release target constraints file
set_property is_enabled false [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 *release_target.xdc] [current_fileset -constrset]
#generate bitstream
launch_runs impl_1 -to_step write_bitstream
#wait for run end
wait_on_run impl_1
#open implemented design
open_run impl_1
#Save Report
report_timing_summary -file $base_dir/Reports/scorpiomwD/fir_00251_proc_scorpiomwD_timing_summary_routed.rpt
report_clock_utilization -file $base_dir/Reports/scorpiomwD/fir_00251_proc_scorpiomwD_clock_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiomwD/fir_00251_proc_scorpiomwD_utilization_placed.rpt
report_utilization -file $base_dir/Reports/scorpiomwD/fir_00251_proc_scorpiomwD_utilization_placed_hier.rpt -hierarchical -hierarchical_depth 5
#Open Block diagram
open_bd_design $base_dir/xilinx/scorpiomwD/fir_00251_proc_scorpiomwD.srcs/sources_1/bd/core/core.bd
#Export hardware for sdk
export_hardware [get_files $base_dir/xilinx/scorpiomwD/fir_00251_proc_scorpiomwD.srcs/sources_1/bd/core/core.bd] [get_runs impl_1] -bitstream -dir $base_dir/sdk/fir_00251_proc_scorpiomwD
exec $base_dir/scripts/updateHwSvnRev.bat scorpiomwD
#Change back target constraints file
set_property is_enabled true [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc]
set_property target_constrs_file [get_files -of_objects constrs_1 -filter {NAME !~ "*release*"} *target.xdc] [current_fileset -constrset]
# End of this build
close_project
