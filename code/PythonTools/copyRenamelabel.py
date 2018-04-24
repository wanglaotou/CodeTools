#change labelname and save to another filepath
import os
import sys
import shutil

ImgDir = '/ssd/wangmaorui'
LabelDir = '/ssd/wangmaorui/data/Label/label'

if __name__=="__main__":
    lblSrc = sys.argv[1]        #path of txt        s.txt
    lblFile = open(lblSrc,'r+')          # open file
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip()        #./scene28/99.txt   
        imgIterms = imgPath.split('/')  # path split
        if len(imgIterms) >= 3:
            timeName = imgIterms[1]            
            imgName = imgIterms[-1]
            imgNewName = '20171122_frame_' + imgName
            imgnewPath = timeName + '/' + imgName
            #print(imgNewName)
            labelFullName = os.path.join(LabelDir,timeName)
            #print(labelFullName)
            if not os.path.exists(labelFullName):
                os.mkdir(labelFullName)

            ## copy
            imgSrcPath = os.path.join(ImgDir,imgnewPath)
            #print(imgSrcPath)
            imgDstPath = os.path.join(labelFullName,imgNewName)
            shutil.copy(imgSrcPath, imgDstPath)

    lblFile.close()
