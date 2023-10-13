function ISE = fourierplotter( A, T, d, M )
% This function plots a periodic signal and a complex exponential series 
% approximation of it. It also produces a stem plot of the Fourier coefficients.
% It is designed for a pulse width modulation signal centered around t = 0 
% (a pulse is centered there), but can be modified as needed for other periodic signals.
%   A: amplitude of pulse train
%   T: fundamental period
%   d: duty cycle
%   M: number of harmonics in the Fourier series approximation
% The function returns the integrated square error (ISE) for the approximation

% E72 Spr 2022, Profs. Bassman, Tsai and Yong
% Based on a function created by Prof. Qimin Yang in Sp 2017.


N0 = 1000;    % number of points within a period. Increase to capture variations for higher harmonics
dt = T/N0;    % time resolution
tau = d*T ;   % duration of non-zero pulse
wo = (2*pi)/T;     % fundamental frequency


% Calculate Fourier coefficients. k goes from -M to M, but the vector of 
% coefficients has to start with index 1
k = -M:1:M;
c = (A./(pi.*k)).*sin(k.*pi.*d);


% C_0 is not calculated by this formula and needs to be done separately 
% due to division by zero.
% Indexing is tricky! C_k is in the (k+M+1)th element of the c vector
c(0+M+1) = A*d; % find c_0 

% Make a vector of times for the plots
t = -T-tau:dt:T+tau; % two full periods plus a bit extra

% Build the approximated signal from the Fourier coefficients and basis functions
xhat = zeros(1,length(t));
for n = -M:1:M  % using n to avoid messing up k vector
    xhat = xhat + c(n+M+1).*exp(1j*n*wo*t); 
end

% Generate a vector of zeros and ones corresponding to the pulse being off
% or on in the original signal. We are using logical AND (&) and OR (|) statements
% to calculate x without having to use a for loop and if statements.
x = ((t>=(-T-tau/2))&(t<=(-T+tau/2))) | ((t>=-tau/2)&(t<=tau/2)) | ((t>=(T-tau/2))&(t<=(T+tau/2)));

% Make plots of the original and approximated signal and a stem plot

figure(1)
clf

% Original and approximated signal
subplot(3,1,1)
plot(t,x*A,'k',t,xhat,'r') 
xlabel('time (sec)')
ylabel('x(t)')
axis tight

% Magnitude and phase stem plots
subplot(3,1,2)
stem(k,abs(c))
ylabel('c_{k} magnitude')
xlabel('k')

subplot(3,1,3)
stem(k,angle(c)/pi)  % note: divided by pi, so 1 on the plot is pi, 0.5 is pi/2
ylabel ('c_{k} phase/\pi')  
xlabel ('k')


% Compute the ISE value within one period of the signal by adding squared error
% at each time (multiplied by time step dt). Show ISE as the title of the graph.

ISE=0;
for i = 1:N0+1   % can start anywhere and add one period's worth of points
    ISE = ISE + (x(i)-xhat(i)).^2*dt;
end
% The x and xhat values are real, but they are calculated from complex
% valued expressions they retain tiiiiiiny imaginary parts. This gets rid
% of them so we don't need to see an error message
ISE = abs(ISE);

subplot(3,1,1)
title(['ISE is ' num2str(ISE,'%0.3e') ' for M = ' num2str(M)]);
% look at documentation for sprintf to see what the %0.3e means for formatting

end

