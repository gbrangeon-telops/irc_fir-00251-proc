#!/usr/local/bin/perl

# Release information version
my $relInfoVersionMajor = 2;
my $relInfoVersionMinor = 2;
my $relInfoVersionSubMinor = 0;

use Getopt::Long;
my $firmwareVersionMajor;
my $firmwareVersionMinor;
my $firmwareVersionSubMinor;
my $firmwareVersionBuild;
my $procRevFile;
my $outputRevFile;
my $storageRevFile1;
my $storageRevFile2;
my $releaseFile;
my $releaseLogFile;

GetOptions("fa=i" => \$firmwareVersionMajor,
      "fi=i" => \$firmwareVersionMinor,
      "fs=i" => \$firmwareVersionSubMinor,
      "fb=i" => \$firmwareVersionBuild,
      "p=s" => \$procRevFile,
      "o=s" => \$outputRevFile,
	  "s1=s" => \$storageRevFile1,
	  "s2=s" => \$storageRevFile2,
      "release=s" => \$releasefile,
      "log=s" => \$releaseLogfile)
   or die("Error in command line arguments\n");

print "Creating release $firmwareVersionMajor.$firmwareVersionMinor.$firmwareVersionSubMinor.$firmwareVersionBuild\n";

# Release revision numbers
our $rel_proc_hw_rev;
our $rel_proc_sw_rev;
our $rel_proc_boot_rev;
our $rel_proc_common_rev;
our $rel_out_hw_rev;
our $rel_out_sw_rev;
our $rel_out_boot_rev;
our $rel_out_common_rev;
our $rel_storage_hw_rev1;
our $rel_storage_sw_rev1;
our $rel_storage_boot_rev1;
our $rel_storage_common_rev1;
our $rel_storage_hw_rev2;
our $rel_storage_sw_rev2;
our $rel_storage_boot_rev2;
our $rel_storage_common_rev2;


require $procRevFile;
require $outputRevFile;
require $storageRevFile1;
require $storageRevFile2;

my $relInfolength = 0;

# Update release file
open(my $fh, ">:raw", $releasefile)
   or die ("Can't open $releasefile\n");

# Skip release information length field
$relInfolength += 4;
seek($fh, $relInfolength, SEEK_SET); 

# Write release information version fields
print $fh pack('I', $relInfoVersionMajor); $relInfolength += 4;
print $fh pack('I', $relInfoVersionMinor); $relInfolength += 4;
print $fh pack('I', $relInfoVersionSubMinor); $relInfolength += 4;

# Write release firmware version fields
print $fh pack('I', $firmwareVersionMajor); $relInfolength += 4;
print $fh pack('I', $firmwareVersionMinor); $relInfolength += 4;
print $fh pack('I', $firmwareVersionSubMinor); $relInfolength += 4;
print $fh pack('I', $firmwareVersionBuild); $relInfolength += 4;

# Write release revision numbers fields
print $fh pack('I', $rel_proc_hw_rev); $relInfolength += 4;
print $fh pack('I', $rel_proc_sw_rev); $relInfolength += 4;
print $fh pack('I', $rel_proc_boot_rev); $relInfolength += 4;
print $fh pack('I', $rel_proc_common_rev); $relInfolength += 4;
print $fh pack('I', $rel_out_hw_rev); $relInfolength += 4;
print $fh pack('I', $rel_out_sw_rev); $relInfolength += 4;
print $fh pack('I', $rel_out_boot_rev); $relInfolength += 4;
print $fh pack('I', $rel_out_common_rev); $relInfolength += 4;
print $fh pack('I', $rel_storage_hw_rev1); $relInfolength += 4;
print $fh pack('I', $rel_storage_sw_rev1); $relInfolength += 4;
print $fh pack('I', $rel_storage_boot_rev1); $relInfolength += 4;
print $fh pack('I', $rel_storage_common_rev1); $relInfolength += 4;
print $fh pack('I', $rel_storage_hw_rev2); $relInfolength += 4;
print $fh pack('I', $rel_storage_sw_rev2); $relInfolength += 4;
print $fh pack('I', $rel_storage_boot_rev2); $relInfolength += 4;
print $fh pack('I', $rel_storage_common_rev2); $relInfolength += 4;


# Write release information length field
seek($fh, 0, SEEK_SET);
print $fh pack('I', $relInfolength);

close ($fh);

# Write log file
open(my $lfh, ">:encoding(UTF-8)", $releaseLogfile)
   or die ("Can't open $releaseLogfile\n");

print $lfh sprintf("Release information file structure version: %d.%d.%d\n", $relInfoVersionMajor, $relInfoVersionMinor, $relInfoVersionSubMinor);
print $lfh sprintf("Release information file length: %d bytes\n", $relInfolength);
print $lfh sprintf("Firmware release version: %d.%d.%d.%d\n", $firmwareVersionMajor, $firmwareVersionMinor, $firmwareVersionSubMinor, $firmwareVersionBuild);
   
print $lfh sprintf("Processing FPGA hardware SVN revision: %d\n", $rel_proc_hw_rev);
print $lfh sprintf("Processing FPGA software SVN revision: %d\n", $rel_proc_sw_rev);
print $lfh sprintf("Processing FPGA boot loader SVN revision: %d\n", $rel_proc_boot_rev);
print $lfh sprintf("Processing FPGA common repository SVN revision: %d\n", $rel_proc_common_rev);

print $lfh sprintf("Output FPGA hardware SVN revision: %d\n", $rel_out_hw_rev);
print $lfh sprintf("Output FPGA software SVN revision: %d\n", $rel_out_sw_rev);
print $lfh sprintf("Output FPGA boot loader SVN revision: %d\n", $rel_out_boot_rev);
print $lfh sprintf("Output FPGA common repository SVN revision: %d\n", $rel_out_common_rev);

print $lfh sprintf("Storage FPGA hardware 16GB SVN revision: %d\n", $rel_storage_hw_rev1);
print $lfh sprintf("Storage FPGA software 16GB SVN revision: %d\n", $rel_storage_sw_rev1);
print $lfh sprintf("Storage FPGA boot loader 16GB SVN revision: %d\n", $rel_storage_boot_rev1);
print $lfh sprintf("Storage FPGA common repository 16GB SVN revision: %d\n", $rel_storage_common_rev1);

print $lfh sprintf("Storage FPGA hardware 32GB SVN revision: %d\n", $rel_storage_hw_rev2);
print $lfh sprintf("Storage FPGA software 32GB SVN revision: %d\n", $rel_storage_sw_rev2);
print $lfh sprintf("Storage FPGA boot loader 32GB SVN revision: %d\n", $rel_storage_boot_rev2);
print $lfh sprintf("Storage FPGA common repository 32GB SVN revision: %d\n", $rel_storage_common_rev2);

close ($lfh);
