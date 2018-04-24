import os, sys
import argparse

# # ************* UCSD dataset***************
# ap = argparse.ArgumentParser()
# ap.add_argument("-i", "--inputpath", required=True, help="path of the input")
# ap.add_argument("-o", "--outputpath", required=True, help="path of the output")
# ap.add_argument("-n", "--val", required=True, help="the val need change, better be even number")
# args = vars(ap.parse_args())

# fo = open(args["outputpath"],'w')
# with open(args["inputpath"]) as fp:
# 	Strlines = fp.readlines()
# 	for line in Strlines:
# 		# print(line)
# 		Srcline = line.strip().split(' ')
# 		length = len(Srcline)
# 		# print(length)
# 		imgpath = Srcline[0].strip()
# 		headnum = int(Srcline[1].strip())
# 		# print(imgpath)
# 		fo.write(imgpath+' '+str(headnum))
# 		for i in range(2,length,5):
# 			pos_x = int(Srcline[i+1]) + int(args["val"])/2
# 			pos_y = int(Srcline[i+2]) + int(args["val"])/2
# 			value = int(Srcline[i+3]) - int(args["val"])
# 			fo.write(' '+str(1)+' '+str(pos_x)+' '+str(pos_y)+' '+str(value)+' '+str(value))
		
# 		fo.write('\n')

# # ************** ShanghaiTech set the min ksize***********************
# ap = argparse.ArgumentParser()
# ap.add_argument("-i", "--inputpath", required=True, help="path of the input")
# ap.add_argument("-o", "--outputpath", required=True, help="path of the output")
# ap.add_argument("-n", "--val", required=True, help="the val need set, better be even number")
# args = vars(ap.parse_args())

# fo = open(args["outputpath"],'w')
# with open(args["inputpath"]) as fp:
# 	Strlines = fp.readlines()
# 	for line in Strlines:
# 		Srcline = line.strip().split(' ')
# 		length = len(Srcline)
# 		# print(length)
# 		imgpath = Srcline[0].strip()
# 		headnum = Srcline[1].strip()
# 		# print(headnum)
# 		fo.write(imgpath+' '+headnum)
# 		for i in range(2,length,5):
# 			pos_x = int(Srcline[i+1])
# 			pos_y = int(Srcline[i+2])
# 			value = int(Srcline[i+3])
# 			if(value < int(args["val"])):	
# 				pos_x = pos_x - int(args["val"])/2
# 				pos_y = pos_y - int(args["val"])/2
# 				value = int(args["val"])
# 			fo.write(' '+str(1)+' '+str(pos_x)+' '+str(pos_y)+' '+str(value)+' '+str(value))

# 		fo.write('\n')


# # ************** ShanghaiTech set the fixed ksize***********************
# ap = argparse.ArgumentParser()
# ap.add_argument("-i", "--inputpath", required=True, help="path of the input")
# ap.add_argument("-o", "--outputpath", required=True, help="path of the output")
# ap.add_argument("-n", "--val", required=True, help="the val need fix, better be even number")
# args = vars(ap.parse_args())

# fo = open(args["outputpath"],'w')
# with open(args["inputpath"]) as fp:
# 	Strlines = fp.readlines()
# 	for line in Strlines:
# 		Srcline = line.strip().split(' ')
# 		length = len(Srcline)
# 		# print(length)
# 		imgpath = Srcline[0].strip()
# 		headnum = Srcline[1].strip()
# 		# print(headnum)
# 		fo.write(imgpath+' '+headnum)
# 		for i in range(2,length,5):
# 			pos_x = int(Srcline[i+1])
# 			pos_y = int(Srcline[i+2])
# 			value = int(args["val"])
# 			pos_x = pos_x - value/2;
# 			pos_y = pos_y - value/2;
# 			fo.write(' '+str(1)+' '+str(pos_x)+' '+str(pos_y)+' '+ str(value) +' '+ str(value))

# 		fo.write('\n')



# ************** part1,2 set the square ksize***********************
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--inputpath", required=True, help="path of the input")
ap.add_argument("-o", "--outputpath", required=True, help="path of the output")
args = vars(ap.parse_args())

fo = open(args["outputpath"],'w')
with open(args["inputpath"]) as fp:
	Strlines = fp.readlines()
	for line in Strlines:
		Srcline = line.strip().split(' ')
		length = len(Srcline)
		# print(length)
		imgpath = Srcline[0].strip()
		headnum = Srcline[1].strip()
		# print(headnum)
		fo.write(imgpath+' '+headnum)
		for i in range(2,length,5):
			pos_x = int(Srcline[i+1])
			pos_y = int(Srcline[i+2])
			wid = int(Srcline[i+3])
			hei = int(Srcline[i+4])
			minval = min(wid,hei);
			fo.write(' '+str(1)+' '+str(pos_x)+' '+str(pos_y)+' '+ str(minval) +' '+ str(minval))

		fo.write('\n')