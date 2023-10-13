data = dlmread('data43.txt', ',', 0, 0);
voltage = data(:, 1);
timestamp_micros = data(:, 2);

% Assuming the Teensy range is from 0 to 4095 (12-bit)
voltage_range_teensy = 4095;
voltage_range_audio = 2; % Assuming the audio range is [-1, 1]

% Rescale the voltage to the audio range
audio_samples = (voltage - voltage_range_teensy/2) * (voltage_range_audio / voltage_range_teensy);

% Given sampling frequency
% fs = 44e3; % 44 kHz
% fs = 20000; % 20 kHz
% fs = 15000;
fs = 45454; %.5455;

% Write the audio samples to a .wav file
audiowrite('output43.wav', audio_samples, fs);
