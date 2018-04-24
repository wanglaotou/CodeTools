clear;
clc;
Dir_path = '/home/wangmaorui/Laotou/CycleGAN-TensorFlow/datasets/man2woman/';

listpath = fullfile(Dir_path,'a_resized.txt');
fpid = fopen(listpath,'r');
while feof(fpid) == 0
    fp = fgetl(fpid);
    Sp = regexp(fp,'/','split');
    scename = char(Sp(1));
    imgname = char(Sp(2));
%     disp(imgname);
    imgpath = fullfile(Dir_path,scename);
    imgpath = fullfile(imgpath,imgname);
%     disp(imgpath);
    img = imread(imgpath);
%     figure;
%     imshow(img);
    [hei, wid,c] = size(img);
    
    scenewname = strcat(scename, '_new');
    imgnewpath = fullfile(Dir_path,scenewname);
    if ~exist(imgnewpath)
        mkdir(imgnewpath);
    end
    imgNewpath = fullfile(imgnewpath,imgname);
%     disp(imgNewpath);
    
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    an = randperm(160,1);
    bn = randperm(160,1);
    for i=an:an+80
        for j=bn:bn+80
            R(i,j) = 0;
            G(i,j) = 0;
            B(i,j) = 0;
        end
    end

    for i=1:hei
        for j=1:wid
            blue(i,j,1) = R(i,j);
            blue(i,j,2) = G(i,j);
            blue(i,j,3) = B(i,j);
        end
    end
    
%     figure;
%     imshow(blue);
%     disp('right');
    imwrite(blue,imgNewpath);

end
fclose(fpid);