clear;
clc;
path = '/ssd/wangmaorui/data/winRoi';
oldpath = fullfile(path,'mask');
oldpath = fullfile(oldpath,'mask19.jpg');
newpath = fullfile(path,'scene');
newpath = fullfile(newpath,'scene19.jpg');
I=imread(oldpath);
I=im2double(I);
level=graythresh(I); 
BW=im2bw(I,level);   
% imgDst=im2bw(I,0.5);
imwrite(BW,newpath);
imshow(BW);

% maskpath = '/ssd/wangmaorui/data/winRoi/scene/scene19.jpg';
% img = imread(maskpath);