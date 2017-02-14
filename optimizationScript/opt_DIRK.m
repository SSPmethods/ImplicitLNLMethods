%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This code finds Diagonally implicit Runge Kutta methods for Linear
%Autonomous problems
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%===============================================================
%Variable meanings:  
% s         - # of stages
% p         - Linear order of accuracy
% % minreff   - r/s  Minimum acceptable r_effective
% Decision variables:
% A,b, - coefficients of the Classical Runge Kutta method
% r     - the radius of absolute monotonicity 
% x     - the decision variables stored in the following order:
%         x=[A ;b' ; r] 
% n         - number of non-zero coeficents in method +1 
% restart   - Determines initial Guess: random start-0  
%                                       previous result-1
%                                       previous result w/ perturbation -2
%==========================================================================

%==========================================================================
% Editable options:
%  s=5;
%  p=6; 
%  minreff = .1501;%Search until Minimum acceptable r_effective achieved
% restart =0;
%==========================================================================


if restart==0; 
    clearvars -except  s minr p restart
    rand('twister', sum(100*clock)); %New random seed every time
end

%Set optimization parameters:
opts=optimset('MaxFunEvals',100000,'TolCon',1.e-14,'TolFun',1.e-14,'TolX',1.e-14,'GradObj','on','MaxIter',10000,'Diagnostics','off','Display','off'...
,'UseParallel','never','Algorithm','sqp');



%==============================================
%Now set up:
%The number of unknowns -                     n 
%The linear constraints -                     Aeq*x = beq
%The upper and lower bounds on the unknowns - ub, lb
n=.5*(s^2+s)+s +1; %A( s(s+1)/2 unknowns) + b(s unknowns) +r(1 unknown)
Aeq=[]; beq=[];
bd=5;  
lb=zeros(1,n); lb(end)=-s*2.1;
ub=bd+zeros(1,n); ub(end)=0; 
%==============================================




count=0;info=-2; 
while (info==-2 || (r)<minr || info==0)

  if restart==0
     x=[rand(1,n-1),-.01];  %random Starting Guess	
  
  elseif restart~=0
        if count==0;  %Save Starting Solution in Dummy Variable;
             X1=X;
        end
        if restart==1
              x=X1;
        elseif restart==2;
          x=X+.001*rand(1,n);
        end
  end

  if count==4000
     strcat({'Failed to find Solution after '},{num2str(count)}, {' attempts'})
     break
  end
  %==============================================
  %The optimization call:
  [X,FVAL,info]=fmincon(@RK_SSP_obj,x,[],[],Aeq,beq,lb,ub,@(x) nlc_RK(x,s,p),opts);
  r=-FVAL;  
  count=count+1
end %while loop
%==============================================

x=[X(1:n-1),X(n-s:n-1),X(end)];
%x=[X(1:10),X(7:10),X(end)];X=x;
[A , b] =  UnpackImplicit(x, s);
 [alpha,beta,v]=butcher2shuosher(A,b,r);
[con,coneq]=nlc_RK(X,s,p);
