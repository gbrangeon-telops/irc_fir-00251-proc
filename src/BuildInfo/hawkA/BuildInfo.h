#ifndef BUILDINFO_H
#define BUILDINFO_H

#define SVN_HARDWARE_REV      17968
#define SVN_SOFTWARE_REV      17969
#define SVN_BOOTLOADER_REV    17902
#define SVN_COMMON_REV        -18019

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#endif
