%Scrpt TP1 E3

close all %cierra todas las ventanas

tini=0; %observacion
tfin=0.1; %observacion
A = 3; %observacion
fm = 800; %(40*2)/0.1
fi = -2*pi*20*5/800; %5/800 [s]
fs = 20; %2/0.1
[t,y]=senoidal(tini,tfin,A,fm,fi,fs);
stem(t,y);