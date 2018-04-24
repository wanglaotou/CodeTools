%check a scene's label info
clear;
clc;
mydir = '/ssd/wangmaorui/data';
imgpath = fullfile(mydir,'Scene');
labelpath = fullfile(mydir,'Label');
labelpath1 = fullfile(labelpath,'label22_53');
labelfullpath = fullfile(labelpath1,'scene53.txt');
perspath = fullfile(mydir,'PersMaps');
perspath = fullfile(perspath,'matPersp');

flabelid = fopen(labelfullpath,'r');
while feof(flabelid) == 0
    labelline = fgetl(flabelid);
    Sl = regexp(labelline,'/','split');
    labelname = char(Sl(7));
    labelend = char(Sl(8));
    lline = regexp(labelend,'.txt','split');
    labelfo = char(lline(1));
    imgend = strcat(labelfo,'.jpg');
    imgpath1 = fullfile(imgpath,labelname);
    imgfullpath = fullfile(imgpath1,imgend);
    img = imread(imgfullpath);
%     figure;
%     imshow(img);
%     hold on;
    
    %load Persp
    persname = strcat(labelname,'.mat');
    persfullpath = fullfile(perspath,persname);
    load(persfullpath);
    
    %load label info
    flid = fopen(labelline,'r');
    while feof(flid) == 0
        tline = fgetl(flid);
        St = regexp(tline,' ','split');
        if(length(St)==1)
            head = char(St(1));
        end
        if(length(St)>1)            
            pos_x = char(St(1));
            pos_x = str2num(pos_x);
%             if(pos_x<=0)
%                 pos_x = 1;
%             end
            pos_y = char(St(2));
            pos_y = str2num(pos_y);
%             if(pos_y<=0)
%                 pos_y = 1;
%             end
            value = PMap(pos_y,pos_x);
%             plot(pos_x,pos_y,'r*');
        end
    end
    fclose(flid);
%     pause(0.1);
end
fclose(flabelid);
            
