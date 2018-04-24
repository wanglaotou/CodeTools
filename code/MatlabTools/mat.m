fid = fopen('/ssd/wangmaorui/code/mat.txt','w');
for i=1:5
    i = num2str(i);
%     new_i = strcat(i);
    fprintf(fid,'%d\n',i);
end
    