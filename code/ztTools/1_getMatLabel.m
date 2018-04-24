%for 20170828 data
% matLabel: only save :TotalNum + gt 

fidin=fopen('/home/zhangting/lhl_work/OurDataset/labeled/20170829/imageKeyPoint0829_proces_tmp/imageKeyPointInfo20170904105826.txt'); % ȥ���һ�к󣬴�.txt�ļ�,       
LabelDIRS = '/home/zhangting/lhl_work/OurDataset/labeled/20170829/matLabel/';

if ~exist(LabelDIRS,'dir')
     mkdir(LabelDIRS); % ��������
end 

while ~feof(fidin)                                      % �ж��Ƿ�Ϊ�ļ�ĩβ               
    tline=fgetl(fidin);                                 % ���ļ�����   
    if isempty(tline)      %�ж��ǲ��ǿ���
       continue
    end
    S = regexp(tline, ' ', 'split');
    imgName = char(S(1));
    
    name = regexp(imgName, '.jpg', 'split');
    name1 = char(name(1));
    
  
%     dir_name = name1(22:38); % luohongling
    % zt 
    dirInx = regexp(name1,'/','split');
    dir_name = char(dirInx(1));
    dir_name = dir_name(end-15:end);
    
    
    frame_name = name1(length(name1)-11:length(name1));
    subDir = fullfile(LabelDIRS,dir_name);
    if ~exist(subDir,'dir')
        mkdir(subDir) % ��������
    end 
    newName = [dir_name,frame_name];
    
    matName=[newName,'.mat'];
    labelName = fullfile(LabelDIRS,matName);
    %display(labelName);
    
    P = str2double(S(4:length(S)));
    id = 1;
    OneNum=0;
    ThreeNum=0;
    while(id>0 && id<length(P))
        if(P(id)==1)
            OneNum = OneNum+1;
            id = id+3;          
        else
            ThreeNum = ThreeNum+1;
            id = id+7;          
        end
    end
    
    gt=ones(OneNum,2);
    ThreePoint=ones(ThreeNum,6);
    
    TotalNum = ThreeNum + OneNum;
    one = 0;
    three = 0;
    id = 1;
    %display(TotalNum);
    for i = 1:TotalNum
     
        if(P(id)==1)
            one = one+1;
            gt(one,1) = P(id+1);
            gt(one,2) = P(id+2);
            id = id+3;          
        else
            three = three+1;
            ThreePoint(three,1) = P(id+1);
            ThreePoint(three,2) = P(id+2);
            ThreePoint(three,3) = P(id+3);
            ThreePoint(three,4) = P(id+4);
            ThreePoint(three,5) = P(id+5);
            ThreePoint(three,6) = P(id+6);
            id = id+7;          
        end
    end
    
    save(labelName,'TotalNum','gt');
  
end
