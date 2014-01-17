%% Mosaicing
%% Pull in Video
clear all
close all

fname = 'gymBasketballClip.mp4';
obj = VideoReader(fname);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;

%% Read Video Object
mov(1).cdata = read(obj,1);;
mov(1).colormap = [];
bigImage = mov(1).cdata;
for k=2:floor(nFrames/3);
    vid = read(obj,k);
    mov(k).cdata = vid;
    mov(k).colormap = [];
    [a,b]=cpselect(mov(k).cdata, bigImage,'Wait',true);
    % homography to update bigImage
    
end

%% Play Video
% h = figure;
% movie(h,mov,1,obj.FrameRate);


