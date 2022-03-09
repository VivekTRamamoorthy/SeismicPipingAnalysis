function plotdeflection(U,g,s)

    hold on
    scale=1;
for i=1:size(g.NCA,1)
   g.NCA(i,2)=g.NCA(i,2)+scale*U(g.NDOF*i-g.NDOF+1); 
   g.NCA(i,3)=g.NCA(i,3)+scale*U(g.NDOF*i-g.NDOF+2);
   g.NCA(i,4)=g.NCA(i,4)+scale*U(g.NDOF*i-g.NDOF+3);
end
    
for i=1:size(g.EDATA,1)

    X=[g.NCA(g.EDATA(i,2),2) g.NCA(g.EDATA(i,3),2)];
    Y=[g.NCA(g.EDATA(i,2),3) g.NCA(g.EDATA(i,3),3)];
    Z=[g.NCA(g.EDATA(i,2),4) g.NCA(g.EDATA(i,3),4)];

    plot3(X,Y,Z,s)
    xlabel('X in mm')
    ylabel('Y in mm')
    zlabel('Z in mm')
    %text(mean(X),mean(Y),mean(Z),num2str(i))

end



