function [x,sa]=acomodar_fft(s,T)

n = length(s);
fm = 1/T;
delta_s = fm/n;
s = abs(s);
if (mod(n,2)==0)
    sa=[s(n/2+1:end) s(1:n/2)];
    x=[-fm/2:delta_s:fm/2-delta_s];
else
    sa=[s(ceil(n/2)+1:end) s(1:floor(n/2)+1)];
    x=[ceil(-fm/2):delta_s:floor(fm/2)];
end