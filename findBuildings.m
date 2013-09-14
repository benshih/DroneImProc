%% Detecting Buildings
%% Initial Details
close all;
clear all;
path = mfilename('fullpath');
addpath([path(1:end-length('findVeritcals')) 'img1']);
%% Load Image File and morphologically filter for edges
img = imread('purnell1.jpg');
img = rgb2gray(img);

se = strel('square', 4);
imD = imdilate(img, se);
imE = imerode(img, se);
imEdge = imD-imE;
figure; imagesc(imEdge); title('Result of Morphological Filter');

%% Analyze edges
figure; hist(double(imEdge(:)),100); 
title('Histogram of Filter Output Intensity');