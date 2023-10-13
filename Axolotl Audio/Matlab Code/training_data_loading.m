% Xander Fries
% 6/15/2023
% Data loading for car audio training data

mainpath = "../Training Data/Audio + Annotations/";
subpath = "CitroenC4Picasso/";
test = "CitroenC4Picasso_35";

%% Try loading data
% Audio
[waveformstereo, fs] = audioread(mainpath + subpath + test + ".wav");
audio = waveform(:,1);
time = (0:length(audio)-1) ./ fs;

% Training label
labelFile = fopen(mainpath + subpath + test + ".txt", "r");
formatSpec = "%f %f";
sizeA = [2];
A = fscanf(labelFile, formatSpec, sizeA);
speed = A(1);
tcross = A(2);
fclose(labelFile);

%% Plotting
plot(time, audio)
xlabel("Time [s]")
ylabel("Audio [EU]")

%% Audio envelope
env = envelope(audio, 10000, 'rms');
[envMax, envMaxI] = max(env);
% Find the -3dB points
magThresh = 0.5 * envMax;
envLowI = envMaxI;
envHighI = envMaxI;
while env(envLowI) > magThresh
    envLowI = envLowI - 1;
end
while env(envHighI) > magThresh
    envHighI = envHighI + 1;
end

plot(time, env);
hold on;
plot([time(envLowI), time(envLowI)], [0, env(envLowI)], "r--");
plot([time(envHighI), time(envHighI)], [0, env(envHighI)], "r--");
xlabel("Time [s]")
ylabel("Magnitude [EU]")
title("Audio Envelope, \DeltaT = " + (time(envHighI) - time(envLowI)))

%% Fourier Analysis
indLow = envLowI;
indHigh = envHighI;
nfft = 4096*4;
noverlap = nfft/2;
window = hanning(nfft);
[s, f, t] = spectrogram(audio(indLow:indHigh), window, noverlap, nfft, fs);

% Compute the difference between adjacent samples
deltas = s;
abss = abs(s);
deltas(:,1) = 0.*s(:,1);
for i=2:length(t)
    deltas(:,i) = abss(:,i) - abss(:,i-1);
end
figure(1);
imagesc(time(indLow:indHigh), f, deltas); colormap jet; axis xy; ylim([0, 400])

figure(2);
imagesc(time(indLow:indHigh), f, abss); colormap jet; axis xy; ylim([0, 400])

%% Attempts to find the frequency/dopper shift ratio
maxf = 0.*t;
for i=1:length(maxf)
    [m,I] = max(abss(:,i));
    maxf(i) = f(I);
end

plot(t, maxf)
xlabel("Time [s]")
ylabel("Frequency (Hz)")