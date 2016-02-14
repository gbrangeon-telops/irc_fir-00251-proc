%Buffer Parameter
Nb_Seq = 8;
SeqSize = 300;
PRE_MOI = 149;
POST_MOI = 150;

%State = WR_MOI

%Active Sequence Parameter
Start_Img_loc   = [0    0   0   51  141 201 251 76];
img_loc         = [0    50  150 200 290 50  100 225];
end_loc         = [299  299 299 50  140 200 150  25];
state           = [0    0   0   1   1   1   1   1]; 

%BufferTable Result
for i=1:1:Nb_Seq
    if(state(i) == 0)
        BT_Start_img_loc(i) = 0;
        BT_MOI_img_loc(i) = img_loc(i);
    else
        if(img_loc(i) > PRE_MOI) %PREMOI
            BT_Start_img_loc(i) = img_loc(i) - PRE_MOI;
            BT_MOI_img_loc(i) = img_loc(i);
            
        else %WAIT MOI
            BT_Start_img_loc(i) = SeqSize - PRE_MOI + img_loc(i);
            BT_MOI_img_loc(i) = img_loc(i);
        end
    end
    %POST MOI
    BT_END_img_loc(i) = end_loc(i);
end

BM_TABLE = [BT_Start_img_loc;BT_MOI_img_loc;BT_END_img_loc];