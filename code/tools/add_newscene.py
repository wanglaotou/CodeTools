import os
import sys
import shutil

ImgDir = '/ssd/wangmaorui/data'
SceneDir = '/ssd/wangmaorui/data/Scene'

if __name__=="__main__":
    lblSrc = sys.argv[1]		#path of txt
    #print(lblSrc)
    lblpath = lblSrc.strip().split('/')
    lblpath_b = lblpath[-1]
    #print(lblpath_b)                #20171122_scene.txt
    lblpath_bn = lblpath_b.strip().split('.')
    lblpath_bname = lblpath_bn[0]
    #print(lblpath_bname)            #20171122_scene->frame
    lblFile = open(lblSrc,'r+')          # open file
    lblSrcFLines = lblFile.readlines()
    #print(lblSrcFLines)
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip()    
        imgIterms = imgPath.split('/')  # path split
        #print(len(imgIterms))
        if len(imgIterms) >= 7:
            #timeName = imgIterms[0]     
            sceneName = imgIterms[5]
            sceneName = int(sceneName) + 21
            sceneName = str(sceneName)
            #print(sceneName)
            imgName = imgIterms[-1]
            sceneNewname = 'scene' + sceneName
            #print(sceneNewname)            #scene30
            imgNewName = lblpath_bname + '_' + imgName
            #print(imgNewName)               #20171122_frame_997.jpg

            labelFullName = os.path.join(SceneDir,sceneNewname)
            #print(labelFullName)           #/ssd/wangmaorui/data/Scene/scene30
            if not os.path.exists(labelFullName):
                os.mkdir(labelFullName)

            ## copy
            imgSrcPath = os.path.join(ImgDir,imgPath)
            imgDstPath = os.path.join(labelFullName,imgNewName)
            shutil.copy(imgSrcPath, imgDstPath)
            

    lblFile.close()
