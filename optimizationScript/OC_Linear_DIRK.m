function coneq= OC_Linear_DIRK(p,A,b,r)
%%%% Linear Order conditions for Runge Kutta Methods
%%%% b'A^(p-2)c-(1/factorial(p)        
%%%%This was created for the Diagonnaly implicit Runge Kutta Method Search


% Order conditions
    c=sum(A,2);
    b=b(:);
    coneq(1)=sum(b)-1;
  
    if p>=2
      coneq(2)=b'*c-1/factorial(2); 
    end
      
	if p>=3        
      coneq(3)=b'*A*c-1/factorial(3);
      %Coneq(4) is the third order nonlinear condition 
      %coneq(4)=0;  uncomment if you want simply linear conditions
      coneq(4)=b'*c.^2-1/3;
    end

    if p>=4      
      coneq(5)=b'*A^2*c-1/factorial(4); 
     % coneq(6)=b'*A*(c.^2)-1/12;
     % coneq(7)=b'*(c.*(A*c))-1/8;
     % coneq(8)=b'*c.^3-1/4;
      %Coneq(6-8) is the fourth order nonlinear condition 
      % uncomment if you want simply linear conditions
      coneq(6)=0;
      coneq(7)=0;
      coneq(8)=0;
      
      
      
    end
    if p>=5
      coneq(9) = b'*A^3*c-1/factorial(5);
   
	end

    if p>=6 
      coneq(10)=b'*A^4*c-1/factorial(6);
    end
      
   if p>=7
	coneq(11)=b'*A^5*c-1/factorial(7);
   end
      
   if p>=8
    coneq(12) = b'*A^6*c-1/factorial(8);
   end
   
   if p>=9
    coneq(13) = b'*A^7*c-1/factorial(9);
   end

   if p>=10
    coneq(14) =b'*A^8*c-1/factorial(10); 
   end

   if p>=11
    coneq(15) = b'*A^9*c-1/factorial(11);
   end

   if p>=12
    coneq(16)= b'*A^10*c-1/factorial(12);
   end
  
%    [alpha,beta,v]=butcher2shuosher(A,b,r);
%    v=v(:)';
%    coneq=[coneq,alpha(5,1:3),alpha(4,1:2),alpha(3,1)];
   
   
end

