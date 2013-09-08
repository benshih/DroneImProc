% The goal of this program is to detect a tree. We will first start with
% the trees in the purnell image.

tic;

close all
clear all

% name of the input file using relative paths
imname = 'tree2.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix (might want to do this later on to same memory)
img = im2double(fullim);

orig = img;


%% Isolate the green channel to identify sky. 
% Assume: the sky is green, which may not always be true.
imgSize = size(orig(:,:,1));
zeroMat = zeros(imgSize);
imgGchan = orig(:,:,2);
imgG = cat(3, zeroMat, imgGchan, zeroMat);

% figure, imagesc(imgGchan)

%% Threshold the image.
threshold = 40; % [percent]
img = im2bw(img, threshold/100);

thresd = img;

%% Dilate image using octagon structuring elements.

se = strel('disk', 4, 0);
img = imerode(img, se);

eroded = img;

%% Convert image from logical do double.
img = +img;

%% Fill the regions and holes in the image.
img = imfill(img);
img = imcomplement(img);
img = imfill(img);
img = imcomplement(img);

filled = img;

%% Bitwise and the image with the inverted filled image in order to leave only the tree.

% naive implementation for: "tree" should be in white (1), background should be in black (0). 
img = imcomplement(img);
imgMasked = zeros(size(orig));

origDim = size(orig);
% origFlat = reshape(numel(orig), 1);
% imgFlat = reshape(numel(img));
for k = 1:origDim(3)
    for i = 1:origDim(1)
        for j = 1:origDim(2)
            if 0 ~= img(i, j)
                imgMasked(i,j,k) = orig(i,j,k);
            end
        end
    end
end

img = imgMasked;


% q: is it possible to do peak detection on a histogram in matlab? we
% assume that the building is the relatively constant/consistent pixel
% value, which means that in the histogram, it will have a sharper peak
% (currently found on the right side of the hist). 
figure, imhist(orig(:,:,1))
figure, imhist(orig(:,:,2))
figure, imhist(orig(:,:,3))

% goal: use reshape to restructure the images into an easily iteratable
% form, then use a conditional to either throw out the original pixel if it
% is considered not part of the tree, or keep the color if it is considered
% part of the tree. (note: & doesn't do the job because 
% it converts it back to a logical, so the output from using & appeared as
% black and white rather than color). 
% this is a little complicated because i want to avoid iterating through
% the matrix in a 3 dimensional for loop approach, instead converting it
% into a single vector and using modular arithematic to figure out which
% element maps to what (the orig image has 3 times the number of elements
% as the img, but because of 1 indexing rather than 0 indexing, % isn't
% enough by itself to map the indices correctly

bitwised = img;

% try sampling the pixel value of the building, nulling those pixels out
% first (using logical operator would work here, and converting back
% logical 1s to the value in the orig image), before you do the
% imerode/dilate/filling -> hypothesis: it would separate the tree from the
% grass because of the bit of building that separates them.


%% Display original image compared to processed image. 
figure
subplot(2,4,1), imshow(orig), title('orig')
subplot(2,4,2), imshow(thresd), title('threshold')
subplot(2,4,3), imshow(eroded), title('eroded')
subplot(2,4,4), imshow(filled), title('filled')
subplot(2,4,5), imshow(bitwised), title('bitwised')

toc;



% %% Isolate the green channel to identify grass/trees.
% % Assume: the grass is green, which may not always be true.
% 
% 

% 
% 
% %%
% 
% % Convert image from logical do double.
% img = +img;
% 
% vert = zeros(95,8);
% for n = 0:5
%     vert(16*n+1:16*(n+1),n+1)=-1;
%     vert(16*n+1:16*(n+1),n+3)=1;
% end
% vert=fliplr(vert);
% %figure; imagesc(vert);
% %
% edges=abs(conv2(orig(:,:,3),vert,'same'));
% % figure; imagesc(abs(edges));
% 
% % Highlight discovered edges
% 
% %figure; hist(edges(:),50);
% [y,x] = find(edges>7);
% figure; imagesc(edges); hold on;
% plot(x,y,'r.'); hold off;
% 
% 
% 
% % threshold or use ren's line finding to separate sky and building (since
% % not all of the key seems to be below the threshold between the sky and
% % building.
% 
% 
% 
% %% Blur the image using a Gaussian filter.
% % h = fspecial('gaussian', 10, 10);
% % imgGaussFilt = imfilter(img, h);
% % 
% % figure
% % subplot(1,2,1), imshow(orig)
% % subplot(1,2,2), imshow(img)
% 
% %% Erode the image using a rolling ball structured element.
% se = strel('square', 4);
% img = imerode(img, se);
% 
% 
% %% Remove small objects from binary image.
% % numPix = 100;
% % imgAreaOpen = bwareaopen(imgbw, numPix);
% % 
% % figure
% % subplot(1,2,1), imshow(orig)
% % subplot(1,2,2), imshow(imgAreaOpen);
% 
% 
% %% Trace region boundaries.
% % http://www.mathworks.com/help/images/ref/bwboundaries.html
% 
% %% Fill holes in the image.
% % http://www.mathworks.com/help/images/ref/imfill.html
% 
% 
% %% Enhance contrast using bottom hat filtering.
% % Create a disk-shaped structuring element, which will be used for
% % morphological processing.
% % se = strel('disk', 3); 
% % img = imsubtract(imadd(img, imtophat(img, se)), imbothat(img, se));
% 

