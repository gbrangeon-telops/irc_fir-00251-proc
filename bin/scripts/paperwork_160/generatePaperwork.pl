#!/usr/local/bin/perl

my $proc_versions;
my $output_versions;
my $storage_versions;
my $template_dir;
my $sensor;
my $encrypt_key_name;
my $xmlver;
my $flashsettingsver;
my $flashdynamicvaluesver;
my $version;

use Getopt::Long;
GetOptions("xml=s" => \$xmlver,
      "fs=s" => \$flashSettingsver,
      "fdv=s" => \$flashdynamicvaluesver,
      "cal=s" => \$calibver,
      "sensor=s" => \$sensor,
      "key=s" => \$encrypt_key_name,
      "version=s" => \$version,
      "proc_revs=s" => \$proc_versions,
      "output_revs=s" => \$output_versions,
      "storage_revs1=s" => \$storage_versions1,
      "storage_revs2=s" => \$storage_versions2,
      "template_dir=s" => \$template_dir)
   or die("Error in command line arguments\n");

my $sharedStringsFile = "$template_dir\\xl\\sharedStrings.xml";

print "proc_versions = $proc_versions\n";
print "output_versions = $output_versions\n";
print "storage_versions1 = $storage_versions1\n";
print "storage_versions2 = $storage_versions2\n";
print "template_dir = $template_dir\n";
print "sharedStringsFile = $sharedStringsFile\n";
print "sensor = $sensor\n";
print "xmlver = $xmlver\n";
print "version = $version\n";

require $proc_versions;
require $output_versions;
require $storage_versions1;
require $storage_versions2;

open(my $fh, ">:raw", $sharedStringsFile)
   or die ("Can't open $sharedStringsFile\n");

use POSIX qw(strftime);

my $date = strftime "%Y-%m-%d", localtime;
print $date;

print $fh "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
print $fh "<sst xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\" count=\"30\" uniqueCount=\"27\">";
print $fh "<si><t>FPGA</t></si>";
print $fh "<si><t>Board</t></si>";
print $fh "<si><t>Component</t></si>";
print $fh "<si><t>Version #</t></si>";
print $fh "<si><t>Date</t></si>";
print $fh "<si><t>Release number</t></si>";
print $fh "<si><t>Assembly</t></si>";
print $fh "<si><t>SN</t></si>";
print $fh "<si><t>Fait Par</t></si>";
print $fh "<si><t>Détecteur</t></si>";
print $fh "<si><t>EFA-00251-x01</t></si>";
print $fh "<si><t>Acquisition Board</t></si>";
print $fh "<si><t>NTx-Mini</t></si>";
print $fh "<si><t>FPGA Processing (xc7k160t)</t></si>";
print $fh "<si><t>FPGA Output (xc7k70t)</t></si>";
print $fh "<si><t>XML $xmlver</t></si>";
print $fh "<si><t>H: $rel_out_hw_rev, S: $rel_out_sw_rev, B: $rel_out_boot_rev, C: $rel_out_common_rev</t></si>";
print $fh "<si><t>$version</t></si>";
print $fh "<si><t>$sensor</t></si>";
print $fh "<si><t>$date</t></si>";
print $fh "<si><t>Storage Board</t></si>";
print $fh "<si><t>EFA-00257-001</t></si>";
print $fh "<si><t>FPGA Storage (xc7k160t)</t></si>";
print $fh "<si><t>H1: $rel_storage_hw_rev1, S1: $rel_storage_sw_rev1, B1: $rel_storage_boot_rev1, C1: $rel_storage_common_rev1, H2: $rel_storage_hw_rev2, S2: $rel_storage_sw_rev2, B2: $rel_storage_boot_rev2, C2: $rel_storage_common_rev2</t></si>";
print $fh "<si><t>H: $rel_proc_hw_rev, S: $rel_proc_sw_rev, B: $rel_proc_boot_rev, C: $rel_proc_common_rev, FS: $flashSettingsver, FDV: $flashdynamicvaluesver, CAL: $calibver</t></si>";
print $fh "<si><t>Encryption key</t></si>";
print $fh "<si><t>$encrypt_key_name</t></si></sst>";

close ($fh);
