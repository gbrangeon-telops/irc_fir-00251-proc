#include "stdafx.h"
#include "CppUnitTest.h"

#include <fstream>

#include "FileInfo.h"
#include "CalibBlockFile.h"

#include "CalibImageCorrectionFile.h"


using namespace Microsoft::VisualStudio::CppUnitTestFramework;

namespace CameraFileLibTests
{		
	TEST_CLASS(CameraFileLibTests)
	{
	public:
		
		void setUp()
		{
		}

		void tearDown()
		{
		}

		TEST_METHOD(LoadCalibrationFile)
		{
			std::string calibPath("C:\\Users\\dhansen\\AppData\\Local\\Telops\\RevealIR\\CalibrationManager\\Cameras\\TSBL\\TEL05254_1507763703.tsbl");
			std::ifstream inFile;
			inFile.open(calibPath, std::ios::binary | std::ios::ate);
			Assert::IsFalse(!inFile);

			uint32_t length = (uint32_t)inFile.tellg();
			inFile.seekg(0);
			char* buffer = new char[length];
			inFile.read(buffer, length);


			CalibBlockFile			calibrationBlock;

			Assert::IsTrue(CalibBlock_LoadCalibrationBlock((uint8_t*)buffer, length, &calibrationBlock));

			CalibBlock_DeleteCalibrationBlock(&calibrationBlock);

			inFile.close();
		}
		TEST_METHOD(LoadImageCorrectionFile)
		{
			std::string icPath("C:\\Users\\dhansen\\AppData\\Local\\Telops\\RevealIR\\CalibrationManager\\Cameras\\TSIC\\TEL05254-1508502073_i_1507756452.tsic");
			std::ifstream inFile;
			inFile.open(icPath);

			Assert::IsTrue(true);
		}

	};
}