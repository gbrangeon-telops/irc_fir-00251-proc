#!/usr/local/bin/perl

use Getopt::Long;
my $bitfile;
my $elffile;
my $bootfile;
my $commondir;
my $releasefile;

GetOptions("inputfile=s" => \$inputfile,
      "text=s" => \$s0text,
      "outpuFile=s" => \$outpuFile)
   or die("Error in command line arguments\n");

open(my $ifh, "<:encoding(UTF-8)", $inputfile)
   or die ("Can't open $inputfile\n");

open(my $ofh, ">:encoding(UTF-8)", $outpuFile)
   or die ("Can't open $outpuFile\n");

# Write S0 record
my $s0rec = sprintf("S0%02X0000%s", length($s0text) + 3, uc(unpack("H*",  $s0text)));

my $checksum = 0;
for (my $i = 2; $i < length($s0rec); $i += 2)
{
   $checksum += hex(substr($s0rec, $i, 2)); 
}
$checksum %= 256;
$checksum = 255 - $checksum;

$s0rec = sprintf("%s%02X\n", $s0rec, $checksum);
print $ofh "$s0rec";

# Copy other records
while (my $row = <$ifh>)
{
   if (substr($row, 0 ,2) ne "S0")
   {
      print $ofh "$row";
   }
}

close ($ofh);

close ($ifh);
