function plotmode(U,g,s)
hold on
box on
axis auto
scale=1;
for degree = 0:20:760
    theta = degree*pi/180;
    cla;
    view(135,45)


    
    for i=1:size(g.EDATA,1)
        
        X=[g.NCA(g.EDATA(i,2),2) g.NCA(g.EDATA(i,3),2)];
        Y=[g.NCA(g.EDATA(i,2),3) g.NCA(g.EDATA(i,3),3)];
        Z=[g.NCA(g.EDATA(i,2),4) g.NCA(g.EDATA(i,3),4)];
        
        plot3(X,Y,Z,'k')
    end
    
    for i=1:size(g.NCA,1)
        g.NCAd(i,2)=g.NCA(i,2)+scale*real( exp(1i*theta)*U(g.NDOF*i-g.NDOF+1));
        g.NCAd(i,3)=g.NCA(i,3)+scale*real( exp(1i*theta)*U(g.NDOF*i-g.NDOF+2));
        g.NCAd(i,4)=g.NCA(i,4)+scale*real( exp(1i*theta)*U(g.NDOF*i-g.NDOF+3));
    end
    
    for i=1:size(g.EDATA,1)
        
        X=[g.NCAd(g.EDATA(i,2),2) g.NCAd(g.EDATA(i,3),2)];
        Y=[g.NCAd(g.EDATA(i,2),3) g.NCAd(g.EDATA(i,3),3)];
        Z=[g.NCAd(g.EDATA(i,2),4) g.NCAd(g.EDATA(i,3),4)];
        
        plot3(X,Y,Z,s)
        
    end
    xlabel('X in m')
    ylabel('Y in m')
    zlabel('Z in m')
    pause(0.01)
end