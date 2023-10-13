A = [-5000 5000 0;
    0 0 100000;
    1000 -2000 0];


t = linspace(0,0.0028,100);  % time points for plotting--vector from 0 to 25 with 100 equally spaced points

% M = expm(A);

% integrated forcing vector 

B = [0; 
    0;
    1]; 

for i = 1:length(t)
    M = expm(A*t(i));
    Y = M*B;
    Vr(i) = Y(1);
end

plot(t,Vr)


