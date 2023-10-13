function [power,t] = rmsPower(x,fs,nsamps)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
nblocks = floor(length(x)/nsamps);
power = zeros(1,nblocks);
t = zeros(1,nblocks);
for i=1:nblocks
    power(i) = sqrt(sum(x((i-1)*nsamps+1:i*nsamps).^2)./nsamps);
    t(i) = (i-1)*nsamps/fs;
end
end