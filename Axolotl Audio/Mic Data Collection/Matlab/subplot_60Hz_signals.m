% Define the equations
t = 0:0.001:1; % Time vector from 0 to 1 second with 0.001 second intervals

% Equation 1 (60 Hz)
y1 = 10^(88.53/20) * sin(2*pi*60.02*t + 0.00579746);

% Equation 2 (120 Hz harmonic)
y2 = 10^(76.4143/20) * sin(2*pi*119.98*t - 2.4142);

% Equation 3 (180 Hz harmonic)
y3 = 10^(80.7868/20) * sin(2*pi*179.98*t - 0.2332);

% Equation 4 (240 Hz harmonic)
y4 = 10^(60.935/20) * sin(2*pi*239.94*t - 0.1204);

% Equation 5 (300 Hz harmonic)
y5 = 10^(71.1666/20) * sin(2*pi*299.96*t - 1.0111);

% Equation 6 (360 Hz harmonic)
y6 = 10^(49.03/20) * sin(2*pi*359.98*t - 1.8754);

% Equation 7 (420 Hz harmonic)
y7 = 10^(68.7937/20) * sin(2*pi*419.92*t + 1.255);

% Plot the signals
figure;
subplot(4, 2, 1);
plot(t, y1);
title('60 Hz');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 2, 2);
plot(t, y2);
title('120 Hz harmonic');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 2, 3);
plot(t, y3);
title('180 Hz harmonic');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 2, 4);
plot(t, y4);
title('240 Hz harmonic');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 2, 5);
plot(t, y5);
title('300 Hz harmonic');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 2, 6);
plot(t, y6);
title('360 Hz harmonic');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(4, 2, 7);
plot(t, y7);
title('420 Hz harmonic');
xlabel('Time (s)');
ylabel('Amplitude');

sgtitle('Harmonic Signals');
