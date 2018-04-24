#change label info, likne scene 640x480-->1280x720
import math
import os

old_file = '/ssd/wangmaorui/data/Label/label/label_part.txt'
dir = '/ssd/wangmaorui/data/Label/label22_53'
fr = open(old_file,'r')

for line in fr.readlines():
    labelPath = line.strip()
    labelName = labelPath.strip().split('/')
    label_name = labelName[7]
    scenename = labelName[6]    #scene22...
    #print(label_name)   #20171122_frame_99.txt
    scenedir = os.path.join(dir,scenename)
    #print(scenedir)
    newlabelPath = os.path.join(scenedir,label_name)
    #print(newlabelPath)
    fw = open(labelPath,'r')
    fm = open(newlabelPath,'w')
    for conline in fw.readlines():
        labelInfo = conline.strip()
        label_info = labelInfo.split(' ')
        if(len(label_info)==1):
            head = label_info[0]
            #print(type(head))
            #head = head + '\n'
            #print(head)
            fm.write(head)
        else:
            label_x = label_info[0]
            label_y = label_info[1]
            label_x = int(label_x)
            label_y = int(label_y)
            label_x = math.ceil((128/57) * (label_x - 35))
            if(label_x <= 0):
                label_x = 0
            label_y = math.floor((72/32) * (label_y - 70))
            if(label_y <= 0):
                label_y = 1
            #print(label_x,label_y)
            label_x = str(label_x)
            label_y = str(label_y)
            new_content = label_x + ' ' + label_y
            #print(new_content)
	    fm.write('\n')
            fm.write(new_content)
    fw.close()
fm.flush()
fm.close()
fr.close()


