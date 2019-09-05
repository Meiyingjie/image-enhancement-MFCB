function [v,vp,Ac,result]=darkc(J,hv)
J = double(J);
% J = double(J) ./255 ;
% figure(1); imshow(J); 
%% ��ͨ��ͼ�� Jdark = min(min());
Jdark = Idark(J);
% figure(2);imshow(Jdark,[]);
 
%%
% ע�⣺�ο���ʹ����soft matting�����Եõ��Ĵ�͸����Jt����ϸ�� 
%       ����������ݶȵ����˲�ʵ��
Jdark = gradient_guidedfilter(Jdark,Jdark, 0.04);
% figure(3);imshow(Jdark,[]);
%% ��������ģ�� J = I*t + A*(1-t)  ��ֱ��˥���+���������ա�
% ͸���� t����ȵĹ�ϵ t=exp(-a*depth)
w = 0.95;         %��ı���ϵ��
Jt = 1 - w*Jdark; %���͸����
 
%% ���ȫ�ִ�������
% 1.���ȶ����������ͼ��I����䰵ͨ��ͼ��Jdark��
% 2.ѡ��Jdark�����ص����ǧ��֮һ��N/1000�������������ص㣬��¼���ص㣨x,y������
% 3.���ݵ������ֱ���ԭͼ��J������ͨ����r,g,b�����ҵ���Щ���ص㲢�Ӻ͵õ���sum_r,sum_g,sum_b��.
% 4.Ac=[Ar,Ag,Ab]. ����Ar=sum_r/N;   Ag=sum_g/N;   Ab=sum_b/N.
[m,n,~] = size(J);
N = floor( m*n./1000 );
MaxPos = [0,0]; % ��ʼ��
for i=1:1:N
    MaxValue = max(max(Jdark));
    [x,y] = find(Jdark==MaxValue);
    Jdack(Jdark==MaxValue) = 0; %���ֵ���㣬Ѱ����һ�δδ�ֵ
    %��鳤��
    MaxPos = vertcat(MaxPos,[x,y]);
    Cnt = length(MaxPos(1));
    if Cnt > N
        break;
    end
end
MaxPosN = MaxPos(2:N+1,:);
for jj=1:hv
    sum(:,:,jj) = 0; 
    for j=1:1:N
        sum(:,:,jj) = sum(:,:,jj) + J(MaxPosN(j,1),MaxPosN(j,2),jj);
    end
end
Ac = [sum(:,:,1)/N, sum(:,:,2)/N, sum(:,:,3)/N];
%% ���������ͼ��
% ���� J = I*t + A*(1-t)   I = (J-A)/Jt + A
Iorg = zeros(m,n,hv);
for i = 1:1:m
    for j = 1:1:n
        for k = 1:1:hv
        Iorg(i,j,k) = (J(i,j,k)-Ac(k)) ./ Jt(i,j) + Ac(k);
        if(Iorg(i,j,k)>1)
            Iorg(i,j,k)=1;
        end
        end
    end
end
result=Iorg;
%% ��������ͼ
for tt=1:hv
    v(:,:,tt)=(1-Jt)*Ac(tt);
end
vp=(1-Jt);

