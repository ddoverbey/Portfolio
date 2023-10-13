function [pxx,pburgFreqs] = psdTool(x,fs,order)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[pxx, pburgFreqs] = pburg(x, order, length(x), fs);
[X, fourierFreqs] = fdomainsingle(x, fs);
fourierIntegral = sum(X.*conj(X));
pburgIntegral = sum(pxx);
coeff = fourierIntegral/pburgIntegral;

pxx = coeff * pxx;
end