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
    srcImg = imread(char(strTemp(1)));
    [imgh, imgw, c] = size(srcImg);
    % get filename
    [pathstr,imgName,ext] = fileparts(char(strTemp(1)));
    %imshow(srcImg);
    
    % twice pooling, density map reduced by 2 times
    m = imgh/8;n = imgw/8;     
    d_map = zeros(m,n);
    get_dmap = 0;
    
    num=0;
    face_num = str2num(char(strTemp(2))); % cell ->str->num
    for i = 3:5:length(strTemp)
        % get rect
        x = str2num(char(strTemp(i+1)));
        y = str2num(char(strTemp(i+2)));
        w1 = str2num(char(strTemp(i+3)));
        h1 = str2num(char(strTemp(i+4)));
        % get sub instance
        rect = [x,y,w1,h1];
        
        % get guassian kernel
        ksize = floor(min(w1,h1)/8);
        if (mod(ksize, 2) == 0)
            ksize = ksize + 1;
        end
        
        sigma = ksize/2.5;
        radius = (ksize-1)/2;

        h = fspecial('gaussian',ksize,sigma);
        x_ = floor(max(1,x/8+w1/16));
        y_ = floor(max(1,y/8+h1/16));

        if (x_-radius+1<1)  % if out of boundary 
            for ra = 0:radius-x_-1
                h(:,end-ra) = h(:,end-ra)+h(:,1);
                h(:,1)=[];
            end
        end

        if (y_-radius+1<1)
            for ra = 0:radius-y_-1
                h(end-ra,:) = h(end-ra,:)+h(1,:);
                h(1,:)=[];
            end
        end
        if (x_+ksize-radius>n)
            for ra = 0:x_+ksize-radius-n-1
                h (:,1+ra) = h(:,1+ra)+h(:,end);
                h(:,end) = [];
            end
        end
        if(y_+ksize-radius>m)
            for ra = 0:y_+ksize-radius-m-1
                h (1+ra,:) = h(1+ra,:)+h(end,:);
                h(end,:) = [];
            end
        end
        
        try
            d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...
                = d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...
                + h;
        catch err
            get_dmap = -1;
            break;
        end
    end

    
%% 2>imshow
    %imagesc(d_map);
    if get_dmap == -1
        continue;
    end
                 
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
        
        
end

%% 4> close file
fclose(lblFn);


