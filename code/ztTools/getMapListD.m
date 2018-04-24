%%test for Expo dataset to get dmap
clear;
clc;
mydir=uigetdir('/Users/ling/Desktop/','选择一个目录');
if mydir(end)~='/'
 mydir=[mydir,'/'];
end
cd(mydir);

imgDIRS = [mydir,'Image','/'];
labelDIRS = [mydir,'oldLabel','/'];
persDIRS = [mydir,'Pres','/'];

subDIRS = dir(labelDIRS);
map_name = [mydir,'map_new.txt'];
fp = fopen(map_name,'wt');


for i = 1 : length(subDIRS)    
    if( isequal(subDIRS(i).name, '.' )||...
        isequal(subDIRS(i).name, '..')||...
        isequal(subDIRS(i).name, '.DS_Store')||...
        ~subDIRS(i).isdir)               % 如果不是目录则跳过
        continue;
    end
    %bat1_name = subDIRS(i).name;
    bat_name = [labelDIRS, subDIRS(i).name,'/'];
    display(bat_name);
    batDIRS = dir(bat_name);
    
    S = [subDIRS(i).name, '.mat'];
    %name = char(S);
    pers_path= [persDIRS,S];
    load(pers_path);
    
    for j = 1 : length(batDIRS) 
        if( isequal(batDIRS(j).name, '.' )||...
            isequal(batDIRS(j).name, '..')||...
            isequal(batDIRS(j).name, '.DS_Store')||...
            ~batDIRS(j).isdir)               % 如果不是目录则跳过
            continue;
        end
        bat2_name = [bat_name, batDIRS(j).name,'/'];
        display(bat2_name);
        display(batDIRS(j).name);
        bat = fullfile(bat2_name);
        DIRS = dir([bat,'*.mat']);
        n = length(DIRS);
        display(n);
        num = 0;
        for k=1:n
            
            label_name = [bat,DIRS(k).name];
            load(label_name);
            S = regexp(DIRS(k).name, '.mat', 'split');
            name = char(S(1));
            index = name(1:11);
            img_name = [index,'.jpg'];
            img_path = ['Image/',subDIRS(i).name,'/',batDIRS(j).name,'/',img_name];
            %display(img_path);
            %display(TotalNum);
            sum = TotalNum;
            fprintf(fp, '%s %d', img_path,sum);
            fprintf(fp, ' ');
            if(TotalNum>0)
                 
%                  img = imread(img_path);
%                  imshow(img); hold on;
                 modify = [ThreePoint(:,1:2);OnePoint];
                 
                 for e = 1:TotalNum
                     a = modify(e,:); 
                     p=PMap(min(max(floor(a(2)),1),1280),min(max(floor(a(1)),1),720));
                     
                     d = floor(p*0.5);                    
                     modify(e,2) = min((modify(e,2) + d),720);                    
                 end

             
                 m=720;n=1280;

                 gt = modify(:,1:2);
           
                 %plot(gt(:,1),gt(:,2),'r*');
                 %d_map = zeros(m,n);
                  % size(gt,1)第i帧的总人头数，从1-size(gt,1)人头数
                 

                 for f=1:size(gt,1)
                     % ceil:向上取整；floor:向下取整；pMapN:双线性内插值算法
                     p2=PMap(min(max(floor(gt(f,2)),1),1280),min(max(floor(gt(f,1)),1),720));
                     
                     ksize = floor(p2);
                     ksize2 = floor(p2*1.5);

                     if(mod(ksize,2) == 0)
                         ksize = ksize + 1;
                     end
                     if(mod(ksize2,2) == 0)
                         ksize2 = ksize2 + 1;
                     end
                     %display(ksize);
                     
                     radius = ceil((ksize-1)/2);
                     radius2 = ceil((ksize2-1)/2);
                     
                     leftup_x = gt(f,1)-radius2;
                     leftup_y = gt(f,2)-radius-floor(radius*0.12);
                     
                     %X = [leftup_x,leftup_x+ksize2,leftup_x+ksize2,leftup_x,leftup_x];
                     %Y = [leftup_y-floor(radius*0.2),leftup_y-floor(radius*0.2),leftup_y+ksize2,leftup_y+ksize2,leftup_y-floor(radius*0.2)];       
                     fprintf(fp, '%s %d %d %d %d ','1',min(max(floor(leftup_x),1),1280),min(max(floor(leftup_y),1),720),floor(ksize2),floor(ksize2));
 
                 end
                 
                 
            end
            fprintf(fp,'\n');
    
        end
    end
end