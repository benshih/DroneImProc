/**
 * file Mosaicking.cpp
 * brief Image stitching
 * author Benjamin Shih
 */
#include <iostream>
#include <stdio.h>

#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/core/core.hpp"
#include "opencv2/nonfree/nonfree.hpp"
#include "opencv2/calib3d/calib3d.hpp"

using namespace cv;
using namespace std;

void readme();

int main(int argc, char** argv)
{
/*    if(1 != argc)
    {
        readme();
        return -1;
    }

    //int numImages = system(ls images|wc -l);
   
    Mat finalImage;

    if(0 == numImages)
    {
        cout << "No images found in subdirectory" << endl;
        return -1;
    }
    if(1 == numImages)
    {
        //Mat image = imread
        //finalImage = 1.png;
        return 0;
    }
*/
    // Load images.
    Mat image1 = imread(argv[2]);
    Mat image2 = imread(argv[1]);
    Mat gray_image1;
    Mat gray_image2;

    // Convert to grayscale.
    cvtColor(image1, gray_image1, CV_RGB2GRAY);
    cvtColor(image2, gray_image2, CV_RGB2GRAY);
    
    imshow("image1", image1);
    imshow("image2", image2);

    if(!gray_image1.data || !gray_image2.data)
    {
        cout << "Error reading images" << endl;
        return -1;
    }

    // 1. Use SURF points to identify key features. 
    int minHessian = 400;
    SurfFeatureDetector detector(minHessian);
    vector<KeyPoint> keypoints_object, keypoints_scene;

    detector.detect(gray_image1, keypoints_object);
    detector.detect(gray_image2, keypoints_scene);

    // 2. Calculate descriptors (feature vectors).
    SurfDescriptorExtractor extractor;
    Mat descriptors_object, descriptors_scene;

    extractor.compute(gray_image1, keypoints_object, descriptors_object);
    extractor.compute(gray_image2, keypoints_scene, descriptors_scene);
    
    // 3. Match descriptors using FLANN matcher.
    FlannBasedMatcher matcher;
    vector<DMatch> matches;
    matcher.match(descriptors_object, descriptors_scene, matches);

    double max_dist = 0;
    double min_dist = 100;

    // Calculation of max and min distances between keypoints.
    for(int i = 0; i < descriptors_object.rows; i++)
    {
        double dist = matches[i].distance;
        if(dist < min_dist)
            min_dist = dist;
        if(dist > max_dist)
            max_dist = dist;
    }

    // Only use matches whose distance is less than 3*min_dist.
    vector<DMatch> good_matches;

    for(int i = 0; i < descriptors_object.rows; i++)
    {
        if(matches[i].distance < 3*min_dist)
        {
            good_matches.push_back(matches[i]);
        }
    }
    vector<Point2f> obj;
    vector<Point2f> scene;

    // Get the keypoints from the good matches
    for(int i = 0; i < good_matches.size(); i++)
    {
        obj.push_back(keypoints_object[good_matches[i].queryIdx].pt);
        scene.push_back(keypoints_scene[good_matches[i].trainIdx].pt);
    }

    // 4. Use the homography matrix to warp the matches.
    // Find the homography matrix.
    Mat H = findHomography(obj, scene, CV_RANSAC);

    Mat result;
    warpPerspective(image1, result, H, Size(image1.cols+image2.cols,image1.rows));
    Mat half(result, Rect(0, 0, image2.cols, image2.rows));
    image2.copyTo(half);
    imshow("Stitched", result);
    imwrite("result.png", result);

    waitKey(0);
    return(0);
}

void readme()
{
    cout << "Usage: './Mosaic'. Images should be in a subdirectory called images" << endl;
}