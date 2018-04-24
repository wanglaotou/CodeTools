% created by lhl
clear;
clc;
mydir=uigetdir('/Users/ling/Desktop/','选择一个目录');
if mydir(end)~='/'
 mydir=[mydir,'/'];
end
cd(mydir);
DIRS = dir([mydir,'*.mat']);
save_dir = '/Users/ling/Desktop/Clean/Data/Persptxt/';
n = length(DIRS);
for k=1:n
     pers_name = DIRS(k).name;
     pers_mat = fullfile(mydir,pers_name);
     load(pers_mat);     
     S = regexp(pers_name, '.mat', 'split');
     name = char(S(1));
     
     save_name = [name,'.txt'];
     save_pers = fullfile(save_dir,save_name);
     
    f=fopen(save_pers,'w');
    for h=1:720
        for w=1:1280
            fprintf(f,'%d',PMap(h,w));
            fprintf(f,' ');
        end
        fprintf(f,'\n');
    end
    fclose(f);
    
end
