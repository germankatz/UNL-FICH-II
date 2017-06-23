%Script TP4 E5

close all %cierra todas las ventanas

figure;

%[t,y]=senoidal(tini,tfin,A,fm,fi,fs)
tini = 0;
tfin = 1;
A = 2;
fm = 50;
fi = 0;
fs = 5;
[t,y]=senoidal(tini,tfin,A,fm,fi,fs);
subplot(4,1,1);
stem(t,y);

subplot(4,1,2);
n = length(t);
Y = fft(y);
stem([1:fm/n:n],abs(Y));

subplot(4,1,3);
[x,Ya]=acomodar_fft(Y,T);
stem(x,Ya);

subplot(4,1,4);
y = ifft(Y);
stem(t,y);