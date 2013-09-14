% Benjamin Shih
% 9/13/2013 to -
% Object Detection and Tracking using the Computer Vision System Toolbox
% Based off the example found at http://www.mathworks.com/help/vision/gs/object-detection-and-tracking.html
close all
clear all 

% Object of interest. 
obj = imread('bottle.JPG');
figure;
imshow(obj);
title('picture of a water bottle');

% Scene environment.
scene = imread('scene.JPG');
figure;
imshow(scene);
title('picture of scene');

% DEtect feature points in both images.
objPoints = detectSURFFeatures(obj(:,:,1));
scenePoints = detectSURFFeatures(scene(:,:,1));


% Visualize the strongest feature points found in the reference image.
% Number of strongest feature points found in the reference image using
% the Speeded Up Robust Features (SURF) algorithm.
n = 50;

figure;
imshow(obj);
title([num2str(n) 'strongest feature points for the object']);
hold on;
plot(objPoints.selectStrongest(n));