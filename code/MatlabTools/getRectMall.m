%get one scene's label info into one scene's txt(imgpath,headnum,label,x,y,w,h)
%save to liyuanqian(label info:imgpath,headnum,label,x,y,w,h)
%save to zhangting (label info:imgpath,headnum,label,x,y)

clear;
clc;
mydir='/ssd/wangmaorui/data';

TrainImg = fullfile(mydir,'mall.txt');
TestImg = fullfile(mydir,'mall_big.txt');


flid = fopen(TrainImg,'r');
ftrid = fopen(TestImg,'w');
while feof(flid) == 0
    flabel = fgetl(flid);
    Sl = regexp(flabel,' ','split');
    imgpath = char(Sl(1));
    fprintf(ftrid,'%s',imgpath);
    img = imread(imgpath);
%     [wid,hei,chan] = size(img);
%     imshow(img);
%     hold on;
    headnum = char(Sl(2));
    fprintf(ftrid,'%s%s',' ',headnum);
    for i = 3:5:length(Sl)
        flag = str2num(char(Sl(i)));
        pos_x = str2num(char(Sl(i+1)));
        pos_y = str2num(char(Sl(i+2)));
        value = str2num(char(Sl(i+3)));
        new_x = pos_x - 4;
        if(new_x < 0)
            new_x = 1;
        end
        new_y = pos_y - 4;
        if(new_y < 0)
            new_y = 1;
        end
        if(new_y < 500) 
            pvalue = value + 8;
        end
        if(new_x == 1)
            pvalue = value;
        end
        if(new_x + pvalue > 640)
            pvalue = 640 - new_x;
        end
        if(new_y + pvalue > 480)
            pvalue = 480 - new_y;
        end
%         rectangle('Position',[new_x,new_y,pvalue,pvalue],'edgecolor','r');
%         pause;
        fprintf(ftrid, '%s%d%s%d%s%d%s%d%s%d',' ',flag,' ',new_x,' ',new_y,' ',pvalue,' ',pvalue);
    end
    fprintf(ftrid, '\n');
%     pause;
end
fclose(ftrid);
fclose(flid);





