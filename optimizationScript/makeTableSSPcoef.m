%cd /Users/zack/Dropbox/ImplicitLinearMethods/OptimalMethods/LowStorageMethods/
DIR=struct2cell(dir(['*' 'DIRK4pLNL.mat']));

for k=1:length(DIR);
    load(DIR{1,k});   
    %clearvars -except A  B r s p k DIR
%save([int2str(s),'s',int2str(p),'DIRK4pLNL.mat'],'A','B','r','s','p')
    Table(s,p)=r;
end
[L,M]=size(Table);
Table(:,1)=1:L;
Table(1,:)=1:M


TableEffective=diag(1./(1:L))*Table;
TableEffective(:,1)=1:L;TableEffective(1,:)=1:M
