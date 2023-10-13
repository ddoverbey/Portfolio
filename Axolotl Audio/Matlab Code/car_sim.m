% Xander Fries
% 6/9/2023
% Doppler shift car speed simulator

%% Calculations
ftom = 1/3;
mphtom = 5260/3 / 60 / 60;

xbounds = [-30, 100]; % Max/min x position [m]
dt = 0.01;
t = 0:dt:5;
vx = t.*0 + 30*mphtom;
x = 0.*t;
x(1) = xbounds(1);
for i=2:length(x)
    x(i) = x(i-1) + dt*vx(i-1);
end
y = 0.*t + 10*ftom;
vy = 0.*t;

fs = 0.*t + 200; % Car emitted frequency [Hz]
c = 343; % Speed of sound [m/s]

r = sqrt(x.^2 + y.^2);
vr = (x.*vx + y.*vy)./r;
fo = fs.*c./(c + vr);

%% Other calculations
dt = 0.001;
Ts = 2;
c = 343;
fs = 200;
v = 15;
y = 4;
tend = 5;
[t, fo] = carSimConstantV(v, y, tend, dt, fs, c);
[st, sfo] = carSimSnap(v, y, tend, dt, fs, c, Ts);
[ev, ey, efs] = carSpeedEstimator(t, fo)
[esv, esy, esfs] = carSpeedEstimator(st, sfo)

%% Plotting
plot(t, fo);
hold on;
plot(st, sfo);
%hold on;
%plot(t, fs);
xlabel("Time [s]")
ylabel("Frequency [Hz]")
legend("fo", "sfo Ts = " + Ts)

%% Error Analysis
% Unchanging values for simulation
dt = 0.001;
c = 343;
fs = 200;
v = 15;
y = 4;
tend = 5;

[t, fo] = carSimConstantV(v, y, tend, dt, fs, c);

% Vary Ts and watch error change
Ts = 0.005:0.01:2;

vestimates = 0.*Ts;
yestimates = 0.*Ts;
fsestimates = 0.*Ts;

for i=1:length(Ts)
    [st, sfo] = snapResolution(t, fo, Ts(i));
    [ev, ey, efs] = carSpeedEstimator(st, sfo)
    vestimates(i) = ev;
    yestimates(i) = ey;
    fsestimates(i) = efs;
end

plot(Ts, vestimates);
hold on;
plot(Ts, yestimates);
plot(Ts, fsestimates);
xlabel("Ts (s)")
legend("v", "y", "fs")


%% Functions
function [t, fo] = carSimConstantV(v, y, tend, dt, fs, c)
    % vx = v, vy = 0, fs constant.
    % dt is the Fourier period, which determines frequency and time
    % resolution.

    % Get t and x, centered on x=0
    tplus = 0:dt:tend;
    xplus = 0.*tplus;
    for i=2:length(tplus)
        xplus(i) = xplus(i-1) + dt*v;
    end
    tminus = -tend:dt:-dt;
    xminus = 0.*tminus;
    for i=2:length(tminus)
        xminus(length(tminus) - i + 1) = xminus(length(tminus) - i + 2) - dt*v;
    end
    x = [xminus, xplus];
    t = [tminus, tplus];

    % Get r and fo
    r = sqrt(x.^2 + y.^2);
    vr = (x.*v)./r;
    fo = fs.*c./(c + vr);
end

function [st, sfo] = carSimSnap(v, y, tend, dt, fs, c, Ts)
    [t, fo] = carSimConstantV(v, y, tend, dt, fs, c);
    % Enforce frequency and time resolution due to Fourier
    [st, sfo] = snapResolution(t, fo, Ts);
end

function [ev, ey, efs] = carSpeedEstimator(t, fo)
    % Determine car speed, distance and source frequency.
    % Assumes constant velocity, vy = 0, constant fs, c=343 m/s.
    c = 343;

    % Estimate fs
    fhigh = max(fo);
    flow = min(fo);
    efs = (fhigh + flow)/2; % Approximation for fs, should be within 1% at reasonable speeds.

    % Estimate vr using doppler equation
    evr = efs./fo .*c - c;

    % Find efs crossover frequency
    sgn = 1; % High to low
    if fo(1) < efs
        sgn = -1; % Low to high
    end
    crossInd = 1;
    for i=1:length(fo)
        if sgn*(fo(i) - efs) < 0 % True as soon as fo crosses past efs (high or low depending on sign of velocity)
            crossInd = i; % Could be i or i-1.
            break
        end
    end
    fo = t(crossInd);

    % Estimate vx using high and low frequency
    ev = (evr(end) - evr(1))/2;

    % Find y by estimating slope at fo
    slopevro = (evr(crossInd + 1) - evr(crossInd - 1))./(t(crossInd + 1) - t(crossInd - 1));
    ey = ev^2/slopevro;
end

function [st, sfo] = snapResolution(t, fo, Ts)
    % Subsamples and rounds a time and frequency array to replicate the
    % fixed time*freq resolution of a Fourier analysis spectrogram.
    st = t(1);
    sfo = floor(fo(1)*Ts)/Ts; % fix
    ind = 1;
    curT = t(1);
    for i=2:length(t)
        if t(i) >= (curT + Ts)
            ind = ind + 1;
            st(ind) = t(i);
            sfo(ind) = floor(fo(i)*Ts)/Ts; % Frequency resolution is 1/Ts
            curT = curT + Ts;
        end
    end
end