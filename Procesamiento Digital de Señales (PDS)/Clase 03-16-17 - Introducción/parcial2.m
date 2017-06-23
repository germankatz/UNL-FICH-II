close all %cierra todas las ventanas

figure %senoidal

subplot(2,1,1);
fm = 10;
fs = 11;
[t,y]=senoidal(0,1,1,fm,-pi/2,fs);
stem(t,y);

subplot(2,1,2);
S = fft(y);
stem([1:1/(1/fm)],abs(S));