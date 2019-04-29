#!/usr/local/bin/perl

sub read_file {
   my($filename) = @_;
   
   local $/ = undef;
   open(my $fh, "<", $filename)
      or die ("Can't open $filename\n");
   my $fileStr = <$fh>;
   close ($fh);

   return $fileStr;
}

use Getopt::Long;
my $buildInfoFile;
my $outputReleaseInfoFile;
my $storageReleaseInfoFile1;
my $storageReleaseInfoFile2;
my $procReleaseInfoFile;
my $releaseLogFile;

GetOptions("bf=s" => \$buildInfoFile,
      "of=s" => \$outputReleaseInfoFile,
      "sf1=s" => \$storageReleaseInfoFile1,
	  "sf2=s" => \$storageReleaseInfoFile2,
      "pf=s" => \$procReleaseInfoFile,
      "rf=s" => \$releaseLogFile)
   or die("Error in command line arguments\n");

my $error = 0;

# Parse build info file
my $buildInfoFileStr = read_file($buildInfoFile);
my $buildInfoHardware;
my $buildInfoSoftware;
my $buildInfoBootLoader;
my $buildInfoCommon;

if ($buildInfoFileStr =~ /SVN_HARDWARE_REV[^\n\r0-9]+(\d+)/) { $buildInfoHardware = $1; } else { $error = 1; }
if ($buildInfoFileStr =~ /SVN_SOFTWARE_REV[^\n\r0-9]+(\d+)/) { $buildInfoSoftware = $1; } else { $error = 1; }
if ($buildInfoFileStr =~ /SVN_BOOTLOADER_REV[^\n\r0-9]+(\d+)/) { $buildInfoBootLoader = $1; } else { $error = 1; }
if ($buildInfoFileStr =~ /SVN_COMMON_REV[^\n\r0-9]+(\d+)/) { $buildInfoCommon = $1; } else { $error = 1; }

if ($error == 1)
{
   die("Cannot parse build info file\n");
}

# Parse output release info file
my $outputReleaseInfoFileStr = read_file($outputReleaseInfoFile);
my $outputReleaseInfoHardware;
my $outputReleaseInfoSoftware;
my $outputReleaseInfoBootLoader;
my $outputReleaseInfoCommon;

if ($outputReleaseInfoFileStr =~ /rel_out_hw_rev[^\n\r0-9]+(\d+)/) { $outputReleaseInfoHardware = $1; } else { $error = 1; }
if ($outputReleaseInfoFileStr =~ /rel_out_sw_rev[^\n\r0-9]+(\d+)/) { $outputReleaseInfoSoftware = $1; } else { $error = 1; }
if ($outputReleaseInfoFileStr =~ /rel_out_boot_rev[^\n\r0-9]+(\d+)/) { $outputReleaseInfoBootLoader = $1; } else { $error = 1; }
if ($outputReleaseInfoFileStr =~ /rel_out_common_rev[^\n\r0-9]+(\d+)/) { $outputReleaseInfoCommon = $1; } else { $error = 1; }

if ($error == 1)
{
   die("Cannot parse output release info file\n");
}

# Parse storage release info file
my $storageReleaseInfoFileStr1 = read_file($storageReleaseInfoFile1);
my $storageReleaseInfoHardware1;
my $storageReleaseInfoSoftware1;
my $storageReleaseInfoBootLoader1;
my $storageReleaseInfoCommon1;

my $storageReleaseInfoFileStr2 = read_file($storageReleaseInfoFile2);
my $storageReleaseInfoHardware2;
my $storageReleaseInfoSoftware2;
my $storageReleaseInfoBootLoader2;
my $storageReleaseInfoCommon2;

if ($storageReleaseInfoFileStr1 =~ /rel_storage_hw_rev1[^\n\r0-9]+(\d+)/) { $storageReleaseInfoHardware1 = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr1 =~ /rel_storage_sw_rev1[^\n\r0-9]+(\d+)/) { $storageReleaseInfoSoftware1 = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr1 =~ /rel_storage_boot_rev1[^\n\r0-9]+(\d+)/) { $storageReleaseInfoBootLoader1 = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr1 =~ /rel_storage_common_rev1[^\n\r0-9]+(\d+)/) { $storageReleaseInfoCommon1 = $1; } else { $error = 1; }

if ($storageReleaseInfoFileStr2 =~ /rel_storage_hw_rev2[^\n\r0-9]+(\d+)/) { $storageReleaseInfoHardware2 = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr2 =~ /rel_storage_sw_rev2[^\n\r0-9]+(\d+)/) { $storageReleaseInfoSoftware2 = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr2 =~ /rel_storage_boot_rev2[^\n\r0-9]+(\d+)/) { $storageReleaseInfoBootLoader2 = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr2 =~ /rel_storage_common_rev2[^\n\r0-9]+(\d+)/) { $storageReleaseInfoCommon2 = $1; } else { $error = 1; }

if ($error == 1)
{
   die("Cannot parse storage release info file\n");
}

# Parse proc release info file
my $procReleaseInfoFileStr = read_file($procReleaseInfoFile);
my $procReleaseInfoHardware;
my $procReleaseInfoSoftware;
my $procReleaseInfoBootLoader;
my $procReleaseInfoCommon;

if ($procReleaseInfoFileStr =~ /rel_proc_hw_rev[^\n\r0-9]+(\d+)/) { $procReleaseInfoHardware = $1; } else { $error = 1; }
if ($procReleaseInfoFileStr =~ /rel_proc_sw_rev[^\n\r0-9]+(\d+)/) { $procReleaseInfoSoftware = $1; } else { $error = 1; }
if ($procReleaseInfoFileStr =~ /rel_proc_boot_rev[^\n\r0-9]+(\d+)/) { $procReleaseInfoBootLoader = $1; } else { $error = 1; }
if ($procReleaseInfoFileStr =~ /rel_proc_common_rev[^\n\r0-9]+(\d+)/) { $procReleaseInfoCommon = $1; } else { $error = 1; }

if ($error == 1)
{
   die("Cannot parse proc release info file\n");
}

# Parse release log file
my $releaseLogFileStr = read_file($releaseLogFile);
my $releaseLogVersion;
my $releaseLogProcHardware;
my $releaseLogProcSoftware;
my $releaseLogProcBootLoader;
my $releaseLogProcCommon;
my $releaseLogOutputHardware;
my $releaseLogOutputSoftware;
my $releaseLogOutputBootLoader;
my $releaseLogOutputCommon;
my $releaseLogStorageHardware1;
my $releaseLogStorageSoftware1;
my $releaseLogStorageBootLoader1;
my $releaseLogStorageCommon1;
my $releaseLogStorageHardware2;
my $releaseLogStorageSoftware2;
my $releaseLogStorageBootLoader2;
my $releaseLogStorageCommon2;


if ($releaseLogFileStr =~ /Firmware release version[^\n\r0-9]+([\d\.]+)/) { $releaseLogVersion = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA hardware[^\n\r0-9]+(\d+)/) { $releaseLogProcHardware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA software[^\n\r0-9]+(\d+)/) { $releaseLogProcSoftware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA boot loader[^\n\r0-9]+(\d+)/) { $releaseLogProcBootLoader = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA common[^\n\r0-9]+(\d+)/) { $releaseLogProcCommon = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA hardware[^\n\r0-9]+(\d+)/) { $releaseLogOutputHardware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA software[^\n\r0-9]+(\d+)/) { $releaseLogOutputSoftware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA boot loader[^\n\r0-9]+(\d+)/) { $releaseLogOutputBootLoader = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA common[^\n\r0-9]+(\d+)/) { $releaseLogOutputCommon = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA hardware 16GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageHardware1 = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA software 16GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageSoftware1 = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA boot loader 16GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageBootLoader1 = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA common repository 16GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageCommon1 = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA hardware 32GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageHardware2 = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA software 32GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageSoftware2 = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA boot loader 32GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageBootLoader2 = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA common repository 32GB[^\n\r0-9]+(\d+)/) { $releaseLogStorageCommon2 = $1; } else { $error = 1; }

if ($error == 1)
{
   die("Cannot parse release log file\n");
}

# Verify proc relase info file
if (($procReleaseInfoHardware ne $buildInfoHardware) ||
   ($procReleaseInfoSoftware ne $buildInfoSoftware) || 
   ($procReleaseInfoBootLoader ne $buildInfoBootLoader) || 
   ($procReleaseInfoCommon ne $buildInfoCommon))
{
   die("Processing FPGA relase info does not match build info\n");
}

# Verify relase log file
if (($procReleaseInfoHardware ne $releaseLogProcHardware) ||
   ($procReleaseInfoSoftware ne $releaseLogProcSoftware) || 
   ($procReleaseInfoBootLoader ne $releaseLogProcBootLoader) || 
   ($procReleaseInfoCommon ne $releaseLogProcCommon))
{
   die("Processing FPGA relase info does not release log file\n");
}

if (($outputReleaseInfoHardware ne $releaseLogOutputHardware) ||
   ($outputReleaseInfoSoftware ne $releaseLogOutputSoftware) || 
   ($outputReleaseInfoBootLoader ne $releaseLogOutputBootLoader) || 
   ($outputReleaseInfoCommon ne $releaseLogOutputCommon))
{
   die("Output FPGA relase info does not release log file\n");
}

if (($storageReleaseInfoHardware1 ne $releaseLogStorageHardware1) ||
   ($storageReleaseInfoSoftware1 ne $releaseLogStorageSoftware1) || 
   ($storageReleaseInfoBootLoader1 ne $releaseLogStorageBootLoader1) || 
   ($storageReleaseInfoCommon1 ne $releaseLogStorageCommon1) ||
   ($storageReleaseInfoHardware2 ne $releaseLogStorageHardware2) ||
   ($storageReleaseInfoSoftware2 ne $releaseLogStorageSoftware2) || 
   ($storageReleaseInfoBootLoader2 ne $releaseLogStorageBootLoader2) || 
   ($storageReleaseInfoCommon2 ne $releaseLogStorageCommon2))
{
   die("Storage FPGA relase info does not correspond to release log file\n");
}

print("$releaseLogVersion (Passed)\n");
