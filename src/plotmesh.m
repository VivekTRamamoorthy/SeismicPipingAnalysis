function plotmesh(g)
    hold on
for i=1:size(g.EDATA,1)
    X=[g.NCA(g.EDATA(i,2),2) g.NCA(g.EDATA(i,3),2)];
    Y=[g.NCA(g.EDATA(i,2),3) g.NCA(g.EDATA(i,3),3)];
    Z=[g.NCA(g.EDATA(i,2),4) g.NCA(g.EDATA(i,3),4)];
    plot3(X,Y,Z)
    plot3(X,Y,Z,'x')
    text(mean(X),mean(Y),mean(Z),num2str(i))

end
for i=1:size(g.NCA,1)
    text(g.NCA(i,2),g.NCA(i,3),g.NCA(i,4),num2str(i))
end
g.ETYPE=g.EDATA(:,4);
    
grid on
xlabel('X mm')
ylabel('Y mm')
zlabel('Z mm')
title('Mesh')
view(135,-45)