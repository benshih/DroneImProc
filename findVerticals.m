%% Vertical Lines

close all;
clear all;
path = mfilename('fullpath');
addpath([path(1:end-length('findVeritcals')) 'img1']);
%%
img = imread('purnell1.jpg');
img_gray = rgb2gray(img);
img_blue = img(:,:,3);
img_green= img(:,:,2);

[imwidth, imheight] = size(img_gray);

% figure; imshow(img_gray);
%% 
vert = zeros(95,8);
for n = 0:5
    vert(16*n+1:16*(n+1),n+1)=-1;
    vert(16*n+1:16*(n+1),n+3)=1;
end
vert=fliplr(vert);
figure; imagesc(vert);
%% Find vertical edges in skyline

edges=abs(conv2(img_blue,vert,'same'));
edges_rot = imrotate(edges,rad2deg(atan(13/287)));
figure; imagesc(edges_rot);
% figure; imagesc(edges);
figure; hist(edges_rot(:),50);
[y,x] = find(edges_rot>3000);
figure; imagesc(img_blue); hold on;
plot(x,y,'r.'); hold off;

%% Identify contiguous of edges

[xnum,xbins]=hist(x,1:imwidth); 
[ynum,ybins]=hist(y,1:imheight); 

figure;
subplot(121);bar(xbins,xnum);title('X-coord for edges'); hold on;
longEdge = max(xnum);
plot(xbins(xnum==longEdge), longEdge,'ro'); hold off;
subplot(122);bar(ybins,ynum);title('Y-coord for edges');

[y2,x2] = find(edges_rot(:,xbins(xnum==longEdge))>3000);
hold on; plot(y2,200*ones(1,length(y2)),'ro'); hold off;
%%
figure; imagesc(imrotate(img_blue,rad2deg(atan(13/287)))); hold on;
plot(x,y,'r.');
plot(xbins(xnum==longEdge),y2,'k.'); hold off;
%%
% edges=abs(conv2(img_green,vert,'same'));
% figure; imagesc(edges);
% figure; hist(edges(:),50);
% [y,x] = find(edges>3000);
% figure; imagesc(img_green); hold on;
% plot(x,y,'r.'); hold off;
