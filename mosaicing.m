%% Mosaicing
%% Pull in Video
clear all
close all

fname = 'C:\tmp\2014-01-15_04-32-24\gymBasketball.m4v';
obj = VideoReader(fname);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;

%% Read Video Object
mov(1).cdata = read(obj,1);;
mov(1).colormap = [];
for k=2:floor(nFrames/3);
    vid = read(obj,k);
    mov(k).cdata = vid;
    mov(k).colormap = [];
    [a,b]=cpselect(mov(k).cdata, mov(k-1).cdata,'Wait',true);
end

%% Play Video
% h = figure;
% movie(h,mov,1,obj.FrameRate);


