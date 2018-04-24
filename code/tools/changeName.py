
old_file = '/ssd/wangmaorui/data/BackUp/label1_32.txt'
new_file = '/ssd/wangmaorui/data/BackUp/label_new.txt'
fr = open(old_file, 'r')
fw = open(new_file, 'w')
for line in fr.readlines():
    imgPath = line.strip() 
    #print(imgPath)   
    imgIterms = imgPath.split('/')  # path split
    if len(imgIterms) >= 3:
        pathName = imgIterms[0] + '/' +imgIterms[1]
        #print(pathName)      
     #  sceneName = imgIterms[2]
        imgName = imgIterms[-1]
        #print(imgName)
        imgNewName = pathName + '/' + '20171122_frame_' + imgName
        #print(imgNewName)      #Label/scene_22/20171122_frame_0.txt
        fw.write(imgNewName+'\n')
fw.flush()
fw.close(); fr.close()