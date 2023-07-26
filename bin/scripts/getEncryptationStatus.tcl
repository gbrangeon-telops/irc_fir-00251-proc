    
#Argument check
if { $argc != 1 } {
	error "The getEncryptationStatus.tcl script requires three argument <scriptsDir> <fpga_size> <sensor_name>"
} else {
	set mcsDir [lindex $argv 0 ]

}

#generate CLI file using mcs
set mcsFile [open ${mcsDir} r]
set registerIsAfter 0
while {[gets $mcsFile line] != -1} {
    if {$registerIsAfter == 0} {
        if {[string match "*3000A001*" $line]} {
            set index [string first "3000A001" $line]
            #get the 8 bits after 3000A001
            set variable [string range $line [expr {$index + 8}] [expr {$index + 15}]]
            #case register is in the other line
            if {[string length $variable] != 8} {
                #puts "Register est dans lautre ligne"
                set registerIsAfter 1
            } else {
                #variable is correctly set 
                #puts "Register est dans la meme ligne"
                break
            }
        }
    } else {
        set variable [string range $line [expr {9}] [expr {16}]]
        break
    }

}

#puts "Les 32 bits apres'3000A001' sont : $variable"
binary scan [binary format H* $variable] B* bits
set sixthBit [expr {($bits & 0b01000000) >> 6}]
#puts "Le 6eme bit de $variable est $sixthBit"
if {$sixthBit == 1} {
    puts "ENCRYPTED"
} else {
    puts "NONE"
} 
    
close $mcsFile