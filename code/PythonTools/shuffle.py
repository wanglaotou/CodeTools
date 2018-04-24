#shuffle list
import os
import random

old_file = '/ssd/wangmaorui/code/111.txt'
new_file = '/ssd/wangmaorui/code/haha.txt'
fr = open(old_file,'r')
fw = open(new_file,'w')
list = []
for line in fr.readlines():
	line = line.strip()
	list.append(line)
random.shuffle(list)
#print(list)
for line2 in list:
	line2 = line2 + '\n'
	fw.write(line2)
fw.flush()
fw.close()
fr.close()

