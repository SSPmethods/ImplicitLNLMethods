function [con,coneq]=nlc_RK(x,s,p)
%Nonlinear Constraints for classical SSP Runge Kutta methods
%=====================================================
% Extract arrays A,d,b,theta from x
%Unpacking decision variables from x
%countA=(s*(s+1))/2;
%X=x;
%x=[X(1:countA),X(countA-s+1:countA),X(end)];
[A , b] =  UnpackImplicit(x, s);
 
r=-x(end); %Radius of absolute monotonicity
e=ones(s+1,1);
%Co-optimize for stability region.cos
SR=@(z) real(1+z*b*((eye(s)-z*A)\ones(s,1)))^2+imag(1+z*b*((eye(s)-z*A)\ones(s,1)))^2-1; %Stability Region Function minus 1
%s=linspace(x(end),0,21);s(end+1)=-5;
SS=linspace(0,r,21);
SS=[-SS,sqrt(-1)*SS];

for i=1:length(SS);
    con(i)=SR((SS(i)));
end

%=====================================================
%=====================================================
% Absolute monotonicity conditions (from Spijker 2007)
% Construct Spijker form

T=[A;b];
T=[T,zeros(s+1,1)];
%con1=(eye(size(T,1))+r*T)\[e r*T];
[alpha,beta,v]=butcher2shuosher(A,b,r);
%v(end+1)=-SR;
con=[con(:);-[alpha(:);v(:)]];
%con=-con1(:);

%=====================================================
% Order conditions
coneq=OC_Linear_DIRK(p,A,b,r);


end % of function