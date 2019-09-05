function [MIN,MAX]=lb2(I,J,ttt,hv)
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
% figure;imshow(Rr);
%     C=Rssr(double(I2),I);
%     C1=guidedfilter(C,C,ttt,ttt^2);
%     C2=guidedfilter(C,C,fix(ttt/2),ttt^2);
%     C3=guidedfilter(C,C,fix(ttt/4),ttt^2);
%     C=(C1+C2+C3)/3;

%     Rr = immultiply(real(C), real(Rr));
    EXPRr = Rr;
    MIN(jj) = mean(mean(EXPRr))-3*std2(EXPRr);
    MAX(jj) = mean(mean(EXPRr))+3*std2(EXPRr);
end
end
