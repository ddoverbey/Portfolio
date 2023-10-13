
% when x or y was on this line, the length was reduced to 6 for no
% reason at all
x = [-6 -4 -2 0 2 4 6]
y = [87.5 12.5 87.5 37.5 87.5 12.5 87.5];
% fft(x);

stem(x, y) 
xlabel('Hz')
ylabel('X')