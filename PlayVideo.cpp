#include <cstdio>
#include<iostream>
#include<fstream>
#include<opencv2/opencv.hpp>
#include<opencv2/nonfree/features2d.hpp>
using namespace std;
using namespace cv;


int main(int argc, char *argv[])
{
    printf("2");
    if (argc <= 1)
    {
        printf("Usage: %s video\n", argv[0]);
        return -1;
    }

    printf("1");

	VideoCapture cap;
	if(argc > 1)
		cap.open(string(argv[1]));
	else
		cap.open(0);
	Mat fram; namedWindow("video",1);

    cout << "reached here";

    Mat frame;
    for(;;)
    {
        cap >> frame; // get a new frame from camera
        if(!frame.data)
		break;
	imshow("video", frame);
	if(waitKey(30) >=0)
		break;
    }

    return 0;
}
