%get one scene's Dmap(scene41)
clear;
clc;
mydir='/ssd/wangmaorui/data';

rectroiDIRS = fullfile(mydir,'RectRoi');
sceneDIRS = fullfile(mydir,'RoiImg');
rectroipath = fullfile(rectroiDIRS,'scene41_old.txt');
flid = fopen(rectroipath,'r');
while feof(flid) == 0
    line = fgetl(flid);     
    S = regexp(line,' ','split');
    imgpath = char(S(1));
    head = char(S(2));
    head = str2num(head);
    rects = [];
    for i = 3:5:length(S)
        pos_x = str2num(char(S(i+1)));
        pos_y = str2num(char(S(i+2)));
        wid = str2num(char(S(i+3)));
        hei = str2num(char(S(i+4)));
        rects = [rects;pos_x];
        rects = [rects;pos_y];
        rects = [rects;wid];
        rects = [rects;hei];
    end
    Sl = regexp(imgpath,'/','split');
    jpgname = char(Sl(7));
    Sj = regexp(jpgname,'.jpg','split');
    dmapfo = char(Sj(1));
    dmapname = strcat(dmapfo,'.txt');

    DmapPath4 = fullfile(dmapp4,dmapname);  %get DmapPath4
    DmapPath4 = char(DmapPath4);
    DmapPath8 = fullfile(dmapp8,dmapname);  %get DmapPath8
    DmapPath8 = char(DmapPath8);
%     disp(DmapPath4);     %/ssd/wangmaorui/data/Dmap/Dmap4/scene21/20170808_frame_02350.txt     
    
    %show img
    img = imread(imgpath);
%     imshow(img);
%     hold on;
    [rwidth,rheight,chan] = size(img);

    %get dmap
%     make width,height divisible by 16
    width = ceil(rwidth/16)*16;
    height = ceil(rheight/16)*16;
    m4=width/scale4;n4=height/scale4;
    d_map4 = zeros(m4,n4);
    m8=width/scale8;n8=height/scale8;
    d_map8 = zeros(m8,n8);

    fdid4=fopen(DmapPath4,'w');
    fprintf(fdid4,'%d%s%d',m4,' ',n4);
    fprintf(fdid4,'\n');
    fdid8=fopen(DmapPath8,'w');
    fprintf(fdid8,'%d%s%d',m8,' ',n8);
    fprintf(fdid8,'\n');
    for k=1:4:length(rects)
        rect_x = rects(k);
        rect_y = rects(k+1);
        pvalue = rects(k+2);
%         pwid = rect(k+2);
%         phei = rects(k+3);
        %dmap4
        rect_x4 = rect_x/scale4;
        rect_y4 = rect_y/scale4;
        if(rect_x4 + pvalue/2 >= n4)
            rect_x4 = rect_x4 - pvalue/2;
        end
        if(rect_y4 + pvalue/2 >= m4)
            rect_y4 = rect_y4 - pvalue/2;
        end
        x4_ = max(1,floor(rect_x4));
        y4_ = max(1,floor(rect_y4));
        %dmap8
        rect_x8 = rect_x/scale8;
        rect_y8 = rect_y/scale8;
        if(rect_x8 + pvalue/2 >= n8)
            rect_x8 = rect_x8 - pvalue/2;
        end
        if(rect_y8 + pvalue/2 >= m8)
            rect_y8 = rect_y8 - pvalue/2;
        end
        x8_ = max(1,floor(rect_x8));
        y8_ = max(1,floor(rect_y8));

        ksize = floor(pvalue/kscale);
        if(mod(ksize,2) == 0)
            ksize = ksize + 1;
        end
        ksize = max(9,ksize);
        sigma = ksize*0.12;
%         ksize =25;
        sigma4 = 1.5;
        sigma8 = 1.0;
        radius = (ksize-1)/2;

        h4 = fspecial('gaussian',ksize,sigma4);

        if (x4_-radius+1<1)  % if out of boundary 
            for ra = 0:radius-x4_-1
                h4(:,end-ra) = h4(:,end-ra)+h4(:,1);
                h4(:,1)=[];
            end
        end
        if (y4_-radius+1<1)
            for ra = 0:radius-y4_-1
                h4(end-ra,:) = h4(end-ra,:)+h4(1,:);
                h4(1,:)=[];
            end
        end
        if (x4_+ksize-radius>n4)
            for ra = 0:x4_+ksize-radius-n4-1
                h4(:,1+ra) = h4(:,1+ra)+h4(:,end);
                h4(:,end) = [];
            end
        end
        if(y4_+ksize-radius>m4)
            for ra = 0:y4_+ksize-radius-m4-1
                h4(1+ra,:) = h4(1+ra,:)+h4(end,:);
                h4(end,:) = [];
            end
        end

        h8 = fspecial('gaussian',ksize,sigma8);
        if (x8_-radius+1<1)  % if out of boundary 
            for ra = 0:radius-x8_-1
                h8(:,end-ra) = h8(:,end-ra)+h8(:,1);
                h8(:,1)=[];
            end
        end
        if (y8_-radius+1<1)
            for ra = 0:radius-y8_-1
                h8(end-ra,:) = h8(end-ra,:)+h8(1,:);
                h8(1,:)=[];
            end
        end
        if (x8_+ksize-radius>n8)
            for ra = 0:x8_+ksize-radius-n8-1
                h8(:,1+ra) = h8(:,1+ra)+h8(:,end);
                h8(:,end) = [];
            end
        end
        if(y8_+ksize-radius>m8)
            for ra = 0:y8_+ksize-radius-m8-1
                h8(1+ra,:) = h8(1+ra,:)+h8(end,:);
                h8(end,:) = [];
            end
        end

        d_map4(max(y4_-radius+1,1):min(y4_+ksize-radius,m4),max(x4_-radius+1,1):min(x4_+ksize-radius,n4))...
            = d_map4(max(y4_-radius+1,1):min(y4_+ksize-radius,m4),max(x4_-radius+1,1):min(x4_+ksize-radius,n4))...
            + h4;
        d_map8(max(y8_-radius+1,1):min(y8_+ksize-radius,m8),max(x8_-radius+1,1):min(x8_+ksize-radius,n8))...
            = d_map8(max(y8_-radius+1,1):min(y8_+ksize-radius,m8),max(x8_-radius+1,1):min(x8_+ksize-radius,n8))...
            + h8;
    end
    
%     fdid4=fopen(DmapPath4,'w');
    for h=1:m4
        for w=1:n4
            fprintf(fdid4,'%d',d_map4(h,w));
            fprintf(fdid4,' ');
        end
        fprintf(fdid4,'\n');
    end
    for h=1:m8
        for w=1:n8
            fprintf(fdid8,'%d',d_map8(h,w));
            fprintf(fdid8,' ');
        end
        fprintf(fdid8,'\n');
    end
    fclose(fdid8);
    fclose(fdid4);
    s4=sum(d_map4(:));
%     imagesc(d_map4);
    s8=sum(d_map8(:));
%     imagesc(d_map8);
    close all;

end
fclose(flid);
