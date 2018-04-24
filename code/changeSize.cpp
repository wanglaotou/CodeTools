// #include <iostream>
// #include <vector>
// #include <fstream>
// #include <string>
// #include <opencv2/opencv.hpp>
// using namespace std;
// using namespace cv;

// Mat getRoiImage(Mat srcimg,string file);
// string Dir_path = "/home/wangmaorui/Desktop/laotou/";

// int main(){
// 	Directory dir;
// 	string newfilename;
// 	vector<string> fileNames = dir.GetListFiles(Dir_path,"*.jpg", false);
// 	for(int i=0;i<fileNames.size();i++){
// 		string fileName = fileNames[i];
// 		string filefullname;
// 		string xmlname;
// 		newfilename = Dir_path + "size\\" + "5-3-" + fileName;
// 		filefullname = Dir_path + fileName;
// 		Mat srcimg = imread(filefullname);
// 		Mat desimg = getRoiImage(srcimg,filefullname);
// 		imwrite(newfilename,desimg);
// 	}
// 	return 0;
// }

// Mat getRoiImage(Mat srcimg, string file){
// 	int width = 0;
// 	int height = 0;
// 	if(3*srcimg.rows <= 5*srcimg.cols){
// 		width = srcimg.cols;
// 		height = 5 * srcimg.cols / 3; 
// 	}else{
// 		height = srcimg.rows;
// 		width = 3 * srcimg.rows / 5;
// 	}
// 	Mat desImg(height,width,CV_8UC3,Scalar(0,0,0));
// 	Mat imageROI;
// 	imageROI = desImg(Rect(0,0,srcimg.cols,srcimg.rows));
// 	Mat mask = imread(file,0);
// 	srcimg.copyTo(imageROI,mask);
// 	return desImg;
// }



#include <iostream>
#include <opencv2/opencv.hpp>
using namespace std;
using namespace cv;
int main(int argc,char **argv){
	Mat orgImg = imread("test.png");
	int extRows = 20;
	int extCols = 15;
	Mat extendImg;
	copyMakeBorder(orgImg,extendImg,extRows,extRows,extCols,extCols,BORDER_CONSTANT);
	imshow("original image", orgImg);
	imshow("extended image", extendImg);
	waitKey();
	return 0;
}