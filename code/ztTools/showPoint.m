% created by lhl
% Example
clear;

load('/Users/ling/Desktop/8080/Label/frames_20170710_bat0085/0231_20170624_200000_20170624_200959/frame_00475.mat');

img_name = '/Users/ling/Desktop/8080/0808/frames_20170710_bat0085/0231_20170624_200000_20170624_200959/frame_00475.jpg';

img = imread(img_name);

width=size(img,2);
height=size(img,1); 

imshow(img); hold on;

plot(OnePoint(:,1),OnePoint(:,2),'r*');
plot(ThreePoint(:,1),ThreePoint(:,2),'g*');
plot(ThreePoint(:,3),ThreePoint(:,4),'b*');
plot(ThreePoint(:,5),ThreePoint(:,6),'m*');

