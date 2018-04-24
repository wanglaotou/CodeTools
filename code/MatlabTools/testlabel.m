% created by lhl
%generate density map and save as .txt file
clear;
clc;
mydir='/ssd/wangmaorui/data';

labelDIRS = fullfile(mydir,'Label');
labelDDIRS = fullfile(labelDIRS,'testlabel');
labelpath = fullfile(labelDDIRS,'label.txt');
perspath = fullfile(mydir,'PersMaps');
perspath = fullfile(perspath,'matPersp');

flid = fopen(labelpath,'r');
while feof(flid) == 0
    flabel = fgetl(flid);
    Sl = regexp(flabel,'/','split');
    labelname = char(Sl(7));
    labelend = char(Sl(8));

    %load PersMaps
    persname = strcat(labelname,'.mat');
    persfullpath = fullfile(perspath,persname);
    load(persfullpath);

    %get new label in Rectroi
    flaid = fopen(flabel,'r');
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
            value = PMap(pos_y,pos_x);

        end
    end
    fclose(flaid);
end
fclose(flid);
