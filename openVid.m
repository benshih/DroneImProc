% Benjamin Shih
% 9/13/2013 to ---
% Separating a video into frames using MATLAB's VideoReader class

tic

clear all
close all

filename = 'kittenslide.mp4';

obj = VideoReader(filename);

% Obtain the 
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;

%%

% Preallocate movie structure.
start = 100;
fin = 400;
len = fin - start + 1;

% take a portion of the video
%mov(1:len) = struct('cdata', zeros(ceil(vidHeight/2), ceil(vidWidth/2), 3, 'uint8'), 'colormap', []);
mov(1:len) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);
video = read(obj, [start fin]);



% Read one frame at a time.
for k = 1:len
    % take a portion of the video
    %mov(k).cdata = video(ceil(vidHeight/4):ceil(3/4*vidHeight),ceil(vidWidth/4):ceil(3/4*vidWidth),:,k);
    mov(k).cdata = video(:,:,:,k);

    mov(k).colormap = [];
end


%%
% Save mov struct as a new mp4
% writeMP4_ren('output',mov);

% Size a figure based on the video's width and height.
hf = figure;
set(hf, 'position', [150 150 vidWidth vidHeight])

% Play back the movie once at the video's frame rate.
movie(hf, mov, 1, obj.FrameRate);
% figure; imshow(mov(70).cdata)




objPoints = detectSURFFeatures(obj(:,:,1));
scenePoints = detectSURFFeatures(scene(:,:,1));


















toc


