
comPort = 'COM21';

%% Config
genSetRegister_v10('TriggerMode',0, comPort)

%Data Path
genSetRegister_v10('Width', 640, comPort)
genSetRegister_v10('Height',512, comPort)
genSetRegister_v10('AcquisitionFrameRate',80, comPort)
genSetRegister_v10('CalibrationMode', 0, comPort)
genSetRegister_v10('TestImageSelector', 31, comPort) % Telops 30,31,35, SCD 40 à 43 -> mode diag

%Exposure Mode
genSetRegister_v10('ExposureAuto', 0, comPort)
genSetRegister_v10('ExposureTime',100, comPort)
genSetRegister_v10('AECImageFraction', 50.0, comPort)
genSetRegister_v10('AECTargetWellFilling', 7.0, comPort)
genSetRegister_v10('AECResponseTime', 1000, comPort)

%Buffering Write to Buffer
genSetRegister_v10('MemoryBufferMode',1, comPort) % 0 Disable, 1 Enable
NimgMax = genGetRegister_v10('MemoryBufferNumberOfImagesMax', comPort)
genSetRegister_v10('MemoryBufferSequenceSize',250 , comPort)
NSeqMax = genGetRegister_v10('MemoryBufferNumberOfSequencesMax', comPort)
genSetRegister_v10('MemoryBufferNumberOfSequences',4 , comPort)
genSetRegister_v10('MemoryBufferSequencePreMOISize',100 , comPort)

%Buffering MOI Source
genSetRegister_v10('TriggerSelector',1 , comPort) % 0 AcquisitionStart, 1 MemoryBufferMOI
genSetRegister_v10('TriggerSource',0 , comPort) % 0 Software, 1 ExternalSignal
genSetRegister_v10('TriggerActivation',0 , comPort) % 0 Rising, 1 Falling, 2 Any, 3 Level High, 4 Level Low

%Acquisition Start
genSetRegister_v10('AcquisitionArm', 1, comPort)
pause(5)
genSetRegister_v10('AcquisitionStart', 1, comPort)

%% Generate MOI
for i=1:1:4
    genSetRegister_v10('TriggerSoftware',1 , comPort) % Sofware MOI CMD
    genSetRegister_v10('TriggerSoftware',0 , comPort) % Sofware MOI CMD
    pause(5)
    genGetRegister_v10('MemoryBufferSequenceCount', comPort)
end 

genSetRegister_v10('AcquisitionStop', 1, comPort)

%% Buffering Read MOI IMG
genSetRegister_v10('MemoryBufferSequenceSelector',1, comPort)
FirstFrameID = genGetRegister_v10('MemoryBufferSequenceFirstFrameID',comPort)
MOIFrameID = genGetRegister_v10('MemoryBufferSequenceMOIFrameID', comPort)
genSetRegister_v10('MemoryBufferSequenceDownloadImageFrameID',FirstFrameID  , comPort)
genSetRegister_v10('MemoryBufferSequenceDownloadImage',1 , comPort)

%% Buffering Read Sequence
genSetRegister_v10('MemoryBufferSequenceSelector',3, comPort)
genSetRegister_v10('MemoryBufferSequenceDownload', 1, comPort)


genSetRegister_v10('MemoryBufferSequenceClearAll', 1, comPort)




