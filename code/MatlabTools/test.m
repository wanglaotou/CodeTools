clear;
clc;
ksize = 25;
sigma = ksize * 2;
ksize4 = ceil(floor(9/4)*25/15);
h = fspecial('gaussian',ksize,sigma);