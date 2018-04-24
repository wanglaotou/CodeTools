clear;
clc;
mydir = '/ssd/wangmaorui/data/winRoi';
label_path = fullfile(mydir,'label');
% label_path = fullfile(label_path,'scene01');
label_ppath = fullfile(label_path,'label01.txt');
mask_path = fullfile(mydir,'mask');
mask_ppath = fullfile(mask_path,'mask01.jpg');
label_new_path = fullfile(label_path,'newscene01'); 
scene_path = fullfile(mydir,'scene');

mask = imread(mask_ppath);
I=im2double(mask);
level=graythresh(I); 
bmask=im2bw(I,level); 
flid = fopen(label_ppath,'r');
while feof(flid) == 0
	flabel = fgetl(flid);
	Sl = regexp(flabel,'/','split');
    labelname = char(Sl(7));
    labelend = char(Sl(8));
    imagepath = fullfile(scene_path,labelname);
    Si = regexp(labelend,'.txt','split');
    nameend = char(Si(1));
    scenename = strcat(nameend,'.jpg');
    imageppath = fullfile(imagepath,scenename);
%     img = imread(imageppath);
%     imshow(img);
%     hold on;
    if ~exist(label_new_path)
        mkdir(label_new_path);
    end
    labelnewpath = fullfile(label_new_path,labelend);
    flaid = fopen(flabel,'r');
    flnid = fopen(labelnewpath,'w');
	arr_x = [];
    arr_y = [];
    while feof(flaid) == 0
        flaline = fgetl(flaid);
        Sla = regexp(flaline,'\t','split');
        labelinfo = char(Sla(1));
        Slain = regexp(labelinfo,' ','split');
        if(length(Slain)==1)
            head = labelinfo;
            head = str2num(head);
        end
        if(length(Slain)==2)
            pos_x = char(Slain(1));
            pos_y = char(Slain(2));
            pos_x = str2num(pos_x);
            pos_y = str2num(pos_y);
%             plot(pos_x,pos_y,'r*');
            pixel = bmask(pos_y,pos_x);
            if(pixel==1)
            	arr_x = [arr_x;pos_x];
            	arr_y = [arr_y;pos_y];
            else
            	head = head - 1;
            end
        end
    end
    fprintf(flnid,'%d',head);
    for i=1:length(arr_x)
        new_x = arr_x(i);
        new_y = arr_y(i);
%         plot(new_x,new_y,'g<');
        fprintf(flnid,'\n');
        fprintf(flnid,'%d%s',new_x,' ');
        fprintf(flnid,'%d',new_y);
    end
    fclose(flnid);
    fclose(flaid);

end
fclose(flid);

 
 
 
 
