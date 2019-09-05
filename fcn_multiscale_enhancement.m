function [ out_I, trans_map, detail_layer] = fcn_multiscale_enhancement( I, p, box_size, scale_smooth, scale_mapping)
%% Preallocation
n_channel = size(I,3);
out_I = zeros(size(I));
base_layer = zeros(size(I));
detail_layer = zeros(size(I));
amb_map = zeros(size(I));
mean_I = zeros(size(I));
var_I = zeros(size(I));
A = zeros(1, n_channel);
%% Guided-filtering based decomposition
for i = 1:n_channel
    [base_layer(:,:,i), detail_layer(:,:,i), amb_map(:,:,i), mean_I(:,:,i), var_I(:,:,i), N] = .... 
        fcn_guided_decomposition(I(:,:,i), p(:,:,i), box_size, scale_smooth, scale_mapping);
end
% imwrite(base_layer, ['C:\Users\23560\Desktop\新建文件夹\picture\process\',num2str(2),'(layer).jpg']);
% imwrite(detail_layer, ['C:\Users\23560\Desktop\新建文件夹\picture\process\(detail_layer).jpg']);
%% ambient estimation
% figure;imshow(base_layer);
% imwrite(base_layer,'results\base_layer.bmp')
A=ambient_A(base_layer);
% figure;imshow(trans_map);
%% transmittance estimation 
if size(I,3) == 3
    guide_I = rgb2gray(base_layer);
else
    guide_I = base_layer;
end

% map=ambient_es(I,size(I,3));

[trans_map]=msrcr_block(I,guide_I,box_size,A);
[x,y]=find(trans_map>1);
for j=1:length(x)
    trans_map(x(j),y(j))=1;
end
[x,y]=find(trans_map<0);
for j=1:length(x)
    trans_map(x(j),y(j))=0;
end
% figure;imshow(trans_map);
%% Color correction
for dim=1:size(A,3)
    Ac(dim)=mean(mean(A(:,:,dim)));
end
if n_channel == 3
    if std(Ac) >  0.15
        disp ('Color biased');
        for nn=1:n_channel
            A2(:,:,nn) = norm(A(:,:,n_channel))./norm(A(:,:,n_channel),2)./sqrt(3).*ones(size(A,1),size(A,2));
        end
    else
        A2=A;
    end
else
    A2 = A;
end


%% Reconstruction
J = zeros(size(out_I));
for i = 1:n_channel
    J(:,:,i) = (base_layer(:,:,i) -A(:,:,i))./trans_map + A2(:,:,i);
    out_I(:,:,i) = J(:,:,i) + detail_layer(:,:,i);
end
% figure;imshow(J)
end



