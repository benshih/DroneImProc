% Benjamin Shih
% 9/13/2013 to ---
% Separating a video into frames using MATLAB's VideoReader class

tic

filename = 'kittenslide.mp4';

obj = VideoReader(filename);

% Obtain the 
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;

% Preallocate movie structure.
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);

% Read one frame at a time.
for k = 1:nFrames
    mov(k).cdata = read(obj, k);
end

% Size a figure based on the video's width and height.
hf = figure;
set(hf, 'position', [150 150 vidWidth vidHeight])

% Play back the movie once at the video's frame rate.
movie(hf, mov, 1, obj.FrameRate);

toc