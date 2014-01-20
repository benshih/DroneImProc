%% Mosaicing
%% Pull in Video
clear all
close all

fname1 = 'gymKidSplice.mp4';
obj = VideoReader(fname1);
nFrames = min(obj.NumberOfFrames,obj.NumberOfFrames);
vidHeight = obj.Height;
vidWidth = obj.Width;

%% Read Video Object

for k=1:nFrames
    % Make sure to use the right constant
    frame = lensdistort(read(obj,k),-.18);

    mov(k).cdata = frame;
    mov(k).colormap = [];
    k
end

%% Play Video
% h = figure;
% movie(h,mov,1,objL.FrameRate);

%%

writeMP4_ren('gymKidUnwarped',mov);


