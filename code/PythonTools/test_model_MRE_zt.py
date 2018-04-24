#### Use : test crowd counting model by MCNN3.x
#### Result Include : (1) test MAE & MSE (MAE :abosulute accuracy ; MSE :model robustness :MRE : relative accuracy)
####                  (2) save or show heatMap
#### base:luo hongling
#### revise:zt
#### date:20170911

#!/usr/bin/env python
import numpy as np
import skimage
import os
import sys
import cv2

from matplotlib import pyplot as plt
import matplotlib

caffe_root = '/home/wangmaorui/crowd_count/CwCCv2.1/caffe/'
sys.path.insert(0,caffe_root+'python')
os.chdir(caffe_root)
import caffe

# v1> print estcount(luo hongling)
def fileMap(filepath, netFile,caffeModel,saveFile):
    mapDir = os.path.join(filepath,'train_test_list/merge_pub_new_test.txt')
    mapList = np.loadtxt(mapDir,str,delimiter=' ')
    test_num = mapList[:,0].size
    total_MAE = 0.0
    total_MSE = 0.0
    total_gtcount = 0
    total_estcount = 0.0
    
    save = file(saveFile,"a")
    save.write("net_file: " + str(netFile)+"\n")
    save.write("caffe_model: "+str(caffeModel)+"\n")
    save.write("#image  #gtcount  #estcount  #abs(gtcount-estcount)  #MAE  #MSE" + "\n")


    ## for each img test
    for m in mapList:
        jpgDir = os.path.join(filepath,m[0])
        print jpgDir

        ## read label file
        a = m[0]
        b=a.replace('Image','Label')
        c=b.replace('jpg','txt')
        txtDir = os.path.join(filepath,c)
        print txtDir
        if(os.path.isfile(txtDir)):
            with open(txtDir,'r') as f:
                gtcount = float(f.readline())
                total_gtcount = total_gtcount + gtcount
                print("The gtcount is %s"%(gtcount))
                save.write(str(m[0])+": ")
                save.write(str(gtcount)+"  ")

        ## predict
        if(os.path.isfile(jpgDir)):
            ## 1> read img
            im = caffe.io.load_image(jpgDir)
            print im.shape[0]  # height
            print im.shape[1]  # width
            print im.shape[2]  # channel
            print im.shape

            ## 2> set net img size
            print 'net shape before:',net.blobs['data'].data.shape
            net.blobs['data'].reshape(1,im.shape[2],im.shape[0],im.shape[1])
            

            ## 3> Transformer
            transformer = caffe.io.Transformer({'data':net.blobs['data'].data.shape})
            transformer.set_transpose('data',(2,0,1))
            transformer.set_raw_scale('data',255)
            transformer.set_channel_swap('data',(2,1,0))

            ## 4> preprocess and Load transformer img to net memory
            net.blobs['data'].data[...] = transformer.preprocess('data',im)
            print 'net shape after:',net.blobs['data'].data.shape

            ## 5> infer
            out = net.forward()

            estcount = net.blobs['estcount'].data[0]
            #estdmap = net.blobs['estdmap'].data[0]

            print("The estcount is %.2f"%(estcount))
            save.write(str(estcount)+"  ")
            error = estcount-gtcount
            save.write(str(error)+"\n")

            cv2.imshow("img", im)
            cv2.waitKey(0)
            cv2.destroyAllWindows()
            #print ecount
        total_estcount = total_estcount + estcount
        total_MAE = total_MAE + np.abs(gtcount - estcount)
        total_MSE = total_MSE + np.square(gtcount - estcount)
    MAE = total_MAE / test_num
    MSE = np.sqrt(total_MSE / test_num)
    print("The total_MAE is %.2f"%(total_MAE))
    print("The total_MSE is %.2f"%(total_MSE))
    print("The MAE is %.2f"%(MAE))
    print("The MSE is %.2f"%(MSE))
    print("The total_gtcount is %.2f"%(total_gtcount))
    print("The P is %.2f"%((total_gtcount-total_MAE)/total_gtcount))
    save.write("total_gtcount = "+str(total_gtcount)+"\n")
    save.write("total_MAE = "+str(total_MSE)+"\n")
    save.write("MAE = "+str(MAE)+"\n")
    save.write("MSE = "+str(MSE)+"\n")
    save.write("P = "+str((total_gtcount-total_MAE)/total_gtcount)+"\n")
    #save.write("P2 = "+str(np.abs(total_num-total_estcount)/total_num)+"\n")
    save.close()


# v2> print estcount (zt :for support heatMap draw&save)
def fileMap(filepath,netFile,caffeModel,saveFile,saveMapFile,isSaveHeatMap=False):
    mapDir = os.path.join(filepath,'train_test_list/map_1_4_test.txt')  # map_1_4_train.txt
    mapList = np.loadtxt(mapDir,str,delimiter=' ')
    test_num = mapList[:,0].size
    total_MAE = 0.0
    total_MSE = 0.0
    total_MRE = 0.0
    total_gtcount = 0
    total_estcount = 0.0
    
    save = file(saveFile,"a")
    save.write("net_file: " + str(netFile)+"\n")
    save.write("caffe_model: "+str(caffeModel)+"\n")
    save.write("#image  #gtcount  #estcount  #abs(gtcount-estcount)  #MAE  #MSE  #MRE" + "\n")

    if isSaveHeatMap == True:
        if not os.path.exists(saveMapFile):
            os.mkdir(saveMapFile)

    ## for each img test
    for m in mapList:
        jpgDir = os.path.join(filepath,m[0])
        print jpgDir

        ## read label file
        a = m[0]
        b=a.replace('Image','Label')
        tmpindex = b.rfind('.')
        tmppath = b[:tmpindex]
        
        c = tmppath + '.txt'

        # print 'label tmppath:',c
        # c=b.replace('jpg','txt')
        txtDir = os.path.join(filepath,c)
        # print txtDir
        if(os.path.isfile(txtDir)):
            with open(txtDir,'r') as f:
                gtcount = float(f.readline())
                total_gtcount = total_gtcount + gtcount
                # print("The gtcount is %s"%(gtcount))
                save.write(str(m[0])+": ")
                save.write(str(gtcount)+"  ")
        else:
            continue

        ## predict
        if(os.path.isfile(jpgDir)):
            ## 1> read img
            # im = caffe.io.load_image(jpgDir)
            im = cv2.imread(jpgDir)

            # print im.shape[0]  # height
            # print im.shape[1]  # width 
            # print im.shape[2]  # channel
            # print im.shape
            w = im.shape[1]
            h = im.shape[0]
            if(im.shape[1]> 1300):
                w = im.shape[1]/2
            
            if(im.shape[0]> 1300):
                h = im.shape[0]/2
                
            # use for mean_value test
            # img = cv2.imread(jpgDir)
            # w = img.shape[1]/2
            # h = img.shape[0]/2
            # if(w> 1300):
            #     w = w/2            
            # if(h> 1300):
            #     h = h/2
            # im = np.array(img, dtype = np.float32)
            # im -= 127.5
            # im *= 0.0078125


            # im = np.reshape(im,(h,w,1))

            ## 2> set net img size
            # print 'net shape before:',net.blobs['data'].data.shape
            # net.blobs['data'].reshape(1,1,h,w)
            # net.blobs['data'].reshape(1,im.shape[2],360,640)
            net.blobs['data'].reshape(1,im.shape[2],360,640)

            ## 3> Transformer
            transformer = caffe.io.Transformer({'data':net.blobs['data'].data.shape})
            transformer.set_transpose('data',(2,0,1))
            # transformer.set_raw_scale('data',255)
            # transformer.set_channel_swap('data',(2,1,0))

            ## 4> preprocess and Load transformer img to net memory
            net.blobs['data'].data[...] = transformer.preprocess('data',im)
            print 'net shape after:',net.blobs['data'].data.shape

            ## 5> infer
            out = net.forward()

            estcount = net.blobs['estcount'].data[0]
        
            # print("The estcount is %.2f"%(estcount))
            save.write(str(estcount)+"  ")
            error = estcount-gtcount
            save.write(str(error)+"  ")
            error2 = round((np.abs(gtcount - estcount) / (gtcount+1)),3)
            print'Mre:',error2
            save.write(str(error2)+"\n")

            count = 0
            if isSaveHeatMap==True:
                count = count + 1
                # print 'count:',count
                feat = net.blobs['estdmap'].data[0]
                # print feat.shape[0]  # channel
                # print feat.shape[1]  # height
                # print feat.shape[2]  # width

                feat1 = np.reshape(feat, (feat.shape[1], feat.shape[2]))
                # print 'feat shape3:',feat1.shape
                
                ## show
                # plt.imshow(feat1,interpolation = 'nearest')
                # plt.show()

                ## save
                imgPathInx = jpgDir.split('/')
                imgName = imgPathInx[-1]
                imgPath = imgPathInx[-3]
                imgNameIndex = imgName.split('.')

                newImgPath = os.path.join(saveMapFile,imgPath)
                # print 'imgName:%s,imgPath:%s'%(imgName,imgPath)
                if not os.path.exists(newImgPath):
                    os.mkdir(newImgPath)
                matplotlib.image.imsave(os.path.join(newImgPath,imgNameIndex[0]+'.png'), feat1)

            # cv2.imshow("img", im)
            # cv2.waitKey(0)
            
     
        total_estcount = total_estcount + estcount
        total_MAE = total_MAE + np.abs(gtcount - estcount)
        total_MSE = total_MSE + np.square(gtcount - estcount)
        total_MRE = total_MRE + (np.abs(gtcount - estcount) / (gtcount+1))
        cv2.destroyAllWindows()

    MAE = total_MAE / test_num
    MSE = np.sqrt(total_MSE / test_num)
    MRE = total_MRE / test_num
    save.write("total_gtcount = "+str(total_gtcount)+"\n")
    save.write("total_MAE = "+str(total_MAE)+"\n")
    save.write("MAE = "+str(MAE)+"\n")
    save.write("MSE = "+str(MSE)+"\n")
    save.write("MRE = "+str(MRE)+"\n")
    save.write("P = "+str((total_gtcount-total_MAE)/total_gtcount)+"\n")
    save.close()

if __name__=='__main__':
    # workPath = '/home/zhangting/zhangting/code_exp/crowd_count/model/MCNN3.1/pretrain1_test1'
    workPath = sys.argv[1]
    dataPath = '/ssd/zhangting/crowdcount/data'

    netFile = os.path.join(workPath,'proto/deploy.prototxt')
    caffeModel = os.path.join(workPath,'model/mcnn.caffemodel')
    caffe.set_device(7)
    caffe.set_mode_gpu()       
    net = caffe.Net(netFile,caffeModel,caffe.TEST)

    savePath = os.path.join(workPath,'test')
    if not os.path.exists(savePath):
        os.mkdir(savePath)
    saveFile = os.path.join(savePath,'test_37.5w.txt')
    saveMapFile = os.path.join(workPath,'showMap')
    
    fileMap(dataPath, netFile,caffeModel,saveFile,saveMapFile,False)
