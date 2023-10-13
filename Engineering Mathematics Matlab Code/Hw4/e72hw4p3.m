load("damAccel.mat")

% the 2 colums are time & acceleration
x0 = data(:,2); 

% Period of sampling is 1.000000000000000e-04
% sampling rate is 1/period


Fs = 1/(1.000000000000000e-04) ;

[X,f]= fdomain(x0,Fs); % X[k] (forward DFT)
X0 = X;
% we want to filter out any of the coefficent values that don't correspond
% to frequencies between 100 and 250 and -100 and -250


% for i = 1:length(f) % X is the fourier vector, X[k] and f is the frequency vector
%     if (f(i) > 250) && (f(i) < 100) % between 100-250 Hz
%     elseif (f(i) < -250) && (f(i) > -100) % between -100- -250 Hz
%         X(i) = 0;
%     else 
%         X(i) = X(i); % keep the value the same 
%     end
% end

% ^^^^ this didn't work so i tried it the opposite way and it did for some
% reason

for i = 1:length(f) % X is the fourier vector, X[k] and f is the frequency vector
    if (f(i) < 250) && (f(i) > 100) % between 100-250 Hz
        X(i) = X(i);
    elseif (f(i) > -250) && (f(i) < -100) % between -100- -250 Hz
        X(i) = X(i);
    else 
        X(i) = 0; % keep the value the same 
    end
end


[x,t] = tdomain(X,Fs); % x[n] (inverse dft) send back to the time domain 

subplot(3, 1, 1)
plot(t,x0, 'r')
hold on
plot(t,x, 'b')
title('Filtered and Original Time Series Data vs Time')
xlabel('Time (s)')
ylabel('Acceleration')
legend('Original', 'Filtered')

subplot(3, 1, 2)
plot(f,X0,'r')
hold on
plot(f,X,'b')
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Original and Filtered 2-Sided Discrete Spectrum')
legend('Original', 'Filtered')


% Part 3c 

N = 15000;
Xabs = abs(X);
X2 = Xabs.*Xabs;
PSD = ((X2).*N)./Fs;

subplot(3, 1, 3)
plot(f,PSD,'b')
title('PSD  vs Frequency')
xlabel('Frequency (Hz)')
ylabel('PSD')


% part 3d
Q = trapz(f, PSD);
meanxsqrd = (mean(x.^2));







    

