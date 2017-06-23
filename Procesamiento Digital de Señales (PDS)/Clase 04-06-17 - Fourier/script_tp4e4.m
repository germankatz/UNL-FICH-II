%Script TP4 E4

close all %cierra todas las ventanas

subplot(3,1,1);
%[t,y]=senoidal(tini,tfin,A,fm,fi,fs)
[t,y]=senoidal(0,1,1,100,0,1);
stem(t,y);

subplot(3,1,2);
oR = v_hamming(y,25,50);
stem(t,oR);

subplot(3,1,3);
OR = fft(oR);
[x,ORa]=acomodar_fft(OR,1/100);
stem(x,ORa);