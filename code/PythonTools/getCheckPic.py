#change label info, likne scene 640x480-->1280x720
import sys
import os

dir = '/home/wangmaorui/crowd_count/Experiments/v2.1.0_mcnn_test5/v2.1.0_mcnn_test5_result/mcnn'
old1_4_file = os.path.join(dir,'crowd1_4_test.txt')
# old1_5_file = os.path.join(dir,'crowd1_5_test')
new1_4_file = os.path.join(dir,'crowd1_4_check.txt')
# new1_5_file = os.path.join(dir,'crowd1_5_check')
print(old1_4_file)
fro1_4 = open(old1_4_file,'r')
# fro1_5 = open(old1_5_file,'r')

for line in fro1_4.readlines():
    # labelPath = line.strip()
    if(len(line)==5):
        llp = line.strip().split(' ')
        RoiPath = llp[0]
        mre = llp[4]
        print(type(mre))
    