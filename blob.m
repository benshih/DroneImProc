tic;

close all
clear all

% name of the input file using relative paths
imname = 'purnell1.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
img = im2double(fullim);

orig = img;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Goal - identify grass building sky first. then tree. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Isolate the blue channel to identify sky. 
% Assume: the sky is blue, which may not always be true.
imgSize = size(orig(:,:,1));
zeroMat = zeros(imgSize);
imgB = cat(3, zeroMat, zeroMat, orig(:,:,3));

figure, imagesc(orig(:,:,3))


% threshold or use ren's line finding to separate sky and building (since
% not all of the key seems to be below the threshold between the sky and
% building.



%% Isolate the green channel to identify grass/trees.
% Assume: the grass is green, which may not always be true.


%% Threshold the image.
threshold = 40; % [percent]
img = im2bw(img, threshold/100);

thresd = img;

%% Blur the image using a Gaussian filter.
% h = fspecial('gaussian', 10, 10);
% imgGaussFilt = imfilter(img, h);
% 
% figure
% subplot(1,2,1), imshow(orig)
% subplot(1,2,2), imshow(img)

%% Erode the image using a rolling ball structured element.
se = strel('square', 4);
img = imerode(img, se);


%% Remove small objects from binary image.
% numPix = 100;
% imgAreaOpen = bwareaopen(imgbw, numPix);
% 
% figure
% subplot(1,2,1), imshow(orig)
% subplot(1,2,2), imshow(imgAreaOpen);


%% Trace region boundaries.
% http://www.mathworks.com/help/images/ref/bwboundaries.html

%% Fill holes in the image.
% http://www.mathworks.com/help/images/ref/imfill.html


%% Enhance contrast using bottom hat filtering.
% Create a disk-shaped structuring element, which will be used for
% morphological processing.
% se = strel('disk', 3); 
% img = imsubtract(imadd(img, imtophat(img, se)), imbothat(img, se));


%% Display original image compared to processed image. 
figure
subplot(1,3,1), imshow(orig)
subplot(1,3,2), imshow(thresd)
subplot(1,3,3), imshow(img)

toc;