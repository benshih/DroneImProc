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

    VideoCapture capture(argv[1]);


    if(!capture.isOpened())
    {
        printf("Failed to open the video\n");
        return -1;
    }

    cout << "reached here";

    for(;;)
    {
        Mat frame;
        capture >> frame; // get a new frame from camera
        cout << "hi";
    }

    return 0;
}
