%% Pixel Analyis
%% Load Video Data

clear all;
close all;

filename = 'gates1.MOV';
obj = VideoReader(filename);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;
mov(1:nFrames) = struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'), 'colormap', []);
video = read(obj);

%%
x = [600 200 400];
y = [150 400 300];
name = cell(1,3);
name{1} = 'tree in sun';
name{2} = 'road in sun';
name{3} = 'walking in shade';

frame = squeeze(video(:,:,:,200));
figure, imshow(frame); hold on;
plot(x,y,'r*'); hold off;

for i=1:length(x)
    h=figure;
    subplot(121);
    plot(160:nFrames,squeeze(video(y(i),x(i),:,160:end))); xlim([150 810]);
    title(['Pixel Intensity: ' name{i}]); xlabel('frame');
    setFontSize(18);
    subplot(122);
    hist(squeeze(video(y(i),x(i),1,160:end)),0:255);
    title('Red Pixel Histogram'); xlabel('intensity');
    setFontSize(18);
end
%%

plot([1:10])

xlhand = 
