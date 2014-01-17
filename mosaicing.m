%% Mosaicing
%% Pull in Video
% clear all
close all

fname = 'gymBasketballClip2.mp4';
obj = VideoReader(fname);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;

%% Read Video Object
K = [40 91 139:nFrames];
bigImage = lensdistort(read(obj,1),-.19);
for n=1:length(K)
    k=K(n);
    frame = lensdistort(read(obj,k),-.19);
    [a,b]=cpselect( bigImage,frame,'Wait',true);
    if(size(a,1)>0)
    % homography to update bigImage
        bigImage = uint8(panorama( double(bigImage), double(frame),[a b]'));
        k
    end
%     figure; imshow(mov(k).cdata); hold on; plot(a(:,1),a(:,2),'o'); hold off;
end

%% Play Video
% h = figure;
% movie(h,mov,1,obj.FrameRate);


