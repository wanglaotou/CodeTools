import os
import sys
import shutil

ImgDir = '/ssd/zhangting/crowdcount/data'
SceneDir = '/ssd/wangmaorui/data/Scene'

if __name__=="__main__":
    lblSrc = sys.argv[1]		#path of txt

    lblFile = open(lblSrc,'r+')          # open file
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip()    
        imgIterms = imgPath.split('/')  # path split
        if len(imgIterms) >= 5:
            timeName = imgIterms[0]     
            sceneName = imgIterms[2]
            imgName = imgIterms[-1]

            imgNewName = timeName + '_' + imgName
            sceneFullName = os.path.join(SceneDir,sceneName)
            if not os.path.exists(sceneFullName):
                os.mkdir(sceneFullName)

            ## copy
            imgSrcPath = os.path.join(ImgDir,imgPath)
            imgDstPath = os.path.join(sceneFullName,imgNewName)
            shutil.copy(imgSrcPath, imgDstPath)

    lblFile.close()
