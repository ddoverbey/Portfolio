function i = time2ind(t,fs)
%time2ind converts a time t into the closest corresponding index in time
%series data, assuming that data starts at t=0.
    i = floor(t*fs)+1;
end