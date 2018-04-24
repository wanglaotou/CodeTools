%get one scene's label info into one scene's txt(imgpath,headnum,label,x,y,w,h)
%save to liyuanqian(label info:imgpath,headnum,label,x,y,w,h)
%save to zhangting (label info:imgpath,headnum,label,x,y)

clear;
clc;
mydir='/ssd/wangmaorui/data/RoiImg/Part_B';

TrainImg = fullfile(mydir,'trainImg.txt');
TestImg = fullfile(mydir,'testImg.txt');
TrainLab = fullfile(mydir,'trainLab.txt');
TestLab = fullfile(mydir,'testLab.txt');
TrainRect = fullfile(mydir,'trainrect.txt');
TestRect = fullfile(mydir,'testrect.txt');


flid = fopen(TestImg,'r');
ftrid = fopen(TestRect,'w');
while feof(flid) == 0
    flabel = fgetl(flid);
    fprintf(ftrid,'%s',flabel);
%     img = imread(flabel);
%     [wid,hei,chan] = size(img);
%     imshow(img);
%     hold on;
    Sl = regexp(flabel,'/','split');
    scenename = char(Sl(7));
    labelend = char(Sl(8));

    sceneend = regexp(labelend,'.jpg','split');
    scenefo = char(sceneend(1));
    scenefull = strcat(scenefo,'.txt');
    scenepath1 = fullfile(mydir,scenename);
    scenefullpath = fullfile(scenepath1,scenefull);
    
    frid = fopen(scenefullpath,'r');             %each label info loop for all roi.txt
    while feof(frid) == 0
        froi = fgetl(frid);
        Sr = regexp(froi,' ','split');
        roi = char(Sr(1));
        if(length(Sr)==1)
            num = roi;
            num = str2num(num);
            fprintf(ftrid,'%s%d',' ',num);
        end
        if(length(Sr)==2)
            roi_x = char(Sr(1));
            roi_y = char(Sr(2));
            roi_x = str2num(roi_x);
            roi_y = str2num(roi_y);
%             plot(roi_x,roi_y,'r*');
            roi_x = roi_x - 50;
            roi_y = roi_y - 50;
            if(roi_x<1)
                roi_x = 1;
            end
            if(roi_y<1)
                roi_y = 1;
            end
            fprintf(ftrid,'%s%d',' ',1);
            fprintf(ftrid,'%s%d',' ',roi_x);
            fprintf(ftrid,'%s%d',' ',roi_y);
            fprintf(ftrid,'%s%d%s%d',' ',100,' ',100);
        end
    end
    fprintf(ftrid,'\n');
    fclose(frid);
%     pause;
end
fclose(ftrid);
fclose(flid);





