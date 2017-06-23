%Scrpt TP1 E1

close all %cierra todas las ventanas

figure %senoidal
subplot(2,2,1);
[t,y]=senoidal(0,10,1,50,0,1);
stem(t,y);
subplot(2,2,2);
[t,y]=senoidal(0,10,1,25,0,0.1);
stem(t,y);
subplot(2,2,3);
[t,y]=senoidal(0,1/10,1,100,-pi/4,50);
stem(t,y);
subplot(2,2,4);
[t,y]=senoidal(0,10,1,25,pi/2,0.5);
stem(t,y);

figure %sinc
subplot(3,1,1);
[I]=i_sinc(t,0.1);
stem(t,I);
subplot(3,1,2);
[I]=i_sinc(t,1);
stem(t,I);
subplot(3,1,3);
[I]=i_sinc(t,50);
stem(t,I);

figure %cuadrada
subplot(3,1,1);
[t,y]=cuadrada(100,1,0);
stem(t,y);
subplot(3,1,2);
[t,y]=cuadrada(100,50,-pi/2);
stem(t,y);
subplot(3,1,3);
[t,y]=cuadrada(50,1,pi/2);
stem(t,y);