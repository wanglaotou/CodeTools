% created by lhl
% Show perspective map and save
clear;
clc;
mydir=uigetdir('/Users/ling/Desktop/','选择一个目录');
if mydir(end)~='/'
 mydir=[mydir,'/'];
end
cd(mydir);

subDIRS = dir(mydir);

checkDIRS = [mydir,'PerspectiveMap','/'];
if ~exist(checkDIRS,'dir')
     mkdir(checkDIRS); % 若不存在
end 


DIRS = dir([mydir,'*.txt']);
n = length(DIRS);
display(n);

for k=1:n
    d_name = [mydir,DIRS(k).name];
    persp=load(d_name);
    imagesc(persp);hold on;
    S = regexp(DIRS(k).name, '.txt', 'split');
    name = char(S(1));
    index = name(1:7);
    save_name1 = [index,'.jpg'];
    save_name = fullfile(checkDIRS,save_name1);
    
    saveas(gcf,save_name);
    hold off;
    close(figure(gcf));
    
end
