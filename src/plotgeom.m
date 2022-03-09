function plotgeom(g)
for i=1:size(g.LINES,1)
    X=[g.KP(g.LINES(i,2),2) g.KP(g.LINES(i,3),2)];
    Y=[g.KP(g.LINES(i,2),3) g.KP(g.LINES(i,3),3)];
    Z=[g.KP(g.LINES(i,2),4) g.KP(g.LINES(i,3),4)];
    plot3(X,Y,Z)
    hold on
end
grid on
xlabel('X mm')
ylabel('Y mm')
zlabel('Z mm')
title('Geometric Model')
view(135,-45)