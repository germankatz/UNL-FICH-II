%Scrpt TP4 E3

close all %cierra todas las ventanas

figure;

tini = 0;
tfin = 1;
fs = 5;
A = 1;
fi = 0;
fm = 100;

%[t,y]=senoidal(tini,tfin,A,fm,fi,fs)
[t,y]=senoidal(tini,tfin,A,fm,fi,fs);

subplot(3,1,1);
stem(t,y);

subplot(3,1,2);
Y = fft(y);
[x,Ya]=acomodar_fft(Y,1/fm);
stem(x,Ya);

subplot(3,1,3);
Y = retardo(Y,10);
y = ifft(Y);
stem(t,y);