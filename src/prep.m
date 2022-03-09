function g1=prep(g)
% Nodal Coordinate Array
g.NCA=g.KP; % keypoints are designated as nodes directly
NNODE=size(g.NCA,1)+1; % number of nodes increased starting from
NELEM=1;
if isfield(g,'ESIZE')==0,g.ESIZE=10e-3;end;%mm
if isfield(g,'ELBDIV')==0,g.ELBDIV=20;end;%no
%% Straight pipe
for i=1:size(g.LINES,1)
    X=[g.KP(g.LINES(i,2),2) g.KP(g.LINES(i,3),2)];
    Y=[g.KP(g.LINES(i,2),3) g.KP(g.LINES(i,3),3)];
    Z=[g.KP(g.LINES(i,2),4) g.KP(g.LINES(i,3),4)];
    L=sqrt((X(1)-X(2))^2+(Y(1)-Y(2))^2+(Z(1)-Z(2))^2); % finding the length of the line
    n=ceil(L/g.ESIZE); % dividing the line into smaller elements based on ESIZE
    n=max(n,3);
    for j=1:n-1 % for all nodal points bw the keypoints
        x=X(1)+(X(2)-X(1))*j/n; % x coordinate of the node
        y=Y(1)+(Y(2)-Y(1))*j/n; % y coordinate of the node
        z=Z(1)+(Z(2)-Z(1))*j/n; % z coordinate of the node
        g.NCA(NNODE,:)=[NNODE x y z];        
        if j==1
            g.EDATA(NELEM,:)=[NELEM g.LINES(i,2) NNODE g.LINES(i,4) g.LINES(i,5)];            
        elseif j==n-1
            g.EDATA(NELEM,:)=[NELEM NNODE-1 NNODE g.LINES(i,4) g.LINES(i,5)];
            NELEM=NELEM+1;
            g.EDATA(NELEM,:)=[NELEM NNODE g.LINES(i,3) g.LINES(i,4) g.LINES(i,5)];            
        else
            g.EDATA(NELEM,:)=[NELEM NNODE-1 NNODE g.LINES(i,4) g.LINES(i,5)];            
        end
        NNODE=NNODE+1;
        NELEM=NELEM+1;
    end
end
%d.NELEM=NELEM-1;d.NNODE=NNODE-1;
%% Elbows   
if isfield(g,'ELBOW')
for i=1:size(g.ELBOW,1)
    X=[g.KP(g.ELBOW(i,2),2) g.KP(g.ELBOW(i,3),2)];
    Y=[g.KP(g.ELBOW(i,2),3) g.KP(g.ELBOW(i,3),3)];
    Z=[g.KP(g.ELBOW(i,2),4) g.KP(g.ELBOW(i,3),4)];
    C=g.ELBOW(i,4:6);
    R=sqrt((C(1)-X(1))^2+(C(2)-Y(1))^2+(C(3)-Z(1))^2);
    % checks
    if sqrt((C(1)-X(2))^2+(C(2)-Y(2))^2+(C(3)-Z(2))^2)-R>1e-4*R
        error(['Elbow definition of elbow no ' num2str(i) ' is wrong!'])
    end
    D1=[C(1)-X(1), C(2)-Y(1), C(3)-Z(1)]; %vector from center to point 1
    D2=[C(1)-X(2), C(2)-Y(2), C(3)-Z(2)]; %vector from center to point 2
    if sum(D1.*D2)>1e-6
        error('Elbow angle not 90 degrees. Please divide elbow/Check input')
    end
    % end checks
    n=ceil(90/g.ELBDIV); % dividing the line into smaller elements based on ESIZE
    n=max(n,3);
    for j=1:n-1 % for all nodal points bw the keypoints
        theta=j*90/n*pi/180;
        x=C(1)+(X(1)-C(1))*cos(theta)+(X(2)-C(1))*sin(theta); % x coordinate of the node
        y=C(2)+(Y(1)-C(2))*cos(theta)+(Y(2)-C(2))*sin(theta); % y coordinate of the node
        z=C(3)+(Z(1)-C(3))*cos(theta)+(Z(2)-C(3))*sin(theta); % z coordinate of the node
        g.NCA(NNODE,:)=[NNODE x y z];        
        if j==1
            g.EDATA(NELEM,:)=[NELEM     g.ELBOW(i,2) NNODE          g.ELBOW(i,7) g.ELBOW(i,8)];            
        elseif j==n-1
            g.EDATA(NELEM,:)=[NELEM     NNODE-1     NNODE           g.ELBOW(i,7) g.ELBOW(i,8)];
            NELEM=NELEM+1;
            g.EDATA(NELEM,:)=[NELEM     NNODE       g.ELBOW(i,3)    g.ELBOW(i,7) g.ELBOW(i,8)];            
        else
            g.EDATA(NELEM,:)=[NELEM     NNODE-1     NNODE           g.ELBOW(i,7) g.ELBOW(i,8)];            
        end
        NNODE=NNODE+1;
        NELEM=NELEM+1;
    end
end
end
g.NELEM=NELEM-1;g.NNODE=NNODE-1;g.ETYPE=g.EDATA(:,4);
g1=g;
