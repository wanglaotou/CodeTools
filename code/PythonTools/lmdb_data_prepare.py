#from prepare.net import *

import os ,sys,cv2,random
#import glob
import numpy as np

import lmdb

#Size of images  
IMAGE_WIDTH = 31 
IMAGE_HEIGHT = 31

caffe_root = "/home/zhangting/code_exp/MTCNN_Mask_20170407/mtcnn_train/caffe-multitask"
log_path = ''
caffe_dir = os.path.join(caffe_root, 'python')
if caffe_dir not in sys.path: 
	sys.path.insert(0, caffe_dir)
	print caffe_dir
	#os.environ['GLOG_logtostderr'] = '0'
	#os.environ['FLAGS_alsologtostderr'] = '1'
	#os.environ['GLOG_stderrthreshold'] = '1'
	#os.environ['GLOG_log_dir'] = os.path.os.path.realpath(log_path)

import caffe
from caffe.proto import caffe_pb2  
if log_path != "":
	caffe.set_log_dir(os.path.os.path.join(log_path, 'pycaffe'))

def get_count_face(filelines):
	right_face_count = 0
	left_face_count = 0
	normal_face_count = 0
	for line in filelines:
		imginfo = line.strip().split()
		facenum = int(imginfo[1])
		for i in range(2,len(imginfo),5):
			pos_label=int(imginfo[i])
			print 'pos_label: ',pos_label
			if pos_label == 0 :
				right_face_count = right_face_count + 1
			elif pos_label == 2 :
				left_face_count = left_face_count + 1
			else :
				normal_face_count = normal_face_count + 1

	return right_face_count,left_face_count,normal_face_count

def transform_img(img, img_width=IMAGE_WIDTH, img_height=IMAGE_HEIGHT):  #Histogram Equalization      
	# img[:, :, 0] = cv2.equalizeHist(img[:, :, 0])  
	# img[:, :, 1] = cv2.equalizeHist(img[:, :, 1])  
	# img[:, :, 2] = cv2.equalizeHist(img[:, :, 2])  
	 
	img = cv2.resize(img, (img_width, img_height), interpolation=cv2.INTER_LINEAR)  #Image Resizing, 
	return img  

# def make_datum(img, label):  #image is numpy.ndarray format. BGR instead of RGB     
# 	return caffe_pb2.Datum(  
# 	    channels=3,  
# 	    width=IMAGE_WIDTH,  
# 	    height=IMAGE_HEIGHT,  
# 	    label=label,  
# 	    data=np.rollaxis(img, 2).tobytes())# or .tostring() if numpy < 1.9  

def make_datum(img, label):  #image is numpy.ndarray format. BGR instead of RGB     
	return caffe_pb2.Datum(  
	    channels=3,  
	    width=IMAGE_WIDTH,  
	    height=IMAGE_HEIGHT,  
	    label=label,  
	    data=img.tostring())# or .tostring() if numpy < 1.9  

		
def net_train_validate_lmdb(train_lmdb,list_all):
	in_db = lmdb.open(train_lmdb, map_size=int(1e12))   
	with in_db.begin(write=True) as in_txn:
		in_idx = 0
		idx_num = 0
		for line in list_all:
			imginfo = line.strip().split()
			imgpath = imginfo[0]
			img = cv2.imread(imgpath,cv2.IMREAD_COLOR)
			if img is None:
				print 'error img'
				continue
			height, width, channels = img.shape
			# facenum = int(imginfo[1])
			for i in range(1,len(imginfo),5):
				pos_label=int(imginfo[i])
				# print 'pos_label: ',pos_label
				rect_x=int(imginfo[i+1])
				rect_y=int(imginfo[i+2])
				rect_w=int(imginfo[i+3])
				rect_h=int(imginfo[i+4])
				rect_x2 = rect_x+rect_w
				rect_y2 = rect_y+rect_h
				if rect_x < 0:
					rect_x = 0
				if rect_y < 0:
					rect_y = 0
				if rect_y2 >=height:
					rect_y2 = height-1
				if rect_x2 >= width:
					rect_x2 = width-1
				crop_img = img[rect_y:rect_y2,rect_x:rect_x2]
				# cv2.imshow('before',crop_img)
				# cv2.waitKey()
				crop_img = transform_img(crop_img, img_width=IMAGE_WIDTH, img_height=IMAGE_HEIGHT)
				# cv2.imshow('after',crop_img)
				# cv2.waitKey()
				datum = make_datum(crop_img, pos_label)
				in_txn.put('{:0>6d}'.format(idx_num), datum.SerializeToString())
				# in_txn.commit()
				# print 'pos_label: ',pos_label
				print '{:0>6d}'.format(idx_num) + ':' + imgpath
				idx_num += 1
				in_idx += 1
				if pos_label == 0 :
					flipped = cv2.flip(crop_img,1)
					# cv2.imshow("Flipped Horizontally", flipped)
					# cv2.waitKey(0)
					pos_label =2
					datum = make_datum(flipped, pos_label)
					in_txn.put('{:0>6d}'.format(idx_num), datum.SerializeToString())
					# print '{:0>6d}'.format(idx_num) + ':' + imgpath
					idx_num += 1
					in_idx += 1
					continue  ## train2 (no continue)
					
				elif pos_label == 2 :
					flipped = cv2.flip(crop_img,1)
					# cv2.imshow("Flipped Horizontally", flipped)
					# cv2.waitKey(0)
					pos_label =0
					datum = make_datum(flipped, pos_label)
					in_txn.put('{:0>6d}'.format(idx_num), datum.SerializeToString())
					# print '{:0>6d}'.format(idx_num) + ':' + imgpath
					idx_num += 1
					in_idx += 1
					continue
				else:
					###
					flipped = cv2.flip(crop_img,1)
					# cv2.imshow("Flipped Horizontally", flipped)
					# cv2.waitKey(0)
					#pos_label =0
					datum = make_datum(flipped, pos_label)
					in_txn.put('{:0>6d}'.format(idx_num), datum.SerializeToString())
					# print '{:0>6d}'.format(idx_num) + ':' + imgpath
					idx_num += 1
					in_idx += 1
					continue

					
	
		# in_txn.commit()
	in_db.close() 

def read_lmdb(lmdb_test):
	lmdb_env = lmdb.open(lmdb_test, readonly=True) 
	lmdb_txn = lmdb_env.begin() 
	lmdb_cursor = lmdb_txn.cursor() 
	datum = caffe_pb2.Datum() 

	for key, value in lmdb_cursor:
	    datum.ParseFromString(value)

	    label = datum.label
	    data = caffe.io.datum_to_array(datum)
	    print label
	    print data.shape
	    print datum.channels
	    image = data.transpose(1, 2, 0)
	    cv2.imshow('cv2.png', image)
	    cv2.waitKey(0)

	cv2.destroyAllWindows()
	lmdb_env.close()


if __name__ == "__main__":
	print ('This is main of module "data_prepare.py"')
	is_lmdb = True
	if is_lmdb :
		filelist1 = open("/home/zhangting/code_exp/MTCNN_AngleFace/Data/totallist/train8_6/train8_6.list",'r')
		filelist2 = open("/home/zhangting/code_exp/MTCNN_AngleFace/Data/totallist/train8/val3.list",'r')
		train_list = filelist1.readlines()
		val_list = filelist2.readlines()

		filelist1.close()
		filelist2.close()

		random.shuffle(train_list)
		random.shuffle(val_list)
	    
	    # f1_right_face_count,f1_left_face_count,f1_normal_face_count = get_count_face(list_all)
	    # print 'f1_right_face_count: ',f1_right_face_count
	    # print 'f1_left_face_count: ',f1_left_face_count
	    # print 'f1_nomal_face_count: ',f1_normal_face_count
	    # print 'length all list :',len(list_all)

		# train_lmdb
		train_lmdb = '/ssd2/zhangting/AngleFaceDet/data_lmdb/train8_6/train_lmdb'
		val_lmdb = '/ssd2/zhangting/AngleFaceDet/data_lmdb/train8_5/val_lmdb'
		os.system('rm -rf  ' + train_lmdb)
		#os.system('rm -rf  ' + val_lmdb)
		net_train_validate_lmdb(train_lmdb,train_list)
		#net_train_validate_lmdb(val_lmdb,val_list)
	else:
		train_lmdb = '/ssd2/zhangting/AngleFaceDet/data_lmdb/train5_3/train_lmdb'
		val_lmdb = '/ssd2/zhangting/AngleFaceDet/data_lmdb/train5_3/val_lmdb'
		read_lmdb(train_lmdb)
