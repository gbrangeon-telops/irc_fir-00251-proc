set base_dir "d:/Telops/fir-00251-Proc"
set detector_list ""

#Enable release build configuration to ignore possible debug cores
set release 1

#Select Detector to build

lappend detector_list {blackbird1280D325}

lappend detector_list {blackbird1520D325}

lappend detector_list {blackbird1920D325}

#lappend detector_list {calcium640D325}

lappend detector_list {hawkA160}

lappend detector_list {herculesD160}

lappend detector_list {isc0207A160}

lappend detector_list {isc0207A_3k325}

lappend detector_list {isc0209A160}

lappend detector_list {isc0804A325}

lappend detector_list {isc0804A_500Hz325}

#lappend detector_list {isc0804A_2k325}

lappend detector_list {pelicanD160}

lappend detector_list {scorpiolwD_230Hz160}

lappend detector_list {scorpiomwA160}

lappend detector_list {scorpiomwA_300Hz160}

lappend detector_list {startup160}
lappend detector_list {startup325}
lappend detector_list {startup_4DDR325}

lappend detector_list {suphawkA325}

lappend detector_list {xro3503A325}

#lappend detector_list {mockfpa325}

#DO NOT MODIFY BEYOND THIS POINT

#Import build fonction
source $base_dir/scripts/create_build_project.tcl

foreach detector $detector_list {
	create_build_project $detector $release
}
