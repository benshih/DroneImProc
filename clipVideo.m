%% Mosaicing
%% Pull in Video
clear all
close all

fname1 = 'gymKidSplice.mp4';
obj = VideoReader(fname1);
nFrames = min(obj.NumberOfFrames,objR.NumberOfFrames);
vidHeight = obj.Height;
vidWidth = obj.Width;

%% Read Video Object
% frames = 90*30:105*30;

for k=1:nFrames
    frame = read(obj,k);
    mov(k).cdata = [frame frameR];
    mov(k).colormap = [];
    k
end

% %% Play Video
% h = figure;
% movie(h,mov,1,objL.FrameRate);

%%

writeMP4_ren('gymKidSpliceUnwarped',mov);


