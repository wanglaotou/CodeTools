% created by zt
% convert .mat label file to .txt
% totalNum 
% x1 y1 k_size
% x2 y2 k_size

clear;  
clc;
mydir=uigetdir('/home/zhangting/zhangting/code_exp/crowd_count/data/20170725','open dir');
if mydir(end)~='/'
 mydir=[mydir,'/'];
end
cd(mydir);

labelDIRS = [mydir,'matLabel','/']; 
saveDIRS = [mydir,'Label2','/'];

subDIRS = dir(labelDIRS);

for i = 1 : length(subDIRS)    
    if( isequal(subDIRS(i).name, '.' )||...
        isequal(subDIRS(i).name, '..')||...
        isequal(subDIRS(i).name, '.DS_Store')||...
        ~subDIRS(i).isdir)               % �����Ŀ¼�����
        continue;
    end

    bat_name = [labelDIRS, subDIRS(i).name,'/'];

    batDIRS = dir(bat_name);

    for j = 1 : length(batDIRS) 
        if( isequal(batDIRS(j).name, '.' )||...
            isequal(batDIRS(j).name, '..')||...
            isequal(batDIRS(j).name, '.DS_Store')||...
            ~batDIRS(j).isdir)               % �����Ŀ¼�����
            continue;
        end
       
        bat2_name = [bat_name, batDIRS(j).name,'/'];
        bat = fullfile(bat2_name);
        DIRS = dir([bat,'*.mat']);
        label_num = length(DIRS);
        
        for k=1:label_num
            label_name = [bat,DIRS(k).name];
            load(label_name);
            S = regexp(DIRS(k).name, '.mat', 'split');
            name = char(S(1));
            %index = name(1:11); % ourdata
            index = name(1:10); % public malldata
            new_name = [index,'.txt'];
            save_path = [saveDIRS,subDIRS(i).name,'/',batDIRS(j).name,'/'];
            
            if ~exist(save_path,'dir') 
                mkdir(save_path); % ��������
            end 
            save_name = fullfile(save_path,new_name);
            fp = fopen(save_name,'wt');
            fprintf(fp, '%d', TotalNum);
            fprintf(fp,'\n');
        
            try
            for x=1:TotalNum
                if(floor(gt(x,1))<0 )
                    gt(x,1) = 0;
                    %display('error1');
                    %continue
                end
                if(floor(gt(x,2))<0)
                    gt(x,2) = 0;
                end
                
                if(floor(gt(x,1))>1280 || floor(gt(x,2))>720)
                    display('error2');   
                end
                %fprintf(fp,'%d %d',max(min(floor(gt(x,1)),1280),1),max(min(floor(gt(x,2)),720),1));
                fprintf(fp,'%d %d %d',max(min(floor(gt(x,1)),1280),1),max(min(floor(gt(x,2)),720),1),0);
                fprintf(fp,'\n');
            end  
            catch err
                continue;
            end
            fclose(fp);
        end
    end
    
end