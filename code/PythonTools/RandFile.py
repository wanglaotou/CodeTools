#把文件行序打乱
import random
import sys
if len(sys.argv) == 2:
    fileName = sys.argv[1]
else:
    fileName = r'.\LIST_TRUTH.txt'

indSuf = fileName.rfind('.')
path = fileName[:indSuf]
suffix = fileName[indSuf:]

infile = open(fileName, 'r')
otfile = open(path + '_R' + suffix, 'w') 

data = infile.readlines()
lenth = len(data)
print(lenth)

random.shuffle(data)

for line in data:
    line1 = line.strip()
    otfile.write(line1)
    otfile.write('\n')

infile.close()
otfile.close()
