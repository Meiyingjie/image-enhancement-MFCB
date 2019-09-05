function C=Rssr(x,I)
% R = I(:, :, 1);
% G = I(:, :, 2);
% B = I(:, :, 3);
% R0 = double(R);
% G0 = double(G);
% B0 = double(B);

% II = imadd(R0, G0);
% II = imadd(II, B0);
[~,~,jj]=size(I);
II=0;
a =125;
for i=0:jj
    II=double(I(:,:,jj))+II;
end
Ir = immultiply(x, a);
C = imdivide(Ir,II);
C = log(C+1);
[x1,y1]=find(isnan(C)==1);
for j=1:length(x1)
    C(x1(j),y1(j))=0;
end
[x1,y1]=find(isinf(C)==1);
for j=1:length(x1)
    C(x1(j),y1(j))=1;
end
% C(isnan(C)==1) = 0;
% C(isinf(C)==1) = 5;