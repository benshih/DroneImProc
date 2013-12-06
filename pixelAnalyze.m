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
name{1} = 'road';
name{2} = 'tree';
name{3} = 'walking';

frame = squeeze(video(:,:,:,200));
figure, imshow(frame); hold on;
plot(x,y,'r*'); hold off;

for i=1:length(x)
    h=figure;
    subplot(121);
    plot(160:nFrames,squeeze(video(y(i),x(i),:,160:end))); xlim([150 810]);
    title(['Pixel Intensity: ' name{i}]); xlabel('frame');
    setFontSize(16);
    subplot(122);
    hist(squeeze(video(y(i),x(i),1,160:end)),0:255);
    title('Red Pixel Histogram'); xlabel('intensity');
    setFontSize(16);
    print(h,'-dpng',[name{i} '.png']);
end

%%
dur = 128;
start = 250;
mu=zeros(1,nFrames);
sig=zeros(1,nFrames);
for k=start:nFrames
    ped = squeeze(video(300,400,1,k-dur:k-1));
    mu(k) = mean(ped);
    sig(k) = sqrt(var(double(ped)));
end

figure, plot(squeeze(video(300,400,1,:))); hold on;
plot(mu,'r');
plot(mu+2*sig,'g');
plot(mu-2*sig,'g');
hold off;xlim([start nFrames])
xlabel('frame'); ylabel('intensity'); title('Pixel Intensity with Pedestrian');
ylim([0 255])
legend('Intensity','MA(128)','\mu+/-2\sigma');setFontSize(16);
