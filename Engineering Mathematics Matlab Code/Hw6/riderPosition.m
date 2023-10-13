function Q = riderPosition(x,a0,b0,gamma,f)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


a = x(1);
b = x(2);


% ask if we can input the values of a0, b0 and L that i got from
% ziplineproblengthsolve.m ?????

% a0 =  0.1435;
% b0 = 0.1268;
% L = 501.9287;

Q(1) = (log((a+sqrt(1+a^2))/(a-b*f+sqrt(1+(a-b*f)^2)))/b) + ((1/b)*log((a-b*f-b*gamma+sqrt(1+(a-b*f-b*gamma)^2))/(a-b*gamma-b+sqrt(1+(a-b*gamma-b)^2)))) - (log((a0+sqrt(1+a0^2))/(a0-b0+sqrt(1+(a0-b0)^2)))/b0);
Q(2) = ((sqrt(1+a^2)-sqrt(1+(a-b*f)^2))/b) + ((sqrt(1+(a-b*f-b*gamma)^2)-sqrt(1+(a-b*gamma-b)^2))/b) - ((sqrt(1+a0^2)-sqrt(1+(a0-b0)^2))/b0);


end