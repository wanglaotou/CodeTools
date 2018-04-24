%rectroi01_21.txt --> Dmap4/8
clear;
clc;
mydir='/ssd/wangmaorui/data';

rectroiDIRS = fullfile(mydir,'RectRoi');
sceneDIRS = fullfile(mydir,'RoiImg');
DmapDIRS = fullfile(mydir,'Dmap');
dmapDIRS4 = fullfile(DmapDIRS,'Dmap4_crowd1_5_test3');     %get Dmap4 info
% dmapDIRS8 = fullfile(DmapDIRS,'Dmap8_crowd1_5_test2');   %get Dmap8 info
rectroipath = fullfile(rectroiDIRS,'rectroitest.txt');
scale4 = 4;  %dmap4
% scale8 = 8;  %dmap8
% kscale4 = 1.2; %ksize scale
% kscale8 = 2.0;
flid = fopen(rectroipath,'r');
while feof(flid) == 0
	line = fgetl(flid);		
	S = regexp(line,' ','split');
%     disp(length(S));
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
%     disp(length(rects));
%     rect = char(S(2));
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
%     dmapp8 = fullfile(dmapDIRS8,scenename);
%     if ~exist(dmapp8)
%         mkdir(dmapp8);
%     end
	DmapPath4 = fullfile(dmapp4,dmapname);	%get DmapPath4
    DmapPath4 = char(DmapPath4);
%     DmapPath8 = fullfile(dmapp8,dmapname);  %get DmapPath8
%     DmapPath8 = char(DmapPath8);
%     disp(DmapPath);     %/ssd/wangmaorui/data/Dmap/Dmap4(8)/scene21/20170808_frame_02350.txt     
    
    %show img
    img = imread(imgpath);
%     imshow(img);
%     hold on;
    [rwidth,rheight,chan] = size(img);
    
    %get dmap
%     make width,height divisible by 16
%     width = ceil(rwidth/16)*16;
%     height = ceil(rheight/16)*16;
    m4=ceil(rwidth/scale4);n4=ceil(rheight/scale4);
    d_map4 = zeros(m4,n4);
%     m8=ceil(rwidth/scale8);n8=ceil(rheight/scale8);
%     d_map8 = zeros(m8,n8);
%     img4 = imresize(img,[m4,n4],'nearest');
%     imshow(img4);
%     hold on;

%     fdid4=fopen(DmapPath4,'w');
%     fprintf(fdid4,'%d%s%d',n4,' ',m4);
%     fprintf(fdid4,'\n');
%     fdid8=fopen(DmapPath8,'w');
%     fprintf(fdid8,'%d%s%d',n8,' ',m8);
%     fprintf(fdid8,'\n');
    for k=1:4:length(rects)
        rect_x = rects(k);
        rect_y = rects(k+1);
        pvalue = rects(k+2);
        rect_x = floor(rect_x + pvalue/2);
        rect_y = floor(rect_y + pvalue/2);
%         plot(rect_x,rect_y,'r*');
%         rectangle('Position',[rect_x,rect_y,pvalue,pvalue],'edgecolor','r');
%         %%test
%         rectx4 = rect_x/scale4;
%         recty4 = rect_y/scale4;
%         if(rectx4 + pvalue/4 > height4)
%             rectx4 = rectx4 - pvalue/4;
%         end
%         if(recty4 + pvalue/4 > width4)
%             recty4 = recty4 - pvalue/4;
%         end
%         plot(rectx4,recty4,'r*');
%         rectangle('Position',[rectx4,recty4,pvalue/4,pvalue/4],'edgecolor','r');

%dmap4
        rect_x4 = floor(rect_x/scale4);
        rect_y4 = floor(rect_y/scale4);
%out of boundary in the right down corner
	    if(rect_x4 + pvalue/8 >= n4)
            rect_x4 = rect_x4 - pvalue/8;
        end
        if(rect_y4 + pvalue/8 >= m4)
            rect_y4 = rect_y4 - pvalue/8;
        end
%         rectangle('Position',[rect_x4,rect_y4,pvalue/4,pvalue/4],'edgecolor','r');
        
        x4_ = max(1,floor(rect_x4));
        y4_ = max(1,floor(rect_y4));

        ksize4 = floor(pvalue/scale4);
        if(mod(ksize4,2) == 0)
            ksize4 = ksize4 + 1;
        end
        sigma4 = ksize4*0.12;
        radius4 = (ksize4-1)/2;
% %dmap8
%         rect_x8 = rect_x/scale8;
%         rect_y8 = rect_y/scale8;
% %out of boundary in the right down corner
%         if(rect_x8 + pvalue/2 >= n8)
%             rect_x8 = rect_x8 - pvalue/2;
%         end
%         if(rect_y8 + pvalue/2 >= m8)
%             rect_y8 = rect_y8 - pvalue/2;
%         end
%         x8_ = max(1,floor(rect_x8));
%         y8_ = max(1,floor(rect_y8));
% 
%         ksize8 = floor(pvalue/scale8);
%         if(mod(ksize8,2) == 0)
%             ksize8 = ksize8 + 1;
%         end
%         sigma8 = ksize8*0.12;
%         radius8 = (ksize8-1)/2;

        h4 = fspecial('gaussian',ksize4,sigma4);
%         h8 = fspecial('gaussian',ksize8,sigma8);
%dmap4
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
% %dmap8
%         if (x8_-radius8+1<1)  % if out of boundary 
%             for ra = 0:radius8-x8_-1
%                 h8(:,end-ra) = h8(:,end-ra)+h8(:,1);
%                 h8(:,1)=[];
%             end
%         end
%         if (y8_-radius8+1<1)
%             for ra = 0:radius8-y8_-1
%                 h8(end-ra,:) = h8(end-ra,:)+h8(1,:);
%                 h8(1,:)=[];
%             end
%         end
%         if (x8_+ksize8-radius8>n8)
%             for ra = 0:x8_+ksize8-radius8-n8-1
%                 h8(:,1+ra) = h8(:,1+ra)+h8(:,end);
%                 h8(:,end) = [];
%             end
%         end
%         if(y8_+ksize8-radius8>m8)
%             for ra = 0:y8_+ksize8-radius8-m8-1
%                 h8(1+ra,:) = h8(1+ra,:)+h8(end,:);
%                 h8(end,:) = [];
%             end
%         end
%         d_map8(max(y8_-radius8+1,1):min(y8_+ksize8-radius8,m8),max(x8_-radius8+1,1):min(x8_+ksize8-radius8,n8))...
%             = d_map8(max(y8_-radius8+1,1):min(y8_+ksize8-radius8,m8),max(x8_-radius8+1,1):min(x8_+ksize8-radius8,n8))...
%             + h8;
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

%     for h=1:m8
%         for w=1:n8
%             fprintf(fdid8,'%d',d_map8(h,w));
%             fprintf(fdid8,' ');
%         end
%         fprintf(fdid8,'\n');
%     end
%     fclose(fdid8);
%     s8=sum(d_map8(:));
%     imagesc(d_map4);
%     figure;
%     imagesc(d_map8);
%     pause;
    close all;
end
fclose(flid);
