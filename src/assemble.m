function [M, K]=assemble(g,m)
% Assembling the global matrix
NDOF=g.NDOF; % Getting the no of element degrees of freedom 
K=zeros(g.NNODE*NDOF); % Initializing the global matrices
M=zeros(g.NNODE*NDOF);
for i=1:size(g.EDATA,1) % assembling stiffness & mass for all elements
    typ=g.ETYPE(i); % getting the element type
    rho=m.rho(typ); % getting the density of the material
    t=m.t(typ);     % % getting the thickness of the pipe
    Do=m.Do(typ);Di=Do-2*t; % getting the outer diameter of the pipe
    v=m.v(typ);     % poisson's ratio of material of the pipe 
    E=m.E(typ);     % getting the young's modulus
    G=m.G(typ);     % getting the rigidity modulus
    A=pi/4*(Do^2-Di^2); % area of the pipe section
    NODE1=g.EDATA(i,2); % node no of first node in the element
    NODE2=g.EDATA(i,3); % node no of second node in the element
    X1=g.NCA(NODE1,2:4); % coordinates of first node
    X2=g.NCA(NODE2,2:4); % coordinates of second node
    L=sqrt(sum((X1-X2).^2)); % Length of the element
    % Assuming the pipe is initially aligned with axis along x direction
    Ix=pi/32*(Do^4-Di^4);Iy=pi/64*(Do^4-Di^4);Iz=pi/64*(Do^4-Di^4);
    % calculated the moment of inertias for different axes
    Me=M3B12(rho,A,L,Ix); % Getting the element mass matrix
    Ke=K3B12(A,E,L,Ix,Iy,Iz,G);NDOF=size(Ke,1)/2; % Getting the element stiffness matrix
    
    V=(X2-X1)/sqrt(sum((X2-X1).^2)); % V is the tangent direction of pipe axis normalized
    N1=zeros(1,3); % initiating normal 1
    if length(g.EDATA(i,:))<5 % no normal is specified, auto generate normal
        if abs(V(1))>0.5*L % if tangent has a component in x direction
            N1(2)=V(3); % N1 is assumed along YZ plane so xcoord N1(1)=0
            N1(3)=-V(2); % N1.V =0 so choosing N1 accordingly
            % if V is x direction itself, N1 will be [0 0 0]
            if sum(N1(1:3)==0),N1(2)=1;end % in that case y direction becomes normal 1
            N1=N1/sqrt(sum(N1.^2)); % normalizing N1
        elseif abs(V(2))>0.5*L % if tangent has a component in y direction
            N1(1)=V(3);
            N1(3)=-V(1);
            if sum(N1(1:3)==0),N1(3)=1;end
            N1=N1/sqrt(sum(N1.^2));
        else % if tangent has a component in z direction
            N1(1)=V(2);
            N1(2)=-V(1);
            if sum(N1(1:3)==0),N1(1)=1;end
            N1=N1/sqrt(sum(N1.^2));
        end
    elseif g.EDATA(i,5)==0 % Normal is set to auto generate
        if abs(V(1))>0.5*L % if tangent has a component in x direction
            N1(2)=V(3);
            N1(3)=-V(2);if sum(N1(1:3)==0),N1(2)=1;end
            N1=N1/sqrt(sum(N1.^2));
        elseif abs(V(2))>0.5*L
            N1(1)=V(3);
            N1(3)=-V(1);if sum(N1(1:3)==0),N1(3)=1;end
            N1=N1/sqrt(sum(N1.^2));
        else
            N1(1)=V(2);
            N1(2)=-V(1);if sum(N1(1:3)==0),N1(1)=1;end
            N1=N1/sqrt(sum(N1.^2));
        end
    else % If normal direction is specified
        N1(g.EDATA(i,5))=1; % if x is the normal then N1 generated as [1 0 0] 
    end
    
    % the second normal is generated as the cross product of V and N1
    N2=[(V(2)*N1(3)-V(3)*N1(2)) -(V(1)*N1(3)-V(3)*N1(1)) (V(1)*N1(2)-V(2)*N1(1))];N2=N2/sqrt(sum(N2.^2));
    Te=[V(1) V(2) V(3)
        N1(1) N1(2) N1(3)
        N2(1) N2(2) N2(3)]; % transformation matrix
    T=zeros(12,12);T(1:3,1:3)=Te;T(4:6,4:6)=Te;T(7:9,7:9)=Te;T(10:12,10:12)=Te; % element transformation matrix
    Ke=transpose(T)*Ke*T;
    Me=transpose(T)*Me*T;
    K([NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2],[NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2])=Ke+K([NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2],[NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2]);
    M([NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2],[NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2])=Me+M([NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2],[NDOF*NODE1-NDOF+1:NDOF*NODE1 NDOF*NODE2-NDOF+1:NDOF*NODE2]);   

end
g.NDOF=NDOF;





end
