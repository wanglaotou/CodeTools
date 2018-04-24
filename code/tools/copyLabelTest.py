import os
import sys
import shutil

ImgDir = '/ssd/wangmaorui/data/BackUp'
LabelDir = '/ssd/wangmaorui/data/Label/label'

if __name__=="__main__":
    lblSrc = sys.argv[1]        #path of txt
    lblFile = open(lblSrc,'r+')          # open file
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip()   
        #print(imgPath) 
        imgIterms = imgPath.split('/')  # path split
        #print(imgIterms)
        if len(imgIterms) >= 3:
            labelpath = imgIterms[0]
            timeName = imgIterms[1]     #scene22
            #labelName = imgIterms[2]
            imgName = imgIterms[-1]
            #print(imgName)
            srcPath = labelpath + '/' + timeName + '/' + imgName
            #print(srcPath)          #Label/scene30/997.txt
            #print(imgName)      #0.txt
            imgnewName = '20171122_frame_' +imgName
            #print(imgName)          #20171122_frame_20171122_frame_997.txt
            labelFullName = os.path.join(LabelDir,timeName)
            #print(labelFullName)   #/ssd/wangmaorui/data/Label/label/scene30
            if not os.path.exists(labelFullName):
                os.mkdir(labelFullName)
            
            ## copy
            imgSrcPath = os.path.join(ImgDir,srcPath)
            #print(imgSrcPath)   #/ssd/wangmaorui/data/BackUp/Label/scene30/997.txt
            imgDstPath = os.path.join(labelFullName,imgnewName)
            #print(imgDstPath)
            shutil.copy(imgSrcPath, imgDstPath)

    lblFile.close()
