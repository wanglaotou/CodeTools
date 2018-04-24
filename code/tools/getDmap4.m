clear;
clc;
mydir='/ssd/wangmaorui/data/Test';
persDIRS = '/ssd/wangmaorui/data/Test/PersMaps/matPersp';
sceneDIRS = fullfile(mydir,'Scene');
labelDIRS = fullfile(mydir,'Label');
labelDDIRS = fullfile(labelDIRS,'label');
dmapDIRS = fullfile(mydir,'Dmap4');     %get Dmap4 info
% dmapDIRS = fullfile(mydir,'Dmap8');   %get Dmap8 info
label_name = fullfile(labelDIRS,'labelall.txt');
scale = 4;  %dmap4
% scale = 8;  %dmap8
flid = fopen(label_name,'r');
while feof(flid) == 0
	line = fgetl(flid);		%'/ssd/wangmaorui/data/Test/Label/label/scene53/20171122_frame_7.txt'...
	S = regexp(line,' ','split');
	labelpath = char(S(1));
	Sl = regexp(labelpath,'/','split');
	scenename = Sl(8);
	dmapname = Sl(9);
	dmapp = fullfile(dmapDIRS,scenename);
    if ~exist(dmapp)
        mkdir(dmapp);
    end
	DmapPath = fullfile(dmapp,dmapname);	%get DmapPath
    DmapPath = char(DmapPath);
%     disp(DmapPath);     %'/ssd/wangmaorui/data/Test/Dmap_4/scene53/20171122_frame_7.txt' 

    persname = fullfile(persDIRS,scenename);
    persPath = strcat(persname,'.mat');     %get Perspmat --> Pmap
    persPath = char(persPath);
%     disp(persPath);
    load(persPath);
    
    dmapname = char(dmapname);
    Sdf = regexp(dmapname,'.txt','split');    %get scene jpg
    dmapnamef = Sdf(1);
	sceneDDir = fullfile(sceneDIRS,scenename);
    scene_name = fullfile(sceneDDir,dmapnamef);
    scenejpg = strcat(scene_name,'.jpg');
    scenejpg = char(scenejpg);
    img = imread(scenejpg);
    [width,height,c] = size(img);

%     make width,height divisible by 16
    width = ceil(width/16)*16;
    height = ceil(height/16)*16;
    
    m=width/scale;n=height/scale;
    d_map = zeros(m,n);
    fwid = fopen(line,'r');                 %get label info
    while feof(fwid) == 0
        PMap1=imresize(PMap,1/scale);
        labelline = fgetl(fwid);
    	Sw = regexp(labelline,' ','split');
     	if(length(Sw)==1)
     		headnum = char(Sw(1));
            headnum = str2num(headnum);
        end
            if(length(Sw)==2)
                pos_x = char(Sw(1));
                pos_y = char(Sw(2));
                pos_x = str2num(pos_x);
                pos_y = str2num(pos_y);
                pos_x = pos_x/scale;
                pos_y = pos_y/scale;
                x_ = max(1,floor(pos_x));
                y_ = max(1,floor(pos_y));
                if(headnum>0)
                    ksize = floor(PMap1(min(max(floor(pos_y),1),m),min(max(floor(pos_x),1),n))/scale);
                    if(mod(ksize,2) == 0)
                        ksize = ksize + 1;
                    end
%                     ksize = max(25,ksize);
                    sigma = ksize*0.12;
                    radius = (ksize-1)/2;

                    h = fspecial('gaussian',ksize,sigma);

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
                end
                d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...
                    = d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...
                    + h;
%                 end
            end
        
    end
    fdid=fopen(DmapPath,'w');
    for h=1:m
        for w=1:n
            fprintf(fdid,'%d',d_map(h,w));
            fprintf(fdid,' ');
        end
        fprintf(fdid,'\n');
    end
    fclose(fdid);
    s1=sum(d_map(:));
%     imagesc(d_map);
    fclose(fwid);
    close all;

end
fclose(flid);
