function K=K3B12(A,E,L,Ix,Iy,Iz,G)
%K=zeros(12,12);
%syms A E L Ix Iy Iz G J
%source: 
J=Ix;
K=[(A*E)/L,              0,              0,        0,             0,             0, -(A*E)/L,              0,              0,        0,             0,             0;
         0,  (12*E*Iz)/L^3,              0,        0,             0,  (6*E*Iz)/L^2,        0, -(12*E*Iz)/L^3,              0,        0,             0,  (6*E*Iz)/L^2;
         0,              0,  (12*E*Iy)/L^3,        0, -(6*E*Iy)/L^2,             0,        0,              0, -(12*E*Iy)/L^3,        0, -(6*E*Iy)/L^2,             0;
         0,              0,              0,  (G*J)/L,             0,             0,        0,              0,              0, -(G*J)/L,             0,             0;
         0,              0,  -(6*E*Iy)/L^2,        0,    (4*E*Iy)/L,             0,        0,              0,   (6*E*Iy)/L^2,        0,    (2*E*Iy)/L,             0;
         0,   (6*E*Iz)/L^2,              0,        0,             0,    (4*E*Iz)/L,        0,  -(6*E*Iz)/L^2,              0,        0,             0,    (2*E*Iz)/L;
  -(A*E)/L,              0,              0,        0,             0,             0,  (A*E)/L,              0,              0,        0,             0,             0;
         0, -(12*E*Iz)/L^3,              0,        0,             0, -(6*E*Iz)/L^2,        0,  (12*E*Iz)/L^3,              0,        0,             0, -(6*E*Iz)/L^2;
         0,              0, -(12*E*Iy)/L^3,        0,  (6*E*Iy)/L^2,             0,        0,              0,  (12*E*Iy)/L^3,        0,  (6*E*Iy)/L^2,             0;
         0,              0,              0, -(G*J)/L,             0,             0,        0,              0,              0,  (G*J)/L,             0,             0;
         0,              0,  -(6*E*Iy)/L^2,        0,    (2*E*Iy)/L,             0,        0,              0,   (6*E*Iy)/L^2,        0,    (4*E*Iy)/L,             0;
         0,   (6*E*Iz)/L^2,              0,        0,             0,    (2*E*Iz)/L,        0,  -(6*E*Iz)/L^2,              0,        0,             0,    (4*E*Iz)/L];
     
     
     