clc;
dir = '/ssd/wangmaorui/data';
mydir = '/ssd/wangmaorui/data/Kaifa';
sfile = '/home/wangmaorui/Desktop/laotou/test/set_2_test.txt';
fmiid = fopen(sfile,'r');

while feof(fmiid) == 0
    fmline = char(fgetl(fmiid));
    Sf = regexp(fmline,' ','split');
    imgpath = char(Sf(1));
    Sr = regexp(imgpath,'/','split');
    imgRoi = char(Sr(1));
    imgScene = char(Sr(2));
    imgname = char(Sr(3));
    imgfullpath = fullfile(dir,imgpath);
    savepath = fullfile(mydir,imgRoi);
    savepath = fullfile(savepath,imgScene);
    savefullpath = fullfile(savepath,imgname);
%     disp(imgfullpath);
    if ~exist(savepath)
        mkdir(savepath);
    end
    img = imread(imgfullpath);
    imwrite(img,savefullpath);
%     pause;
end
fclose(fmiid);

   