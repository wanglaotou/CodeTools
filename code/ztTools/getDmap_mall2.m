clear;  
load('../Mall/perspective_roi.mat');  
load('../Mall/mall_gt.mat');  
  
m=480;n=640;  
m=m/8;  
n=n/8;  
mask = imresize(roi.mask,0.125);  
%imagesc(roi.mask);

% d_name ='scene22.txt';  
% %d_map_name = [d_name,'.txt']; 
% dmapDIRS = ['../Mall','/',d_name];
% f=fopen(dmapDIRS,'w');
% for h=1:480
%    for w=1:640
%        fprintf(f,'%f',pMapN(h,w));
%        fprintf(f,' ');
%    end
%    fprintf(f,'\n');
% end
% fclose(f);
% 
% imagesc(pMapN);%dmap
% pMap=imresize(pMapN,[480/2,640/2]);
% pMap = pMapN/4;


for i=1:2000  
   i  
   gt = frame{i}.loc;  
   gt = gt/8;  
   d_map = zeros(m,n);  
   for j=1:size(gt,1)  
       ksize = ceil(25/sqrt(pMapN(floor(gt(j,2)),1)));  
       ksize = max(ksize,7);  
       ksize = min(ksize,25); 
%        if mod(ksize,2)==0
%            ksize= ksize+1;
%        end
       radius = ceil(ksize/2);  
       sigma = ksize/2.5;  
       h = fspecial('gaussian',ksize,sigma);  
       x_ = max(1,floor(gt(j,1)));  
       y_ = max(1,floor(gt(j,2)));  
  
       if (x_-radius+1<1)  
              for ra = 0:radius-x_-1  
                   h(:,end-ra) = h(:,end-ra)+h(:,1);  
                   h(:,1)=[];  
              end  
       end  
      if (y_-radius+1<1)  
           for ra = 0:radius-y_-1  
               h(end-ra,:) = h(end-ra,:)+h(1,:);  
               h(1,:)=[];  
           end  
      end  
       
      if (x_+ksize-radius>n)
          for ra = 0:x_+ksize-radius-n-1
              h (:,1+ra) = h(:,1+ra)+h(:,end);
              h(:,end) = [];
          end
      end
                    
       if(y_+ksize-radius>m)  
            for ra = 0:y_+ksize-radius-m-1  
                h (1+ra,:) = h(1+ra,:)+h(end,:);  
                h(end,:) = [];  
            end  
       end
       t = d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n));
          d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...  
             = d_map(max(y_-radius+1,1):min(y_+ksize-radius,m),max(x_-radius+1,1):min(x_+ksize-radius,n))...  
              + h;  
   end

   d_name =sprintf('seq_%.6d.txt',i);  
   %d_map_name = [d_name,'.txt']; 
   dmapDIRS = ['../Mall/Dmap_8','/',d_name];
   f=fopen(dmapDIRS,'w');
   for h=1:m
       for w=1:n
           fprintf(f,'%d',d_map(h,w));
           fprintf(f,' ');
       end
       fprintf(f,'\n');
   end
   
   fclose(f);
           
   imagesc(d_map);%dmap
   s1=sum(d_map(:));
   %display(s1);  
end