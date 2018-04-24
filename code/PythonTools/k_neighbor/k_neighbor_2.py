## 20180212 zt
##Use : (x_center y_center w h) -> adjust to (x y  w h)
##Reason : some k_neighbor rect is so large!!!!

import os, math, cv2
import numpy as np
from sklearn.neighbors import NearestNeighbors

K_NEIGHBORS = 7

rectdir = '/ssd/zhangting/crowdcount/data/tools/k_neighbor'
labpath = os.path.join(rectdir,'allPosrect.txt')  ## k_neighbor rects (x_center y_center w h) by kneighrect.py
finalpath = os.path.join(rectdir,'rect.txt')  ## k_neighbor rects (x y w h)
fin = open(labpath,'r')     ##  src_results
fout = open(finalpath, 'w')  ## result (x y w h)
flines = fin.readlines()
for fline in flines:
    imginfo = fline.strip().split()
    imgpath = imginfo[0]
    # img = cv2.imread(imgpath)
    # cv2.waitKey()

   ## 2> read lbl pts file
    listarr = []
    facenum = int(imginfo[1])
    for i in range(2,len(imginfo),5):
        rect = []
        pos_label=int(imginfo[i])
        x_center = int(imginfo[i+1])
        y_center = int(imginfo[i+2])
        rect_w = int(imginfo[i+3])
        rect_h = int(imginfo[i+4])
        rect = [x_center, y_center, rect_w, rect_h]

        listarr.append(rect)
    ## read end

    ## save
    newline = imgpath + ' '+ imginfo[1]
    fout.write(newline)
    if len(listarr) == 0:
        pass
    elif len(listarr) == 1:
        value = 20
        x = listarr[0][0] - value /2
        y = listarr[0][1] - value /2
        newline = ' ' + str(1)+' '+str(x) +' ' + str(y) +' ' + str(value) +' ' + str(value);
        fout.write(newline)
    else:
        ### 3> for list_arr each pt : list to arr ->(x y w h)   --> arr (x y)  & arr(w h)
        arr = np.array(listarr)
        arr_re = np.split(arr, 2, axis = 1)
        pt_arr = arr_re[0]
        val_arr = arr_re[1] 
        # print 'pt_arr:',pt_arr
        # print 'val_arr',val_arr

        ### 4> do k_neighbor
        neigh = NearestNeighbors(K_NEIGHBORS, 0.4)
        neigh.fit(pt_arr)
        distance, indices = neigh.kneighbors(pt_arr, K_NEIGHBORS, return_distance=True)
        # print 'k_neighbor dis:', distance
        # print 'k_neighbor ind:', indices

        ## 5> indices
        for idx in range(0, len(indices)):
            indice = indices[idx]
            # print 'idx:', idx
            # print 'indice:',indice

            ## all rect value;discard max, min
            rrect = []
            for iidx in range(0, len(indice)):
                rrect.append(val_arr[indice[iidx]][0])
            rrect_arr = np.array(rrect)
            r_sum = np.sum(rrect_arr)
            r_max = np.max(rrect_arr)
            r_min = np.min(rrect_arr)
            # print 'rrect_arr:',rrect_arr


            r_final = (r_sum - r_max - r_min) / (K_NEIGHBORS -2)
            # print 'r_final', r_final

            value = r_final
            x = pt_arr[idx][0] - value /2
            y = pt_arr[idx][1] - value /2
            newline = ' ' + str(1)+' '+str(x) +' ' + str(y) +' ' + str(value) +' ' + str(value);
            fout.write(newline)
            # img = cv2.imread(imgpath)
            # cv2.waitKey()
            

    fout.write('\n')


    
fin.close()
fout.close()