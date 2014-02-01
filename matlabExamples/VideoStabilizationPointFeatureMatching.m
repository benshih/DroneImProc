% Benjamin Shih
% 11/17/2013
% MATLAB Computer Vision System Toolbox
% Feature Detection, Extraction, and Matching: Video Stabilization using
% Point Feature Matching

% The main difference is that the Video Stabilization Example is given a
% region to track while this example is given no such knowledge. Both
% examples use the same video.

% This method works without a priori knowledge - we don't need to know where
% the salient features lie in the first video frame. It automatically
% searches for the background plane in a video sequence, and uses its
% observed distortion to correct for camera motion. 

% The algorithm involves two primary steps:
% 1. Determine the affine image transformations between all neighboring
% frames of a video sequence using the estimateGeometricTransform function
% by determining the homography relating sequential frames.
% 2. Warp the video frames in order to eliminate video movement. 

function VideoStabilizationPointFeatureMatching
    filename = '/Users/benshih/Desktop/BenProjectsActive/DroneImProc/ARDroneVideos/gymKidUnwarped.mp4';
    hVideoSrc = vision.VideoFileReader(filename, 'ImageColorSpace', 'RGB');

    imgA = step(hVideoSrc); % Read first frame into imgA
    imgB = step(hVideoSrc); % Read second frame into imgB

    % Convert the imgA and imgB to B channel
    imgA = imgA(:,:,3);
    imgB = imgB(:,:,3);


    ptThresh = 0.1;
    pointsA = detectFASTFeatures(imgA, 'MinContrast', ptThresh);
    pointsB = detectFASTFeatures(imgB, 'MinContrast', ptThresh);

    % Extract FREAK descriptors for the corners
    [featuresA, pointsA] = extractFeatures(imgA, pointsA);
    [featuresB, pointsB] = extractFeatures(imgB, pointsB);

    indexPairs = matchFeatures(featuresA, featuresB);
    pointsA = pointsA(indexPairs(:, 1), :);
    pointsB = pointsB(indexPairs(:, 2), :);


    [tform, pointsBm, pointsAm] = estimateGeometricTransform(...
        pointsB, pointsA, 'affine');
    imgBp = imwarp(imgB, tform, 'OutputView', imref2d(size(imgB)));
    pointsBmp = transformPointsForward(tform, pointsBm.Location);

    % Extract scale and rotation part sub-matrix.
    H = tform.T;
    R = H(1:2,1:2);
    % Compute theta from mean of two possible arctangents
    theta = mean([atan2(R(2),R(1)) atan2(-R(3),R(4))]);
    % Compute scale from mean of two stable mean calculations
    scale = mean(R([1 4])/cos(theta));
    % Translation remains the same:
    translation = H(3, 1:2);
    % Reconstitute new s-R-t transform:
    HsRt = [[scale*[cos(theta) -sin(theta); sin(theta) cos(theta)]; ...
      translation], [0 0 1]'];
    tformsRT = affine2d(HsRt);

    imgBold = imwarp(imgB, tform, 'OutputView', imref2d(size(imgB)));
    imgBsRt = imwarp(imgB, tformsRT, 'OutputView', imref2d(size(imgB)));


    % Reset the video source to the beginning of the file.
    reset(hVideoSrc);

    hVPlayer = vision.VideoPlayer; % Create video viewer
    hVWriter = vision.VideoFileWriter('/Users/benshih/Desktop/BenProjectsActive/DroneImProc/ARDroneVideos/gymKidUnwarped_stable_RENAMEME.avi');

    % Process all frames in the video
    movMean = step(hVideoSrc);
    movMean = movMean(:,:,3);
    imgB = movMean;
    imgBp = imgB;
    correctedMean = imgBp;
    ii = 2;
    Hcumulative = eye(3);
    while ~isDone(hVideoSrc)
        % Read in new frame
        imgA = imgB; % z^-1
        imgAp = imgBp; % z^-1
        imgB = step(hVideoSrc);
        imgB = imgB(:,:,3);
        movMean = movMean + imgB;

        % Estimate transform from frame A to frame B, and fit as an s-R-t
        H = cvexEstStabilizationTform(imgA,imgB);
        HsRt = cvexTformToSRT(H);
        Hcumulative = HsRt * Hcumulative;
        imgBp = imwarp(imgB,affine2d(Hcumulative),'OutputView',imref2d(size(imgB)));

        % Display as color composite with last corrected frame
        step(hVPlayer, imfuse(imgAp,imgBp));
        step(hVWriter, imfuse(imgAp,imgBp));
        correctedMean = correctedMean + imgBp;

        ii = ii+1;
    end
    correctedMean = correctedMean/(ii-2);
    movMean = movMean/(ii-2);

    % Here you call the release method on the objects to close any open files
    % and release memory.
    release(hVideoSrc);
    release(hVPlayer);


    figure; imshowpair(movMean, correctedMean, 'montage');
    title(['Raw input mean', repmat(' ',[1 50]), 'Corrected sequence mean']);

end
