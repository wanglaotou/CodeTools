%rectroi.txt --> get Dmap4/8
%rectroi.txt,rectroizt.txt --> validate one scenes label info correct
clear;
clc;
mydir='/ssd/wangmaorui/data';

rectroiDIRS = fullfile(mydir,'RectRoiS');
sceneDIRS = fullfile(mydir,'RoiImg');
DmapDIRS = fullfile(mydir,'Dmap');
dmapDIRS4 = fullfile(DmapDIRS,'Dmap4');     %get Dmap4 info
dmapDIRS8 = fullfile(DmapDIRS,'Dmap8');   %get Dmap8 info
rectroipath = fullfile(rectroiDIRS,'rectrois.txt');
rectroinewpath = fullfile(rectroiDIRS,'scene41.txt');   %save new scene41 info
scale4 = 4;  %dmap4
scale8 = 8;  %dmap8
kscale = 1.0; %ksize scale
flid = fopen(rectroipath,'r');
flnid = fopen(rectroinewpath,'w');
while feof(flid) == 0
	line = fgetl(flid);		
	S = regexp(line,' ','split');
%     disp(length(S));
	imgpath = char(S(1));
    fprintf(flnid,'%s',imgpath);    %1-->imgpath
    head = char(S(2));
    fprintf(flnid,'%s%s',' ',head);       %2-->head
    head = str2num(head);
    rects = [];
    for i = 3:3:length(S)
        pos_x = str2num(char(S(i+1)));
        pos_y = str2num(char(S(i+2)));
%         wid = str2num(char(S(i+3)));
%         hei = str2num(char(S(i+4)));
        rects = [rects;pos_x];
        rects = [rects;pos_y];
%         rects = [rects;wid];
%         rects = [rects;hei];
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
    dmapp8 = fullfile(dmapDIRS8,scenename);
%     if ~exist(dmapp4)
%         mkdir(dmapp4);
%     end
%     if ~exist(dmapp8)
%         mkdir(dmapp8);
%     end
	DmapPath4 = fullfile(dmapp4,dmapname);	%get DmapPath4
    DmapPath4 = char(DmapPath4);
    DmapPath8 = fullfile(dmapp8,dmapname);	%get DmapPath8
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

%     fdid4=fopen(DmapPath4,'w');
%     fprintf(fdid4,'%d%s%d',m4,' ',n4);
%     fprintf(fdid4,'\n');
%     fdid8=fopen(DmapPath8,'w');
%     fprintf(fdid8,'%d%s%d',m8,' ',n8);
%     fprintf(fdid8,'\n');
    for k=1:2:length(rects)
        rect_x = ceil(rects(k)*(2/3));
        rect_y = ceil(rects(k+1)*(2/3));
%         pvalue = ceil(rects(k+2) * 2/3);
%         rect_x = ceil(rect_x - pvalue/2);
%         rect_y = ceil(rect_y - pvalue/2);
        fprintf(flnid,'%s',' ');
        fprintf(flnid,'%d',1);
        fprintf(flnid,'%s',' ');
        fprintf(flnid,'%d',rect_x);
        fprintf(flnid,'%s',' ');
        fprintf(flnid,'%d',rect_y);
%         fprintf(flnid,'%s',' ');
%         fprintf(flnid,'%d',pvalue);
%         fprintf(flnid,'%s',' ');
%         fprintf(flnid,'%d',pvalue);
%         plot(rect_x,rect_y,'r*');
%         rectangle('Position',[rect_x-pvalue/2,rect_y-pvalue/2,pvalue,pvalue],'edgecolor','r');
%         pwid = rect(k+2);
%         phei = rects(k+3);
%         %dmap4
%         rect_x4 = rect_x/scale4;
%         rect_y4 = rect_y/scale4;
%        
%         if(rect_x4 + pvalue/2 >= n4)
%             rect_x4 = rect_x4 - pvalue/2;
%         end
%         if(rect_y4 + pvalue/2 >= m4)
%             rect_y4 = rect_y4 - pvalue/2;
%         end
%         
%         x4_ = max(1,floor(rect_x4));
%         y4_ = max(1,floor(rect_y4));
%         %dmap8
%         rect_x8 = rect_x/scale8;
%         rect_y8 = rect_y/scale8;
%        
%         if(rect_x8 + pvalue/2 >= n8)
%             rect_x8 = rect_x8 - pvalue/2;
%         end
%         if(rect_y8 + pvalue/2 >= m8)
%             rect_y8 = rect_y8 - pvalue/2;
%         end
%        
%         x8_ = max(1,floor(rect_x8));
%         y8_ = max(1,floor(rect_y8));
% 
%         ksize = floor(pvalue/kscale);
%         if(mod(ksize,2) == 0)
%             ksize = ksize + 1;
%         end
%         
% %         ksize8 = max(9,ksize8);
%         ksize = floor(pvalue/kscale);
%         if(mod(ksize,2) == 0)
%             ksize = ksize + 1;
%         end
%         ksize = max(9,ksize);
% 
% %         sigma = ksize*0.12;
% %         ksize =25;
%         sigma4 = 1.5;
%         sigma8 = 1.0;
%         radius = (ksize-1)/2;
% 
%         h4 = fspecial('gaussian',ksize,sigma4);
% 
%         if (x4_-radius+1<1)  % if out of boundary 
%             for ra = 0:radius-x4_-1
%                 h4(:,end-ra) = h4(:,end-ra)+h4(:,1);
%                 h4(:,1)=[];
%             end
%         end
%         if (y4_-radius+1<1)
%             for ra = 0:radius-y4_-1
%                 h4(end-ra,:) = h4(end-ra,:)+h4(1,:);
%                 h4(1,:)=[];
%             end
%         end
%         if (x4_+ksize-radius>n4)
%             for ra = 0:x4_+ksize-radius-n4-1
%                 h4(:,1+ra) = h4(:,1+ra)+h4(:,end);
%                 h4(:,end) = [];
%             end
%         end
%         if(y4_+ksize-radius>m4)
%             for ra = 0:y4_+ksize-radius-m4-1
%                 h4(1+ra,:) = h4(1+ra,:)+h4(end,:);
%                 h4(end,:) = [];
%             end
%         end
%         
%         
%         h8 = fspecial('gaussian',ksize,sigma8);
%         if (x8_-radius+1<1)  % if out of boundary 
%             for ra = 0:radius-x8_-1
%                 h8(:,end-ra) = h8(:,end-ra)+h8(:,1);
%                 h8(:,1)=[];
%             end
%         end
%         if (y8_-radius+1<1)
%             for ra = 0:radius-y8_-1
%                 h8(end-ra,:) = h8(end-ra,:)+h8(1,:);
%                 h8(1,:)=[];
%             end
%         end
%         if (x8_+ksize-radius>n8)
%             for ra = 0:x8_+ksize-radius-n8-1
%                 h8(:,1+ra) = h8(:,1+ra)+h8(:,end);
%                 h8(:,end) = [];
%             end
%         end
%         if(y8_+ksize-radius>m8)
%             for ra = 0:y8_+ksize-radius-m8-1
%                 h8(1+ra,:) = h8(1+ra,:)+h8(end,:);
%                 h8(end,:) = [];
%             end
%         end
% 
%         d_map4(max(y4_-radius+1,1):min(y4_+ksize-radius,m4),max(x4_-radius+1,1):min(x4_+ksize-radius,n4))...
%             = d_map4(max(y4_-radius+1,1):min(y4_+ksize-radius,m4),max(x4_-radius+1,1):min(x4_+ksize-radius,n4))...
%             + h4;
%         d_map8(max(y8_-radius+1,1):min(y8_+ksize-radius,m8),max(x8_-radius+1,1):min(x8_+ksize-radius,n8))...
%             = d_map8(max(y8_-radius+1,1):min(y8_+ksize-radius,m8),max(x8_-radius+1,1):min(x8_+ksize-radius,n8))...
%             + h8;
    end

%     for h=1:m4
%         for w=1:n4
%             fprintf(fdid4,'%d',d_map4(h,w));
%             fprintf(fdid4,' ');
%         end
%         fprintf(fdid4,'\n');
%     end
%     for h=1:m8
%         for w=1:n8
%             fprintf(fdid8,'%d',d_map8(h,w));
%             fprintf(fdid8,' ');
%         end
%         fprintf(fdid8,'\n');
%     end
%     fclose(fdid8);
%     fclose(fdid4);
%     s4=sum(d_map4(:));
%     imagesc(d_map4);
%     s8=sum(d_map8(:));
%     imagesc(d_map8);
%     close all;
    fprintf(flnid,'\n');
end
fclose(flnid);
fclose(flid);
