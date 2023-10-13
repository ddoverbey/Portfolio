% step 1: fifgure out actual equaiton by substituting dv/dt (solve for 1st
% equation)


% to find dy/dx, first take spline of rider path, themn find rate of change
% of spline with fndr (puppspline), then find ppval of the fnder thing
% (which should be rate of chnage spline), that ppval is your dy/dx.
% substitute that into the velocity equation and then do ode45



X = 500;
m = 15;


% these are hard coded in:
T0 = 60000;
Y = 40;
L = 501.9; % (this corresponds to the T0 and Y values) 

tyVector(1) = T0;
tyVector(2) = Y;




% T0 = tyVector(1);
% Y = tyVector(2);




% RIDER WEIGHT OF 30kg ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rdwt = 30;

Q = riderPositionSolve(tyVector,30);

riderPositionVector = Q;


riderPositionSpline = spline(riderPositionVector(:,1),riderPositionVector(:,2));
% tplot = linspace(0,1,500);
% x = linspace(0,1,500);
% hold on
% plot(x, ppval(riderPositionSpline, x),'g')
% hold on

rateofchangespline = fnder(riderPositionSpline);  % fnder produces another spline object, which we need to evaluate using fnder
figure(2)
% plot(x, ppval(rateofchangespline, x),'b')

dydx = @(x) [ppval(rateofchangespline, x)];



% DE stuff:
% diffeq=@(x,v2) [(2*(m*9.8*sin(-atan(dydx(x)))- (0.03*m^(2/3))*v2(2))*(sqrt(1+dydx(x)^2)))/m];


diffeq=@(x,v2) [2*(9.8*sin(-atan(dydx(x))) - (0.03*v2*m^(2/3))/m)*sqrt(1+dydx(x)^2) ];



% solve the differential equations

velocity = ode45(diffeq, [0,L],0);


plot(sqrt(velocity.x),sqrt(-velocity.y),'b')
hold on







% RIDER WEIGHT OF 70kg ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rdwt = 70;

Q = riderPositionSolve(tyVector,70);

riderPositionVector = Q;


riderPositionSpline = spline(riderPositionVector(:,1),riderPositionVector(:,2));
% tplot = linspace(0,1,500);
% x = linspace(0,1,500);
% hold on
% plot(x, ppval(riderPositionSpline, x),'r')
% hold on

rateofchangespline = fnder(riderPositionSpline);  % fnder produces another spline object, which we need to evaluate using fnder
figure(2)
% plot(x, ppval(rateofchangespline, x),'b')

dydx = @(x) [ppval(rateofchangespline, x)];



% DE stuff:
% diffeq=@(x,v2) [(2*(m*9.8*sin(-atan(dydx(x)))- (0.03*m^(2/3))*v2(2))*(sqrt(1+dydx(x)^2)))/m];


diffeq=@(x,v2) [2*(9.8*sin(-atan(dydx(x))) - (0.03*v2*m^(2/3))/m)*sqrt(1+dydx(x)^2) ];



% solve the differential equations

velocity = ode45(diffeq, [0,L],0);


plot(sqrt(velocity.x),sqrt(-velocity.y),'r')
hold on




% RIDER WEIGHT OF 140kg ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rdwt = 140;

Q = riderPositionSolve(tyVector,140);

riderPositionVector = Q;


riderPositionSpline = spline(riderPositionVector(:,1),riderPositionVector(:,2));
% tplot = linspace(0,1,500);
x = linspace(0,1,500);
% hold on
% plot(x, ppval(riderPositionSpline, x),'r')
% hold on

rateofchangespline = fnder(riderPositionSpline);  % fnder produces another spline object, which we need to evaluate using fnder
figure(2)
% plot(x, ppval(rateofchangespline, x),'b')

dydx = @(x) [ppval(rateofchangespline, x)];



% DE stuff:
% diffeq=@(x,v2) [(2*(m*9.8*sin(-atan(dydx(x)))- (0.03*m^(2/3))*v2(2))*(sqrt(1+dydx(x)^2)))/m];


diffeq=@(x,v2) [2*(9.8*sin(-atan(dydx(x))) - (0.03*v2*m^(2/3))/m)*sqrt(1+dydx(x)^2) ];



% solve the differential equations

velocity = ode45(diffeq, [0,L],0);

% 
plot(sqrt(velocity.x),sqrt(-velocity.y),'g')
hold on





