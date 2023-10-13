% using the values from the hints website to check

% X and m can be hard coded, the rest can't 
X = 500;
m = 15;

T0 = 60000;
Y = 40;

% x0 = [0.2 0.2 506.874];

tempfun = @(x) lengthSolver(x, X, Y, m, T0); % useful to change a specific input 

F = fsolve(tempfun, [0.2 0.2 506.874])











