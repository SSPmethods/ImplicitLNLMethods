%This repacks all of our data from coefficients matricies back into the
%vector x which can be fed into the optimizer.
%function [X]= packing(A , B, r);


function [X]= packing(A , B, r);
s=length(A);


aa=[];
for i=1:s;
    for j=1:i;
        aa=[aa,A(i,j)];
    end
end
aa=aa(:);


bb=B(:);


X=[aa;;bb;-r];
X=X';

end
