% e72truss.m

% PROBLEM 2 % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


%
%  [[[ Put your names here!! ]]]
% E72 Spr 2022, Profs. Bassman, Tsai, and Yong
%
% This program takes the x- and y-coordinates of joint B as input
% (in a vector) and outputs some desired property of the truss.

% to run you need e72truss([2,1])


function output = e72truss(B)

% These are the locations of the joints.
A=[5 0];
C=[2 2];
D=[0 0];
E=[0 2];

% Calculate unit vectors from one joint to another.
% "norm" calculates the length of a vector
unitAB = (B-A)/norm(B-A);
unitAC = (C-A)/norm(C-A);
unitAD = (D-A)/norm(D-A);
unitAE = (E-A)/norm(E-A);
unitBC = (C-B)/norm(C-B);
unitBD = (D-B)/norm(D-B);
unitBE = (E-B)/norm(E-B);
unitCD = (D-C)/norm(D-C);
unitCE = (E-C)/norm(E-C);
unitDE = (E-D)/norm(E-D);

% Now form a system of equations governing the bar forces and
% reaction forces. The vector of unknowns is "forces", and we will
% arrange the unknowns as
%
% forces = [ ...write them in here just to document your work... ]
%
% In this calculation, we will take F=1 (load).

matrix = [unitAB(1) unitAC(1) 0 0 0 0 0 0 0 0;
    unitAB(2) unitAC(2) 0 0 0 0 0 0 0 0;
    -unitAB(1) 0 unitBC(1) unitBD(1) 0 0 0 0 0 0;
    -unitAB(2) 0 unitBC(2) unitBD(2) 0 0 0 0 0 0;
    0 -unitAC(1) -unitBC(1) 0 unitCD(1) unitCE(1) 0 0 0 0;
    0 -unitAC(2) -unitBC(2) 0 unitCD(2) unitCE(2) 0 0 0 0;
    0 0 0 -unitBD(1) -unitCD(1) 0 unitDE(1) 1 0 0;
    0 0 0 -unitBD(2) -unitCD(2) 0 unitDE(2) 0 0 0;
    0 0 0 0 0 -unitCE(1) -unitDE(1) 0 1 0;
    0 0 0 0 0 -unitCE(2) -unitDE(2) 0 0 1;
    ];

%% HINT:  unitAB(1) is the i-component of the unit vector from A to B
%% HINT:  unitAB(2) is the j-component of the unit vector from A to B

% Define the vector representing the right-hand side of the system
% of equations.
RHS = [ 0; 1; 0; 0; 0; 0; 0; 0; 0; 0 ];

% Solve the system of equations for the forces.
forces = matrix\RHS;

forces

% % Calculate the total length of the truss.
totallength = sum([norm(A-B), norm(A-C), norm(B-C), norm(B-D), norm(C-E), norm(E-D), norm(C-D)]);

output = totallength


% Problem 2a ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% (this must be done in the command window)
% COMMAND IS: fminsearch(@e72truss, [2,1])

% ans = 2.046808147900644 &  1.407532422514314





% PROBLEM 2b % ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


% (this must be done in the command window)
% COMMAND IS: fmincon(@e72truss, [0,0], [],[],[],[],[3,-inf],[inf,inf])

% ans =
% 
%    3.000000027148624   0.943083562017380



% 
% % Calculate the maximum applied load (Fmax).
% ???
% 
% % Set the output to be whatever we want to observe.
% output = totallength;


% Problem 2c ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Qi = 

end


