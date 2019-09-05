function [PSNR, MSE] = psnr(X, Y)
% �����ֵ�����PSNR�����������MSE
% �������YΪ�գ�����ΪX���䱾��������PSNR��MSE

if nargin<2
    D = X;
else
    if any(size(X)~=size(Y))
        error('The input size is not equal to each other!');
    end
    D = X-Y;
end
MSE = sum(D(:).*D(:))/prod(size(X));
PSNR = 10*log10(255^2/MSE);
display(MSE);
display(PSNR);