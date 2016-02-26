#ifndef BUILDINFO_H
#define BUILDINFO_H

#define SVN_HARDWARE_REV      17885
#define SVN_SOFTWARE_REV      18119
#define SVN_BOOTLOADER_REV    18119
#define SVN_COMMON_REV        18087

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#endif
