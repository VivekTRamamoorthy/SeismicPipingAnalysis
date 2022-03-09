function [fn,U]=eigenspringmass(K,M)
%[wn,U]=eigenspringmass(k,m)
%where k is the stiffness matrix
%where m is the mass matrix
%fn gives the eigen frequencies in Hz
%U mass normalized modal matrix
n=size(M,1);
[U,wn]=eig(M\K);
%columns of V eigen vectors diagonal elems of D eigen values
wn=sqrt(diag(wn));
fn=wn/(2*pi);
%mass normalization
for i=1:n
U(:,i)=U(:,i)/sqrt(U(:,i)'*M*U(:,i));
end

[fn,kk]=sort(fn);
U=U(:,kk);
