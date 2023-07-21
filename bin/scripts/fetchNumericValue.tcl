proc usage {} {
    puts "Usage: fetchNumericValue.tcl -if <inputfile> -f <fieldName>"
}

set inputfile ""
set fieldName ""

while {[llength $argv] > 0} {
    switch -- [lindex $argv 0] {
    "-if" {
        set inputfile [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-f" {
        set fieldName [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    default {
        puts [lindex $argv 0]
        usage
        error "Error in command line arguments"
        }
    }
}

set fp [open $inputfile r]
set inputStr [read $fp]
close $fp

if {[regexp "$fieldName=(\\d+)" $inputStr match number]} {
    puts $number
} elseif {[regexp "$fieldName\\s+(\\d+)" $inputStr match number]} {
    puts $number
} else {
    puts 0
}
