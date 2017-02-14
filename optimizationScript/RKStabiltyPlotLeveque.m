function [imagax,realax] = RKStabiltyPlotLeveque(A,B,xa,xb,ya,yb);
s=length(A);
I=eye(s);e=ones(s,1);
color={'r'};
% plot S, the region of absolute stability for the rational function R(z).
%
% If plotOS=1 then also plot the Order Star (complement of the 
% region of relative stability) 
%
% Typically R(z) is an approximation to exp(z) obtained by applying a 
% finite difference method to y' = lambda y, where z = dt*lambda.
%
% axisbox = axis region 
%           (if omitted, default values are used that may be a poor choice)
%
% See also makeplotS.m, from which this routine is called for a variety of
% specific R(z) functions.
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/chapter7  (2007)

 %   xa = -30; xb = 2; ya = -15; yb = 15;  % default values
%Assume its consistant;
%poly=1;
%for i=1:s
%poly(i+1)=b*sum(A^(i-1),2);
%end
%Fix this line to be more general I usually run this by hand

R1=@(z) 1+z*B*((I-z*A)\e);
%R2=@(z,zhat) 1+(z*B+zhat*Bhat)*((I-z*A-zhat*Ahat)\e);

% compute ratio R(z) over a fine grid on the region [xa,xb] x [ya,yb]
dx=.5; dy=.5;
%dx=.1; dy=.1;

nptsx=round((xb-xa)/dx);
nptsy = round((yb-ya)/dy);

%nptsx = 501; nptsy = 501;

x = linspace(xa,xb,nptsx);
y = linspace(ya,yb,nptsy);
[X,Y] = meshgrid(x,y);
Z = X + 1i*Y;
%Rval = feval(R,Z);
[imax,jmax]=size(Z);
for i=1:imax
    for j=1:jmax;
    Rval1(i,j)=R1(Z(i,j));
   % Rval2(i,j)=R2(Z(i,j),-sqrt(.5)*Z(i,j)^2);

    end
end
%----------------------------------------------------------------------
% Plot S, region of absolute stability:

Rabs1 = abs(Rval1);
%Rabs2 = abs(Rval2);

% plot Rabs with a color map that is shaded in S (where Rabs < 1)
% and which in complement (where Rabs > 1).

%figure(1)
%clf
%surf(x,y,0*Rabs,Rabs,'EdgeColor','none')
view(2)
%colormap([.7 1 .7;1 1 1])
colormap([.7 .7 1;1 1 1])
%colormap([.7 .7 .7;1 1 1])   % grayscale
caxis([.99 1.01])
daspect([1 1 1])
hold on
%contour(x,y,Rabs1,[1 1],color{1},'linewidth',3)
contourf(x,y,Rabs1,[0,1],[color{1}])
%contour(x,y,Rabs1,[1 1],[color,'--.'],'linewidth',3)
%contour(x,y,Rabs2,[1 1],[color{2},'--.'],'linewidth',3)

box on
hold off
title('Region of absolute stability','FontSize',15)
% plot axes:
hold on
plot([xa xb],[0 0],'k')
plot([0 0],[ya yb],'k')
axis([xa xb ya yb])
set(gca,'FontSize',15)
%hold off

% if ~plotOS, return, end
% 
% %----------------------------------------------------------------------
% % Plot order star, complement of region of relative stability:
% 
% Rrel = abs(Rval ./ exp(Z));
% 
% % plot Rrel with a color map that is shaded in order star (where Rrel > 1)
% % and white in complement (where Rrel < 1).
% 
% figure(2)
% clf
% surf(x,y,0*Rrel,Rrel,'EdgeColor','none')
% view(2)
% colormap([1 1 1; .7 .7 1])
% %colormap([1 1 1; .7 .7 .7])   % grayscale
% caxis([.99 1.01])
% daspect([1 1 1])
% hold on
% contour(x,y,Rrel,[1 1],'k')
% box on
% hold off
% title('Order Star','FontSize',15)
% % plot axes:
% hold on
% plot([xa xb],[0 0],'k')
% plot([0 0],[ya yb],'k')
% axis([xa xb ya yb])
% set(gca,'FontSize',15)
% hold off

[I,J]=max(diff(find(Rabs1(:,length(x)-xb/dx)>1)));
imagax=abs(y(J));

[I,J]=max(diff(find(Rabs1(length(y)-yb/dy,:)>1)));
realax=(x(J));


end