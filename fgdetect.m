%% Foreground Detection
% This script will demonstrate foreground detection
%% Initialization

clear all
close all

%% Load Video

filename = 'kittenslide_clip.mp4';
obj = VideoReader(filename);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);
video = read(obj);

% Read one frame at a time.
for k = 1:nFrames
    % take a portion of the video
    %mov(k).cdata = video(ceil(vidHeight/4):ceil(3/4*vidHeight),ceil(vidWidth/4):ceil(3/4*vidWidth),:,k);
    mov(k).cdata = video(:,:,:,k);

    mov(k).colormap = [];
end

%% Inspecting individual pixels

A = squeeze(video(100,100,:,:));
B = squeeze(video(100,200,:,:));
C = squeeze(video(250,200,:,:));

figure;
subplot(2,2,1); imshow(video(:,:,:,1));
hold on; plot([100 100 250],[100 200 200],'ro'); hold off;
subplot(2,2,2); plot(1:nFrames,A); title('Pixel at (100,100)'); 
xlabel('frame'); ylabel('intensity');
subplot(2,2,3); plot(1:nFrames,B); title('Pixel at (100,200)'); 
xlabel('frame'); ylabel('intensity');
subplot(2,2,4); plot(1:nFrames,C); title('Pixel at (250,200)'); 
xlabel('frame'); ylabel('intensity');
set(findall(gcf,'type','text'),'fontSize',16,'fontWeight','bold')

%% Average pixel value
mu = mean(video,4);
figure, imshow(mu/255);

figure(3);
for k = 32:nFrames
    % take a portion of the video
    %mov(k).cdata = video(ceil(vidHeight/4):ceil(3/4*vidHeight),ceil(vidWidth/4):ceil(3/4*vidWidth),:,k);
    clip = video(:,:,:,k-31:k);
    mu = mean(clip,4);
    figure(3); imshow(mu/255);
end