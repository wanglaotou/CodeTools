% Creates train set

function create_train_our()
image_dir = '/ssd/wangmaorui/data/';
gt_path = '/ssd/wangmaorui/data/List/set_2_train.txt';

final_image_fold = '/ssd/zhangting/crowdcount/data/ourset5/scnn_valid/images';
final_gt_fold = '/ssd/zhangting/crowdcount/data/ourset5/scnn_valid/gt';

mkdir(final_image_fold);
mkdir(final_gt_fold);

f_train = fopen(gt_path);
train_lists = textscan(f_train,'%s','Delimiter','\n');
fclose(f_train);

num_train = length(train_lists{1});

do_train = true;
is_show = false;
lbl_list = train_lists{1};
for idx = 1:num_train
    if (mod(idx,50)~=0)
        fprintf(1,'Processing %3d/%d files\n', idx, num_train);
        continue;
    end
    %% imgpath lbl split
    imgline_info = regexp(lbl_list(idx),' ','split');
    img_info = imgline_info{1};
    img_basename = char(img_info(1));
    start_id = strfind(img_basename, '/');
    end_id = strfind(img_basename, '.');
    imgname = img_basename(start_id(1,size(start_id,2))+1:end_id(1,size(end_id,2))-1);
    input_img_name = fullfile(image_dir,img_basename);
    
    im = imread(input_img_name);
    anno_num = str2num(char(img_info(2)));
    [nr, nc] = size(img_info);
    gt = [];
    if anno_num > 0
        for iidx = 1:anno_num
            flg = str2num(char(img_info((iidx-1)*5 + 3)));
            x = str2num(char(img_info((iidx-1)*5 + 4)));
            y = str2num(char(img_info((iidx-1)*5 + 5)));
            w = str2num(char(img_info((iidx-1)*5 + 6)));
            h = str2num(char(img_info((iidx-1)*5 + 7)));
            x_center = x + w/2;
            y_center = y + h/2;
            gt =[gt;x_center,y_center];
        end
    end
    %% imshow
    if is_show
        figure,
        imshow(im);
        hold on,
        plot(gt(:,1), gt(:,2), 'r.');
        hold off,
        close all;
    end
    
    
    %% generate density map
    d_map_h = floor(floor(double(size(im, 1)) / 2.0) / 2.0);
    d_map_w = floor(floor(double(size(im, 2)) / 2.0) / 2.0);
    
    % Density Map with Geometry-Adaptive Kernels (see MCNN code:
    % Single-Image Crowd Counting via Multi-Column Convolutional
    % Neural Network; CVPR 2017)
    d_map = create_density(gt / 4.0, d_map_h, d_map_w);
        figure,
            imagesc(d_map);
            
            close all;
    p_h = floor(double(size(im, 1)) / 3.0);
    p_w = floor(double(size(im, 2)) / 3.0);
    d_map_ph = floor(floor(p_h / 2.0) / 2.0);
    d_map_pw = floor(floor(p_w / 2.0) / 2.0);
    
    %% create overlapping patches of images and density maps
    py = 1;
    py2 = 1;
    count = 1;
    for j = 1: 3
        px = 1;
        px2 = 1;
        for k = 1: 3
            final_image = double(im(py: py + p_h - 1, px: px + p_w - 1, :));
            final_gt = d_map(py2: py2 + d_map_ph - 1, px2: px2 + d_map_pw - 1);
            px = px + p_w;
            px2 = px2 + d_map_pw;
            if size(final_image, 3) < 3
                final_image = repmat(final_image, [1, 1, 3]);
            end
            
            image_name = sprintf('%s_%d.jpg', imgname, count);
            gt_name = sprintf('%s_%d.mat', imgname, count);
            imwrite(uint8(final_image), fullfile(final_image_fold, image_name));
            do_save(fullfile(final_gt_fold, gt_name), final_gt);
            count = count + 1;
        end
        py = py + p_h;
        py2 = py2 + d_map_ph;
    end
end

end


function do_save(gt_name, final_gt)

save(gt_name, 'final_gt');

end


