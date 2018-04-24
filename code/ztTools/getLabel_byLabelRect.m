%% Program: CrowdCount 
% date:20171020
% use : rect label to dmap
% input: label list: imgpath num 1 x y w h
% output : dmap for each img
% created by zt
% generate density map and save as .txt file
clear;
clc;

%% 1> read lbl list file
lblFn = fopen('/home/zhangting/zhangting/code_exp/crowd_count/data/toujian/toujian_rect_lbl.list');

%% 2> for : each img & lbl
while ~feof(lblFn)
    lblLine = fgetl(lblFn);
    lblLine
    if isempty(lblLine)
        continue;
    end
    strTemp = regexp(lblLine,' ','split');
    try
        srcImg = imread(char(strTemp(1)));
    catch err
        continue;
    end
    [imgh, imgw, c] = size(srcImg);
    % get filename
    [pathstr,imgName,ext] = fileparts(char(strTemp(1)));
%  %show
%     imagesc(srcImg);
%     hold on
    
    % label save
    labelDir = strrep(pathstr,'Image','Label2');
    if ~exist(labelDir,'dir')
        mkdir(labelDir);
    end
    saveName = [labelDir,'/',imgName,'.txt'];
    f=fopen(saveName,'w');
    
    % twice pooling, density map reduced by 2 times
    
    num=0;
    face_num = str2num(char(strTemp(2))); % cell ->str->num
    
    fprintf(f,'%d',face_num);
    fprintf(f,'\n');
    for i = 3:5:length(strTemp)
        % get rect
        x = str2num(char(strTemp(i+1)));
        y = str2num(char(strTemp(i+2)));
        w1 = str2num(char(strTemp(i+3)));
        h1 = str2num(char(strTemp(i+4)));
        % get sub instance
        rect = [x,y,w1,h1];
        ksize = min(w1,h1);
        
        x_center = floor(x+w1/2);
        y_center = floor(y+h1/2);
%         plot(x_center,y_center,'r*');
        
        fprintf(f,'%d %d %d',x_center,y_center,ksize);
        fprintf(f,'\n');
    end

    
%% 2>imshow
    %imagesc(d_map);
                 
%% 3> save label txt  
    fclose(f);
end

%% 4> close file
fclose(lblFn);


