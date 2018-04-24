import os
import sys
import shutil

originDir = '/ssd/wangmaorui/data/SaveImg'
labelDir = '/ssd/wangmaorui/data/Label/newlabel'

if __name__=="__main__":
    #lblSrc = sys.argv[1]		#path of txt
    originpath = os.path.join(originDir,'scene50_ImageFolder.txt')
    forigin = open(originpath,'r')
    OriginLines = forigin.readlines()
    for originline in OriginLines:
        oline = originline.strip().split()
        #print(len(oline))
        oriInfo = oline[0]
        #print(oriInfo)
        originfo = oriInfo.strip().split('\\')

        scenename = originfo[1]
        imgname = originfo[2]
        imginfo = imgname.strip().split('.jpg')
        imgfo = imginfo[0]
        labelname = imgfo + '.txt'
        labelpath = os.path.join(labelDir,scenename)
        if os.path.exists(labelpath):
            pass
        else:
            os.mkdir(labelpath)
        labelfullpath = os.path.join(labelpath,labelname)
        #print(labelfullpath)
        flabel = open(labelfullpath,'w')
        head = oline[1]
        flabel.write(head)
        for i in range(2,len(oline)-1,2):
            pos_x = oline[i]
            pos_y = oline[i+1]
            flabel.write('\n')
            flabel.write(pos_x)
            flabel.write(' ')
            flabel.write(pos_y)
        flabel.close()

    forigin.close()

