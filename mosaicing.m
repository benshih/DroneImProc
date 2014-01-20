%% Mosaicing
%% Pull in Video
% clear all
close all

fname = 'gymBasketballClip2.mp4';
obj = VideoReader(fname);
nFrames = obj.NumberOfFrames;
vidHeight = obj.Height;
vidWidth = obj.Width;

%% Read Video Object
K = [1 40 91 139 217 231 321 404 449 469 577 646 651 669 700 712 736:1:948];
% bigImage = lensdistort(read(obj,1),-.19);
for n=15:length(K)
    k=K(n);
    frame = lensdistort(read(obj,k),-.19);
    [a,b]=cpselect( bigImage,frame,'Wait',true);
    if(size(a,1)>0)
        % homography to update bigImage
        for k1=K(n-1):K(n)-1
            mov(k1).cdata = bigImage;
            mov(k1).colormap = [];
        end
        
        bigImage = uint8(panorama( double(bigImage), double(frame),[a b]'));
        k
        print(gcf,'-dpng',num2str(k)); 
    end
%         figure; imshow(mov(k).cdata); hold on; plot(a(:,1),a(:,2),'o'); hold off;
end

%% Play Video
h = figure;
movie(h,mov,1,obj.FrameRate);


