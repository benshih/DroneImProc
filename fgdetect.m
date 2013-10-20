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
for k = 1:nFrames
    % take a portion of the video
    %mov(k).cdata = video(ceil(vidHeight/4):ceil(3/4*vidHeight),ceil(vidWidth/4):ceil(3/4*vidWidth),:,k);
    mov(k).cdata = video(:,:,:,k);

    mov(k).colormap = [];
end

%% Inspecting individual pixels

% A = squeeze(video(100,100,:,:));
% B = squeeze(video(100,200,:,:));
% C = squeeze(video(250,200,:,:));
% 
% figure;
% subplot(2,2,1); imshow(video(:,:,:,1));
% hold on; plot([100 100 250],[100 200 200],'ro'); hold off;
% subplot(2,2,2); plot(1:nFrames,A); title('Pixel at (100,100)'); 
% xlabel('frame'); ylabel('intensity');
% subplot(2,2,3); plot(1:nFrames,B); title('Pixel at (100,200)'); 
% xlabel('frame'); ylabel('intensity');
% subplot(2,2,4); plot(1:nFrames,C); title('Pixel at (250,200)'); 
% xlabel('frame'); ylabel('intensity');
% set(findall(gcf,'type','text'),'fontSize',16,'fontWeight','bold')

%% Average pixel value
% mu = mean(video,4);
% figure, imshow(mu/255);
%% Moving Average

try
%     close figure 100
    close figure 101
catch me
end
% figure(100); set(100,'Position',[0 0 vidWidth vidHeight]);
figure(101); %set(100,'Position',[vidWidth+100 0 vidWidth vidHeight]);
mu=0;
for k = 1:nFrames
    mu = mu+video(:,:,:,k)/32;
    if(k>32)
        mu = mu-video(:,:,:,k-32)/32;
    end
    mask = abs(mu - video(:,:,:,k))>15;
    mask = mask(:,:,1)&mask(:,:,2)&mask(:,:,3);
    
%     figure(100); imshow(mu);
    figure(101); imshow(double(mask));
end

%% Thresholding
% 
% figure(3);
% for k = 32:nFrames
%     clip = video(:,:,:,k-31:k);
%     mu = mean(clip,4);
%     sigma = sqrt(var(double(clip),0,4));
%     maskR = abs(double(video(:,:,1,k))-mu(:,:,1))>1*sigma(:,:,1);
%     maskG = abs(double(video(:,:,2,k))-mu(:,:,2))>1*sigma(:,:,2);
%     maskB = abs(double(video(:,:,3,k))-mu(:,:,3))>1*sigma(:,:,3);
%     mask = maskR & maskB & maskG;
%     figure(3); imshow(double(mask).*double(video(:,:,1,k)));
% end