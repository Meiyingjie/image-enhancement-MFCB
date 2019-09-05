function [result]=MSRCR_multi2(I,J,ttt,hv,MIN,MAX)
minn=MIN;
maxn=MAX;
for jj=1:hv
    I1=I(:,:,jj);
    Rm = J(:, :, jj);
    I2= double(Rm);
    f=double(I2);

    x11=guidedfilter(f,f,ttt,0.01^2);
    x21=guidedfilter(f,f,ttt,0.1^2);
    x31=guidedfilter(f,f,ttt,1^2);
    xx=(x11+x21+x31)/3;
    % figure;imshow(xx1);

    Rlog=log(double(I1)+1);
    DRlog=log(double(xx)+1);

    Rr = Rlog - DRlog;
    Rr=fcn_mapping(Rr, 'nonlinear', 0.5, 40, 0);
    [x1,y1]=find(isnan(Rr)==1);
%     for j=1:length(x1)
%         Rr(x1(j),y1(j))=0.0001;
%     end
%     [x2,y2]=find(isinf(Rr)==1);
%     for j=1:length(x2)
%         Rr(x2(j),y2(j))=0.9999;
%     end
% C=Rssr(double(I2),I);
% % C1=guidedfilter(C,C,ttt,ttt^2);
% % C2=guidedfilter(C,C,fix(ttt/2),ttt^2);
% % C3=guidedfilter(C,C,fix(ttt/4),ttt^2);
% % C=(C1+C2+C3)/3;
% 
% Rr = 5*immultiply(real(C), real(Rr));

    MIN1=minn(jj);
    MAX1=maxn(jj);
    if(abs(MAX1-MIN1)<=0.1)
        M=0.1;
    else
        M=MAX1-MIN1;
    end
    EXPRrr(:,:,jj) = (Rr - MIN1)/M;
    [xx,yy]=find(EXPRrr(:,:,jj)<=0.001);
    for j=1:length(xx)
        EXPRrr(xx(j),yy(j),jj)=0.001;
    end
    EXPRr(:,:,jj)= adapthisteq(EXPRrr(:,:,jj));
% img(:,:,jj)=double(I(:,:,jj))./255./A(jj);
% post(:,:,jj)=double(EXPRr(:,:,jj))./255./A(jj);
end
% result=(1-Idark(img))./(1-Idark(post));
result=EXPRr;
end
