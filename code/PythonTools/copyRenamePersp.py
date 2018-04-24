#change Perspname and save to another filepath
import os
import sys
import shutil

ImgDir = '/ssd/wangmaorui/data/Test/PersMaps'

if __name__=="__main__":
    sceneTxt = 'persp.txt'
    scenePath = os.path.join(ImgDir,sceneTxt)
    lblFile = open(scenePath,'r+') 
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip()    
        imgIterms = imgPath.split('/')  # path split
        if len(imgIterms) >= 3:    
            imgName = imgIterms[-1]
            imgNewName = imgName.strip().split('.')
            imgNamef = imgNewName[0]
            imgNamef = imgNamef.strip().split('_')
            imgScene = imgNamef[0]
            imgSceneName = imgScene + '.mat'
            PersDir = os.path.join(ImgDir,'matPer')

            ## copy
            oldPer = os.path.join(ImgDir,'matPersp')
            imgSrcPath = os.path.join(oldPer,imgOriName)
            imgDstPath = os.path.join(PersDir,imgSceneName)
            shutil.copy(imgPath, imgDstPath)

    lblFile.close()
