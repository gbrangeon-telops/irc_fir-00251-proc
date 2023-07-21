    
#Argument check
if { $argc != 1 } {
	error "The getEncryptationStatus.tcl script requires three argument <scriptsDir> <fpga_size> <sensor_name>"
} else {
	set mcsDir [lindex $argv 0 ]

}

#generate CLI file using mcs
set mcsFile [open ${mcsDir} r]

while {[gets $mcsFile line] != -1} {
    if {[string match "*3000A001*" $line]} {
        set index [string first "3000A001" $line]
        set variable [string range $line [expr {$index + 8}] [expr {$index + 15}]]
    }
}
#example : 80000040
#puts "Les 32 bits apres'3000A001' sont : $variable"
set binaryVariable [binary format H* $variable]
set binaryValue [binary scan $binaryVariable B8 bits]
set sixthBit [expr {($binaryValue & 0b00100000) >> 5}]
#puts "Le 6eme bit de $variable est $sixthBit"
if {$sixthBit == 1} {
    puts "ENCRYPTED"
} else {
    puts "NONE"
} 
    
close $mcsFile