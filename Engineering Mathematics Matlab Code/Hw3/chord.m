% This function plays a chord composed of three frequencies

% For your work consider the fundamental period to be 1 second, so the
% fundamental frequency is 1 Hz.

% E72 Spr 2022, Profs. Bassman, Tsai, and Yong

fs = 16000;     % sampling frequency - sets # of points and needs to be sufficiently high 
t = [0:1/fs:1]; % vector of times to use for playing the chord

% Components of the chord
freqC = 262; % Hz - middle C
freqE = 330; % Hz - E above middle C
freqG = 392; % Hz - G above middle C

% Create sinusoids with chord frequencies and sum them
cos1 = cos(2*pi*freqC*t);
cos2 = cos(2*pi*freqE*t);
cos3 = cos(2*pi*freqG*t);
play = cos1 + cos2 + cos3;

% play1 is playing the amplitude modulated signal y(t)
play1 = play.*cos(2*pi*1000*t);

% Play the summed signal
soundsc(play1,fs);


