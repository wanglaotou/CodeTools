#???
import os
import sys
import shutil

rstDir = '/ssd/wangmaorui/data/rst'
ROIDir = '/ssd/wangmaorui/data/ROI'

if __name__=="__main__":
    lblSrc = sys.argv[1]		#path of txt

    lblFile = open(lblSrc,'r+')          # open file
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        #print(srcLine)              #['newRoi/roi_1.txt']
        imgPath = srcLine[0].strip()  
        #print(imgPath)              #newRoi/roi_1.txt
        imgIterms = imgPath.split('/')  # path split
        #print(len(imgIterms))
        if len(imgIterms) >= 4:
            pathName = imgIterms[1]
            sceneName = imgIterms[2]
            #print(pathName)         #rst_frame_20171115_bat0006...
            labelpath = imgIterms[-1]
            #print(labelpath)       #1_ImageFolder.txt...

            labelnewName = pathName + '/' + sceneName + '/' + labelpath
            labelFullName = os.path.join(rstDir,labelnewName)
            #print(labelFullName)        #/ssd/wangmaorui/data/rst/rst_frame_20171115_bat0033/9/9_ImageFolder.txt
            
            labelFile = open(labelFullName,'r+')
            labelSrcLines = labelFile.readlines()
            for labellines in labelSrcLines:
                labelLine = labellines.strip().split('.')
                #print(labelLine)
                labelPath = labelLine[3]
                #print(labelName)    #jpg 9 516 183 592 192 512 217 488 197 405 197 127 215 111 209 86 220 53 236

                labelName = labelPath.strip().split(' ')
                labelNew = labelName[1:]
                #print(labelNew)
            #if not os.path.exists(labelFullName):
             #   os.mkdir(labelFullName)

            ## copy
            #imgSrcPath = os.path.join(DmapDir,imgPath)
            #imgDstPath = os.path.join(sceneFullName,imgNewName)
            #shutil.copy(imgSrcPath, imgDstPath)
           


    lblFile.close()
