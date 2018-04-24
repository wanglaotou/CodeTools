clear;
clc;
dir = '/ssd/wangmaorui/data';
rectdir = fullfile(dir,'RectroiZT');
rectpath = fullfile(rectdir,'rectroiztsall.txt');
labeldir = fullfile(dir,'Label');
labelddir = fullfile(labeldir,'labelup');
fmiid = fopen(rectpath,'r');

while feof(fmiid) == 0
    fmline = char(fgetl(fmiid));
    Sf = regexp(fmline,' ','split');
    imgpath = char(Sf(1));
%     img = imread(imgpath);
%     [hei,wid,c] = size(img);
%     imshow(img);
%     hold on;
    headnum = char(Sf(2));
    rects = [];
    for i = 3:3:length(Sf)
        pos_x = str2num(char(Sf(i+1)));
        pos_y = str2num(char(Sf(i+2)));
        rects = [rects;pos_x];
        rects = [rects;pos_y];
    end
    Sl = regexp(imgpath,'/','split');
    scenename = char(Sl(6));
    jpgname = char(Sl(7));
    Sj = regexp(jpgname,'.jpg','split');
    labelfo = char(Sj(1));
    labelname = strcat(labelfo,'.txt');
    label_path = fullfile(labelddir,scenename);
    if ~exist(label_path)
        mkdir(label_path);
    end
    LabelPath = char(fullfile(label_path,labelname));  
    flid = fopen(LabelPath,'w');
    fprintf(flid, '%s', headnum);
    for k=1:2:length(rects)
        rect_x = rects(k);
        rect_y = rects(k+1);
%         plot(rect_x,rect_y,'r*');
        fprintf(flid, '\n');
        fprintf(flid, '%d%s%d', rect_x,' ',rect_y);
    end
    fclose(flid);
%     pause;
end
fclose(fmiid);



   