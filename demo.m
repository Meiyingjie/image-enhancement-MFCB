clc;clear;close all
I= imread('images\hc.png');
img = im2double(I);
figure;imshow(img);
[size1,size2,hv]=size(img);
tt=fix(min(size1,size2)/2-1);
tic;
[dehazed_img, comp_time, trans_map, x] = fcn_multi(img);
toc;
figure;imshow(dehazed_img);
title('Enhancement result');
% imwrite(trans_map1,'C:\Users\Administrator\Desktop\picture\hc(trans_map1).bmp')
figure;
imagesc(trans_map); 
title('transmission map');
