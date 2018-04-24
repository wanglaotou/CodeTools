%rectroi01_21.txt --> Dmap4/8
clear;
clc;
mydir='/ssd/wangmaorui/data';

rectroiDIRS = fullfile(mydir,'RectRoi');
sceneDIRS = fullfile(mydir,'RoiImg');
DmapDIRS = fullfile(mydir,'Dmap');
dmapDIRS4 = fullfile(DmapDIRS,'Dmap4roihalf');     %get Dmap4 info
rectroipath = fullfile(rectroiDIRS,'rectroi01_21.txt');
scale4 = 4;  %dmap4
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
	scenename = char(Sl(6));
	jpgname = char(Sl(7));
    Sj = regexp(jpgname,'.jpg','split');
    dmapfo = char(Sj(1));
    dmapname = strcat(dmapfo,'.txt');
	dmapp4 = fullfile(dmapDIRS4,scenename);
    if ~exist(dmapp4)
        mkdir(dmapp4);
    end
	DmapPath4 = fullfile(dmapp4,dmapname);	%get DmapPath4
    DmapPath4 = char(DmapPath4);

    %show img
    img = imread(imgpath);
%     figure;
%     imshow(img);
%     hold on;
    [rwidth,rheight,chan] = size(img);
    
    %get dmap
%     make width,height divisible by 16
%     width = ceil(rwidth/16)*16;
%     height = ceil(rheight/16)*16;
    m4=ceil(rwidth/2/scale4);n4=ceil(rheight/2/scale4);
    d_map4 = zeros(m4,n4);

%     img4 = imresize(img,[m4,n4],'nearest');
%     figure;
%     imshow(img4);
%     hold on;
% 
    fdid4=fopen(DmapPath4,'w');
    fprintf(fdid4,'%d%s%d',n4,' ',m4);
    fprintf(fdid4,'\n');
    
    for k=1:4:length(rects)
        rect_x = floor(rects(k)/2);
        rect_y = floor(rects(k+1)/2);
        pvalue = ceil(rects(k+2)/2);
%         plot(rect_x,rect_y,'r*');
%         rectangle('Position',[rect_x,rect_y,pvalue,pvalue],'edgecolor','r');
%         %%test
        rectx4 = rect_x/scale4;
        recty4 = rect_y/scale4;
        if(rectx4 + pvalue/4 > n4)
            rectx4 = rectx4 - pvalue/4;
        end
        if(recty4 + pvalue/4 > m4)
            recty4 = recty4 - pvalue/4;
        end
%         plot(rectx4,recty4,'r*');
%         rectangle('Position',[rectx4,recty4,pvalue/4,pvalue/4],'edgecolor','r');

%%dmap4
        rect_x4 = rect_x/scale4;
        rect_y4 = rect_y/scale4;
%out of boundary in the right down corner
	    if(rect_x4 + pvalue/4 >= n4)
            rect_x4 = rect_x4 - pvalue/4;
        end
        if(rect_y4 + pvalue/4 >= m4)
            rect_y4 = rect_y4 - pvalue/4;
        end
        
        x4_ = max(1,floor(rect_x4));
        y4_ = max(1,floor(rect_y4));
%         ksize4 = floor(pvalue/scale4);
        ksize4 = floor(pvalue/scale4);
%         ksize4 = 25;
        if(mod(ksize4,2) == 0)
            ksize4 = ksize4 + 1;
        end
        sigma4 = ksize4*0.12;
%         sigma4 = 1.5;
        radius4 = (ksize4-1)/2;

        h4 = fspecial('gaussian',ksize4,sigma4);
        if (x4_-radius4+1<1)  % if out of boundary 
            for ra = 0:radius4-x4_-1
                h4(:,end-ra) = h4(:,end-ra)+h4(:,1);
                h4(:,1)=[];
            end
        end
        if (y4_-radius4+1<1)
            for ra = 0:radius4-y4_-1
                h4(end-ra,:) = h4(end-ra,:)+h4(1,:);
                h4(1,:)=[];
            end
        end
        if (x4_+ksize4-radius4>n4)
            for ra = 0:x4_+ksize4-radius4-n4-1
                h4(:,1+ra) = h4(:,1+ra)+h4(:,end);
                h4(:,end) = [];
            end
        end
        if(y4_+ksize4-radius4>m4)
            for ra = 0:y4_+ksize4-radius4-m4-1
                h4(1+ra,:) = h4(1+ra,:)+h4(end,:);
                h4(end,:) = [];
            end
        end
        d_map4(max(y4_-radius4+1,1):min(y4_+ksize4-radius4,m4),max(x4_-radius4+1,1):min(x4_+ksize4-radius4,n4))...
            = d_map4(max(y4_-radius4+1,1):min(y4_+ksize4-radius4,m4),max(x4_-radius4+1,1):min(x4_+ksize4-radius4,n4))...
            + h4;
    end
    for h=1:m4
        for w=1:n4
            fprintf(fdid4,'%d',d_map4(h,w));
            fprintf(fdid4,' ');
        end
        fprintf(fdid4,'\n');
    end
    fclose(fdid4);
    s4=sum(d_map4(:));
%     figure;
%     imagesc(d_map4);
%     pause;
    close all;

end
fclose(flid);
