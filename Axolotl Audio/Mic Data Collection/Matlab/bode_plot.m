% Read the data from the text file
% data11Asinwave.txt is the primary one we've been observing 

data = dlmread('data11Asinwave.txt');

% Extract voltage and timestamp from the data
voltage_12bit = data(:, 1);
timestamp_micros = data(:, 2);

% Convert voltage from 12-bit Teensy units to volts
Vref = 3.3; % Reference voltage of the Teensy (you may adjust this if different)
bit_resolution = 2^12; % 12-bit resolution
voltage_volts = (voltage_12bit / bit_resolution) * Vref;

% Calculate the time vector in seconds
time_seconds = timestamp_micros / 1e6;
% voltage_volts = sin(time_seconds);

% Calculate the sampling frequency (assuming the data is uniformly sampled)
sampling_frequency = 1 / (time_seconds(3) - time_seconds(2));
% sampling_frequency = 1 / average(time_seconds(2:) - time_seconds(1:)); % figure thsi out later


% Calculate the number of samples
num_samples = length(voltage_volts); % was... numel? 

% % Zero-pad the data to increase the number of samples for better frequency
% % resolution (GPT suggested... look into it) 
% desired_num_samples = 10 * num_samples; % Increase the number of samples by a factor of 10
% voltage_volts_padded = interp1(1:num_samples, voltage_volts, linspace(1, num_samples, desired_num_samples));

% Calculate the one-sided FFT of the voltage signal
% fft_voltage = fft(voltage_volts_padded);
% fft_voltage = fft(voltage_volts);
fft_voltage = 2*(fft(voltage_volts)/num_samples);
fft_voltage_one_sided = fft_voltage(1:num_samples/2 + 1); % update to f-domainsingle.m

% Calculate the corresponding frequencies for the FFT bins
frequencies = (0 : (num_samples/2)) * (sampling_frequency / num_samples);

% Calculate the amplitude and phase response
amplitude_response = abs(fft_voltage_one_sided);
phase_response_radians = angle(fft_voltage_one_sided);

% Convert frequencies to Hz for plotting
frequencies_hz = frequencies;

% Plot the Bode plot
figure;
subplot(2, 1, 1);
semilogx(frequencies_hz, 20*log10(amplitude_response));
title('Bode Plot of Mic/Amplifier Transfer Function');
ylabel('Amplitude (dB)');
grid on;

subplot(2, 1, 2);
semilogx(frequencies_hz, rad2deg(phase_response_radians));
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;

% Additional debugging information
disp(['Number of data samples: ', num2str(num_samples)]);
disp(['Sampling frequency (Hz): ', num2str(sampling_frequency)]);
disp(['Nyquist frequency (Hz): ', num2str(sampling_frequency / 2)]);
% disp(['Number of FFT samples: ', num2str(desired_num_samples)]);
