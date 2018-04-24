#some label.txt(no headnum) doesn't exist, so we add 0 to this label.txt
#scene.txt(all)-->label.txt(all)
import os
import sys

lable_file = '/ssd/wangmaorui/data/Scene/label.txt'

fl = open(lable_file,'r')
for line in fl.readlines():
    labelPath = line.strip() 
    #print(labelPath)
    #print(os.path.exists(labelPath))
    if(os.path.exists(labelPath)):
    	pass
    else:
    	fw = open(labelPath,'w')
    	fw.write('0')
    	fw.flush()
fw.close()
fl.close()

