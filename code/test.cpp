#include <iostream>
#include <vector>
#include <fstream>
#include <string>
using namespace std;
int main()
{
	vector<string> va;
	ifstream in("/ssd/wangmaorui/data/winRoi/winRoi_Images.txt");
	for(string s;in>>s;)
		va.push_back(s);
	for(int i=0;i<va.size();i++)
		cout<<va[i]<<" ";
	return 0;
}