Ix = 0.06;
Iy = 0.099;
Iz = 0.101;
c = 1;

tfinal = 1000;
plott=linspace(0,tfinal,2000);  

explorerdiffeq=@(t,w) [ ((Iy-Iz)*w(3)*w(2))/Ix; 
    ((Iz-Ix)*w(1)*w(3))/Iy; 
    ((Ix-Iy)*w(2)*w(1))/Iz]; 

% case 1
initdata1 = [c, 0.01, 0.01];
oscillatingsol1=ode45(explorerdiffeq,[0,tfinal],initdata1);
subplot(3,1,1)
plot(plott,deval(oscillatingsol1,plott,1),'b') 
hold on
plot(plott,deval(oscillatingsol1,plott,2),'k-.')
plot(plott,deval(oscillatingsol1,plott,3),'r-.')
hold off


% case 2
initdata2 = [0.01, c, 0.01];
oscillatingsol2=ode45(explorerdiffeq,[0,tfinal],initdata2);

subplot(3,1,2)
plot(plott,deval(oscillatingsol2,plott,1),'b') 
hold on
plot(plott,deval(oscillatingsol2,plott,2),'r')
plot(plott,deval(oscillatingsol2,plott,3),'g')

%case 3
initdata2 = [0.01, 0.01, c];
oscillatingsol2=ode45(explorerdiffeq,[0,tfinal],initdata2);

subplot(3,1,3)
plot(plott,deval(oscillatingsol2,plott,1),'b') 
hold on
plot(plott,deval(oscillatingsol2,plott,2),'r')
plot(plott,deval(oscillatingsol2,plott,3),'g')





