% created by lhl
% get perspective map
% Linear interpolation according to y coordinates

clear;
clc;
mydir=uigetdir('/ssd/wangmaorui/data/Test/Scene/','open a dir');
if mydir(end)~='/'
 mydir=[mydir,'/'];
end
cd(mydir);
DIRS = dir([mydir,'*.txt']);  
n = length(DIRS);

for k=1:n
     pers_name = DIRS(k).name;
     pers_txt = fullfile(mydir,pers_name);
%      a = load(pers_txt);   %coordinate(x,y,value)  
     S = regexp(pers_name, '.txt', 'split');
     name = char(S(1));
     save_name = [name,'.mat'];
     save_pers = fullfile(mydir,save_name);
     
     %scene03 
     X=[1,100,200,400,600,800,1000,1280];
     Y=[1,100,200,300,400,500,600,720];
     value =[6,8,16,30,40,50,56,60;
            6,10,20,30,40,50,60,62;
            8,12,20,36,52,58,62,66;
            8,14,24,40,50,58,64,70;
            8,14,30,36,46,54,64,70;
            8,12,28,38,52,58,66,70;
            8,10,22,32,44,56,64,70;
            8,10,18,26,38,50,60,70];

     PMap = zeros(720,1280);
     
%      for i = 1:720        
%          PMap(i,1)=interp1(Y,value,i,'linear');
%          for j = 1:1280
%               PMap(i,j)= PMap(i,1);
%          end
%      end     

     for i = 1:1280
         for j = 1:720
             PMap(j,i)=interp2(X,Y,value,j,i,'spline');
             
            
         end
     end
     
%      persp=load(scene01.mat);
%      imagesc(persp);hold on;
     
     
     save(save_pers,'PMap');
    
end
