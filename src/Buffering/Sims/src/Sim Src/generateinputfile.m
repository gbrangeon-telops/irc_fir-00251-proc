%%simulation memory for 131072 pixel

%% Prepare Data
Nb_Seq = 1;
Nb_Frame = 120;
Ts = 1;
Nbit_length = 15;
width = 64;
heigth = 6;
FrameSize = width*heigth;


%% Generate Test Data
Test_pattern = zeros(Nb_Frame*Nb_Seq,FrameSize);
Test_pattern = uint16(Test_pattern);
Test_pattern32 = zeros(Nb_Frame*Nb_Seq,FrameSize/2);
Test_pattern32 = uint32(Test_pattern32);
Test_ID = zeros(Nb_Frame*Nb_Seq,FrameSize);
Test_ID = uint16(Test_ID);
Test_ID = zeros(Nb_Frame*Nb_Seq,FrameSize/2);

for i=1:1:(Nb_Frame*Nb_Seq)
    for j=1:1:heigth
        for k=1:1:width
            Test_pattern(i,(j-1)*width+k) = k/width*(2^Nbit_length-1) ;
            if(j<=2)
                if(j==2 && k== width)
                    Test_ID(i,(j-1)*width+k) = 3;  
                else
                    Test_ID(i,(j-1)*width+k) = 1;  
                end
            else
                if(j==heigth && k== width)
                    Test_ID(i,(j-1)*width+k) = 2; 
                else
                    Test_ID(i,(j-1)*width+k) = 0;    
                end
                
            end
        end
    end
    for n=1:1:length(Test_pattern32(i,:))
        Test_pattern32(i,n) = hex2dec([dec2hex(Test_pattern(i,n*2),4), dec2hex(Test_pattern(i,(n*2)-1),4)]); 
        Test_ID32(i,:) = max(Test_ID(i,1:2:end),Test_ID(i,2:2:end));
    end;
end


write_path = 'D:\Telops\FIR-00251-Proc\src\Buffering\Sims\src\';
name_param = ['IN_Seq' num2str(Nb_Seq) '_LEN' num2str(Nb_Frame) '_w' num2str(width) '_h' num2str(heigth)];
filename_data = [write_path name_param '_data.dat']
filename_id = [write_path name_param '_id.dat'];

mat2vhdl(Test_pattern32, filename_data, 'w+','uint32');
mat2vhdl(Test_ID32, filename_id, 'w+','uint32');