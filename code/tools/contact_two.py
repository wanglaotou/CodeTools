old_file = '/ssd/wangmaorui/data/Scene/scene01_53.txt'
new_file = '/ssd/wangmaorui/data/Label/label/label01_53.txt'
mm_file = '/ssd/wangmaorui/data/scene_label01_53.txt'
#fr = open(old_file, 'r')
#fw = open(new_file, 'r')
fm = open(mm_file,'w')
for (index1, line1) in enumerate(open(old_file,'r')):
	for (index2, line2) in enumerate(open(new_file,'r')):
		if(index1 == index2):
			new_line = line1.strip() + ' ' + line2.strip()
			fm.write(new_line)
			fm.write('\n')
    #new_line = line.strip() + ' ' + line
    #fw.write(new_line)
fm.flush()
fm.close()
