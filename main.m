%% FINITE ELEMENT PROGRAM FOR PIPING SYSTEM ANALYSIS
% Program for Nuclear piping system analysis
% Author:
% Vivek T R 
%% Geometric Model
% Please specify the input piping element geometry in the inp function and
% verify the mesh plot generated before proceeding
clear
addpath('./src')
 g=inp();
%% PROPERTY & SECTION Assignments
% Material Properties Etype1, Etype2,...
m.type={'pipe' 'elbow'};
m.E=    [   1.95e11     1.95e11]; % N/mm^3
m.rho=  [   8000    8000]; % ton/mm^3
m.Do=   [   168e-3     168e-3];
m.t=    [   7e-3       7e-3];
m.v=    [   0.29    0.29];
m.G=    [   0.7e11   0.7e11];

Aw=pi/4*(m.Do-2*m.t).^2;Ap=pi/4*(m.Do.^2)-Aw;
m.rho=(m.rho.*Ap+1000.*Aw)./(Ap);
%checks
if length(m.type)<max(g.ETYPE)
    error('Material property assignment not complete')
end

%% Global Matrices Assembly
[M, K]=assemble(g,m);
%% BC
% Fixing locations
fixkp=[1 18 13];% dofs which are fixed
% fixkp=[1];
dof=[];
for i=1:length(fixkp)
    dof=[dof [g.NDOF*fixkp(i)-g.NDOF+1:1:g.NDOF*fixkp(i)]];
end
if isfield(g,'ADDM')
    for i=1:size(g.ADDM,1)
        node=g.ADDM(i,1);
        for j=1:3 % all 3 translatory directions
            
            M(g.NDOF*node-g.NDOF+j,g.NDOF*node-g.NDOF+j)=g.ADDM(i,2)+M(g.NDOF*node-g.NDOF+j,g.NDOF*node-g.NDOF+j);
        end
        for j=4:6 % adding rotary inertias due to the masses
            M(g.NDOF*i-g.NDOF+j,g.NDOF*i-g.NDOF+j)=g.ADDM(i,j-1)+M(g.NDOF*i-g.NDOF+j,g.NDOF*i-g.NDOF+j);
        end
    end
end
[Kbc,Mbc,Q]=fixdof(K,M,dof);
%% modal
% [fn,U]=eigenspringmass(Kbc,Mbc);
% fn(1:8)
% Uac=Q'*U;
% %test
% %% plotting
% close all
% mode=2;
% plotdeflection(Uac,g,'bx')


%% static displacement
Fbc=zeros(size(Kbc,1),1);
Fbc(7*g.NDOF-5)=10000;

u=Kbc\Fbc;
uac=Q'*u;
plotdeflection(100*uac,g,'r')
hold on
plotdeflection(zeros(size(uac)),g,'bx')
        %axis([-1 1 0 750 -1 1])
        grid on
        view(135,45)
        title('Static Deflection')
        xlabel('X in mm')
        ylabel('Y in mm')
        zlabel('Z in mm')
