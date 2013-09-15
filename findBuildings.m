%% Detecting Buildings
%% Initial Details
close all;
clear all;
path = mfilename('fullpath');
addpath([path(1:end-length('findVeritcals')) 'img1']);
%% Load Image File and morphologically filter for edges
img = imread('purnell1.jpg');
img = rgb2gray(img);

se = strel('disk', 4);
imD = imdilate(img, se);
imE = imerode(img, se);
imEdge = double(imD-imE);
figure(1); imagesc(imEdge); title('Result of Morphological Filter');

%% Analyze edges
figure(2); hist(double(imEdge(:)),100); 
title('Histogram of Filter Output Intensity');

maxval = max(imEdge(:));
[y,x] = find(imEdge==maxval);
figure(1);
hold on; plot(x,y,'k.'); hold off;

%% Traverse Along Minimum Gradient
[imWidth, imHeight] = size(img);
cropX = max(0,x(1)-50):min(x(1)+50,imWidth);
cropY = max(0,y(1)-50):min(y(1)+50,imHeight);

crop = imEdge(cropX,cropY);
figure(3); imagesc(crop);
figure(4); hist(crop(:),200);

gradient = diff(crop);
se = strel('disk', 4);
% gradient = imerode(gradient,se);
figure(5); imagesc(gradient);
