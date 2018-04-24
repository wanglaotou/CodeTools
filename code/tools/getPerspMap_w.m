% created by lhl
% get perspective map
% Linear interpolation according to y coordinates

clear;
clc;
mydir=uigetdir('/ssd/wangmaorui/data/Test','open a scene dir');
if mydir(end)~='/'
 mydir=[mydir,'/'];
end
cd(mydir);
DIRS = dir([mydir,'*.txt']);  
n = length(DIRS);
mapValue = zeros(720,1280);

for k=1:n
     pers_name = DIRS(k).name;

     %%  get PerspMap.
     pers_txt = fullfile(mydir,pers_name); 
     S = regexp(pers_name, '.txt', 'split');
     name = char(S(1));
     save_name = [name,'_persp.mat'];
%      disp(save_name);
     save_pers = fullfile(mydir,save_name);
%      disp(save_pers);       %/ssd/wangmaorui/data/Test/scene01_persp.mat


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

     
%      figure;
%      imagesc(PMap);hold on;
%      plot(PMap);
%      hold on;
     
%      S = regexp(DIRS(k).name, '.txt', 'split');
%      name = char(S(1));
%      disp(name);
%      index = name(1:7);
%      save_name1 = [index,'.jpg'];
%      persimgpath = fullfile(mydir,'/PersMaps/jpgPersp',save_name1);
%     
%      saveas(gcf,save_name1);
%      hold off;
%      close(figure(gcf));

    %% 
     Persp_path = fullfile(mydir,save_name);
%      disp(Persp_path);      %/ssd/wangmaorui/data/Test/scene01_persp.mat
     load(Persp_path);
%      figure;
%      imagesc(PMap);hold on;
     
     
     fsid = fopen(pers_name,'r');     
     i = 1;
     while feof(fsid) == 0    
         tline{i,1} = fgetl(fsid);
         S = regexp(tline{i,1}, ' ', 'split');
  
         %% get img
         imgpath = S(1);
         imgpath = fullfile(mydir,'/Scene',imgpath);
         imgpath = imgpath{1};      %cell to string         
%          disp(imgpath);     %/ssd/wangmaorui/data/Test/Scene/scene01/20170725_frame_00200.jpg
         img = imread(imgpath);
         imshow(img);
         hold on;
         %% get label
         labelpath = S(2);
         labelpath = fullfile(mydir,'/Label/label',labelpath);
         labelpath = labelpath{1};
%          disp(labelpath);   %/ssd/wangmaorui/data/Test/Label/label/scene01/20170725_frame_00200.txt
         flid = fopen(labelpath,'r');
         while feof(flid) == 0
             labeline{i,1} = fgetl(flid);
%              disp(labline{i,1});     %read one txt's message
             Sl = regexp(labeline{i,1}, '\t', 'split');
             head = char(Sl(1));
%              disp(length(head));
             if(length(head) == 1 || length(head) == 2)              
                 headnum = head;
%                  disp(headnum); %8 9 10 9 13 6 13 10
             end
             if(length(head)>3)
                 headpos = head;
%                  disp(headpos);    %1010 324...
                 Sp = regexp(headpos, ' ', 'split');
                 pos_x = char(Sp(1));
                 pos_x = str2num(pos_x);
                 pos_y = char(Sp(2));
                 pos_y = str2num(pos_y);
%                  disp(pos_x);   %973
%                  disp(pos_y);   %337
                 plot(pos_x,pos_y,'r*');
                 
% PerspMap Validation
                 mapValue(pos_y,pos_x) = PMap(pos_y,pos_x);
                 value = mapValue(pos_y,pos_x);
                 rectangle('Position',[pos_x-value/2,pos_y-value/2,value,value],'Curvature',[1,1],'edgecolor','r');
                 
                 
             end
         end
         fclose(flid);

         i = i+1;  
     end

     fclose(fsid);          
    %% PerspMap Validation
%      cd(mydir);
%      load(save_name);
%      figure;
%      imagesc(PMap);hold on;
% %      plot(PMap);
%      hold on;

end