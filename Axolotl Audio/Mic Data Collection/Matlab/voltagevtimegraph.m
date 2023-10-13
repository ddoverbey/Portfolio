% File name
filename = 'data11Asinwave.txt';
% filename = 'data35.txt';

% Read data from the file
data = dlmread(filename);

% Convert the first column (voltage) to volts
voltage_teensy_units = data(:, 1);
voltage_volts = (voltage_teensy_units / (2^12 - 1)) * 3.3; % Assuming Teensy is operating at 3.3V

% Convert the second column (time) to seconds
time_microseconds = data(:, 2);
time_seconds = time_microseconds * 1e-6;

% Define the time vector for the harmonics (using the same time vector as the original data)
t = time_seconds; % Use the original data's time vector

% Define the functions for the harmonics as shown in the previous response

% Calculate the summed function for the harmonics
summed_signal = eq1(t) + eq2(t) + eq3(t) + eq4(t) + eq5(t) + eq6(t) + eq7(t);

% Plot the summed function in red
plot(t, summed_signal, 'r'); % Red color
hold on; % To keep the current plot and add the next one

% Plot the voltage vs. time graph in blue
plot(time_seconds, voltage_volts, 'b'); % Blue color

hold off; % Release the hold on the plot

xlabel('Time (seconds)');
ylabel('Voltage (volts)');
title('Voltage vs. Time with Summed Harmonics');
legend('Summed Harmonics', 'Original Data');
grid on;
