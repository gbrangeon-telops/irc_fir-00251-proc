rem Clean up
del %revFile%

echo our $rel_proc_hw_rev = $WCREV$;> %revFile%
%svn_subwcrev% %hwFile% %revFile% %revFile%

echo our $rel_proc_sw_rev = $WCREV$;>> %revFile%
%svn_subwcrev% %elfFile% %revFile% %revFile%

echo our $rel_proc_boot_rev = $WCREV$;>> %revFile%
%svn_subwcrev% %bootFile% %revFile% %revFile%

echo our $rel_proc_common_rev = $WCREV$;>> %revFile%
%svn_subwcrev% %commonDir% %revFile% %revFile%

echo 1;>> %revFile%