clear;
clc;
dir = '/ssd/wangmaorui/data';
RoiImg_dir = fullfile(dir,'RoiImg');
HroiImg_dir = fullfile(dir,'HroiImg');
roiImg_path = fullfile(RoiImg_dir,'scene.txt');
friid = fopen(roiImg_path,'r');
while feof(friid) == 0
    roiline = fgetl(friid);
    imgpath = char(roiline);
    Sr = regexp(roiline,'/','split');
    scenename = char(Sr(6));
    HroiImg_path = fullfile(HroiImg_dir,scenename);
    if ~exist(HroiImg_path)
        mkdir(HroiImg_path);
    end
    imgend = char(Sr(7));
    HroiImg_fullpath = fullfile(HroiImg_path,imgend);
    img = imread(imgpath);
    [hei,wid,c] = size(img);
    rows = ceil(hei/2);
    cols = ceil(wid/2);
    himg = imresize(img,[rows cols],'nearest');
    imwrite(himg,HroiImg_fullpath);
end
fclose(friid);