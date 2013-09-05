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





%% Isolate the green channel to identify grass/trees.
% Assume: the grass is green, which may not always be true.


%% Threshold the image.
threshold = 40; % [percent]
img = im2bw(img, threshold/100);

thresd = img;


%%

% Convert image from logical do double.
img = +img;

vert = zeros(95,8);
for n = 0:5
    vert(16*n+1:16*(n+1),n+1)=-1;
    vert(16*n+1:16*(n+1),n+3)=1;
end
vert=fliplr(vert);
%figure; imagesc(vert);
%
edges=abs(conv2(orig(:,:,3),vert,'same'));
% figure; imagesc(abs(edges));

% Highlight discovered edges

%figure; hist(edges(:),50);
[y,x] = find(edges>7);
figure; imagesc(edges); hold on;
plot(x,y,'r.'); hold off;



% threshold or use ren's line finding to separate sky and building (since
% not all of the key seems to be below the threshold between the sky and
% building.



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