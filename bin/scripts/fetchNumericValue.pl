#!/usr/local/bin/perl

use Getopt::Long;
my $inputfile;
my $fieldName;

GetOptions("if=s" => \$inputfile,
      "f=s" => \$fieldName)
   or die("Error in command line arguments\n");

local $/ = undef;
open(my $fh, "<", $inputfile)
   or die ("Can't open $inputfile\n");
my $inputStr = <$fh>;
close ($fh);

if ($inputStr =~ /$fieldName\D+(\d+)/)
{
   print $1;
}
