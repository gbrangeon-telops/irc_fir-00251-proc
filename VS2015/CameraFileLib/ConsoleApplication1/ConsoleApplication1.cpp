// ConsoleApplication1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include <fstream>

#include "FileInfo.h"
#include "CalibBlockFile.h"

int main()
{
	std::string calibPath("C:\\Users\\dhansen\\AppData\\Local\\Telops\\RevealIR\\CalibrationManager\\Cameras\\TSBL\\TEL05254_1507763703.tsbl");
	std::ifstream inFile;
	inFile.open(calibPath, std::ios::binary | std::ios::ate);

	uint32_t length = (uint32_t)inFile.tellg();
	inFile.seekg(0);
	char* buffer = new char[length];
	inFile.read(buffer, length);

	fileInfo_t					 fileInfo;
	//CalibBlock_BlockFileHeader_v2_t blockHeader;

	//uint32_t headerSize = CalibBlock_ParseBlockFileHeader((uint8_t*)buffer, length, &fileInfo, &blockHeader);

	CalibBlock_LUTNLDataHeader_v2_t blockHeader;

	uint32_t headerSize = CalibBlock_ParseLUTNLDataHeader((uint8_t*)buffer, length, &fileInfo, &blockHeader);


    return 0;
}

