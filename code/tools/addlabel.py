import os
import sys

lable_file = '/ssd/wangmaorui/data/scene23_test/new_label23.txt'

fl = open(lable_file,'r')
for line in fl.readlines():
    labelPath = line.strip() 
    #print(labelPath)
    if(os.path.exists(labelPath)):
    	pass
    else:
    	fw = open(labelPath,'w')
    	fw.write('0')
    	fw.flush()
fw.close()
fl.close()


