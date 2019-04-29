%%This file Initialize the histogram before the model generation

Ts = 1;
Nb_bin = 128;
Nbit_length = 13;
MaxHistValue_bit = ceil(log2(1280*1024));
Nb_Frame = 1;

RandData=round(rand([1 2^Nbit_length])*(2^Nbit_length-1));
TestData=[RandData];
H1=hist(RandData,Nb_bin);
edges=0:64:2^Nbit_length;
H2=histc(RandData,edges);
H=[H1 0;H2];


StartTime = 1; % wait for 100 clock cycle before start
ActiveFrame = 1;
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
