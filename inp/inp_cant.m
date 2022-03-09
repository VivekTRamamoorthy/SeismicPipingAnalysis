function g=inp_cant()
%% INPUT SPACE
% Key points
% R=228.6;% radius of elbow in mm
% g.KP=[1 0         0           0;
%     2 0         750         0;% elbow
%     3 R         750+R       0; % elbow
%     4 R+1940    750+R       0;
%     5 2*R+1940  750+R       R;
%     6 2*R+1940  750+R       R+425;
%     7 2*R+1940  750+R       R+970;
%     8 2*R+1940  750+R       R+970+425;
%     9 2*R+1940  750+R       R+970*2;
%     10 R+1940   750+R       2*R+970*2;
%     11 R        750+R       2*R+970*2;
%     12 0        750         2*R+970*2;
%     13 0        0           2*R+970*2;
%     14 2*R+1940 1480        R+970;
%     15 R+1940   R+1480      R+970;
%     16 R+300    R+1480      R+970;
%     17 300      1480      R+970;
%     18 300      0           R+970;];
% % Lines
% g.LINES=[1 1 2  1   3; % LINENO NODE1 NODE2 ETYPE NORMAL1(1-x,2-y,3-z)
%     %2 2 3       2 3;%Elbow
%     3 3 4       1   3;
%     %4 4 5       2;%Elbow
%     5 5 6       1 2;
%     6 6 7       1 2;
%     7 7 8       1 2;
%     8 8 9       1 2;
%     %9 9 10      2;%Elbow
%     10 10 11    1 2;
%     %11 11 12    2;%Elbow
%     12 12 13    1 3;
%     13 7 14     1 3;
%     %14 14 15    2 3;%Elbow
%     15 15 16    1 3;
%     %16 16 17    2 3;%Elbow
%     17 17 18    1 3;];
% % Elbows no KP1 KP2 C1          C2      C3          ETYPE   Normal1(1-X,2-Y,3-Z)
% g.ELBOW=[2  2   3   R           750     0           2       3;
%     4       4   5   R+1940      750+R   R           2       2;
%     9       9   10  R+1940      750+R   R+2*970     2       2;
%     11      11  12  R           750     2*R+970*2   2       3;
%     14      14  15  R+1940      1480    R+970       2       3;
%     16      16  17  R+300       1480    R+970       2       3];
g.ADDM=[2 250 3.5 3.5 7]; % node m Ix Iy Iz global

%% for debugging
g.KP=[1 0         0     0;
      2 750*sqrt(1/3)       750*sqrt(1/3)     750*sqrt(1/3);]*1e-3;% elbow

g.LINES=[1 1 2 1 0]; % ELEMNO NODE1 NODE2 ETYPE NORMAL
% line numbers and elbow numbers don't matter. EDATA is formed separately
ESIZE=50e-3;%mm
ELBDIV=20;%mm
g.NDOF=6;


%% Plotting keypoints and lines
plotgeom(g)
%% PREPROCESSING
g=prep(g);

%% plotting nodes and elements
plotmesh(g)



end
