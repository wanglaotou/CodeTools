import os, sys
import cv2
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy

imgpath = "/home/wangmaorui/Desktop/laotou/test.jpg"
img = mpimg.imread(imgpath)
newimg = cv2.copyMakeBorder(img,50,50,50,50,cv2.BORDER_CONSTANT,value=[0,255,0])
plt.imshow(newimg)
plt.axis('off')
plt.show()