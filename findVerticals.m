%% Vertical Lines

close all;
clear all;
path = mfilename('fullpath');
addpath([path(1:end-length('findVeritcals')) 'img1']);
%%
img = imread('purnell1.jpg');
img_bw = rgb2gray(img);
figure; imshow(img_bw);
%% 
vert = zeros(95,8);
for n = 0:5
    vert(16*n+1:16*(n+1),n+1)=-1;
    vert(16*n+1:16*(n+1),n+3)=1;
end
vert=fliplr(vert);
figure; imagesc(vert);
%%
edges=abs(conv2(img_bw,vert,'same'));
% figure; imagesc(abs(edges));

%% Highlight discovered edges

figure; hist(edges(:),50);
[y,x] = find(edges>2500);
figure; imagesc(edges); hold on;
plot(x,y,'r.'); hold off;
