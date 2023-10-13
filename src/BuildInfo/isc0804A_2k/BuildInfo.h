#ifndef BUILDINFO_H
#define BUILDINFO_H

#ifdef ARCH_FPGA_160

#define SVN_HARDWARE_REV      29088
#define SVN_SOFTWARE_REV      29100
#define SVN_BOOTLOADER_REV    29088
#define SVN_COMMON_REV        29125

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#define HARDWARE_MISMATCH (1)

#if HARDWARE_MISMATCH
#error D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_isc0804A_2k\hw_platform_160\system.hdf does not match D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_isc0804A_2k\fir_00251_proc_isc0804A_2k_160.hdf
#endif

#elif defined(ARCH_FPGA_325)

#define SVN_HARDWARE_REV      -29130
#define SVN_SOFTWARE_REV      -29100
#define SVN_BOOTLOADER_REV    29130
#define SVN_COMMON_REV        29125

#define SVN_UNCOMMITTED_CHANGES  ((SVN_HARDWARE_REV < 0) || (SVN_SOFTWARE_REV < 0) || (SVN_BOOTLOADER_REV < 0) || (SVN_COMMON_REV < 0))

#if SVN_UNCOMMITTED_CHANGES
#warning Uncommitted changes detected.
#endif

#define HARDWARE_MISMATCH (0)

#if HARDWARE_MISMATCH
#error D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_isc0804A_2k\hw_platform_325\system.hdf does not match D:\Telops\FIR-00251-Proc\sdk\fir_00251_proc_isc0804A_2k\fir_00251_proc_isc0804A_2k_325.hdf
#endif

#endif  // FPGA_ARCH Check

#endif // BUILDINFO_H
