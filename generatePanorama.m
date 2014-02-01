img1 = imread('taj1r.jpg');
img2 = imread('taj2r.jpg');
pts = load('tajPts.mat');
pts = pts.tajPts;

plotMatches(img1, img2, pts);

%%

% plotMatches(im2double(taj1r), im2double(taj2r), tajPts) to see the
% corresponding points between the two taj images.

 panorama(im2double(img1), im2double(img2), tajPts)% to generate the full
% panoramic image (uncut). 

% right now we are looking just at the video(:,:,:,1) and video(:,:,:,2)
% frames in order to get the panorama generation working (then we can save
% the resulting image, and combine it with video(:,:,:,iNext).
% 
% we are missing the correspondence points between video(:,:,:,1) and
% video(:,:,:,2). these can be obtained in various ways, such as RANSAC.


% in addition, the correspondence points should be between points in the
% image that AREN'T moving because for example in taj1r and taj2r, the
% correspondence points are points that aren't moving between the two
% images (because otherwise our homography is no longer valid).

