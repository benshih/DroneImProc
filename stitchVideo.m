%% Mosaicing
%% Pull in Video
clear all
close all

fname1 = 'gymKidSplice.mp4';
fname2 = 'gymKidSpliceStable.avi';
objL = VideoReader(fname1);
objR = VideoReader(fname2);
nFrames = min(objL.NumberOfFrames,objR.NumberOfFrames);
vidHeight = objL.Height;
vidWidth = objL.Width;

%% Read Video Object
% frames = 90*30:105*30;

for k=1:nFrames
    frameL = read(objL,k);
    frameR = read(objR,k);
    mov(k).cdata = [frameL frameR];
    mov(k).colormap = [];
    k
end

% %% Play Video
% h = figure;
% movie(h,mov,1,objL.FrameRate);

%%

writeMP4_ren('gymKidDemo',mov);


