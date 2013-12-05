%% Pixel Analyis
%% Load Video Data

clear all;
close all;

filename = 'gates1.MOV';
obj = VideoReader(filename);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);
video = read(obj);

%% 
x = [600 200 400];
y = [150 400 300];

frame = squeeze(video(:,:,:,200));
figure, imshow(frame); hold on;
plot(x,y,'r*'); hold off;