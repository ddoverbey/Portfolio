% Define the time vector
t = linspace(0, 54, 100000); % Adjust the time range and number of points as needed

% Define the functions
eq1 = @(t) 10^(88.53/20) * sin(2*pi*60.02*t + 0.00579746);
eq2 = @(t) 10^(76.4143/20) * sin(2*pi*119.98*t - 2.4142);
eq3 = @(t) 10^(80.7868/20) * sin(2*pi*179.98*t - 0.2332);
eq4 = @(t) 10^(60.935/20) * sin(2*pi*239.94*t - 0.1204);
eq5 = @(t) 10^(71.1666/20) * sin(2*pi*299.96*t - 1.0111);
eq6 = @(t) 10^(49.03/20) * sin(2*pi*359.98*t - 1.8754);
eq7 = @(t) 10^(68.7937/20) * sin(2*pi*419.92*t + 1.255);

% Calculate the summed function
summed_signal = eq1(t) + eq2(t) + eq3(t) + eq4(t) + eq5(t) + eq6(t) + eq7(t);

% Plot the summed function
figure;
plot(t, summed_signal);
xlabel('Time (s)');
ylabel('Voltage');
title('Summed Signal with Harmonics');
grid on;
