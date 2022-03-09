function g=inpbend()
clear;clc;
%% INPUT SPACE
% Key points
R=228.6;% radius of elbow in mm
g.KP=[1 0           0           0;
    2 0             0           750         ;% elbow
    3 R             0           750+R; % elbow
    4 R+1940        0           750+R;]*1e-3;
%     5 2*R+1940      R           750+R;
%     6 2*R+1940      R+425       750+R;
%     7 2*R+1940      R+970       750+R;
%     8 2*R+1940      R+970+425   750+R;
%     9 2*R+1940      R+970*2     750+R;
%     10 R+1940       2*R+970*2   750+R;
%     11 R            2*R+970*2  	750+R;
%     12 0            2*R+970*2	750;
%     13 0            2*R+970*2  	0;
%     14 2*R+1940     R+970       1480;
%     15 R+1940       R+970       R+1480;
%     16 R+300        R+970       R+1480;
%     17 300          R+970       1480;
%     18 300          R+970       0;]*1e-3;

% Lines
g.LINES=[1  1   2   1   2; % LINENO NODE1 NODE2 ETYPE NORMAL1(1-x,2-y,3-z)
        %2	2   3  	2   3;%Elbow
        3   3   4 	1   2;];
        %4  4   5	2   ;%Elbow
%         5   5   6	1   3;
%         6   6   7	1   3;
%         7   7   8 	1   3;
%         8   8   9  	1   3;
%         %9  9   10 	2   ;%Elbow
%         10  10  11 	1   3;
%         %11 11  12 	2   ;%Elbow
%         12  12  13 	1   2;
%         13  7   14 	1   2;
%         %14 14  15 	2   3;%Elbow
%         15  15  16	1   2;
%         %16 16  17 	2   3;%Elbow
%         17  17  18 	1   2;];
%     g.LINES(:,5)=0;
% Elbows no KP1 KP2 C1          C2      C3          ETYPE   Normal1(0-auto,1-X,2-Y,3-Z)
g.ELBOW=[2  2   3   R           0           750     2       2;];
%     4       4   5   R+1940      R           750+R   2       3;
%     9       9   10  R+1940      R+2*970     750+R   2       3;
%     11      11  12  R           2*R+970*2   750     2       2;
%     14      14  15  R+1940      R+970       1480    2       2;
%     16      16  17  R+300       R+970       1480    2       2];

g.ELBOW(:,4:6)=g.ELBOW(:,4:6)*1e-3;
% line numbers and elbow numbers don't matter. EDATA is formed separately
g.ESIZE=100e-3;%m
g.ELBDIV=20;% number
g.NDOF=6;
% Added Masses
% g.ADDM=[6 250 3.5 3.5 7; % node m Ix Iy Iz global
%     8   250 3.5 3.5 7];
%% for debugging
% d.KP=[1 0         0           0;
%     2 0         750         0;];% elbow
% 
% d.LINES=[1 1 2 ]; % ELEMNO NODE1 NODE2 ETYPE

%% Plotting keypoints and lines
plotgeom(g)
%% PREPROCESSING
g=prep(g);

%% plotting nodes and elements
plotmesh(g)
end
