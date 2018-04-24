#add many .txt info into a .txt
#get many .txt to a listfile, and read this listfile to add all .txt into a .txt
import os
import sys
import shutil

rectroipath = '/ssd/wangmaorui/data/RectRoi01_21'

if __name__=="__main__":

    rectroioldpath = os.path.join(rectroipath,'rectroi.txt')
    rectroinewpath = os.path.join(rectroipath,'rectroiall.txt')
    lblFile = open(rectroioldpath,'r')
    frect = open(rectroinewpath,'w')

    lblSrcFLines = lblFile.readlines()
    for line in lblSrcFLines:
        srcLine = line.strip().split()  # space split
        sline = srcLine[0].strip()
        froi = open(sline,'r')
        roilines = froi.readlines()
        for rline in roilines:
            frect.write(rline)
        froi.close()

    frect.close()
    lblFile.close()


