#get label info from ImageFolder.txt(origin from YangWY) opposite to getOrigin.py
import os
import sys
import shutil

mydir = '/home/wangmaorui/crowd_count/Experiments/v2.1.0_mcnn_test5/mcnn/log'

if __name__=="__main__":
    #lblSrc = sys.argv[1]		#path of txt
    originpath = os.path.join(mydir,'pycaffe20180110-151247-31929_train.log')
    losspath = os.path.join(mydir,'train_loss.log')
    floss = open(losspath,'w')
    forigin = open(originpath,'r')
    OriginLines = forigin.readlines()
    for originline in OriginLines:
        oline = originline.strip().split(',')
        #print(len(oline))
        Iters = oline[0]
        #print(oriInfo)
        loss = oline[5]
        floss.write(Iters)
        floss.write(',')
        floss.write(loss)
        floss.write('\n')
    floss.close()
    forigin.close()

