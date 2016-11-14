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
my $storageReleaseInfoFile;
my $procReleaseInfoFile;
my $releaseLogFile;

GetOptions("bf=s" => \$buildInfoFile,
      "of=s" => \$outputReleaseInfoFile,
      "sf=s" => \$storageReleaseInfoFile,
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
my $storageReleaseInfoFileStr = read_file($storageReleaseInfoFile);
my $storageReleaseInfoHardware;
my $storageReleaseInfoSoftware;
my $storageReleaseInfoBootLoader;
my $storageReleaseInfoCommon;

if ($storageReleaseInfoFileStr =~ /rel_storage_hw_rev[^\n\r0-9]+(\d+)/) { $storageReleaseInfoHardware = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr =~ /rel_storage_sw_rev[^\n\r0-9]+(\d+)/) { $storageReleaseInfoSoftware = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr =~ /rel_storage_boot_rev[^\n\r0-9]+(\d+)/) { $storageReleaseInfoBootLoader = $1; } else { $error = 1; }
if ($storageReleaseInfoFileStr =~ /rel_storage_common_rev[^\n\r0-9]+(\d+)/) { $storageReleaseInfoCommon = $1; } else { $error = 1; }

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
my $releaseLogStorageHardware;
my $releaseLogStorageSoftware;
my $releaseLogStorageBootLoader;
my $releaseLogStorageCommon;

if ($releaseLogFileStr =~ /Firmware release version[^\n\r0-9]+([\d\.]+)/) { $releaseLogVersion = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA hardware[^\n\r0-9]+(\d+)/) { $releaseLogProcHardware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA software[^\n\r0-9]+(\d+)/) { $releaseLogProcSoftware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA boot loader[^\n\r0-9]+(\d+)/) { $releaseLogProcBootLoader = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Processing FPGA common[^\n\r0-9]+(\d+)/) { $releaseLogProcCommon = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA hardware[^\n\r0-9]+(\d+)/) { $releaseLogOutputHardware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA software[^\n\r0-9]+(\d+)/) { $releaseLogOutputSoftware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA boot loader[^\n\r0-9]+(\d+)/) { $releaseLogOutputBootLoader = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Output FPGA common[^\n\r0-9]+(\d+)/) { $releaseLogOutputCommon = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA hardware[^\n\r0-9]+(\d+)/) { $releaseLogStorageHardware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA software[^\n\r0-9]+(\d+)/) { $releaseLogStorageSoftware = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA boot loader[^\n\r0-9]+(\d+)/) { $releaseLogStorageBootLoader = $1; } else { $error = 1; }
if ($releaseLogFileStr =~ /Storage FPGA common[^\n\r0-9]+(\d+)/) { $releaseLogStorageCommon = $1; } else { $error = 1; }

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

if (($storageReleaseInfoHardware ne $releaseLogStorageHardware) ||
   ($storageReleaseInfoSoftware ne $releaseLogStorageSoftware) || 
   ($storageReleaseInfoBootLoader ne $releaseLogStorageBootLoader) || 
   ($storageReleaseInfoCommon ne $releaseLogStorageCommon))
{
   die("Storage FPGA relase info does not release log file\n");
}

print("$releaseLogVersion (Passed)\n");
