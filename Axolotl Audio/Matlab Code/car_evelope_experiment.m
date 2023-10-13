% Xander Fries
% 6/15/2023
% -3dB envelope calibration with training data

% I think it might be work looking at how the -3dB point of the audio
% amplitude envelope varies with car speed. This is easier than coming up
% with a novel doppler shift algorithm for low frequencies with short
% sampling times, and we have amplitude data available at a high
% time resolution.

mainpath = "../Training Data/Audio + Annotations/";
subpath = "CitroenC4Picasso/";
% Each of the different speeds we have tests for
testPaths = "CitroenC4Picasso_" + ["35", "38", "41", "44", "48", "51", "54", "57", "59", "63", "65", "68", "72", "74", "78", "80", "83", "85", "87", "92", "94", "96", "101"];

%% Envelope Calibration
speedVals = zeros(1,length(testPaths));
tcrossVals = speedVals.*0;

tcrossGuessVals = speedVals.*0;
deltaTVals = speedVals.*0;

speedguessVals = speedVals.*0;
fleftVals = speedVals.*0;
frightVals = speedVals.*0;

% Envelope detection settings
envthresh = sqrt(0.5);

% Two-sided fourier settings
timeOffset = 0;
fourierWidth = 2;

for i=1:length(testPaths)
    [audio, time, speed, tcross] = loadData(mainpath + subpath + testPaths(i));
    fs = 1/(time(2) - time(1));
    speedVals(i) = speed;
    tcrossVals(i) = tcross;
    
    % Run envelope width detection
    [deltaTVals(i), tcrossGuessVals(i)] = getEnvelopeWidth(audio, time, envthresh);

    % Run two-sided fourier speed estimation
    [speedguessVals(i), fleftVals(i), frightVals(i)] = twoSideFourierEstimator(audio, fs, tcrossGuessVals(i), timeOffset, fourierWidth);
end

%% Plotting
% Envelope width
figure(1);
plot(speedVals, deltaTVals);
xlabel("True Speed [km/hr]")
ylabel("Envelope Width [s]")
title(subpath + " Envelope Width")
legend("Thresh = " + envthresh);

% Crossing time
figure(2);
plot(speedVals, tcrossVals);
hold on;
plot(speedVals, tcrossGuessVals);
xlabel("True Speed [km/hr]")
ylabel("Cross Time [s]")
legend("True", "Estimate")
title(subpath + " Cross Time")

% Speed prediction
figure(3);
plot(speedVals, speedVals);
hold on;
plot(speedVals, speedguessVals);
xlabel("True Speed [km/hr]")
ylabel("Estimated Speed [km/hr]")
legend("True", "Estimate")
title(subpath + " Fourier Speed Estimation")
%xlim([35, 50])

%% Functions

function [audio, time, speed, tcross] = loadData(path)
    % Load the audio and speed/cross time label file from the training
    % data.
    [waveformstereo, fs] = audioread(path + ".wav");
    audio = waveformstereo(:,1);
    time = (0:length(audio)-1) ./ fs;

    % Training label
    labelFile = fopen(path + ".txt", "r");
    formatSpec = "%f %f";
    sizeA = [2];
    A = fscanf(labelFile, formatSpec, sizeA);
    speed = A(1);
    tcross = A(2);
    fclose(labelFile);
end

function [deltaT, tCross] = getEnvelopeWidth(audio, t, thresh)
    % Find the width of the envelope, defined as the time difference
    % between the threshold crossings on either side of the maximum.
    env = envelope(audio, 10000, 'rms');
    [envMax, envMaxI] = max(env);
    % Find the threshold crossings
    magThresh = thresh * envMax;
    envLowI = envMaxI;
    envHighI = envMaxI;
    while env(envLowI) > magThresh
        envLowI = envLowI - 1;
    end
    while env(envHighI) > magThresh
        envHighI = envHighI + 1;
    end

    deltaT = t(envHighI) - t(envLowI);
    tCross = t(envMaxI);
end

function [speedguess, leftDominantFreq, rightDominantFreq] = twoSideFourierEstimator(audio, fs, centerTime, timeOffset, fourierWidth)
 % Uses the old doppler algorithm, get the dominant frequency before and
 % after the car passes to determine its speed.
 % timeOffset: Distance between zero-crossing and the start of each
 % fourier.
 % fourierWidth: Width of the fourier transform on each side.
 % speedguess: Predicted speed in km/hr.
    c = 1234.8; % Speed of sound [km/hr]
    
    leftLowInd = time2ind(centerTime - timeOffset - fourierWidth, fs);
    leftHighInd = time2ind(centerTime - timeOffset, fs);
    rightLowInd = time2ind(centerTime + timeOffset, fs);
    rightHighInd = time2ind(centerTime + timeOffset + fourierWidth, fs);
    
    [leftX, leftF] = fdomainsingle(audio(leftLowInd:leftHighInd), fs);
    [rightX, rightF] = fdomainsingle(audio(rightLowInd:rightHighInd), fs);
    
    % Get the dominant frequencies
    [leftMax, leftMaxi] = max(abs(leftX));
    [rightMax, rightMaxi] = max(abs(rightX));
    leftDominantFreq = leftF(leftMaxi);
    rightDominantFreq = rightF(rightMaxi);

    % Calculate car speed
    k = leftDominantFreq/rightDominantFreq;
    speedguess = c*(k-1)/(k+1);
end