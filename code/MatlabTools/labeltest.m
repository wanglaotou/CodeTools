%test single scene's label info
clear;
clc;
imgpath = '/ssd/wangmaorui/data/Scene/Part_A/test_data/IMG_60.jpg';
labelpath = '/ssd/wangmaorui/data/Scene/Part_A/test_data/IMG_60.txt';
img = imread(imgpath);
figure;
imshow(img);
hold on;
flid = fopen(labelpath,'r');
 while feof(flid) == 0
     labeline = fgetl(flid);
%              disp(labline{i,1});     %read one txt's message
     Sl = regexp(labeline, '\t', 'split');
     head = char(Sl(1));
     Stf = regexp(head, ' ', 'split');
     if(length(Stf)>1)
         headpos = head;
         Sp = regexp(headpos, ' ', 'split');
         pos_x = char(Sp(1));
         pos_x = str2num(pos_x);
%          pos_x = pos_x - 176;   %roi * (2/3)  (-minx)
%          if(pos_x<=0)
%              pos_x = 1;
%          end
%                      if(pos_x>=1280)
%                          pos_x = 1280;
%                      end
         pos_y = char(Sp(2));
         pos_y = str2num(pos_y);
%          pos_y = pos_y - 54;    %roi * (2/3)  (-miny)
%          if(pos_y<=0)
%              pos_y = 1;
%          end
%                      if(pos_x>=720)
%                          pos_x = 720;
%                      end
         plot(pos_x,pos_y,'r*');
     end
 end
            
