clear;
clc;
dir = '/ssd/wangmaorui/huo/test';
rectpath = fullfile(dir,'UCSD_new.txt');
newpath = fullfile(dir,'UCSD_wmr.txt');
fmiid = fopen(rectpath,'r');
fnid = fopen(newpath,'w');

while feof(fmiid) == 0
    fmline = char(fgetl(fmiid));
    Sf = regexp(fmline,' ','split');
    imgpath = char(Sf(1));
    fprintf(fnid, '%s', imgpath);
%     img = imread(imgpath);
%     [hei,wid,c] = size(img);
%     imshow(img);
%     hold on;
    headnum = char(Sf(2));
    rects = [];
    for i = 3:5:length(Sf)
        pos_x = str2num(char(Sf(i+1))) + 3;
        pos_y = str2num(char(Sf(i+2))) + 3;
        value = str2num(char(Sf(i+4))) - 6;
        rects = [rects;pos_x];
        rects = [rects;pos_y];
        rects = [rects;value];
        rects = [rects;value];
    end
    fprintf(fnid, '%s%s', ' ',headnum);
    for k=1:4:length(rects)
        rect_x = rects(k);
        rect_y = rects(k+1);
        pvalue = rects(k+3);
        if(rect_x < 1)
%             pvalue = rect_x + pvalue;
            rect_x = 1;     
        end
        if(rect_y < 1)
%             pvalue = rect_y + pvalue;
            rect_y = 1;     
        end
%         rect_x = num2str(rect_x);
%         rect_y = num2str(rect_y);
%         values = num2str(pvalue);
%         plot(rect_x,rect_y,'r*');
        fprintf(fnid, '%s%d', ' ', 1);
        fprintf(fnid, '%s%d%s%d%s%d%s%d', ' ',rect_x,' ',rect_y,' ',pvalue,' ',pvalue);
    end
    fprintf(fnid, '\n');
%     pause;
end
fclose(fnid);
fclose(fmiid);



   