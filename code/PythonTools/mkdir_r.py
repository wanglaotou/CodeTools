import os

rootdir = '/ssd/wangmaorui/data/Label/label22_53'
list = os.listdir(rootdir) 

for i in range(0,len(list)):	#32
    path = os.path.join(rootdir,list[i])
    #scenename = 'scene' + str(i+22)
    #labelname = 'scene' + str(i+22)
    #fullscenename = os.path.join(path,scenename)
    #fulllabelname = os.path.join(path,labelname)
    #print(fulllabelname)
    #print(os.path.exists(path)) #false
    if os.path.exists(path):
        for k in os.listdir(path):
            #print(k)
            fullpath = os.path.join(path,k)
            #print(fullpath)
            os.remove(os.path.join(path,k))
        
    else:
        pass
    #    os.mkdir(fulllabelname)
    #	os.mkdir(fullscenename)