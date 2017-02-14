function [r,g]=RK_SSP_obj(coeffs)
% Used by opt_tsrk



r=coeffs(end);
g=zeros(size(coeffs));
g(end)=1;




end