clear;clc;close all
I=im2double(imread('C:\Users\Administrator\Desktop\�˻�����\matlab\sweden.jpg'));
% I=imread('C:\Users\Administrator\Desktop\\1.png');
trainSetFolder = 'C:/Users/Administrator/Desktop/ͼ��ȥ��2/ͼƬ';
% I=rgb2gray(I);
% I=imnoise(I,'salt & pepper',0.05);
%% �ֿ������ͼƬ�ֿ���������ƽ��
ttt=1;
%% ��ԭͼ��һЩ�ߴ���й������������ָ�
[size1,size2,hv]=size(I);
size1=fix(size1/ttt)*ttt;
size2=fix(size2/ttt)*ttt;
tx1=fix(min(size1,size2)/(ttt*2)-1);%tx1��tx2�������˲����˲�����
tx2=fix(min(size1,size2)/2-1);
aa=size1/ttt;%aa��bb��ʾÿ���ֿ�ͼ��ĳ��Ϳ�
bb=size2/ttt;
%% ��ԭͼ���к��ʳ߶��и�ֿ�ǰ����ͼ��
II=imcrop(I,[0,0,size2,size1]);
% figure;imshow(uint8(II));title('ԭͼ');
out1=entropy(uint8(II))%��Ϣ��
%% ��ͨ������
% II=rgb2ycbcr(II);
[v,vp,A,re]=darkc(uint8(II),hv);
figure;imshow(II);title('�����ͼ');
out2=entropy(re)%��Ϣ��
J=II;
II=double(II)-v;
%% ��ͼ�񣨹�����ͼ�񡢰�ͨ��ͼ�񡢴�������ͼ���������򻮷֣���ͼ��ֿ�
[high,wide]=size(II);
III=mat2cell(II,ones(ttt,1)*aa,ones(ttt,1)*bb,hv);%Ԫ����������ttt^2��С���飬ÿ��С������һ����ͼ
JJJ=mat2cell(J,ones(ttt,1)*aa,ones(ttt,1)*bb,hv);
vpp=mat2cell(v,ones(ttt,1)*aa,ones(ttt,1)*bb,hv);
%% ��ÿ���ֿ�ͼ����д���
c=0;
[ss,ww,nn]=size(III);
picture1=reshape(III,[ss*ww*nn,1]);
picture2=reshape(JJJ,[ss*ww*nn,1]);
picture3=reshape(vpp,[ss*ww*nn,1]);
tic;
for i=1:ttt^2
    a1=cell2mat(picture1(i));%��ȡԪ�������ڵ�ÿһ���ֿ�ͼ�����ݣ���ת������������
    a2=cell2mat(picture2(i));
    a3=cell2mat(picture3(i));
    [MIN,MAX]=lb(a2,a2,a3,tx1,hv);
    m=MSRCR_multi(J,J,v,tx2,hv,MIN,MAX);
    b{i}=m;
    c=b{i}/(ttt*ttt)+c;
%     imwrite(uint8(m),sprintf([trainSetFolder '/I%01d.jpg'],i));
end
toc;
%% ���
figure;imshow(c);title('MCRSRͼ');
out3=entropy(c)
