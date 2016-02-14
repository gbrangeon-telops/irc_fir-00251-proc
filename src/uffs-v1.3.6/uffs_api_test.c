/**
 * \file uffs_api_test.c
 * \brief example for using/testing uffs file system
 * \author Francois Duchesneau, 2014-08-01
 */

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include "uffs_config.h"
#include "uffs/uffs_public.h"
#include "uffs/uffs_fs.h"
#include "uffs/uffs_utils.h"
#include "uffs/uffs_core.h"
#include "uffs/uffs_mtb.h"
#include "uffs/uffs_find.h"
#include "uffs/uffs_fd.h"
#include "uffs/uffs_mtb.h"
#include "utils.h"
#include <stdint.h>

#define PFX "cmd : "

#define MAX_PATH_LENGTH 128

#define MSGLN(msg,...) uffs_Perror(UFFS_MSG_NORMAL, msg, ## __VA_ARGS__)
#define MSG(msg,...) uffs_PerrorRaw(UFFS_MSG_NORMAL, msg, ## __VA_ARGS__)

#define CLI_INVALID_ARG			-100

#ifdef SHOW_LOW_ACCESS
extern int trace;

extern volatile int Total_Nand_read_full;
extern volatile int Total_Nand_read_partial;
extern volatile int Total_Nand_write;
extern volatile int Total_Nand_erase;
extern volatile int Total_Nand_check;
#endif




/** mount partition or show mounted partitions
 *		mount [<mount>]
 */
static int cmd_mount(int argc, char *argv[])
{
	uffs_MountTable *tab;
	const char *mount = NULL;

	if (argc == 1) {
		tab = uffs_MtbGetMounted();
		while (tab) {
			MSG(" %s : (%d) ~ (%d)\n", tab->mount, tab->start_block, tab->end_block);
			tab = tab->next;
		}
	}
	else {
		mount = argv[1];
		if (uffs_Mount(mount) < 0) {
			MSGLN("Can't mount %s", mount);
			return -1;
		}
	}
	return 0;
}

/* test create file, write file and read back */
static int cmd_t1(int argc, char *argv[])
{
	int fd;
	URET ret;
	char buf[100];
	const char *name;

	if (argc < 2) {
		return CLI_INVALID_ARG;
	}

	name = argv[1];

	fd = uffs_open(name, UO_RDWR|UO_CREATE|UO_TRUNC);
	if (fd < 0) {
		MSGLN("Can't open %s", name);
		goto fail;
	}
	if (argc > 2) {
		if (strcmp(argv[2], "1") == 0) {
			sprintf(buf, "abcdefghijklmnopqrstuvwxyz");
		}
		else {
			sprintf(buf, "ABCDEFGHIJKLMNOPQRSTUVWXYZ");
		}
	}
	else {
		sprintf(buf, "123456789ABCDEF");
	}
	ret = uffs_write(fd, buf, strlen(buf));
	MSGLN("write %d bytes to file, content: %s", ret, buf);

	ret = uffs_seek(fd, 3, USEEK_SET);
	MSGLN("new file position: %d", ret);

	memset(buf, 0, sizeof(buf));
	ret = uffs_read(fd, buf, 5);
	MSGLN("read %d bytes, content: %s", ret, buf);

	uffs_close(fd);

	return 0;
fail:

	return -1;
}

#define READ_SIZE 8192
//#define READ_SIZE 2048
//u8 buflargeread[READ_SIZE] __attribute__ ((section (".bram_section"))); // large buffer for large file test
//u8 buflargewrite[READ_SIZE] __attribute__ ((section (".bram_section"))); // large buffer for large file test
u8 buflargeread[READ_SIZE]; // large buffer for large file test
u8 buflargewrite[READ_SIZE]; // large buffer for large file test
/* test read back file from created from t1*/
static int cmd_t2(int argc, char *argv[])
{
	int fd;
	URET ret;
	//char buf[101], buf2[101];
	const char *name;
   uint64_t tic = 0;

	if (argc < 2) {
		return CLI_INVALID_ARG;
	}

	name = argv[1];
	printf("Reading (%s)\n", name);

	fd = uffs_open(name, UO_RDONLY);
	if (fd < 0) {
		MSGLN("Can't open %s", name);
		goto fail;
	}
	//buf2[0] = 0;
   GETTIME(&tic);
	do {
		ret = uffs_read(fd, buflargeread, READ_SIZE);
		if (ret > 0){
			//buf[ret] = 0;
			//memcpy(buf2, buf, 100); // keep previous line
			/*if (memcmp(buflargeread, buflargewrite, sizeof(buflargewrite)) != 0) {
				printf("buflargeread != buflargewrite\r\n");
			}*/
		}
		else{
			//buf[0] = 0;
		}
		//MSGLN("read %d bytes, content: (%s)", ret, buf);
	}while(ret == READ_SIZE);
	//MSGLN("read %d bytes, content: (%s)", ret, buf2); // print last line only
	uffs_close(fd);
   printf("elapsed_time_us read (tic) = %lld\r\n", elapsed_time_us(tic));

	return 0;
fail:

	return -1;
}

/**
 * usage: t_pfs <start> <n>
 *
 * for example: t_pfs /x/ 100
 *
 * This test case performs:
 *   1) create <n> files under <start>, write full file name as file content
 *   2) list files under <start>, check files are all listed once
 *   3) check file content aganist file name
 *   4) delete files on success
 */
static int cmd_TestPopulateFiles(int argc, char *argv[])
{
	const char *start = "/";
	int count = 80;
	int i, fd, num;
	char name[128];
	char buf[128];
	uffs_DIR *dirp;
	struct uffs_dirent *ent;
	unsigned long bitmap[50] = {0};	// one bit per file, maximu 32*50 = 1600 files
	UBOOL succ = U_TRUE;

#define SBIT(n) bitmap[(n)/(sizeof(bitmap[0]) * 8)] |= (1 << ((n) % (sizeof(bitmap[0]) * 8)))
#define GBIT(n) (bitmap[(n)/(sizeof(bitmap[0]) * 8)] & (1 << ((n) % (sizeof(bitmap[0]) * 8))))

	if (argc > 1) {
		start = argv[1];
		if (argc > 2) {
			count = strtol(argv[2], NULL, 10);
		}
	}

	if (count > sizeof(bitmap) * 8)
		count = sizeof(bitmap) * 8;

	for (i = 0, fd = -1; i < count; i++) {
		sprintf(name, "%sFile%03d", start, i);
		fd = uffs_open(name, UO_RDWR|UO_CREATE|UO_TRUNC);
		if (fd < 0) {
			MSGLN("Create file %s failed", name);
			break;
		}
		if (uffs_write(fd, name, strlen(name)) != strlen(name)) { // write full path name to file
			MSGLN("Write to file %s failed", name);
			uffs_close(fd);
			break;
		}
		uffs_close(fd);
	}

	if (i < count) {
		// not success, need to clean up
		for (; i >= 0; i--) {
			sprintf(name, "%sFile%03d", start, i);
			if (uffs_remove(name) < 0)
				MSGLN("Delete file %s failed", name);
		}
		succ = U_FALSE;
		goto ext;
	}

	MSGLN("%d files created.", count);

	// list files
	dirp = uffs_opendir(start);
	if (dirp == NULL) {
		MSGLN("Can't open dir %s !", start);
		succ = U_FALSE;
		goto ext;
	}
	ent = uffs_readdir(dirp);
	while (ent && succ) {

		if (!(ent->d_type & FILE_ATTR_DIR) &&					// not a dir
			ent->d_namelen == strlen("File000") &&				// check file name length
			memcmp(ent->d_name, "File", strlen("File")) == 0) {	// file name start with "File"

			MSGLN("List entry %s", ent->d_name);

			num = strtol(ent->d_name + 4, NULL, 10);
			if (GBIT(num)) {
				// file already listed ?
				MSGLN("File %d listed twice !", ent->d_name);
				succ = U_FALSE;
				break;
			}
			SBIT(num);

			// check file content
			sprintf(name, "%s%s", start, ent->d_name);
			fd = uffs_open(name, UO_RDONLY);
			if (fd < 0) {
				MSGLN("Open file %d for read failed !", name);
			}
			else {
				memset(buf, 0, sizeof(buf));
				num = uffs_read(fd, buf, sizeof(buf));
				if (num != strlen(name)) {
					MSGLN("%s Read data length expect %d but got %d !", name, strlen(name), num);
					succ = U_FALSE;
				}
				else {
					if (memcmp(name, buf, num) != 0) {
						MSGLN("File %s have wrong content '%s' !", name, buf);
						succ = U_FALSE;
					}
				}
				uffs_close(fd);
			}
		}
		ent = uffs_readdir(dirp);
	}
	uffs_closedir(dirp);

	// check absent files
	for (i = 0; i < count; i++) {
		if (GBIT(i) == 0) {
			sprintf(name, "%sFile%03d", start, i);
			MSGLN("File %s not listed !", name);
			succ = U_FALSE;
		}
	}
#if 1
	// delete files if pass the test
	for (i = 0; succ && i < count; i++) {
		sprintf(name, "%sFile%03d", start, i);
		if (uffs_remove(name) < 0) {
			MSGLN("Delete file %s failed", name);
			succ = U_FALSE;
		}
	}
#endif

ext:
	MSGLN("Populate files test %s !", succ ? "SUCC" : "FAILED");
	return succ ? 0 : -1;

}

#ifdef PERFORMANCE_LOW
static int cmd_t10(int argc, char *argv[])
{
	return -1;
}

#else


/* test create large file*/
static int cmd_t10(int argc, char *argv[])
{
	int fd;
	int i;
	// int j;
	// char buf[100];
	// char line[10];
	// char *s;
	// char *d;
	const char *name;
	uint64_t tic = 0;

	if (argc < 2) {
		return CLI_INVALID_ARG;
	}

	name = argv[1];
	printf("Creating (%s)\n", name);

	fd = uffs_open(name, UO_RDWR|UO_CREATE|UO_TRUNC);
	if (fd < 0) {
		MSGLN("Can't open %s", name);
		goto fail;
	}

/*	for (i = 0; i < 100; i++){
		buf[i] = i+0x21;
	}
	buf[99] = 0;
	j = 0;*/
	for (i = 0; i < READ_SIZE; i++){
		buflargewrite[i] = i % 255;
	}

	//for (i = 0; i < (1250); i++){		//10Mbytes
	//for (i = 0; i < (2500); i++){		//20Mbytes
   GETTIME(&tic);
   printf("start 40MBytes test\r\n");
	for (i = 0; i < (5120); i++){		//40Mbytes
	//for (i = 0; i < (10000); i++){	//80Mbytes
	//for (i = 0; i < (65000); i++){		//500Mbytes
		if (uffs_write(fd, buflargewrite, READ_SIZE) != READ_SIZE) {
			MSGLN("Write to file %s failed", name);
			uffs_close(fd);
			goto fail;
		}
#ifdef SHOW_LOW_ACCESS
		//printf("%03d F:%d, P:%d, W:%d, E:%d\n",i, Total_Nand_read_full, Total_Nand_read_partial, Total_Nand_write, Total_Nand_erase);
#endif


		/*
		sprintf(line, "%09d", i);
		s = line;
		d = buf;
		while(*s) {
			*d++ = *s++;
		}
		if (uffs_write(fd, buf, 100) != 100) {
			MSGLN("Write to file %s failed", name);
			uffs_close(fd);
			goto fail;
		}
		*/
	}

   printf("elapsed_time_us(tic) write = %lld\r\n", elapsed_time_us(tic));
	uffs_close(fd);

	return 0;
fail:
	return -1;
}
#endif

static char *argv1[] =  {"uffs_api_test", "\0"};
static char *argv2[] =  {"uffs_api_test", "/cs0/file_test1", "1", "\0"};
static char *argv3[] =  {"uffs_api_test", "/cs0/", "\0"};
static char *argv4[] =  {"uffs_api_test", "/cs0/file_test_large", "\0"};
static char *argv5[] =  {"uffs_api_test", "/cs1/file_test2", "2", "\0"};

int uffs_api_test(int iOption){
	int ret = 0;
	printf("uffs_version: %d\n", uffs_version());
#ifdef SHOW_LOW_ACCESS
	trace = 1;
	Total_Nand_read_full = 0;
	Total_Nand_read_partial = 0;
	Total_Nand_write = 0;
	Total_Nand_erase = 0;
	Total_Nand_check = 0;
#endif
#if 1
	printf("cs0 total:%ld\n", uffs_space_total("/cs0/"));
	printf("cs0 used:%ld\n", uffs_space_used("/cs0/"));
	printf("cs0 free:%ld\n", uffs_space_free("/cs0/"));
#endif
	ret = cmd_mount(1, argv1); // list mount partition
	printf("cmd_mount ret:%d\n", ret);
	switch(iOption) {
	case 0: // simple small file test
		ret = cmd_t1(2, argv2);
		printf("cmd_t1 ret:%d\n", ret);

		ret = cmd_t2(2, argv2);
		printf("cmd_t2 ret:%d\n", ret);
		if (uffs_remove( argv2[1]) < 0) {
			MSGLN("Delete file %s failed",  argv2[1]);
		}
	break;
	case 1: // large file test
		ret = cmd_t10(2, argv4);
		printf("cmd_t10 ret:%d\n", ret);
#if 1
#ifdef SHOW_LOW_ACCESS
		printf("Total_Nand_read F:%d, P:%d\n",Total_Nand_read_full, Total_Nand_read_partial);
		printf("Total_Nand_write:%d\n",Total_Nand_write);
		printf("Total_Nand_erase:%d\n",Total_Nand_erase);
		printf("Total_Nand_check:%d\n",Total_Nand_check);
		Total_Nand_read_full = 0;
		Total_Nand_read_partial = 0;
		Total_Nand_write = 0;
		Total_Nand_erase = 0;
		Total_Nand_check = 0;
#endif
		printf("cs0 total:%ld\n", uffs_space_total("/cs0/"));
		printf("cs0 used:%ld\n", uffs_space_used("/cs0/"));
		printf("cs0 free:%ld\n", uffs_space_free("/cs0/"));
#endif
		ret = cmd_t2(2, argv4);
		printf("cmd_t2 ret:%d\n", ret);
		//if (uffs_remove("/cs0/file_test_large") < 0) {
		//	MSGLN("Delete file %s failed", "/cs0/file_test_large");
		//}
	break;

	case 2: // multiple files test
		printf("Start TestPopulateFiles\n");
		ret = cmd_TestPopulateFiles(2, argv3);
		printf("cmd_TestPopulateFiles ret:%d\n", ret);
	break;
	case 3: // simple small file test on both partition
		ret = cmd_t1(3, argv2);
		printf("cmd_t1 ret:%d\n", ret);

		ret = cmd_t1(3, argv5);
		printf("cmd_t1 ret:%d\n", ret);
		printf("cs0 total:%ld\n", uffs_space_total("/cs0/"));
		printf("cs0 used:%ld\n", uffs_space_used("/cs0/"));
		printf("cs0 free:%ld\n", uffs_space_free("/cs0/"));
		printf("cs1 total:%ld\n", uffs_space_total("/cs1/"));
		printf("cs1 used:%ld\n", uffs_space_used("/cs1/"));
		printf("cs1 free:%ld\n", uffs_space_free("/cs1/"));

		ret = cmd_t2(3, argv2);
		printf("cmd_t2 ret:%d\n", ret);
		if (uffs_remove( argv2[1]) < 0) {
			MSGLN("Delete file %s failed",  argv2[1]);
		}
		ret = cmd_t2(3, argv5);
		printf("cmd_t2 ret:%d\n", ret);
		if (uffs_remove( argv5[1]) < 0) {
			MSGLN("Delete file %s failed",  argv5[1]);
		}
#if 1
		printf("cs1 total:%ld\n", uffs_space_total("/cs1/"));
		printf("cs1 used:%ld\n", uffs_space_used("/cs1/"));
		printf("cs1 free:%ld\n", uffs_space_free("/cs1/"));
#endif
	break;
	}
#if 1
	printf("cs0 total:%ld\n", uffs_space_total("/cs0/"));
	printf("cs0 used:%ld\n", uffs_space_used("/cs0/"));
	printf("cs0 free:%ld\n", uffs_space_free("/cs0/"));
#endif
#ifdef SHOW_LOW_ACCESS
	printf("Total_Nand_read F:%d, P:%d\n",Total_Nand_read_full, Total_Nand_read_partial);
	printf("Total_Nand_write:%d\n",Total_Nand_write);
	printf("Total_Nand_erase:%d\n",Total_Nand_erase);
	printf("Total_Nand_check:%d\n",Total_Nand_check);
#endif
	return ret;
}



