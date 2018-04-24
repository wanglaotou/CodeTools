import os, sys
import argparse
import cv2

# ************* select the special list ***************
ap = argparse.ArgumentParser()
ap.add_argument("-dirs", "--dir", required=True, help="path of the image input")
ap.add_argument("-lists", "--list", required=True, help="name of the list")
ap.add_argument("-dsts", "--dst", required=True, help="path of the crop output")
ap.add_argument("-txt","--txt",required=True,help="path of the crop list")
args = vars(ap.parse_args())

txt = args["txt"]
ft = open(txt,'w')

def create_crop(dirs,lists,dsts):
	if not os.path.exists(dsts):
		os.makedirs(dsts)
	with open(lists) as fl:
		strLines = fl.readlines()
		for line in strLines:
			srcLine = line.strip().split(' ')
			lenlist = len(srcLine)
			rect = []
			for c in range(2,lenlist,5):
				flag = srcLine[c].strip()
				pos_x = srcLine[c+1].strip()
				pos_y = srcLine[c+2].strip()
				value_x = srcLine[c+3].strip()
				value_y = srcLine[c+4].strip()
				rect.append(flag)
				rect.append(pos_x)
				rect.append(pos_y)
				rect.append(value_x)
				rect.append(value_y)
			# print(rect)
			lenrect = len(rect)
			imgpath = srcLine[0].strip()
			# print(imgpath)
			pathLine = imgpath.strip().split('/')
			imgname = pathLine[-1]
			# print(imgname)
			imgpre = imgname[:-4]
			imgpost = imgname[-4:]
			scene = pathLine[1:-1]
			length = len(scene)
			if(length==1):
				dstpath = os.path.join(dsts,str(scene[0]))
			elif(length==2):
				dstpath = os.path.join(dsts,str(scene[0]))
				dstpath = os.path.join(dstpath,str(scene[1]))
			else:
				break;
			# print(dstpath)
			if not os.path.exists(dstpath):
				os.makedirs(dstpath)
			
			imgfullpath = os.path.join(dirs,imgpath)
			img = cv2.imread(imgfullpath)
			hei,wid = img.shape[:2]
			# print(hei,wid)
			hh = hei / 128
			ww = wid / 128
			for i in range(0,hh):
				for j in range(0,ww):
					imgcrop = img[i*128:(i+1)*128,j*128:(j+1)*128]
					aa = imgcrop.shape[0]
					bb = imgcrop.shape[1]
					count = i*ww+j+1
					imgnew = imgpre + '_' + str(count) + imgpost
					cropfullpath = os.path.join(dstpath,imgnew)
					ft.write(cropfullpath)
					# print(cropfullpath)
					# cv2.namedWindow("Image")
					# cv2.imshow("Image", imgcrop)
					# cv2.waitKey(0)
					# cv2.imwrite(cropfullpath,imgcrop)

					head = 0
					for r in range(0,lenrect,5):
						flag = rect[r].strip()
						pos_x = int(rect[r+1].strip())
						pos_y = int(rect[r+2].strip())
						value_x = int(rect[r+3].strip())
						value_y = int(rect[r+4].strip())
						head_x = pos_x + int(value_x/2)
						head_y = pos_y + int(value_y/2)
						if(head_x>=j*128 and head_x<(j+1)*128 and head_y>=i*128 and head_y<(i+1)*128):
							head += 1
							
					ft.write(' '+str(head))
					for r in range(0,lenrect,5):
						flag = rect[r].strip()
						pos_x = int(rect[r+1].strip())
						pos_y = int(rect[r+2].strip())
						value_x = int(rect[r+3].strip())
						value_y = int(rect[r+4].strip())
						head_x = pos_x + int(value_x/2)
						head_y = pos_y + int(value_y/2)
						# if(pos_x>=i*128 and pos_x<(i+1)*128 and pos_y>=j*128 and pos_y<(j+1)*128):
						# 	head += 1
						if(head>0):
							if(head_x>=j*128 and head_x<(j+1)*128 and head_y>=i*128 and head_y<(i+1)*128):
								ft.write(' '+flag+' '+str(head_x - int(value_x/2) - j*128)+' '+str(head_y - int(value_y/2) - i*128)+' '+str(value_x)+' '+str(value_y))
					ft.write('\n')
			

def main():
	dirs = args["dir"]
	lists = args["list"]
	dsts = args["dst"]
	create_crop(dirs,lists,dsts)


if __name__ == '__main__':
	main()