close all %cierra todas las ventanas

figure;

subplot(3,1,1);
fm = 10;
fs = 11;
[t,y]=senoidal(0,1,1,fm,pi/2,fs);
stem(t,y);

subplot(3,1,2);
S = fft(y);
stem([1:1/(1/fm)],abs(S));

subplot(3,1,3);
%[x,sa]=acomodar_fft(s,T)
[x,sa]=acomodar_fft(S,1/fm);
stem(x,sa);