function [ base_layer, detail_layer, amb_map, mean_I, var_II, N, residual_img ] = fcn_guided_decomposition(I, p, r, eps, scale_mapping)
[hei, wid] = size(I);
detail_layer = zeros(size(I));
N = boxfilter(ones(hei, wid), r); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean_I = boxfilter(I, r) ./ N;
mean_p = boxfilter(p, r) ./ N;
mean_Ip = boxfilter(I.*p, r) ./ N;
cov_Ip = mean_Ip - mean_I .* mean_p; % this is the covariance of (I, p) in each local patch.

mean_II = boxfilter(I.*I, r) ./ N;
var_II = mean_II - mean_I .* mean_I;
% decomposition process
% ------------------------------------------------------------
q{1} = I;
% qq{1} = I;
for i = 1:length(eps)
    a = cov_Ip ./ (var_II + eps(i));
%     b = mean_p - a .* mean_I;
%     a = cov_Ip ./ ( var_II + (eps(i) .* mean2(var_II)) + eps0 ); % eqn.(13)
    b = mean_p - a .* mean_I;
    mean_a{i+1} = boxfilter(a, r) ./ N;
    mean_b{i+1} = boxfilter(b, r) ./ N;
    gamma = 1.0;
%     beta{i+1} = ( ( mean_a{i+1} ./ (1-mean_a{i+1})) ) .^ gamma; % eqn.(27)
    q{i+1} = mean_a{i+1} .* I + mean_b{i+1};
%     imwrite(q{i},'C:\Users\Administrator\Desktop\picture\q%03d.bmp');
%     qq{i+1} = ( I - q{i+1}) .* beta{i+1}  + q{i+1};
    residual_img{i} = q{i} - q{i+1};
%     residual_img1{i}=log(q{i})-log(q{i+1});
    detail_layer = detail_layer + fcn_mapping(residual_img{i}, 'nonlinear', scale_mapping{i}(1), scale_mapping{i}(2), 0);
%     imwrite(residual_img{i}, ['C:\Users\23560\Desktop\新建文件夹\picture\process\',num2str(i),'(residual_image).jpg']);
end
base_layer = q{end};
amb_map = mean_b{end};

end

