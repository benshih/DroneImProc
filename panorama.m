function [matched] = panorama(im1, im2, pts)
    imgWidth = 1280;

    [H] = computeH_norm(pts(3:4,:),pts(1:2,:));
    %Translate the image down
    tr = H*[size(im2,2);1;1];
    tr(1,:) = tr(1,:)./tr(3,:);
    tr(2,:) = tr(2,:)./tr(3,:);
    T = [1 0 0; 0 1 -tr(2); 0 0 1];
    
    %How tall does the image need to be?
    tr = T*H*[size(im2,2);size(im2,1);1];
    tr(1,:) = tr(1,:)./tr(3,:);
    tr(2,:) = tr(2,:)./tr(3,:);
    height = tr(2);
    width = tr(1);
    
    %Rescale the image to fit the specified width
    S = [imgWidth/width 0 0; 0 imgWidth/width 0; 0 0 1]; 
    
    %Combine the transform and apply to images
    M = S*T;
    imageDim = [2000,imgWidth]; 
    img1_warped = warpH(im1,M,imageDim);
    img2_warped = warpH(im2,M*H,imageDim);
    
%     %%Panorama stitching with blending
%     %Create a mask the size of the image and compute a distance transform from
%     %the edges of that image.
%     mask = zeros(size(im1,1),size(im2,2));
%     mask(1,:) = 1;
%     mask(end,:) = 1;
%     mask(:,1) = 1;
%     mask(:,end) = 1;
%     mask = bwdist(mask, 'city');
%     mask = mask/max(mask(:));
%     
%     %Both masks get warped
%     mask_warped1 = warpH(mask,M,imageDim);
%     mask_warped2 = warpH(mask,M*H,imageDim);
%     
%     %The blending function is a/(a+b) for one image and b/(a+b) for the other
%     mask_combined = mask_warped1 + mask_warped2;
%     alpha1 = 0.5;%mask_warped1./mask_combined;
%     alpha2 = 0.5;%mask_warped2./mask_combined;
%     
%     %Blend each of the RGB channels
%     blended(:,:,1) = alpha1.*img1_warped(:,:,1) + alpha2.*img2_warped(:,:,1);
%     blended(:,:,2) = alpha1.*img1_warped(:,:,2) + alpha2.*img2_warped(:,:,2);
%     blended(:,:,3) = alpha1.*img1_warped(:,:,3) + alpha2.*img2_warped(:,:,3);
    mask1 = logical(ceil(img1_warped/max(img1_warped(:))));
    img2_warped(mask1)=0;
    matched = img1_warped+img2_warped;
    figure;
    imshow(uint8(matched));
    %print('djpeg','r300','q6 2 pan.jpg');  


    

end