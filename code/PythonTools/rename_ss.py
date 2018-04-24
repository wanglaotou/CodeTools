#???
import os
import sys

if __name__=="__main__":
    lblSrc = sys.argv[1]        #path of txt
    lblFile = open(lblSrc,'r+')          # open file
    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        imgPath = srcLine[0].strip() 
        print imgPath   
        imgtypes = imgPath.split('.')   #~,jpg
        #img_type = imgtypes[0]          
        #img_newtype = img_type + ".mat"
        imgIterms = imgPath.split('/')  # path split
        if len(imgIterms) >= 5:
            timeName = imgIterms[1]     
            #sceneName = imgIterms[2]
            imgName = imgIterms[-1]
            imgNamef = imgName.split('.')
            imgf = imgNamef[0]
            #imgNewName = timeName + '_' + imgName
        imgNewName = timeName + '_' + img_newtype

files = os.listdir("/ssd/wangmaorui/code")
for filename in files:
    portion = os.path.splitext(filename)
    print(portion)
    if portion[1] ==".mp4":
        newname = portion[0]+".mp3"
        os.chdir("")
        os.rename(filename,newname)
