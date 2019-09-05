function A=ambient_A(I)
% I=im2double(imread('C:\Users\Administrator\Desktop\人机交互\matlab\hc.png'));

%% 画图参数
result=I;
times=0;
box_size=fix(min(size(I,1),size(I,2)));
%%
if(size(I,3)==3)
    YUV_img=rgb2ycbcr(I);
else
    YUV_img=I;
end
flag2=[1,size(YUV_img,1),1,size(YUV_img,2)];
while(box_size>=10)
    step_size=box_size;
    for i = 1:ceil((flag2(2)-flag2(1)+1)/step_size)
        for j = 1:ceil((flag2(4)-flag2(3)+1)/step_size)
            end_i = i * step_size+flag2(1)-1; 
            end_j = j * step_size+flag2(3)-1;
            if end_i > flag2(2)
                end_i = flag2(2);
            end
            if end_j > flag2(4)
                end_j = flag2(4);
            end
            III{i,j} = YUV_img((end_i-step_size)+1:end_i, (end_j-step_size)+1:end_j, :);
            record{i,j} = [(end_i-step_size)+1,end_i,(end_j-step_size)+1,end_j];
        end
    end
    [ss,ww]=size(III);
    picture1=reshape(III,[ss*ww,1]);
    record2=reshape(record,[ss*ww,1]);
    parfor ii=1:ss*ww
        a1=cell2mat(picture1(ii));
        mm(ii)=mean(mean(a1(:,:,1)));
    end
    [~,flag]=find(mm==max(mm));
    threshold=max(mm);
    flag2=cell2mat(record2(flag(1)));
    
    if(size(I,3)==3)
        YUV_img_block=cell2mat(picture1(flag(1)));
        rgb_img_block=ycbcr2rgb(YUV_img_block);
        for iii=1:3
            A(:,:,iii)=mean(mean(rgb_img_block(:,:,iii)))*ones(size(I,1),size(I,2));
        end
    else
        A(:,:)=max(mm)*ones(size(I,1),size(I,2));
    end
    box_size=fix(box_size-10);
    %% 画图显示寻找过程
    times=times+1;
    result(flag2(1):flag2(1)+1,flag2(3):flag2(4),1)=0.1*times;
    result(flag2(1):flag2(1)+1,flag2(3):flag2(4),2)=0.08*times;
    result(flag2(1):flag2(1)+1,flag2(3):flag2(4),3)=0.05*times;
   
    result(flag2(2):flag2(2)+1,flag2(3):flag2(4),1)=0.1*times;
    result(flag2(2):flag2(2)+1,flag2(3):flag2(4),2)=0.08*times;
    result(flag2(2):flag2(2)+1,flag2(3):flag2(4),3)=0.05*times;
    
    result(flag2(1):flag2(2),flag2(3):flag2(3)+1,1)=0.1*times;
    result(flag2(1):flag2(2),flag2(3):flag2(3)+1,2)=0.08*times;
    result(flag2(1):flag2(2),flag2(3):flag2(3)+1,3)=0.05*times;
    
    result(flag2(1):flag2(2),flag2(4):flag2(4)+1,1)=0.1*times;
    result(flag2(1):flag2(2),flag2(4):flag2(4)+1,2)=0.08*times;
    result(flag2(1):flag2(2),flag2(4):flag2(4)+1,3)=0.05*times;
end

result(flag2(1):flag2(2),flag2(3):flag2(4),1)=1;
result(flag2(1):flag2(2),flag2(3):flag2(4),2)=0;
result(flag2(1):flag2(2),flag2(3):flag2(4),3)=0;

[A,result]=ambient_AA(I,A,box_size+10,threshold,result);
figure;imshow(result);
% imwrite(result,'C:\Users\Administrator\Desktop\picture\hc(A).bmp');
figure;imagesc(rgb2gray(A));
% imwrite(rgb2gray(A),'C:\Users\Administrator\Desktop\picture\hc(AA).bmp');