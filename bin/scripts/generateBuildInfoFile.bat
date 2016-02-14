rem Clean up
del %buildInfoFile%

echo #ifndef BUILDINFO_H> %buildInfoFile%
echo #define BUILDINFO_H>> %buildInfoFile%
echo.>> %buildInfoFile%

% rem Get hardware revision
echo #define SVN_HARDWARE_REV      $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %bitFile% %buildInfoFile% %buildInfoFile%

% rem Get software revision
echo #define SVN_SOFTWARE_REV      $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %elfFile% %buildInfoFile% %buildInfoFile%

% rem Get boot loader revision
echo #define SVN_BOOTLOADER_REV    $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %bootFile% %buildInfoFile% %buildInfoFile%

% rem Get common directory revision
echo #define SVN_COMMON_REV        $WCMODS?-:$$WCREV$>> %buildInfoFile%
%svn_subwcrev% %commonDir% %buildInfoFile% %buildInfoFile%

% rem Check for uncommitted changes
echo.>> %buildInfoFile%
echo #define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV ^< 0) ^|^| (SVN_SOFTWARE_REV ^< 0) ^|^| (SVN_BOOTLOADER_REV ^< 0) ^|^| (SVN_COMMON_REV ^< 0))>> %buildInfoFile%
echo.>> %buildInfoFile%
echo #if SVN_UNCOMMITTED_CHANGES>> %buildInfoFile%
echo #warning Uncommitted changes detected.>> %buildInfoFile%
echo #endif>> %buildInfoFile%
echo.>> %buildInfoFile%
echo #endif>> %buildInfoFile%
