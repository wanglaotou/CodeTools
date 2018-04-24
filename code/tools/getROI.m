% created by lhl
%generate density map and save as .txt file
clear;
clc;
mydir='/ssd/wangmaorui/data/Test';

sceneDIRS = fullfile(mydir,'Scene');
roiDIRS = fullfile(mydir,'ROI');
scenepath = fullfile(mydir,'scene.txt');
roipath = fullfile(roiDIRS,'roi.txt');
roiimgpath = fullfile(mydir,'RoiImg2');

frid = fopen(roipath,'r');
while feof(frid) == 0
    froi = fgetl(frid);
    Sr = regexp(froi,'/','split');
    ROI_path = char(Sr(7)); 
    roiname = char(Sr(8));
    roi_name = char(Sr(9));
    forroi = regexp(roi_name,'.txt','split');
    froifor = char(forroi(1));
    roinewname = strcat(froifor,'_new.txt');
    roinewpath = fullfile(roiDIRS,ROI_path);
    roinewpath = fullfile(roinewpath,roiname);
    roinewpath = fullfile(roinewpath,roinewname);

    % make roiimg dir
    fullroiimg = fullfile(roiimgpath,roiname);
    if ~exist(fullroiimg)
        mkdir(fullroiimg);
    end

    %%get new roi             
    fnrid = fopen(froi,'r');
    frwid = fopen(roinewpath,'w');
    while ~feof(fnrid)
        roinewline = fgetl(fnrid);
    end
    fprintf(frwid, '%s\n', roinewline);
    fnrid = fopen(froi,'r');
    while feof(fnrid) == 0
        roiline = fgetl(fnrid);
        Sr = regexp(roiline, '\t', 'split');
        roi = char(Sr(1));
        Srf = regexp(roi, ' ', 'split');
        if(length(Srf)>1)
            roipos = roi;
            fprintf(frwid, '%s\n', roipos);
        end
    end
    fclose(frwid);

%     %show newroi
%     frdata = dlmread(roinewpath);
%     roi_x = frdata(:,1);
%     roi_y = frdata(:,2);                 
% %     plot(roi_x,roi_y, '-.or',MarkerSize',10);
%     figure;
%     plot(roi_x,roi_y,'-.or','MarkerFaceColor','g')
%     hold on;

    %get rectangle roi
    arr_x = [];
    arr_y = [];
    freid = fopen(roinewpath,'r');
    while feof(freid) == 0
        rectline = fgetl(freid);
        Sre = regexp(rectline,' ','split');
        pos_x = char(Sre(1));
        pos_y = char(Sre(2));
        pos_x = str2num(pos_x);
        pos_y = str2num(pos_y);
        arr_x = [arr_x;pos_x];
        arr_y = [arr_y;pos_y];
    end
    min_x = min(arr_x);
    max_x = max(arr_x);
    wid = ceil((max_x - min_x)/8)*8;
    min_y = min(arr_y);
    max_y = max(arr_y);
    hei = ceil((max_y - min_y)/8)*8;
%     rectangle('Position',[min_x,min_y,wid,hei]);
%     hold on;

    %save roiimg 
    fsid = fopen(scenepath,'r');
    while feof(fsid) == 0
        fscene = fgetl(fsid);
        Ss = regexp(fscene,'/','split');
        scenename = char(Ss(7));
        imgname = char(Ss(8));
        fullroiimgpath = fullfile(fullroiimg,imgname);
        img = imread(fscene);
        if(scenename==roiname)            
            roiimg = imcrop(img,[min_x min_y wid hei]);
            roiimg = imresize(roiimg, [hei wid]);
            imwrite(roiimg,fullroiimgpath);           
%             imshow(roiimg);
%             saveas(gcf,fullroiimgpath);
        else
            imwrite(img,fullroiimgpath);
        end
    end
    fclose(fsid);
end
fclose(frid);


    
