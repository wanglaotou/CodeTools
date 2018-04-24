##
# date:20170324
# Use : count the face numbers
# Input: rectroiall.txt
##


import os,sys

def get_count_face(filename):
	no_face_count = 0
	face_count = 0
	
	f = open(filename)
	filelines = f.readlines()
	for line in filelines:
		imginfo = line.strip().split()
		#print line
		facenum = int(imginfo[1])
		if facenum == 0:
			no_face_count = no_face_count + 1
		else:
			face_count = face_count+facenum

		# for i in range(2,len(imginfo),5):
		# 	pos_label=int(imginfo[i])
		# 	print 'pos_label: ',pos_label
		# 	if pos_label == 0 :
		# 		right_face_count = right_face_count + 1
		# 	if pos_label == 2 :
		# 		left_face_count = left_face_count + 1
		# 	else :
		# 		normal_face_count = normal_face_count + 1
	f.close()

	return no_face_count,face_count


if __name__=="__main__":
	filename1 = sys.argv[1]
	# file1		            		
	no_face_count,face_count = get_count_face(filename1)
	print 'f1_no_face_count: ',no_face_count
	print 'f1_face_count: ',face_count



