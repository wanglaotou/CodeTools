#include <opencv2/opencv.hpp>
#include <iostream>
#include <vector>
#include <fstream>
#include <string>
using namespace cv;
using namespace std;
int main(){  
	string img_path;
	int head_num;
	int posx,posy;
	ifstream infile("scene01.txt");
	Mat img = imread("scene01.jpg", CV_LOAD_IMAGE_UNCHANGED);
	cv::Mat locMask(img.rows,img.cols,CV_8UC1,cv::Scalar(0));
	cv::Point pt;
	std::vector<cv::Point> coordinates;
	while (infile >>img_path >> head_num) {
		//cout<<"head_num:"<<head_num<<endl;
        for(int i = 0 ; i< head_num;i++) {
            infile >> posx >> posy;
            pt = Point(posx,posy);
            coordinates.push_back(pt);
        }
    }
	//cv::drawContours(locMask,coordinates,cv::Scalar(255),CV_FILLED,8);
	return 0;
}
