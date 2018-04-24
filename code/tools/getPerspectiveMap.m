% created by lhl
% get perspective map
% Linear interpolation according to y coordinates

clear;
clc;
Scenedir=uigetdir('/ssd/wangmaorui/data/Test/Scene','open a directory');
if Scenedir(end)~='/'
 Scenedir=[Scenedir,'/'];
end
cd(Scenedir);
DIRS = dir([Scenedir,'*.txt']);  
n = length(DIRS);
disp(n);
for k=1:n
     pers_name = DIRS(k).name;
%      disp(pers_name);   %scene01.txt
     fid = fopen(pers_name,'r');
     
     fclose(fid);
     
     pers_txt = fullfile(Scenedir,pers_name); 
     S = regexp(pers_name, '.txt', 'split');
     name = char(S(1));
     save_name = [name,'_persp.mat'];
     %disp(save_name);
     save_pers = fullfile(Scenedir,save_name);

     %scene13
     
     Y=[1,260,312,360,400,450,500,530,630,720];
     value =[6,8,14,16,26,30,36,38,44,48];

     PMap = zeros(720,1280);
     
     for i = 1:720        
         PMap(i,1)=interp1(Y,value,i,'linear');
         for j = 1:1280
              PMap(i,j)= PMap(i,1);
         end
     end     
     
     save(save_pers,'PMap');
     cd(Scenedir);
     load(save_name);
     imagesc(PMap);hold on;
    
end
