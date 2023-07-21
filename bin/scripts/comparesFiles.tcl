proc usage {} {
    puts "Usage: comparesFiles.tcl -f1 <file1> -f2 <file2>"
}

set file1 ""
set file2 ""

while {[llength $argv] > 0} {
    switch -- [lindex $argv 0] {
        "-f1" {
            set file1 [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        "-f2" {
            set file2 [lindex $argv 1]
            set argv [lrange $argv 2 end]
        }
        default {
            usage
            error "Error in command line arguments"
        }
    }
}

set fp1 [open $file1 r]
set fp2 [open $file2 r]

set content1 [read $fp1]
set content2 [read $fp2]

close $fp1
close $fp2

if {$content1 eq $content2} {
    exit 0
} else {
    exit 1
}

