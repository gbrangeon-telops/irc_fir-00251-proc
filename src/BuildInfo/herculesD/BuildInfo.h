#ifndef BUILDINFO_H
#define BUILDINFO_H

#ifdef ARCH_FPGA_160

#define SVN_HARDWARE_REV      26938
#define SVN_SOFTWARE_REV      26940
#define SVN_BOOTLOADER_REV    26769
#define SVN_COMMON_REV        26738

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#define HARDWARE_MISMATCH (0)

#if HARDWARE_MISMATCH
#error D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_herculesD\hw_platform_160\system.hdf does not match D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_herculesD\fir_00251_proc_herculesD_160.hdf
#endif

#elif defined(ARCH_FPGA_325)

#define SVN_HARDWARE_REV      23419
#define SVN_SOFTWARE_REV      23419
#define SVN_BOOTLOADER_REV    25079
#define SVN_COMMON_REV        26738

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#define HARDWARE_MISMATCH (0)

#if HARDWARE_MISMATCH
#error D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_herculesD\hw_platform_325\system.hdf does not match D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_herculesD\fir_00251_proc_herculesD_325.hdf
#endif

#endif  // FPGA_ARCH Check

#endif // BUILDINFO_H
