%Scrpt TP3 E2

close all %cierra todas las ventanas

figure

%[t,y]=senoidal(tini,tfin,A,fm,phi,fs)
[t,sen1]=senoidal(-2,2,1,25,0,1);
[t,sen2]=senoidal(-2,2,1,25,-pi/2,2);
[t,sen3]=senoidal(-2,2,1,25,0,1);
[t,sen4]=senoidal(-2,2,1,25,0,1);
sen4 = -sen4;


subplot(5,1,1);
stem(t,sen1);

subplot(5,1,2);
stem(t,sen2);

subplot(5,1,3);
stem(t,sen1.*sen3);

subplot(5,1,4);
stem(t,sen1.*sen2);

subplot(5,1,5)
stem(t,sen1.*sen4);