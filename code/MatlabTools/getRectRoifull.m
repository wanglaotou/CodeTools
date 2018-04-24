%get one scene's label info into one scene's txt(imgpath,headnum,label,x,y,w,h)
%save to liyuanqian(label info:imgpath,headnum,label,x,y,w,h)
%save to zhangting (label info:imgpath,headnum,label,x,y)

clear;
clc;
mydir='/ssd/wangmaorui/data';
reRoiImgdir = 'RoiImg';

sceneDIRS = fullfile(mydir,'RoiImg');
labelDIRS = fullfile(mydir,'Label');
labelpath = fullfile(labelDIRS,'labelroi01_21.txt');
RectRoipath = fullfile(mydir,'RectRoi01_21');
roiDIRS = fullfile(mydir,'ROI');
roipath = fullfile(roiDIRS,'roi.txt');
perspath = fullfile(mydir,'PersMaps');
perspath = fullfile(perspath,'matPersp');
scenepath = fullfile(mydir,'Scene');
% RectroiZTpath = fullfile(mydir,'RectroiZTSS');


flid = fopen(labelpath,'r');
while feof(flid) == 0
    flabel = fgetl(flid);
    Sl = regexp(flabel,'/','split');
    labelname = char(Sl(7));
    labelend = char(Sl(8));

    %load img info
    sceneend = regexp(labelend,'.txt','split');
    scenefo = char(sceneend(1));
    scenefull = strcat(scenefo,'.jpg');
    scenepath1 = fullfile(scenepath,labelname);
    scenefullpath = fullfile(scenepath1,scenefull);
    img = imread(scenefullpath);
    [wid,hei,chan] = size(img);
    imshow(img);
    hold on;
    %get RectroiZT dir
    if ~exist(RectRoipath)
        mkdir(RectRoipath);
    end
%     %get RectroiZT dir
%     if ~exist(RectroiZTpath)
%         mkdir(RectroiZTpath);
%     end

    %load PersMaps
    persname = strcat(labelname,'.mat');
    persfullpath = fullfile(perspath,persname);
    load(persfullpath);

    %load roi info
    min_x = 0;
    min_y = 0;

    frid = fopen(roipath,'r');              %each label info loop for all roi.txt
    while feof(frid) == 0
        froi = fgetl(frid);
        Sr = regexp(froi,'/','split');
        roiname = char(Sr(6));
        if(labelname==roiname)              %attention scene01-21 have no roi info
            arr_x = [];
            arr_y = [];
            froid = fopen(froi,'r');
            while feof(froid) == 0
                froline = fgetl(froid);
                Sro = regexp(froline,' ','split');
                roi = char(Sro(1));
                if(length(Sro)==1)
                    num = roi;
                end
                if(length(Sro)==2)
                    roi_x = char(Sro(1));
                    roi_y = char(Sro(2));
                    roi_x = str2num(roi_x);
                    roi_y = str2num(roi_y);
                    arr_x = [arr_x;roi_x];
                    arr_y = [arr_y;roi_y];
                end
                min_x = min(arr_x);
                min_y = min(arr_y);
                
%                 max_x = max(arr_x);
%                 wid = ceil((max_x - min_x)/8)*8;               
%                 max_y = max(arr_y);
%                 hei = ceil((max_y - min_y)/8)*8;
            end
            fclose(froid);
        end
    end
    fclose(frid);

    %get new label in Rectroi
    flaid = fopen(flabel,'r');
%     fullrectroipath = fullfile(RectRoifullpath,labelend);
    rectroiname = strcat(labelname,'.txt');
    fullrectroipath = fullfile(RectRoipath,rectroiname);
%     ffrid = fopen(fullrectroipath,'w');             %use for clean
    ffrid = fopen(fullrectroipath,'a');
    RoiImgpath = fullfile(reRoiImgdir,labelname);
    reRoiImgpath = fullfile(RoiImgpath,scenefull);
    fprintf(ffrid, '%s', reRoiImgpath);
    fprintf(ffrid,' ');

    %get new label in RectroiZT
%     fullrectroiZTpath = fullfile(RectroiZTpath,rectroiname);
%     ffrzid = fopen(fullrectroiZTpath,'a');
%     RoiImgpath = fullfile(reRoiImgdir,labelname);
%     reRoiImgpath = fullfile(RoiImgpath,scenefull);
%     fprintf(ffrzid, '%s', reRoiImgpath);
%     fprintf(ffrzid,' ');

    while feof(flaid) == 0
        flaline = fgetl(flaid);
        Sla = regexp(flaline,'\t','split');
        labelinfo = char(Sla(1));
        Slain = regexp(labelinfo,' ','split');
        if(length(Slain)==1)
            head = labelinfo;
            head = str2num(head);
            fprintf(ffrid, '%d', head);
%             fprintf(ffrzid, '%d', head);
        end
        if(length(Slain)==2)
            fprintf(ffrid, ' ');
            fprintf(ffrid, '%d', 1);
%             fprintf(ffrzid, ' ');
%             fprintf(ffrzid, '%d', 1);
            pos_x = char(Slain(1));
            pos_y = char(Slain(2));
            pos_x = str2num(pos_x);
            pos_y = str2num(pos_y);
            rect_x = pos_x - min_x;
            rect_y = pos_y - min_y;
            value = PMap(pos_y,pos_x);
            value = ceil(value);
            newrect_x = floor(rect_x - value/2);
            newrect_y = floor(rect_y - value/2);
%             plot(rect_x,rect_y,'r*');
            %roi boundary process
            if(newrect_x<=0)
                newrect_x = pos_x;
                value = ceil(value/2);
            end
            if(newrect_y<=0)
                newrect_y = pos_y;
                value = ceil(value/2);
            end

            fprintf(ffrid, ' ');
            fprintf(ffrid, '%d', newrect_x);	%save to liyuanqian(label info:imgpath,headnum,label,x,y,w,h)
            fprintf(ffrid, ' ');
            fprintf(ffrid, '%d', newrect_y);           
            fprintf(ffrid, ' ');
            fprintf(ffrid, '%d', value);
            fprintf(ffrid, ' ');
            fprintf(ffrid, '%d', value);

%             fprintf(ffrzid, ' ');		
%             fprintf(ffrzid, '%d', rect_x);	%save to zhangting (label info:imgpath,headnum,label,x,y)
%             fprintf(ffrzid, ' ');
%             fprintf(ffrzid, '%d', rect_y);
        end
    end
    fprintf(ffrid, '\n');
%     fprintf(ffrzid, '\n');
%     fclose(ffrzid);
    fclose(ffrid);
    fclose(flaid);
end
fclose(flid);





