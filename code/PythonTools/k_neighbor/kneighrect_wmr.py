import os, math, cv2
import numpy as np
from sklearn.neighbors import NearestNeighbors

mydir = '/ssd/wangmaorui/data/Scene/Part_B'
partApath = os.path.join(mydir,'allImg.txt')
rectpath = os.path.join(mydir,'allRect.txt')
frp = open(rectpath,'w')
fpa = open(partApath,'r')
paLines = fpa.readlines()
for paline in paLines:
    pline = paline.strip().split()
    lpline = ''.join(pline)
    lline = lpline.strip().split('/')
    datatype = lline[6]
    datatype = 'lab_' + datatype
    labname = lline[7]
    labname = 'lab_' + labname
    labpath = os.path.join(mydir,datatype)
    if os.path.exists(labpath):
        pass
    else:
        os.mkdir(labpath)
    labpath = os.path.join(labpath,labname)
    flp = open(labpath,'w')
    pline = ''.join(pline)
    # print(pline)
    listarr = []
    fpl1 = open(pline,'r')
    plLines1 = fpl1.readlines()
    for plline1 in plLines1:
        line1 = plline1.strip().split()
        if(len(line1) == 2):
            listarr.append(line1)

    fpl1.close()
    # print(listarr)
    fpl2 = open(pline,'r')
    plLines2 = fpl2.readlines()
    for plline2 in plLines2:
        line2 = plline2.strip().split()
        if(len(line2) == 1):
            linee = ''.join(line2)
            flp.write(linee)	#head
        if(len(line2) == 2):
            liner = ' '.join(line2)
            flp.write('\n')
            flp.write(liner)		#pos_x,pos_y
            neigh = NearestNeighbors(2, 0.4)
            neigh.fit(listarr)
            result = neigh.kneighbors(line2, 2, return_distance=True)
            if(len(result[0][0])==1):
                value = 12
                flp.write(' ')
                flp.write(str(value))	#one pos
                flp.write(' ')
                flp.write(str(value))
            if(len(result[0][0])>1):
                value = result[0][0][1]
                flp.write(' ')
                flp.write(str(int(value)))	#more than one pos
                flp.write(' ')
                flp.write(str(int(value)))
    flp.close()
    fpl2.close()
fpa.close()



# samples = [[0, 2], [1, 0,], [2, 2,]]
# neigh = NearestNeighbors(2, 0.4)
# print(neigh)
# neigh.fit(samples)
# result = neigh.kneighbors([[1, 1]], 2, return_distance=True)
# np.asarray(result[0][0])
# print (type(result))
# point = list(result)
# print(point[0][0][0])