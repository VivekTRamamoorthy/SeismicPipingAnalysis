function animatese(s,e)

 for i=1:length(e)
     clf
     subplot(3,1,1)
plot(e(1:i,2),s(1:i,2))
text(e(i,2),s(i,2),'x')
subplot(3,1,2)
plot(e(:,1),e(:,2))
text(e(i,1),e(i,2),'x')
subplot(3,1,3)
plot(s(:,1),s(:,2))
text(s(i,1),s(i,2),'x')
pause(0.1)
end