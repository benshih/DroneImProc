%% Foreground Detection
% This script will demonstrate foreground detection
%% Initialization

clear all
close all

%% Load Video

filename = 'gates1.MOV';
obj = VideoReader(filename);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;

% mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);
video = read(obj);
video1 = zeros(240,320,3,nFrames);
%%
for n=1:nFrames
   video1(:,:,:,n) = double(imresize(squeeze(video(:,:,:,n)),[240 320]));
end
%%
% Read one frame at a time.
% for k = 1:nFrames
%     % take a portion of the video
%     %mov(k).cdata = video(ceil(vidHeight/4):ceil(3/4*vidHeight),ceil(vidWidth/4):ceil(3/4*vidWidth),:,k);
%     mov(k).cdata = double(video(:,:,:,k));
%     
%     mov(k).colormap = [];
% end

%% Moving Average
dur = 128;
start = 250;
try
    %     close figure 100
    close figure 101
catch me
end
% figure(100); set(100,'Position',[0 0 vidWidth vidHeight]);
% figure(101); set(101,'Position',[vidWidth+100 0 vidWidth vidHeight]);
sum=0;
sig=0;
mu = squeeze(mean(video1(:,:,:,start-dur:start-1),4));
for k = start:nFrames
    mu = mu-(video1(:,:,:,k-dur)/dur);
    mu = mu+(video1(:,:,:,k-1)/dur);
    for n=k-dur+1:k
        delta = (video1(:,:,:,k))-mu;
    end
    sig = sqrt(var((video1(:,:,:,k-dur:k-1)),0,4));
    mask = abs(delta)>2*sig;
    mask = mask(:,:,1)&mask(:,:,2)&mask(:,:,3);
    output(:,:,k) = mask;
%     figure(101), imshow(mask);
    k
end
%%
obj2 = VideoWriter('oneMode240x320.avi');
open(obj2);
frame = uint8(zeros(240,640,3));
for n=start:nFrames
    frame(:,1:320,:) = uint8(video1(:,:,:,n));
    frame(:,321:end,:) = 255*uint8(repmat(output(:,:,n),[1 1 3]));
    writeVideo(obj2,uint8(frame));
    figure(1), imshow(frame);
end
close(obj2);