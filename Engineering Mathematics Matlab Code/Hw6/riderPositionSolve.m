function riderPositionVector = riderPositionSolve(tyVector, rdwt)

T0 = tyVector(1);
Y = tyVector(2);

% Given: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% rdwt = 70; % rider weight
rpwt = 15; % rope weight per meter




% I was hard-coding these:
% T0 = 60000;
% Y = 40;
% so: tyVector = [60000,40];
% rdwt = 70*9.8; % rider weight

X = 500;
m = 15; % rope weight



tempfun = @(x) lengthSolver(x, X, Y, m, T0); % useful to change a specific input

abl = fsolve(tempfun, [0.2 0.2 506.874]);

% Find: ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
a0 = abl(1);
b0 = abl(2);
L = abl(3);


% (this varies w/ the above variables)
gamma = rdwt/(rpwt*L); % ratio, rpwt*L bc it's rope weight per meter

% a0 =  0.1435;
% b0 = 0.1268;
% L = 501.9287;
% you need to solve 

riderPositionVector = [];



% for f = linspace(0,1,500) 

for f = 0:0.01:1

    % initial conditions (guesses)
    x0 = [1,2];
 
    tempfun = @(x) riderPosition(x,a0,b0,gamma,f);

    Q = fsolve(tempfun, x0, optimset('MaxFunEvals',1000,'TolFun',1E-12,'MaxIter',1000,'Display','Off') );

    % let: 
    a = Q(1);
    b = Q(2);
 
    % equations 8 & 10 from ZipPaperEqns.m

    xtilde = L*log((a+sqrt(1+a^2))/(a-b*f+sqrt(1+(a-b*f)^2)))/b;
    ytilde = L*(sqrt(1+a^2)-sqrt(1+(a-b*f)^2))/b;

    % riderPosition is x & y which is why it's 2 columns here 

    riderPositionVector = [riderPositionVector; xtilde, ytilde];

end 

% plot(riderPositionVector(:, 1),- riderPositionVector(:,2),'r')


