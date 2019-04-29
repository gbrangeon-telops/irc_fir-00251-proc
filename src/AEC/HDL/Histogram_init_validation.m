%%This file Initialize the histogram before the model generation

Ts = 1;
Nb_bin = 128;
Nbit_length = 13;
MaxHistValue_bit = ceil(log2(1280*1024));
Nb_Frame = 1;

%TestVector for activeHDL sim
TestData = importdata('D:\Telops\FIR-00251-Proc\src\AEC\HDL\Histo_test_pattern_13.dat');
%RandData=round(rand([1 64*64])*(2^Nbit_length-1));
%TestData=[RandData];
% H1=hist(TestData(1,:),Nb_bin); % chack only firt transmission
% 
% edges=0:2^Nbit_length/Nb_bin:2^Nbit_length-2^Nbit_length/Nb_bin;
% H2=histc(TestData(1,:),edges);
ActiveFrame = 2;
edges=0:2^Nbit_length/Nb_bin:2^Nbit_length;
Hist_valid = [];
for i=1:1:Nb_Frame
  H1=histc(TestData(ActiveFrame,:),edges);
  Hist_valid = [Hist_valid H1(1:1:end-1)];
end

max(TestData(1:end))

 
%% Prepare Data for AXIS/LL insertion
% Write then read

StartTime = 100; % wait for 100 clock cycle before start
TMI_Padding = 16;
ReadTmiDelay = Nb_bin; %nbin 
StopDelay = ReadTmiDelay+256+TMI_Padding; % wait 256 clock cycle before sim end
DataLength = length( TestData(ActiveFrame,:));

TMIStartDelay = StartTime+DataLength+TMI_Padding; % 16 padding cycle
Clear_delay = 50;
TimeSerie = [0:1:StartTime+DataLength+StopDelay-1]; 
ExpTime = 4500;
TotalTime = TimeSerie(end)+1;

switch Nbit_length
    case 13
        bitpos = 0;
    case 14
        bitpos = 1;
    case 15
        bitpos = 2;
    case 16
        bitpos = 3;
    otherwise
        bitpos = 3;
end

% Write then read 
Rx_Data_start = zeros(1,StartTime);
Rx_Data_stop = zeros(1,StopDelay);
Rx_data = [TimeSerie; Rx_Data_start TestData(ActiveFrame,:) Rx_Data_stop]';
Rx_dval = [TimeSerie; zeros(1,StartTime) ones(1,DataLength) zeros(1,StopDelay)]';
Rx_sof_value = [ones(1,StartTime+1) zeros(1,StopDelay+DataLength-1)];
Rx_eof_value = [zeros(1,StartTime+DataLength-1) 1 zeros(1,StopDelay)];
Rx_sof = [TimeSerie;      Rx_sof_value ]';
Rx_eof = [TimeSerie;      Rx_eof_value]';
Clear_Mem = [TimeSerie; zeros(1,TMIStartDelay+ReadTmiDelay) 1 zeros(1,TotalTime-TMIStartDelay-ReadTmiDelay-1) ]';
Pos = [TimeSerie; ones(1,TotalTime)*bitpos ]';
Ext_data_in = [TimeSerie; ones(1,StartTime+1)*ExpTime zeros(1,StopDelay+DataLength-1)]';

%TMI READ
tmi_add = [TimeSerie; zeros(1,TMIStartDelay) 0:1:(Nb_bin-1) zeros(1,StopDelay-ReadTmiDelay-TMI_Padding)]';
tmi_dval = [TimeSerie;zeros(1,TMIStartDelay) ones(1,Nb_bin) zeros(1,StopDelay-ReadTmiDelay-TMI_Padding)]';
% 

%% TMI READ DATA 
%TimeSerie = [StartTime+DataLength+StopDelay:1:StartTime+DataLength+StopDelay-1]; 


%% Run Simulation
SimOut = sim('histogram_AXIS_TMI');

%% analyse result
figure
ax1=subplot(3,1,1); plot(TMI_DVAL);
ax2=subplot(3,1,2), plot(TMI_OUT);
ax3=subplot(3,1,3), plot(TMI_BUSY);
linkaxes([ax1,ax2,ax3],'x');

TMi_data_valid = TMI_OUT(find(TMI_DVAL == 1));
figure
ax1=subplot(3,1,1)
plot(TMi_data_valid)
ax2=subplot(3,1,2)
plot(Hist_valid)
ax3=subplot(3,1,3)
plot(TMi_data_valid'-Hist_valid)
linkaxes([ax1,ax2,ax3],'x');


NbPixel = cumsum(TMi_data_valid);