function q = guidedfilter(I, p, r, eps)

%   - guidance image: I (should be a gray-scale/single channel image)
%   - filtering input image: p (should be a gray-scale/single channel image)
%   - local window radius: r
%   - regularization parameter: eps

[hei, wid] = size(I);
N = boxfilter(ones(hei, wid), r); 

mean_I = boxfilter(I, r) ./ N;
mean_p = boxfilter(p, r) ./ N;
mean_Ip = boxfilter(I.*p, r) ./ N;
% this is the covariance of (I, p) in each local patch.
cov_Ip = mean_Ip - mean_I .* mean_p; 

mean_II = boxfilter(I.*I, r) ./ N;
var_I = mean_II - mean_I .* mean_I;

a = cov_Ip ./ (var_I + eps); 
b = mean_p - a .* mean_I; 

mean_a = boxfilter(a, r) ./ N;
mean_b = boxfilter(b, r) ./ N;

q = mean_a.*I+ mean_b; 
% epsilon=(0.001*(max(p(:))-min(p(:))))^2;  
% r1=1;  
%   
% N1 = boxfilter(ones(hei, wid), r1); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.  
% mean_I1 = boxfilter(I, r1) ./ N1;  
% mean_II1 = boxfilter(I.*I, r1) ./ N1;  
% var_I1 = mean_II1 - mean_I1 .* mean_I1;  
%   
% chi_I=sqrt(abs(var_I1.*var_I));      
% weight=(chi_I+epsilon)/(mean(chi_I(:))+epsilon);       
%   
% gamma = (4/(mean(chi_I(:))-min(chi_I(:))))*(chi_I-mean(chi_I(:)));  
% gamma = 1 - 1./(1 + exp(gamma));  
%   
% %result  
% a = (cov_Ip + (eps./weight).*gamma) ./ (var_I + (eps./weight));   
% b = mean_p - a .* mean_I;   
%   
% mean_a = boxfilter(a, r) ./ N;  
% mean_b = boxfilter(b, r) ./ N;  
%   
% q = mean_a .* I + mean_b;   
end
