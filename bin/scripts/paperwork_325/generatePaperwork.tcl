proc usage {} {
    #note : see switch case line 20
    puts "Usage: generatePaperwork.tcl -xml <xmlver> -fs <flashSettingsver> ... "
}

set proc_versions ""
set output_versions ""
set storage_versions ""
set template_dir ""
set sensor ""
set encrypt_key_name ""
set xmlver ""
set flashsettingsver ""
set flashdynamicvaluesver ""
set version ""

#set argv [lassign $argv _]

while {[llength $argv] > 0} {
    switch -- [lindex $argv 0] {
    "-xml" {
        set xmlver [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-x" {
        set xmlver [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-fs" {
        set flashSettingsver [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-fdv" {
        set flashdynamicvaluesver [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-cal" {
        set calibver [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-sensor" {
        set sensor [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-key" {
        set encrypt_key_name [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-version" {
        set version [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-v" {
        set version [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-proc_revs" {
        set proc_versions [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-p" {
        set proc_versions [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-output_revs" {
        set output_versions [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-o" {
        set output_versions [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-storage_revs1" {
        set storage_versions1 [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-storage_revs2" {
        set storage_versions2 [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-template_dir" {
        set template_dir [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    "-t" {
        set template_dir [lindex $argv 1]
        set argv [lrange $argv 2 end]
    }
    default {
        usage
        puts [lindex $argv 0] 
        error "Error in command line arguments"
        }
    }
}

set sharedStringsFile = "$template_dir\\xl\\sharedStrings.xml";
puts "proc_versions = $proc_versions"
puts "output_versions = $output_versions"
puts "storage_versions1 = $storage_versions1"
puts "storage_versions2 = $storage_versions2"
puts "template_dir = $template_dir"
puts "sharedStringsFile = $sharedStringsFile"
puts "sensor = $sensor"
puts "xmlver = $xmlver"
puts "version = $version"

#require
source $proc_versions 
source $output_versions
source $storage_versions1 
source $storage_versions2 

set fh [open $sharedStringsFile w]
set date [clock format [clock seconds] -format %Y-%m-%d]
puts $fh "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>"
puts $fh "<sst xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\" count=\"30\" uniqueCount=\"27\">"
puts $fh "<si><t>FPGA</t></si>"
puts $fh "<si><t>Board</t></si>"
puts $fh "<si><t>Component</t></si>"
puts $fh "<si><t>Version #</t></si>"
puts $fh "<si><t>Date</t></si>"
puts $fh "<si><t>Release number</t></si>"
puts $fh "<si><t>Assembly</t></si>"
puts $fh "<si><t>SN</t></si>"
puts $fh "<si><t>Fait Par</t></si>"
puts $fh "<si><t>Détecteur</t></si>"
puts $fh "<si><t>EFA-00251-x03</t></si>"
puts $fh "<si><t>Acquisition Board</t></si>"
puts $fh "<si><t>NTx-Mini</t></si>"
puts $fh "<si><t>FPGA Processing (xc7k325t)</t></si>"
puts $fh "<si><t>FPGA Output (xc7k160t)</t></si>"
puts $fh "<si><t>XML $xmlver</t></si>"
puts $fh "<si><t>H: $rel_out_hw_rev, S: $rel_out_sw_rev, B: $rel_out_boot_rev, C: $rel_out_common_rev</t></si>"
puts $fh "<si><t>$version</t></si>"
puts $fh "<si><t>$sensor</t></si>"
puts $fh "<si><t>$date</t></si>"
puts $fh "<si><t>Storage Board</t></si>"
puts $fh "<si><t>EFA-00257-001</t></si>"
puts $fh "<si><t>FPGA Storage (xc7k160t)</t></si>"
puts $fh "<si><t>H1: $rel_storage_hw_rev1, S1: $rel_storage_sw_rev1, B1: $rel_storage_boot_rev1, C1: $rel_storage_common_rev1, H2: $rel_storage_hw_rev2, S2: $rel_storage_sw_rev2, B2: $rel_storage_boot_rev2, C2: $rel_storage_common_rev2</t></si>"
puts $fh "<si><t>H: $rel_proc_hw_rev, S: $rel_proc_sw_rev, B: $rel_proc_boot_rev, C: $rel_proc_common_rev, FS: $flashSettingsver, FDV: $flashdynamicvaluesver, CAL: $calibver</t></si>"
puts $fh "<si><t>Encryption key</t></si>"
puts $fh "<si><t>$encrypt_key_name</t></si></sst>"
close $fh