#!/usr/local/bin/perl

use Getopt::Long;
use File::Compare;
my $file1;
my $file2;

GetOptions("f1=s" => \$file1,
      "f2=s" => \$file2)
   or die("Error in command line arguments\n");

if (compare($file1, $file2) != 0)
{
   exit(1);
}
else
{
   exit(0);
}
