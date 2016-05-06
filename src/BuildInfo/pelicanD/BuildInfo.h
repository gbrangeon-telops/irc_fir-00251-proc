#ifndef BUILDINFO_H
#define BUILDINFO_H

#define SVN_HARDWARE_REV      18406
#define SVN_SOFTWARE_REV      18503
#define SVN_BOOTLOADER_REV    18503
#define SVN_COMMON_REV        18684

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#define HARDWARE_MISMATCH (0)

#if HARDWARE_MISMATCH
#error D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_pelicanD\hw_platform_0\fir_00251_proc_pelicanD.bit does not match D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_pelicanD\hw\fir_00251_proc_pelicanD.bit.
#endif

#endif // BUILDINFO_H
