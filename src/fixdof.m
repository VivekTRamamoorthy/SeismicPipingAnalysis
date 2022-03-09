function [Knew,Mnew,Q]=fixdof(K,M,dof)
m=size(K,1);
j=1; %counter
I=eye(m);
Q=zeros(m-length(dof),m);
for i=1:m
    isfixed=0;
    for temp=1:length(dof)
        if i==dof(temp)
            isfixed=1;
        end
    end
    if isfixed==0
        Q(j,:)=I(i,:);
        j=j+1;
    end
end

Knew=Q*K*Q';
Mnew=Q*M*Q';
