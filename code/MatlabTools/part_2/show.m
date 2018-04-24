clc;
clear;

dir = '/ssd/wangmaorui/data/Test/part_2/sample';

listfile = fullfile(dir,'sample.txt');

frid = fopen(listfile,'r');
while feof(frid) == 0
    froi = fgetl(frid);
	Sf = regexp(froi,' ','split');
	imgpath = char(Sf(1));
	num = str2num(char(Sf(2)));
% 	disp(imgpath);
%     disp(num);
	imgfullpath = fullfile(dir,imgpath);
	img = imread(imgfullpath);
	imshow(img);
	hold on;

	len = length(imgpath);
	imgfor = imgpath(1:end-4);
	imgend = imgpath(end-3:len);
%     disp(imgfor);
%     disp(imgend);
    imgfor = strcat('_',imgfor);
    imgapp = strcat(imgfor,'_'); 
  
    for i = 1:num
        pos_x = str2num(char(Sf(i*5-1)));
        pos_y = str2num(char(Sf(i*5)));
        wid = str2num(char(Sf(i*5+1)));
        hei = str2num(char(Sf(i*5+2)));
        rectangle('Position',[pos_x,pos_y,wid,hei],'edgecolor','r');           
        imgappend = strcat(imgapp,num2str(i));
        imgnewpath = strcat(imgappend,imgend);
        roiimg = imcrop(img,[pos_x pos_y wid hei]);
        roiimg = imresize(roiimg, [hei wid]);
        fullroiimgpath = fullfile(dir,imgnewpath); 
        imwrite(roiimg,fullroiimgpath);    
    end
%     pause;
end
