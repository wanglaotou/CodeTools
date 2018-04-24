%get RoiImg from scene(scene.txt,roi.txt-->RoiImg)
%generate density map and save as .txt file
clear;
clc;
mydir='/ssd/wangmaorui/data/RoiImg/ShanghaiExpo';
train_dir = fullfile(mydir,'test_data');
train_roi = fullfile(train_dir,'roiPoint');
trainpath = fullfile(mydir,'testImg.txt');
Train_Roi = fullfile(mydir,'Test_Roi');
train_rectpath = fullfile(mydir,'testrect.txt');

frid = fopen(trainpath,'r');
ftid = fopen(train_rectpath,'w');
while feof(frid) == 0
    count = 0;
    froi = fgetl(frid);
    img = imread(froi);
%     imshow(img);
%     hold on;
    fprintf(ftid, '%s', froi);
    Sr = regexp(froi,'/','split');
    scenename = char(Sr(7));      %train_data or test_data 
    imgname = char(Sr(8));
    forroi = regexp(imgname,'.jpg','split');
    froifor = char(forroi(1));
    labelname = strcat(froifor,'.txt');
    labelpath = fullfile(mydir,scenename);
    labelnewpath = fullfile(labelpath,labelname);

    if ~exist(Train_Roi)
        mkdir(Train_Roi);
    end

    %%get roi       
%     roiforw = regexp(imgname,'-','split'); 
%     roiname = char(roiforw(1));  
%     roiname = strcat(roiname,'.txt');  
%     roinamepath = fullfile(train_roi,roiname); 

    roiforw = regexp(imgname,'_','split'); 
    roiname = char(roiforw(1));  
    roinnamef = regexp(roiname,'-','split');
    roinname = char(roinnamef(1));
    roinamend = strcat(roinname,'.txt');  
    roinamepath = fullfile(train_roi,roinamend);

    %get rectangle roi (the min External rectangle)
    arr_x = [];
    arr_y = [];
    freid = fopen(roinamepath,'r');
    while feof(freid) == 0
        rectline = fgetl(freid);
        Sre = regexp(rectline,' ','split');
        if(length(Sre)==2)
            pos_x = char(Sre(1));
            pos_y = char(Sre(2));
            pos_x = str2num(pos_x);
            pos_y = str2num(pos_y);
            arr_x = [arr_x;pos_x];
            arr_y = [arr_y;pos_y];
        end
    end
    min_x = min(arr_x);
    max_x = max(arr_x);
    wid = ceil((max_x - min_x)/8)*8;
    wid = max_x - min_x;
    min_y = min(arr_y);
    max_y = max(arr_y);
    hei = ceil((max_y - min_y)/8)*8;
    hei = max_y - min_y;
    fclose(freid);
    
    %get labelinfo
    flid = fopen(labelnewpath,'r');
    headnum = 0;
    rects = [];
    while ~feof(flid)
        flline = fgetl(flid);
        Sl = regexp(flline,' ','split');       
        if(length(Sl)==1)
            headnum = str2num(char(Sl(1)));
        end
        if(length(Sl)==2)
            roi_x = str2num(char(Sl(1)));
            roi_y = str2num(char(Sl(2)));
%             plot(roi_x,roi_y,'r*');
            if(roi_x < min_x || roi_x > max_x || roi_y < min_y || roi_y > max_y)
                headnum = headnum - 1;
            end
            if(roi_x >= min_x && roi_x <= max_x && roi_y >= min_y && roi_y <= max_y)
%                 plot(roi_x,roi_y,'g^');
                roi_xx = roi_x - 20;
                roi_yy = roi_y - 20;
                rects = [rects;roi_xx];
                rects = [rects;roi_yy];
%                 rectangle('Position',[roi_xx,roi_yy,40,40],'edgecolor','r');
            end
        end 
    end
    fclose(flid);
    if(headnum<1)
        headnum = 0;
    end
    fprintf(ftid, '%s%d', ' ',headnum);
    if(headnum>0)        
        for k=1:2:length(rects)
            rect_x = rects(k);
            rect_y = rects(k+1);
            fprintf(ftid,'%s%d',' ',1);
            fprintf(ftid,'%s%d',' ',rect_x);
            fprintf(ftid,'%s%d',' ',rect_y);
            fprintf(ftid, '%s%d%s%d',' ',40,' ',40);
        end
     end
    fprintf(ftid,'\n');
    %save roiimg 
    fullroiimgpath = fullfile(Train_Roi,imgname);
    roiimg = imcrop(img,[min_x min_y wid hei]);
    roiimg = imresize(roiimg, [hei wid]);
    imwrite(roiimg,fullroiimgpath);
    pause;
end
fclose(frid);
fclose(ftid);


    
