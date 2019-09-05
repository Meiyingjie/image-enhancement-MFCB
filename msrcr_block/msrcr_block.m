function [result]=msrcr_block(I,trans,box_size,A)
for i = 1:ceil((size(I,1)-1)/box_size)
    for j = 1:ceil((size(I,2)-1)/box_size)
        end_i = i * box_size; end_j = j * box_size;
        if end_i > size(I,1)
            end_i = size(I,1);
        end
        if end_j > size(I,2)
            end_j = size(I,2);
        end
        III{i,j} = I((i-1)* box_size+1:end_i, (j-1)* box_size+1:end_j, :);
    end
end
[size1,size2,hv]=size(I);
[ss,ww]=size(III);
picture1=reshape(III,[ss*ww,1]);
% c=0;
% d=0;
% result=0;
tic;
parfor ii=1:ss*ww
    a1=cell2mat(picture1(ii));%读取元胞数组内的每一个分块图像数据，并转换成正常数组
    tx1=fix(min(size(a1,1),size(a1,2))/2-1);
    [MIN,MAX]=lb2(a1,a1,tx1,hv);
%     [m{i}]=MSRCR_multi2(a1,a1,tx1,hv,MIN,MAX);
    [m{ii}]=MSRCR_multi2(a1,a1,tx1,hv,MIN,MAX);
    mm{ii}(:,:,1)=mean(mean(m{ii}(:,:,1)))/255.*ones(size(a1,1),size(a1,2));
    mm{ii}(:,:,2)=mean(mean(m{ii}(:,:,2)))/255.*ones(size(a1,1),size(a1,2));
    mm{ii}(:,:,3)=mean(mean(m{ii}(:,:,3)))/255.*ones(size(a1,1),size(a1,2));
%     c=m{i}/(ss*ww)+c;
end
disp(['msrcr_block,box_size=',num2str(box_size)]);
toc;
mmm=reshape(m,[ceil((size(I,1)-1)/box_size),ceil((size(I,2)-1)/box_size)]);
result1=cell2mat(mmm);
% figure;imshow(result1);
% imwrite(result1,'results\block1.bmp')
for xx=1:size(I,3)
    I(:,:,xx)=I(:,:,xx)./A(:,:,xx);
    result1(:,:,xx)=result1(:,:,xx)./A(:,:,xx);
end
psnr(result1);
pic1=Idark(I);
pic2=Idark(result1);
[x1,y1]=find(pic1>=1);
for j=1:length(x1)
    pic1(x1(j),y1(j))=0.97;
end
[x2,y2]=find(pic2>=1);
for j=1:length(x2)
    pic2(x2(j),y2(j))=0.97;
end
result2= (1-0.95*pic1)./(1-0.95*pic2);
% imwrite(result2,'results\block2.bmp')
[x,y]=find(result1>=1);
for j=1:length(x)
    result1(x(j),y(j))=0.97;
end
[xx,yy]=find(result1<0);
for j=1:length(xx)
    result1(xx(j),yy(j))=0;
end
result=gradient_guidedfilter(trans,result2, 0.04);
