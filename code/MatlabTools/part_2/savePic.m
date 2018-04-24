clc;
clear;

dir = '/ssd/wangmaorui/data/Test/part_2';
savedir = fullfile(dir,'RoiImg');
listfile = fullfile(dir,'imglist.txt');
experfile = fullfile(dir,'exper.txt');

frid = fopen(listfile,'r');
while feof(frid) == 0
    froi = fgetl(frid);
    imgpath = char(froi);
%     disp(imgpath);
    img = imread(imgpath);
%     imshow(img);
%     hold on;
	Sf = regexp(froi,'/','split');
	imgscene = char(Sf(7));
%     disp(imgscene);
    imgname = char(Sf(8));
    feid = fopen(experfile,'r');
    while feof(feid) == 0
        fexp = fgetl(feid);
        Se = regexp(fexp,' ','split');
        scene = char(Se(1));
        num = str2num(char(Se(2)));
        if(imgscene==scene)
            roiimgpath = fullfile(savedir,scene);
            if ~exist(roiimgpath)
                mkdir(roiimgpath);
            end
            len = length(imgname);
            imgfor = imgname(1:end-4);
            imgend = imgname(end-3:len);
        %     disp(imgfor);
        %     disp(imgend);
            
            imgfor = strcat('_',imgfor);
            imgfor = strcat(scene,imgfor);
            imgapp = strcat(imgfor,'_'); 
            for i = 1:num
                pos_x = str2num(char(Se(i*5-1)));
                pos_y = str2num(char(Se(i*5)));
                wid = str2num(char(Se(i*5+1)));
                hei = str2num(char(Se(i*5+2)));
%                 rectangle('Position',[pos_x,pos_y,wid,hei],'edgecolor','r');           
                imgappend = strcat(imgapp,num2str(i));
                imgnewpath = strcat(imgappend,imgend);
                roiimg = imcrop(img,[pos_x pos_y wid hei]);
                roiimg = imresize(roiimg, [hei wid]);
                fullroiimgpath = fullfile(roiimgpath,imgnewpath); 
                imwrite(roiimg,fullroiimgpath);    
            end

        end
    end
    fclose(feid);
%     pause;
end
fclose(frid);
