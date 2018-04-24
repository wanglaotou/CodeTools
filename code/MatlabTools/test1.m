clear;
clc;

Lab_path = '/ssd/wangmaorui/data/List/ListSepa';
listpath = fullfile(Lab_path,'part2_12_test.txt');
fpid = fopen(listpath,'r');
while feof(fpid) == 0
    fp = fgetl(fpid);
    Sp = regexp(fp,' ','split');
    imgpath = char(Sp(1));
    headnum = int(Sp(2));
    len = length(Sp);
    disp(len);
    for i=3:len
        pos_x = char(Sp(i+i));
        pos_y = char(Sp(i+2));
        if(pos_x>1140&&pos_x<1274&&pos_y>1&&pos_y<180)
            headnum=headnum-1;
        end
    end
end