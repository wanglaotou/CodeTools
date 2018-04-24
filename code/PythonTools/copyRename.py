#change scenename and save to another filepath
import os
import sys
import shutil

ImgDir = '/ssd/wangmaorui/data/Test'
SceneDir = '/ssd/wangmaorui/data/Test/Scene'

if __name__=="__main__":
    sceneTxt = 'scene.txt'
    scenePath = os.path.join(ImgDir,sceneTxt)
    lblFile = open(scenePath,'r+') 
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip() 
        #print(imgPath)   
        imgIterms = imgPath.split('/')  # path split
        if len(imgIterms) >= 9:    
            sceneName = imgIterms[7]
            imgName = imgIterms[-1]

            sceneFullName = os.path.join(SceneDir,sceneName)
            #print(sceneFullName)
            #if not os.path.exists(sceneFullName):
             #   os.mkdir(sceneFullName)

            ## copy
            #imgSrcPath = os.path.join(ImgDir,imgPath)
            imgDstPath = os.path.join(sceneFullName,imgName)
            #print(imgDstPath)
            shutil.copy(imgPath, imgDstPath)

    lblFile.close()
