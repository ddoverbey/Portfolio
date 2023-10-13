% Load data from file
data = dlmread('data10.txt', ',', 0, 0);
voltage = data(:, 1);
timestamp_micros = data(:, 2);

% Assuming the Teensy range is from 0 to 4095 (12-bit)
voltage_range_teensy = 4095;
voltage_range_audio = 2; % Assuming the audio range is [-1, 1]

% Rescale the voltage to the audio range
audio_samples = (voltage - voltage_range_teensy/2) * (voltage_range_audio / voltage_range_teensy);

% Given sampling frequency
fs = 20e3; % 20 kHz

% Design the notch filter
notch_freq = 123.47; % Frequency to remove
bandwidth = 0.1; % Bandwidth of the notch (adjust as needed)
wo = notch_freq / (fs/2);
bw = wo / bandwidth;
[b, a] = iirnotch(wo, bw);

% Apply the notch filter to the audio samples
filtered_audio = filter(b, a, audio_samples);

% Write the filtered audio samples to a .wav file
audiowrite('output10_notch_filtered.wav', filtered_audio, fs);
