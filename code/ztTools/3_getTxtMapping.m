% % created by lhl
clear;
mydir=uigetdir('/home/zhangting/zhangting/code_exp/crowd_count/data/','ѡ��һ��Ŀ¼');
if mydir(end)~='/'
    mydir=[mydir,'/'];
end
cd(mydir);

myDirPart = regexp(mydir, '/', 'split');
myDirPartname = char(myDirPart(end-1));  %%% sub data date dir like:20170725

labelDIRS = [mydir,'Label','/'];
dmapDIRS = [mydir,'Dmap','/'];
imgDIRS = [mydir,'Image','/'];
persDir = '/home/zhangting/zhangting/code_exp/crowd_count/data/PersMaps/Persp/';

subDIRS = dir(labelDIRS);
map_name = [mydir,'map.txt'];
fp = fopen(map_name,'wt');

for i = 1 : length(subDIRS)
    if( isequal(subDIRS(i).name, '.' )||...
            isequal(subDIRS(i).name, '..')||...
            isequal(subDIRS(i).name, '.DS_Store')||...
            ~subDIRS(i).isdir)               % �����Ŀ¼�����
        continue;
    end
    
    bat_name = [labelDIRS, subDIRS(i).name,'/'];   
    batDIRS = dir(bat_name);
    display(bat_name);
    for j = 1 : length(batDIRS)
        if( isequal(batDIRS(j).name, '.' )||...
                isequal(batDIRS(j).name, '..')||...
                isequal(batDIRS(j).name, '.DS_Store')||...
                ~batDIRS(j).isdir)               % �����Ŀ¼�����
            continue;
        end      
        bat2_name = [bat_name, batDIRS(j).name,'/'];
        display(bat2_name);
        bat = fullfile(bat2_name);
        DIRS = dir([bat,'*.txt']);
        n=length(DIRS);
        
        for k=1:n          
            txt_name = DIRS(k).name;
            display(txt_name);
            S = regexp(txt_name, '.txt', 'split');
            name = char(S(1));
            img_name =['Image','/',subDIRS(i).name,'/',batDIRS(j).name,'/',name,'.jpg'];
            img = fullfile(mydir,img_name);
            label_name =['Label','/',subDIRS(i).name,'/',batDIRS(j).name,'/',name,'.txt'];
            label = fullfile(mydir,label_name);
            persp_name = [persDir,subDIRS(i).name,'.txt'];
            
            persp = fullfile(persp_name);
%             dmap_name = ['Dmap','/',subDIRS(i).name,'/',batDIRS(j).name,'/',name,'.txt'];
%             dmap = fullfile(mydir,dmap_name);

            if ~exist(img,'file')
                display(img);
                display('not exist'); % ��������
                break;
            end
            if ~exist(label,'file')
                display(label);
                display('not exist'); % ��������
                break;
            end
            if ~exist(persp,'file')
                display(persp);
                display('not exist'); % ��������
                break;
            end
            
            img_name =[myDirPartname,'/','Image','/',subDIRS(i).name,'/',batDIRS(j).name,'/',name,'.jpg'];
            display(img_name);
            %fprintf(fp, '%s %s %s %s', img_name,'1',persp_name,'0');
            fprintf(fp, '%s %s %s %s', img_name,'1','1','0');
            fprintf(fp,'\n');
            
            
        end
    end
    
end
fclose(fp);







