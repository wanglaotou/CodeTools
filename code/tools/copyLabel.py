import os
import sys
import shutil

ImgDir = '/ssd/zhangting/crowdcount/data'
LabelDir = '/ssd/wangmaorui/data/Label/label'

if __name__=="__main__":
    lblSrc = sys.argv[1]        #path of txt

    lblFile = open(lblSrc,'r+')          # open file
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip()    
        imgIterms = imgPath.split('/')  # path split
        if len(imgIterms) >= 5:
            timeName = imgIterms[0]     
            labelName = imgIterms[2]
            imgName = imgIterms[-1]

            imgNewName = timeName + '_' + imgName
            labelFullName = os.path.join(LabelDir,labelName)
            if not os.path.exists(labelFullName):
                os.mkdir(labelFullName)

            ## copy
            imgSrcPath = os.path.join(ImgDir,imgPath)
            imgDstPath = os.path.join(labelFullName,imgNewName)
            shutil.copy(imgSrcPath, imgDstPath)

    lblFile.close()
