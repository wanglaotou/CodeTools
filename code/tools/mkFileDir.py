#date:20171122
#Use : copyfile mkdir & remove src files
# Input : label file : imgfullpath
# OutPut : make new label file


import os,sys,re,cv2
import shutil

lblDir = '/ssd/wangmaorui'

if __name__=="__main__":
    lblSrc = sys.argv[1]

    if not os.path.isfile(lblSrc):
        print ('error')

    lblSrcF = open(lblSrc,'r')

    lblSrcFLines = lblSrcF.readlines()  #['/ssd/wangmaorui/code/7/7.txt\n']
    numLines = len(lblSrcFLines)
    numFolder = 1
    for srcLine in lblSrcFLines:
        lblFile = srcLine.strip() # label file      #/ssd/wangmaorui/code/7/7.txt
        if not os.path.isfile(lblFile):
            continue
        lblFileIterms = lblFile.split('/')
        folderName = lblFileIterms[-2]
        folderNewName = 'scene'+str(int(folderName) +21)
        folderNewPath = os.path.join(lblDir, folderNewName)     #scene28
        if not os.path.exists(folderNewPath):
            os.mkdir(folderNewPath)

        lblF = open(lblFile,'r')
        lblFLines = lblF.readlines()

        for lblFline in lblFLines:
            imgIterms = lblFline.strip().split()

            imgPath = imgIterms[0]
            imgName = imgPath.split("\\")[-1].split('.jpg')[0]      #99

            headNum = imgIterms[1]
            ## make lbl file save
            lblNewF = os.path.join(folderNewPath,imgName+'.txt')    #/ssd/wangmaorui/scene28/99.txt
            lblNewFile = open(lblNewF,'w')

            lblNewFile.write(headNum)
            lblNewFile.write('\n')

            for i in range(2,len(imgIterms),2):
                pt_x = imgIterms[i+0]
                pt_y = imgIterms[i+1]
                lblNewFile.write(pt_x+' '+pt_y+'\n')

            lblNewFile.close()
        lblF.close()

    lblSrcF.close()     
