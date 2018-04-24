% created by lhl
%generate density map and save as .txt file
clear;
clc;
mydir=uigetdir('/ssd/wangmaorui/data','pick a directory');
if mydir(end)~='/'
 mydir=[mydir,'/'];
end
cd(mydir);

%persDIS = [mydir,'Persp','/'];
persDIS = '/ssd/wangmaorui/data/PersMaps/matPersp/';
labelDIRS = [mydir,'Label/matLabel','/'];
dmapDIRS = [mydir,'Dmap/Dmap_8','/'];

if ~exist(dmapDIRS,'dir')
     mkdir(dmapDIRS);
end 

subDIRS = dir(labelDIRS);

for i = 1: length(subDIRS)    % i=21,scene01...
    if( isequal(subDIRS(i).name, '.' )||...
        isequal(subDIRS(i).name, '..')||...
        isequal(subDIRS(i).name, '.DS_Store')||...
        ~subDIRS(i).isdir)               
        continue;
    end

    pers_name = [persDIS, subDIRS(i).name,'.mat'];

    load(pers_name);
    display(subDIRS(i).name);

    bat_name = [labelDIRS, subDIRS(i).name,'/'];
    %wangmaorui
    bat = fullfile(bat_name);
    DIRS =dir([bat,'*.mat']);
    label_num = length(DIRS);
%    display(label_num);

    for k=1:label_num
        label_name = [bat,DIRS(k).name];
        load(label_name);
        S = regexp(DIRS(k).name, '.mat', 'split');
        name = char(S(1));
        index = name(1:20);
        bmap_name = [index,'.txt'];
        bmap_path = [dmapDIRS,subDIRS(i).name,'/'];

        if ~exist(bmap_path,'dir')
            mkdir(bmap_path);
        end
        save_name = fullfile(bmap_path,bmap_name);
%        display(save_name);
            
            
        % twice pooling, density map reduced by 2 times
        m=720/8;n=1280/8;     
        d_map = zeros(m,n);
        gt1 = gt/8;
        %PMap1=imresize(PMap,0.25);
        PMap1=imresize(PMap,0.125);
             
        if(TotalNum>0)                
            for s=1:size(gt1,1)  
                a = gt1(s,:); 
                ksize = floor(PMap1(min(max(floor(a(2)),1),m),min(max(floor(a(1)),1),n))/8);
                if(mod(ksize,2) == 0)
                    ksize = ksize + 1;
                end
                sigma = ksize*0.12;

                radius = (ksize-1)/2;

                h = fspecial('gaussian',ksize,sigma);
                x_ = max(1,floor(gt1(s,1)));
                y_ = max(1,floor(gt1(s,2)));

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
                d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...
                    = d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...
                    + h;

            end               
        end
            
        f=fopen(save_name,'w');
        for h=1:m
            for w=1:n
                fprintf(f,'%d',d_map(h,w));
                fprintf(f,' ');
            end
            fprintf(f,'\n');
        end


        fclose(f);
        imagesc(d_map);
    end
 
    s1=sum(d_map(:));
    display(s1);
end


%




