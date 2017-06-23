function [I]=i_sinc(t,fs)
%fm: frecuencia de muestreo
%fs: frecuencia de la senoidal

%t: valores discretos de tiempo
t = 2*pi*fs*t;

n = length(t);
I = zeros(n,1);
for i=1:n
    if t(i)==0
        I(i) = 1;
    else
        I(i) = sin(t(i))/t(i);
    end
end