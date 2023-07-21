
#!/usr/bin/tclsh

proc usage {} {
    puts "Usage: setRecordS0.tcl <inputfile> <s0text> <outputFile>"
}

proc toHex {text} {
    set hexString ""
    foreach char [split $text ""] {
        append hexString [format "%02X" [scan $char %c]]
    }
    return $hexString
}

proc hexToDec {hex} { 
    set decimal 0 
    foreach digit [split $hex ""] { 
        set decimal [expr {16 * $decimal + [scan $digit %x]}] 
    } 
    return $decimal
}

proc generate_tempS0 {inputfile s0text outputFile} {

    if {$inputfile == "" || $s0text == "" || $outputFile == ""} {
        usage
        exit 1
    }

    set ifh [open $inputfile r]
    set ofh [open $outputFile w]

    # Write S0 record
    #set s0rec [format "S0%02X0000%s" [expr {[string length $s0text] + 3}] [string toupper [binary encode hex $s0text]]]
    set s0rec [format "S0%02X0000%s" [expr {[string length $s0text] + 3}] [toHex $s0text]]
    set checksum 0

    for {set i 2} {$i < [string length $s0rec]} {incr i 2} {
        set value [string range $s0rec $i [expr {$i+1}]]
        set intValue [hexToDec $value]
        set checksum [expr {$checksum +  [hexToDec $value]}]
    }

    set checksum [expr {$checksum % 256}]
    set checksum [expr {255 - $checksum}]

    set s0rec [format "%s%02X\n" $s0rec $checksum]
    #set s0rec [format "%s%02X\n" $s0rec [hexToDec $checksum]]
    puts -nonewline $ofh $s0rec

    # Copy other records
    while {[gets $ifh row] != -1} {
        if {[string range $row 0 1] ne "S0"} {
            #puts -nonewline $ofh $row
            puts $ofh $row
        }
    }

    close $ofh
    close $ifh
}

