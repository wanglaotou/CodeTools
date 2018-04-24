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
lblFn = fopen('/home/zhangting/zhangting/code_exp/crowd_count/data/Neg/Neg.list');

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
    %imshow(srcImg);
    
    % twice pooling, density map reduced by 2 times
    m = imgh/8;n = imgw/8;     
    d_map = zeros(m,n);
    
    num=0;
    face_num = str2num(char(strTemp(2))); % cell ->str->num
    
%% 2>imshow
    %imagesc(d_map);
                 
%% 3> save dmap txt  
    % pathstr
    dmapDir = strrep(pathstr,'Image','Dmap_8');
    if ~exist(dmapDir,'dir')
        mkdir(dmapDir);
        %dmapDir
    end
    
    saveName = [dmapDir,'/',imgName,'.txt'];
    f=fopen(saveName,'w');
    for h=1:m
        for w=1:n
            fprintf(f,'%d',d_map(h,w));
            fprintf(f,' ');
        end
        fprintf(f,'\n');
    end


    fclose(f);
    
    % show dmap
    %imagesc(d_map);
    %s1=sum(d_map(:));
    %display(s1);
    
    
%% 3> save label txt  
    % pathstr
%     labelDir = strrep(pathstr,'Image','Label');
%     if ~exist(labelDir,'dir')
%         mkdir(labelDir);
%     end
%     
%     saveName = [labelDir,'/',imgName,'.txt'];
%     f=fopen(saveName,'w');
%     fprintf(f,'%d',face_num);
%     fclose(f);
end

%% 4> close file
fclose(lblFn);
