%%%Unpacking Diagonally Implicit %%%%
%&& We are taking our coeficient vector X which is being fed through
%%% the optimizer and unpacking the pieces back into the original form

%%% A is Diagonnaly Implicit and has (s^2+s)/2 unknowns 
%%% B is a row vector of length s;
function [A,B] =  UnpackImplicit(X,s);
A = zeros(s);
ind  = tril(true(s),0);
count=.5*(s^2+s);
A(ind) = X(1:count);
B=X(count+1:count+s);

end

