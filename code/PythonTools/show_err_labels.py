#show [label,rect] info by random list
#Input:rectroiall.txt
import os, sys, inspect, shutil, random, cv2
import argparse

RootDir = '/ssd/wangmaorui/data'

ap = argparse.ArgumentParser()
ap.add_argument("-lists", "--list", required=True, help="name of the list")
args = vars(ap.parse_args())

def show():
    path_img = args["list"]
    with open(path_img) as fl:
        Paths = fl.readlines()
        for Path in Paths:
            srcPath = Path.strip().split(' ')
            imgpath = srcPath[0].strip()
            head = srcPath[1].strip()
            print(head)
            length = len(srcPath)
            rect = []
            for i in range(2,length,5):
                flag = srcPath[i].strip()
                pos_x = srcPath[i+1].strip()
                pos_y = srcPath[i+2].strip()
                value_x = srcPath[i+3].strip()
                value_y = srcPath[i+4].strip()
                rect.append(flag)
                rect.append(pos_x)
                rect.append(pos_y)
                rect.append(value_x)
                rect.append(value_y)
            lenrect = len(rect)
            imgpath = os.path.join(RootDir,imgpath)
            print(imgpath)
            img = cv2.imread(imgpath)
            
            for i in range(0,lenrect,5):
                pos_x = int(rect[i+1])
                pos_y = int(rect[i+2])
                value_x = int(rect[i+3])
                value_y = int(rect[i+4])
                cv2.rectangle(img,(pos_x,pos_y),(pos_x+value_x,pos_y+value_y),(0,255,0),1)
            cv2.imshow('show', img)
            cv2.waitKey(0)

def main():
  show()

if __name__ == '__main__':
    main()
