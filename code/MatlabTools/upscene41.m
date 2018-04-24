%change one scene's(scene41) label info to roi
DIRS = '/ssd/wangmaorui/data';
RoiImgDIRS = fullfile(DIRS,'RoiImg');
labelDIR = fullfile(DIRS,'Label');
labelDIRS = fullfile(labelDIR,'labelroi');

RoiImgpath = fullfile(RoiImgDIRS,'scene41.txt');
fr = fopen(RoiImgpath,'r');

while feof(fr) == 0                                                       
    rline=fgetl(fr);
	rline = strtrim(rline);
%     disp(class(rline));
	Sr = regexp(rline, '/', 'split');
	scenename = Sr(6);
	roiname = Sr(7);
    roilabel = regexp(roiname,'.jpg','split');
    roifor = char(roilabel(1));
    roiend = strcat(roifor,'.txt');
    scenenewname = strcat(scenename,'_new');
	scenenewdir = fullfile(RoiImgDIRS,scenenewname);
    scenenewdir = char(scenenewdir);
%     if ~exist(scenenewdir)
%         mkdir(scenenewdir);
%     end
    scenenewpath = fullfile(scenenewdir,roiname);
    img = imread(rline);
    [width,height,ch] = size(img);
    wid = ceil(width * (2/3));
    hei = ceil(height * (2/3));
    newimg = imresize(img, [hei wid]);
    %imwrite(newimg,scenenewpath);

	labelpath = fullfile(labelDIRS,scenename);
    labelfullpath = fullfile(labelpath,roiend);
	labelfullpath=char(labelfullpath);
    newscene = strcat(scenename,'_new');
    newlabel = fullfile(labelDIRS,newscene);
    labelnewpath = fullfile(newlabel,roiend);
 	fl = fopen(labelfullpath,'r');
%     fln = fopen(labelnewpath,'w');
	while feof(fl) == 0
		lline=fgetl(fl);
		lline=strtrim(lline);
		Sw = regexp(lline, ' ', 'split');
 		if(length(Sw)==1)
 			head = Sw(1);
 			head = char(head);
            %fprintf(fln,'%s\n',head);
        end
        if(length(Sw)==2)
        	label_x = char(Sw(1));
        	label_y = char(Sw(2));
        	label_x = str2num(label_x);
        	label_y = str2num(label_y);
        	label_x = ceil(label_x * (2/3));
        	if(label_x <= 0)
        		label_x = 1;
            end
        	label_y = ceil(label_y * (2/3));
 			if(label_y <= 0)
 				label_y = 1;
            end
 			label_x = num2str(label_x);
 			label_y = num2str(label_y);
 			new_content = strcat(label_x,{32},label_y);
 			new_content = char(new_content);          
            %fprintf(fln,'%s\n',new_content);
        end
    end
    fclose(fln);
    fclose(fl);  
end
fclose(fr);
