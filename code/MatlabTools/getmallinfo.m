clear;
clc;
dir = '/ssd/wangmaorui/data/RoiImg/Mall';
mall_gt_path = fullfile(dir,'mall_gt.mat');
mall_feat_path = fullfile(dir,'mall_feat.mat');
persp_roi_path = fullfile(dir,'perspective_roi.mat');
mall_img_path = fullfile(dir,'mall_img.txt');
mall_path = fullfile(dir,'mall.txt');

fmiid = fopen(mall_img_path,'r');
fmid = fopen(mall_path,'w');
i = 1;
while feof(fmiid) == 0
    fmline = fgetl(fmiid);
    imgpath = char(fmline);
    img = imread(imgpath);
    [hei,wid,c] = size(img);
%     imshow(img);
%     hold on;
%     fprintf(fmid,'%s',imgpath);
    gt_mat = load(mall_gt_path);
    gt = gt_mat.count;
    headnum = gt(i);
    headnum = int16(headnum);
%     disp(class(headnum));
%     fprintf(fmid,'%s%d',' ',headnum);
    mall_feat = load(mall_feat_path);
    persp_roi = load(persp_roi_path);
    loc{i} = gt_mat.frame{1,i}.loc;
    len = length(loc{i});
    loc_x = loc{i}(:,1);
    loc_y = loc{i}(:,2);
    pMap = persp_roi.pMapN;
%     k = 1;
%     locx1 = loc_x(k);
%     locy2 = loc_y(k);
%     disp(class(locx1));
    for j=1:len
        pvalue = ceil(pMap((hei-floor(loc_y(j))),(wid-floor(loc_x(j))))); 
%         fprintf(fmid,'%s%d',' ',1);
        loc_xx = int16(floor(loc_x(j)));
        loc_yy = int16(floor(loc_y(j)));
%         rectangle('Position',[loc_xx-pvalue*2,loc_yy-pvalue*2,pvalue*4,pvalue*4],'edgecolor','r');
%         disp(loc_xx);
%         fprintf(fmid,'%s%d',' ',loc_xx-pvalue*2);
%         fprintf(fmid,'%s%d',' ',loc_yy-pvalue*2);
%         fprintf(fmid,'%s%d',' ',pvalue*4);
%         fprintf(fmid,'%s%d',' ',pvalue*4);
    end
%     fprintf(fmid,'\n');
    i = i+1;
    pause;
end
fclose(fmid);
fclose(fmiid);