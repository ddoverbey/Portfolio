function F = lengthSolver(x, X, Y, m, T0)

% let x(1) = a0
% let x(2) = b0
% let x(3) = L
% 
% T0 = 60000;
% X = 500;
% Y = 40;
% m = 15;

a0 = x(1);
b0 = x(2);
L = x(3);

F(1) = T0*cos(atan(a0)) - (m*L)/b0; % combined equations 1,2, and some of 12
F(2) = log((a0+sqrt(1+a0^2))/(a0-b0+sqrt(1+(a0-b0)^2)))/b0 - X/L; % equation 9
F(3) = (sqrt(1+a0^2)-sqrt(1+(a0-b0)^2))/b0 - Y/L; % equation 11

end
