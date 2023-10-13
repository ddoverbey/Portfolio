% E72 HOMEWORK 3 PROBLEM 2a-d 

function ISE = fourierplotter()
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

tau = 86400; % tau = 86400 for 24 hours and 50 for 50 seconds 
N0 = 1000;    % number of points within a period. Increase to capture variations for higher harmonics
dt = tau/N0;    % time resolution  
wo = (2*pi)/tau;     % fundamental frequency
Y = 1;

% t = -tau-tau:dt:tau+tau; % two full periods plus a bit extra 
t = -tau:dt:tau;

% Generate a vector of zeros and ones corresponding to the pulse being off
% or on in the original signal. We are using logical AND (&) and OR (|) statements
% to calculate x without having to use a for loop and if statements.
x = ((t>=(-tau-tau/2))&(t<=(-tau+tau/2))) | ((t>=-tau/2)&(t<=tau/2)) | ((t>=(tau-tau/2))&(t<=(tau+tau/2)));

% Make plots of the original and approximated signal and a stem plot

figure(1)
clf

% SUBPLOTS ~~~~~~~~~~~~~~~~~~~~~~~~~~

y = 0.5*sawtooth((2*pi*t)/tau)+0.5; 



% COPY AND PASTE THIS CODE FOR EACH VALUE OF M


% G = ((1i*wo.*k+0.8)/(-(wo.*k)^2+1i*wo.*k+0.8));

% M = 3
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% x(t) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

M = 3;
k = -M:1:M;

G = ((1i*wo.*k+0.8)/(-(wo.*k).^2+1i*wo.*k+0.8));
c = (-Y./(2.*pi.*j.*k)).*G;


c(0+M+1) = Y/2; % find c_0 

% Make a vector of times for the plots
% original t:
t = -tau:dt:tau;



% Build the approximated signal from the Fourier coefficients and basis functions
xhat = zeros(1,length(t));
for n = -M:1:M  % using n to avoid messing up k vector
    xhat = xhat + c(n+M+1).*exp(1j*n*wo*t); 
end

% black line is y, red line is x

plot(t,y,'k',t,xhat,'r')
xlabel('time (sec)')
ylabel('Amplitude')
axis tight 

hold on

% y(t) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


M = 3;
k = -M:1:M;

c = (-Y./(2.*pi.*j.*k));


c(0+M+1) = Y/2; % find c_0 

% Make a vector of times for the plots
% original t:
t = -tau:dt:tau;


% Build the approximated signal from the Fourier coefficients and basis functions
yhat = zeros(1,length(t));
for n = -M:1:M  % using n to avoid messing up k vector
    yhat = yhat + c(n+M+1).*exp(1j*n*wo*t); 
end


plot(t,y,'k',t,yhat,'b')
xlabel('time (sec)')
ylabel('Amplitude')
axis tight 

legend("sawtooth", "x(t)", "y(t)")


figure((2))


% this code worked but is being commented out for the sake of part d
% Magnitude and phase stem plots
% subplot(3,1,2)
% stem(k,abs(c))
% ylabel('c_{k} magnitude')
% xlabel('k')
% 
% subplot(3,1,3)
% stem(k,angle(c)/pi)  % note: divided by pi, so 1 on the plot is pi, 0.5 is pi/2
% ylabel ('c_{k} phase/\pi')  
% xlabel ('k')
% end 