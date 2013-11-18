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
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);
video = read(obj);

% Read one frame at a time.
% for k = 1:nFrames
%     % take a portion of the video
%     %mov(k).cdata = video(ceil(vidHeight/4):ceil(3/4*vidHeight),ceil(vidWidth/4):ceil(3/4*vidWidth),:,k);
%     mov(k).cdata = double(video(:,:,:,k));
%     
%     mov(k).colormap = [];
% end

%% Moving Average
dur = 32;
try
    %     close figure 100
    close figure 101
catch me
end
% figure(100); set(100,'Position',[0 0 vidWidth vidHeight]);
% figure(101); set(101,'Position',[vidWidth+100 0 vidWidth vidHeight]);
mu=0;
sum=0;
gig=0;
mu = uint8(squeeze(mean(video(:,:,:,1:dur-1),4)));
for k = dur:200%nFrames
    mu = mu-video(:,:,:,k-dur+1)/dur;
    mu = mu+video(:,:,:,k)/dur;
    for n=k-dur+1:k
        delta = video(:,:,:,k)-mu;
        sum = sum + (delta).^2;
    end
    sig = sqrt(double(sum)/dur)*2;
    mask = abs(delta)>sig;
    mask = mask(:,:,1)&mask(:,:,2)&mask(:,:,3);
%     output(:,:,k) = mask;
    figure(101), imshow(mask);
    k
end
