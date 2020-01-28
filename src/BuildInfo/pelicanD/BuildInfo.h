#ifndef BUILDINFO_H
#define BUILDINFO_H

#ifdef ARCH_FPGA_160

#define SVN_HARDWARE_REV      24841
#define SVN_SOFTWARE_REV      24833
#define SVN_BOOTLOADER_REV    24832
#define SVN_COMMON_REV        24839

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#define HARDWARE_MISMATCH (0)

#if HARDWARE_MISMATCH
#error D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_pelicanD\hw_platform_160\system.hdf does not match D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_pelicanD\fir_00251_proc_pelicanD_160.hdf
#endif

#elif defined(ARCH_FPGA_325)

#define SVN_HARDWARE_REV      23419
#define SVN_SOFTWARE_REV      23419
#define SVN_BOOTLOADER_REV    23419
#define SVN_COMMON_REV        24839

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#define HARDWARE_MISMATCH (0)

#if HARDWARE_MISMATCH
#error D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_pelicanD\hw_platform_325\system.hdf does not match D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_pelicanD\fir_00251_proc_pelicanD_325.hdf
#endif

#endif  // FPGA_ARCH Check

#endif // BUILDINFO_H
