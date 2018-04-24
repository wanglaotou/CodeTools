clear;
clc;
old_file = '/ssd/wangmaorui/data/Label/label/label41.txt';
dir = '/ssd/wangmaorui/data/Label/label41';
fr = fopen(old_file,'r');

while ~feof(fr)                                                       
    rline=fgetl(fr);
	rline = strtrim(rline);
%     disp(class(rline));
	Sr = regexp(rline, '/', 'split');
% 	disp(Sr);
	scenename = Sr(7);
	labelname = Sr(8);
	scenedir = fullfile(dir,scenename);
% 	disp(scenedir);
	labelpath = fullfile(scenedir,labelname);
	labelpath=char(labelpath);
	fw = fopen(rline,'r');
 	fm = fopen(labelpath,'w');
	while ~feof(fw)
		wline=fgetl(fw);
		wline=strtrim(wline);
		Sw = regexp(wline, ' ', 'split');
 		if(length(Sw)==1)
 			head = Sw(1);
 			head = char(head);
            fprintf(fm,'%s\n',head);
        else
        	label_x = Sw(1);
        	label_y = Sw(2);
            label_x = char(label_x);
            label_y = char(label_y);
        	label_x = str2num(label_x);
        	label_y = str2num(label_y);
        	label_x = ceil((192/57) * (label_x - 35));
        	if(label_x <= 0)
        		label_x = 0;
        	end
        	label_y = floor((108/32) * (label_y - 70));
 			if(label_y <= 0)
 				label_y = 1;
 			end
 			label_x = num2str(label_x);
 			label_y = num2str(label_y);
 			new_content = strcat(label_x,{32},label_y);
 			new_content = char(new_content);          
            fprintf(fm,'%s\n',new_content);
        end
    end
    fclose(fm);
    fclose(fw);  
end
fclose(fr);


