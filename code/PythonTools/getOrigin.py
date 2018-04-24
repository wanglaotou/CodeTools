#get ImageFolder.txt from labelinfo (opposite to getLabel.py)
import os
import sys
import shutil

ImgDir = '/ssd/wangmaorui/data/Label/label22_53'
SceneDir = '/ssd/wangmaorui/data/OriginInfo'

if __name__=="__main__":
    #lblSrc = sys.argv[1]		#path of txt
    for i in range(22,54):
        sceneFile = "scene"+str(i)
        scenefullfile = os.path.join(SceneDir,sceneFile)
        if os.path.exists(scenefullfile):
            pass
        else:
            os.mkdir(scenefullfile)
        sceneTxt = sceneFile + '.txt'
        scenePath = os.path.join(scenefullfile,sceneTxt)
        fs = open(scenePath,'w')

        info = 'origin.txt'
        oldfile = os.path.join(ImgDir,info)
        lblFile = open(oldfile,'r+')          # open file
        lblSrcFLines = lblFile.readlines()
        for line in lblSrcFLines:
            srcLine = line.strip().split()  # space split
            imgPath = srcLine[0].strip()  
            #print(imgPath)  
            imgIterms = imgPath.split('/')  # path split
            #if len(imgIterms) >= 8:     
            sceneName = imgIterms[6]
            infoName = sceneName + '.txt'
            imgName = imgIterms[-1]
            imgsplit = imgName.strip().split('.')
            imgqz = imgsplit[0]
            img_name = imgqz + '.jpg'            
            if(sceneFile==sceneName):
                fs.write(sceneFile)
                fs.write('\\')
                fs.write(img_name)
                fr = open(imgPath,'r')
                InfoLine = fr.readlines()
                for infole in InfoLine:
                    info = infole.strip().split()
                    if(len(info)==1):
                        fs.write(' ')
                        infor = info[0]
                        fs.write(infor)                        
                    else:
                        fs.write(' ')
                        infor = info[0]
                        fs.write(infor)
                        fs.write(' ')
                        infob = info[1]
                        fs.write(infob)
                fs.write('\n')
                fr.close()
            else:
                pass
        lblFile.close()
        fs.close()
