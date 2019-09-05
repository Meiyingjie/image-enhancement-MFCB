clear;clc;close all
I=im2double(imread('C:\Users\Administrator\Desktop\人机交互\matlab\sweden.jpg'));
% I=imread('C:\Users\Administrator\Desktop\\1.png');
trainSetFolder = 'C:/Users/Administrator/Desktop/图像去雾2/图片';
% I=rgb2gray(I);
% I=imnoise(I,'salt & pepper',0.05);
%% 分块次数，图片分块数是它的平方
ttt=1;
%% 对原图的一些尺寸进行归整便于整数分割
[size1,size2,hv]=size(I);
size1=fix(size1/ttt)*ttt;
size2=fix(size2/ttt)*ttt;
tx1=fix(min(size1,size2)/(ttt*2)-1);%tx1和tx2是引导滤波的滤波窗口
tx2=fix(min(size1,size2)/2-1);
aa=size1/ttt;%aa，bb表示每个分块图像的长和宽
bb=size2/ttt;
%% 对原图进行合适尺度切割（分块前的整图）
II=imcrop(I,[0,0,size2,size1]);
% figure;imshow(uint8(II));title('原图');
out1=entropy(uint8(II))%信息熵
%% 暗通道处理
% II=rgb2ycbcr(II);
[v,vp,A,re]=darkc(uint8(II),hv);
figure;imshow(II);title('整理后图');
out2=entropy(re)%信息熵
J=II;
II=double(II)-v;
%% 对图像（归整后图像、暗通道图像、大气光照图）进行区域划分，即图像分块
[high,wide]=size(II);
III=mat2cell(II,ones(ttt,1)*aa,ones(ttt,1)*bb,hv);%元胞数组内有ttt^2个小数组，每个小数组是一个块图
JJJ=mat2cell(J,ones(ttt,1)*aa,ones(ttt,1)*bb,hv);
vpp=mat2cell(v,ones(ttt,1)*aa,ones(ttt,1)*bb,hv);
%% 对每个分块图像进行处理
c=0;
[ss,ww,nn]=size(III);
picture1=reshape(III,[ss*ww*nn,1]);
picture2=reshape(JJJ,[ss*ww*nn,1]);
picture3=reshape(vpp,[ss*ww*nn,1]);
tic;
for i=1:ttt^2
    a1=cell2mat(picture1(i));%读取元胞数组内的每一个分块图像数据，并转换成正常数组
    a2=cell2mat(picture2(i));
    a3=cell2mat(picture3(i));
    [MIN,MAX]=lb(a2,a2,a3,tx1,hv);
    m=MSRCR_multi(J,J,v,tx2,hv,MIN,MAX);
    b{i}=m;
    c=b{i}/(ttt*ttt)+c;
%     imwrite(uint8(m),sprintf([trainSetFolder '/I%01d.jpg'],i));
end
toc;
%% 结果
figure;imshow(c);title('MCRSR图');
out3=entropy(c)
