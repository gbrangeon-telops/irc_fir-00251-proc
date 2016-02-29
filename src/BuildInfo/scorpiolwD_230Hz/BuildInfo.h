#ifndef BUILDINFO_H
#define BUILDINFO_H

#define SVN_HARDWARE_REV      17885
#define SVN_SOFTWARE_REV      17886
#define SVN_BOOTLOADER_REV    17818
#define SVN_COMMON_REV        18129

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#endif
