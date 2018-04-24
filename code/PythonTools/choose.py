import os, sys
import argparse

ap = argparse.ArgumentParser()
ap.add_argument("-i", "--inputpath", required=True, help="path of the input")
ap.add_argument("-o", "--outputpath", required=True, help="path of the output")
args = vars(ap.parse_args())

# # ********choose the scene need pick out***********
# fo = open(args["outputpath"],'w')
# with open(args["inputpath"]) as fp:
# 	Strlines = fp.readlines()
# 	for line in Strlines:
# 		Srcline = line.strip().split(' ')
# 		# print(type(Srcline))
# 		imgpath = Srcline[0].strip()
# 		# print(imgpath)
# 		Srcpath = imgpath.strip().split('/')
# 		scenename = Srcpath[2].strip()
# 		# print(scenename)
# 		if(scenename=='12'):
# 			fo.write(line)


# # *********change the label info which the scene pick out ********
# fo = open(args["outputpath"],'w')
# with open(args["inputpath"]) as fp:
# 	Strlines = fp.readlines()
# 	for line in Strlines:
# 		Srcline = line.strip().split(' ')
# 		imgpath = Srcline[0].strip()
# 		print(imgpath)
# 		headnum = int(Srcline[1].strip())
# 		fo.write(imgpath)
# 		length = len(Srcline)
# 		rect = []
# 		for i in range(2,length,5):
# 			pos_x = int(Srcline[i+1])
# 			pos_y = int(Srcline[i+2])
# 			wid = int(Srcline[i+3])
# 			hei = int(Srcline[i+4])
# 			if(pos_x>1155 and pos_x<1200 and pos_y>140 and pos_y<180):
# 				headnum = headnum-1
# 			else:
# 				rect.append(pos_x)
# 				rect.append(pos_y)
# 				rect.append(wid)
# 				rect.append(hei)

# 		fo.write(' '+str(headnum))
# 		lenrect = len(rect)
# 		print(rect)
# 		for i in range(0,lenrect,4):
# 			pos_x = rect[i]
# 			pos_y = rect[i+1]
# 			wid = rect[i+2]
# 			hei = rect[i+3]
# 			fo.write(' '+ str(1) + ' '+ str(pos_x)+' '+str(pos_y)+' '+str(wid)+' '+str(hei))
# 		fo.write('\n')


# # *********change the label info which the scene pick out ********
# fo = open(args["outputpath"],'w')
# with open(args["inputpath"]) as fp:
# 	Strlines = fp.readlines()
# 	for line in Strlines:
# 		Srcline = line.strip().split(' ')
# 		imgpath = Srcline[0].strip()
# 		print(imgpath)
# 		headnum = int(Srcline[1].strip())
# 		fo.write(imgpath)
# 		length = len(Srcline)
# 		Simgline = imgpath.strip().split('/')
# 		scene = Simgline[1].strip()
# 		scenename = Simgline[2].strip()
# 		print(scenename)
# 		rect = []
# 		for i in range(2,length,5):
# 			pos_x = int(Srcline[i+1])
# 			pos_y = int(Srcline[i+2])
# 			wid = int(Srcline[i+3])
# 			hei = int(Srcline[i+4])
# 			if(scene =='part2_roi' and scenename == '12' and pos_x>1155 and pos_x<1200 and pos_y>140 and pos_y<180):
# 				headnum = headnum-1
# 			else:
# 				rect.append(pos_x)
# 				rect.append(pos_y)
# 				rect.append(wid)
# 				rect.append(hei)

# 		fo.write(' '+str(headnum))
# 		lenrect = len(rect)
# 		print(rect)
# 		for i in range(0,lenrect,4):
# 			pos_x = rect[i]
# 			pos_y = rect[i+1]
# 			wid = rect[i+2]
# 			hei = rect[i+3]
# 			fo.write(' '+ str(1) + ' '+ str(pos_x)+' '+str(pos_y)+' '+str(wid)+' '+str(hei))
# 		fo.write('\n')

# *********choose the scenes  which are picked out ********
fo = open(args["outputpath"],'w')
with open(args["inputpath"]) as fp:
	Strlines = fp.readlines()
	for line in Strlines:
		Srcline = line.strip().split(' ')
		imgpath = Srcline[0].strip()
		# print(imgpath)
		headnum = int(Srcline[1].strip())
		
		length = len(Srcline)
		Simgline = imgpath.strip().split('/')
		scene = Simgline[1].strip()
		scenename = Simgline[2].strip()
		print(scene)
		if(scene == 'scene48'):
			fo.write(imgpath)
			rect = []
			for i in range(2,length,5):
				pos_x = int(Srcline[i+1])
				pos_y = int(Srcline[i+2])
				wid = int(Srcline[i+3])
				hei = int(Srcline[i+4])
		
				rect.append(pos_x)
				rect.append(pos_y)
				rect.append(wid)
				rect.append(hei)

			fo.write(' '+str(headnum))
			lenrect = len(rect)
			# print(rect)
			for i in range(0,lenrect,4):
				pos_x = rect[i]
				pos_y = rect[i+1]
				wid = rect[i+2]
				hei = rect[i+3]
				fo.write(' '+ str(1) + ' '+ str(pos_x)+' '+str(pos_y)+' '+str(wid)+' '+str(hei))
			fo.write('\n')