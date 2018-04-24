% created by lhl
% get perspective map
% Linear interpolation according to y coordinates
% get each scene's PerspMap(from scene22-53)
clear;
clc;

    mydir = '/ssd/wangmaorui/data/Test/Testlabel/scene53_total';
%     mydir=uigetdir(opendir,'open a scene dir');
    if mydir(end)~='/'
     mydir=[mydir,'/'];
    end
    cd(mydir);
    DIRS = dir([mydir,'*.txt']);  
    n = length(DIRS);
    roi_path = '/ssd/wangmaorui/data/Test/Testlabel/scene53_total/roi53';
    roinewname = 'roi53_new.txt';
    roinewpath = fullfile(roi_path,roinewname);
%     roinewpath = '/ssd/wangmaorui/data/Test/Testlabel/scene33_total/roi33/roi33_new.txt';
    if roi_path(end)~='/'
     roi_path=[roi_path,'/'];
    end
    roiDIRs = dir([roi_path,'*.txt']);
    m = length(roiDIRs);
    global roi_name;
    for l=1:m       %m=1
        roi_name = roiDIRs(l).name;
    end
    roifullpath = fullfile(roi_path,roi_name);
    mapValue = zeros(720,1280);
    for k=1:n       %n=1
         pers_name = DIRS(k).name;
         %%  get PerspMap.
         pers_txt = fullfile(mydir,pers_name); 
         S = regexp(pers_name, '.txt', 'split');
         name = char(S(1));
         save_name = [name,'_persp.mat'];       %advice to change Persp name(such as scene22.mat)
         save_pers = fullfile(mydir,save_name);  
         
%          %scene22     --->OK lift
%          Y=[1,260,310,360,400,450,500,530,620,720];
%          value =[8,12,14,20,24,26,26,28,50,52];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene22     --->OK lift
%         X=[1,100,200,400,600,800,1000,1280];
%         Y=[1,100,200,300,400,500,600,720];
%         value =[8,10,14,14,10,10,10,8;
%             12,12,14,14,20,20,14,12;
%             14,14,16,20,24,24,18,16;
%             18,20,24,26,26,26,22,20;
%             20,24,28,26,26,26,26,24;
%             30,32,34,26,26,26,30,30;
%             40,40,42,46,46,46,44,44;
%             50,52,52,52,50,50,50,50];
% 
%         PMap = zeros(720,1280);
%         for i = 1:1280
%           for j = 1:720
%              PMap(j,i)=interp2(X,Y,value,j,i,'linear');
%              
%           end
%         end

% %            scene23      --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,17,24,31,38,45,52,60,65];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene24     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[10,14,20,28,36,42,46,54,60,64];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');

%            %scene25     --->OK lift
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,14,18,22,32,42,46,50,54];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene26     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,17,24,31,38,45,52,60,65];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');       
         
%            %scene27     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,17,24,31,38,45,52,60,65];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene28     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,17,24,31,38,45,52,60,65];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene29     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,17,24,31,38,45,52,60,65];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%           %scene30     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,8,12,18,28,32,38,42,46,48];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene31     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,8,12,18,24,30,36,40,42,44];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene32     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[30,34,38,42,46,48,50,54,56,56];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene33     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,14,20,26,30,36,42,48,52];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene34     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,14,20,26,30,36,40,44,48];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene35     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,14,16,18,20,30,42,46,50];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%           %scene36     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,16,18,30,38,44,50,54,60];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene37     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,12,14,18,24,28,32,34,38];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene38     --->OK 
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,10,12,14,18,22,26,28,32,34];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene39     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[10,16,20,26,30,40,44,52,56,58];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');

%          %scene40     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,16,20,26,30,40,44,50,54,56];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
% %          scene41     --->OK
%          Y=[1,100,200,310,420,540,740,880,960,1080];
%          value =[10,16,22,28,36,42,50,60,68,72];
%          PMap = zeros(720,1280);
%          for i = 1:1080        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1920
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene42     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,14,20,26,30,40,44,48,54,56];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene43     --->??? no body
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,14,18,24,28,38,42,48,52,54];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');

%          %scene44     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[12,18,22,34,42,46,50,54,60,66];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene45     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,14,18,28,32,36,40,44,46,48];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene46     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[8,14,16,22,26,32,38,42,46,48];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%           %scene47     --->OK
%          Y=[1,80,160,240,320,400,480,560,640,720];
%          value =[16,24,32,38,46,54,60,64,68,70];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene48     --->OK
%          Y=[1,80,160,240,300,360,440,560,640,720];
%          value =[10,16,22,28,32,40,44,48,52,56];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene49     --->OK
%          Y=[1,80,160,240,300,360,440,560,640,720];
%          value =[8,12,18,22,28,34,40,44,48,52];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%           %scene50     --->OK  lift
%          Y=[1,80,160,240,300,360,440,560,640,720];
%          value =[10,12,16,20,26,32,38,44,48,52];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene51     --->OK
%          Y=[1,80,160,240,300,360,440,560,640,720];
%          value =[10,12,18,22,28,36,42,44,50,54];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
%          %scene52     --->OK    lift
%          Y=[1,80,160,240,300,360,440,560,640,720];
%          value =[8,8,16,22,28,34,40,44,48,52];
%          PMap = zeros(720,1280);
%          for i = 1:720        
%              PMap(i,1)=interp1(Y,value,i,'linear');
%              for j = 1:1280
%                   PMap(i,j)= PMap(i,1);
%              end
%          end    
%          save(save_pers,'PMap');
         
         %scene53     --->OK
         Y=[1,80,160,240,300,360,440,560,640,720];
         value =[8,10,16,20,26,32,38,42,46,50];
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

%          figure;
         fsid = fopen(pers_name,'r');     
         i = 1;
         while feof(fsid) == 0    
             tline{i,1} = fgetl(fsid);
             S = regexp(tline{i,1}, ' ', 'split');

             %% get img
             imgpath = S(1);
             imgpath = fullfile(mydir,imgpath);
             imgpath = imgpath{1};      %cell to string         
    %          disp(imgpath);     %/ssd/wangmaorui/data/Test/Testlabel/scene22_total/scene22/20171122_frame_0.jpg
             img = imread(imgpath);
             figure;
             imshow(img);
             hold on;
             
             %%show roi             
             frid = fopen(roifullpath,'r');
             frwid = fopen(roinewpath,'w');
             while ~feof(frid)
                roinewline = fgetl(frid);
             end
             fprintf(frwid, '%s\n', roinewline);
             frid = fopen(roifullpath,'r');
             while feof(frid) == 0
                roiline{i,1} = fgetl(frid);
                Sr = regexp(roiline{i,1}, '\t', 'split');
                roi = char(Sr(1));
                Srf = regexp(roi, ' ', 'split');
                if(length(Srf)>1)
                    roipos = roi;
                    fprintf(frwid, '%s\n', roipos);
                end
             end             
             frdata = dlmread(roinewpath);
             roi_x = frdata(:,1);
             roi_y = frdata(:,2);                 
%              plot(roi_x,roi_y, '-.or',MarkerSize',10);
             plot(roi_x,roi_y,'-.or','MarkerFaceColor','g')
             hold on;
             
             %% get label
             labelpath = S(2);
             labelpath = fullfile(mydir,labelpath);
             labelpath = labelpath{1};
    %          disp(labelpath);   %/ssd/wangmaorui/data/Test/Testlabel/scene22_total/label22/20171122_frame_0.txt
             flid = fopen(labelpath,'r');
             while feof(flid) == 0
                 labeline{i,1} = fgetl(flid);
    %              disp(labline{i,1});     %read one txt's message
                 Sl = regexp(labeline{i,1}, '\t', 'split');
                 head = char(Sl(1));
                 Stf = regexp(head, ' ', 'split');
                 if(length(Stf)>1)
                     headpos = head;
                     Sp = regexp(headpos, ' ', 'split');
                     pos_x = char(Sp(1));
                     pos_x = str2num(pos_x);
                     if(pos_x<=0)
                         pos_x = 0;
                     end
%                      if(pos_x>=1280)
%                          pos_x = 1280;
%                      end
                     pos_y = char(Sp(2));
                     pos_y = str2num(pos_y);
                     if(pos_y<=0)
                         pos_y = 1;
                     end
%                      if(pos_x>=720)
%                          pos_x = 720;
%                      end
                     plot(pos_x,pos_y,'r*');
    % PerspMap Validation
                     mapValue(pos_y,pos_x) = PMap(pos_y,pos_x);
                     value = mapValue(pos_y,pos_x);
                     rectangle('Position',[pos_x-value/2,pos_y-value/2,value,value],'edgecolor','r');
                     pause(0.2);

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

