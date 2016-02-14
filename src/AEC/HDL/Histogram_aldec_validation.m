%% Prepare Data
Nb_Frame = 3;
Ts = 1;
Nb_bin = 128;
Nbit_length = 13;
width = 320;
heigth = 256;
FrameSize = width*heigth;
MaxHistValue_bit = ceil(log2(1280*1024));

%% Generate Test Data
Test_pattern = zeros(Nb_Frame,FrameSize);
for i=1:1:Nb_Frame
    Test_pattern(i,:) = rand([1,FrameSize]) * ((2^Nbit_length)-1);
end

%mat2vhdl(Test_pattern, 'D:\Telops\FIR-00251-Proc\src\AEC\HDL\Histo_test_pattern_13.dat', 'w+');

%% output result
fid = fopen('D:\Telops\FIR-00251-Proc\src\AEC\HDL\Histo_test_pattern_out_13.dat');
H_out = fread(fid,'uint32');
fclose(fid);

%%
%TestVector for activeHDL sim
TestData = importdata('D:\Telops\FIR-00251-Proc\src\AEC\HDL\Histo_test_pattern_13.dat');
edges=0:2^Nbit_length/Nb_bin:2^Nbit_length;
Hist_valid = [];
for i=1:1:Nb_Frame
  H1=histc(TestData(i,:),edges);
  Hist_valid = [Hist_valid H1(1:1:end-1)];
end


%% analyse result

figure
ax1=subplot(3,1,1)
plot(H_out')
ax2=subplot(3,1,2)
plot(Hist_valid)
ax3=subplot(3,1,3)
plot(H_out'-Hist_valid)
linkaxes([ax1,ax2,ax3],'x');


NbPixel_in = cumsum(Hist_valid);
NbPixel_out = cumsum(H_out);
TestPix = NbPixel_in(end)
OutputPix = NbPixel_out(end)