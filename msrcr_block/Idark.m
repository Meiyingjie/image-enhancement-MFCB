function Jdark = Idark( I )
% output�� Jdark = min(min(r),min(g),min(b));
Wnd = 3;
hv=size(I,3);
if(hv==3)
Ir = I(:,:,1);
Ig = I(:,:,2);
Ib = I(:,:,3);
%% ͼ����չ
[m,n,~] = size(I);
Irr = zeros(m+Wnd-1, n+Wnd-1); 
Irr((Wnd-1)/2 : m+(Wnd-1)/2-1 , (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ir;
Igg = zeros(m+Wnd-1, n+Wnd-1); 
Igg((Wnd-1)/2 : m+(Wnd-1)/2-1 , (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ig;
Ibb = zeros(m+Wnd-1, n+Wnd-1); 
Ibb((Wnd-1)/2 : m+(Wnd-1)/2-1, (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ib;
%% ��ͨ��
for i=1:1:m
    for j=1:1:n
        Rmin = min(min ( Irr(i:i+Wnd-1, j:j+Wnd-1) ));
        Gmin = min(min ( Igg(i:i+Wnd-1, j:j+Wnd-1) ));
        Bmin = min(min ( Ibb(i:i+Wnd-1, j:j+Wnd-1) ));
        Jdark(i,j) = min(min(Rmin,Gmin),Bmin);
    end
end
 
end
if(hv==1)
Ir = I(:,:);
%% ͼ����չ
[m,n,~] = size(I);
Irr = zeros(m+Wnd-1, n+Wnd-1); 
Irr((Wnd-1)/2 : m+(Wnd-1)/2-1 , (Wnd-1)/2 : n+(Wnd-1)/2-1 ) = Ir;
%% ��ͨ��
for i=1:1:m
    for j=1:1:n
        Rmin = min(min ( Irr(i:i+Wnd-1, j:j+Wnd-1) ));
        Jdark(i,j) = min(Rmin);
    end
end
 
end
end
