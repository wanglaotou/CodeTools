%get one scene's label info into one scene's txt(imgpath,headnum,label,x,y,w,h)
%save to liyuanqian(label info:imgpath,headnum,label,x,y,w,h)
%save to zhangting (label info:imgpath,headnum,label,x,y)
clear;
clc;
save_rectsrc = false;

mydir='/ssd/wangmaorui/data';
sceneDIRS = fullfile(mydir,'Scene');
RectSrcpath = fullfile(mydir,'RectSrc');
rectfullpath = fullfile(RectSrcpath,'rectnewsrc.txt');
labelpath = fullfile(mydir,'Label');
labelpath = fullfile(labelpath,'labelroi');
perspath = fullfile(mydir,'PersMaps');
perspath = fullfile(perspath,'matPersp');
rectnewpath = fullfile(RectSrcpath,'rectnewsrc2.txt');
scenearr = [];
for i=22:53
    i = num2str(i);
    scene = strcat('scene',i);
    scenearr = [scenearr;scene];
end
frid = fopen(rectnewpath,'w');
flid = fopen(rectfullpath,'r');
while feof(flid) == 0
    fsrc = fgetl(flid);
    Sl = regexp(fsrc,' ','split');
    imgpath = char(Sl(1));
    headnum = char(Sl(2));
    Sp = regexp(imgpath,'/','split');
    scenename = char(Sp(6));
    sceneend = char(Sp(7));
%     if ~ismember(scenearr,scenename)
    if(strcmp(scenename,'scene41')==0)
        fprintf(frid, '%s', fsrc);
    else
        fprintf(frid,'%s%s%s',imgpath,' ',headnum);
        %load label
        Ss = regexp(sceneend,'.jpg','split');
        labelend = char(Ss(1));
        labelend = strcat(labelend,'.txt');
        labelfullpath = fullfile(labelpath,scenename);
        labelfullpath = fullfile(labelfullpath,labelend);
        %load PersMaps
        persname = strcat(scenename,'.mat');
        persfullpath = fullfile(perspath,persname);
        load(persfullpath);

        flaid = fopen(labelfullpath,'r'); 
        while feof(flaid) == 0
            flaline = fgetl(flaid);
            Sla = regexp(flaline,'\t','split');
            labelinfo = char(Sla(1));
            Slain = regexp(labelinfo,' ','split');
            if(length(Slain)==1)
                head = labelinfo;
                head = str2num(head);
            end
            if(length(Slain)==2&&head>0)
                pos_x = char(Slain(1));
                pos_y = char(Slain(2));
                pos_x = str2num(pos_x);
                pos_y = str2num(pos_y);
                label_x = ceil(pos_x * (3/2));
                label_y = ceil(pos_y * (3/2));
                value = ceil(PMap(pos_y,pos_x));
                rect_x = ceil(label_x - value/2);
                rect_y = ceil(label_y - value/2);
                fprintf(frid,'%s%d%s%d%s%d%s%d%s%d',' ',1,' ',rect_x,' ',rect_y,' ',value,' ',value);
            end
        end
        
        fclose(flaid);
    end
    fprintf(frid,'\n');
end
fclose(flid);
fclose(frid);




