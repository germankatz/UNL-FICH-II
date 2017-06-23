%Scrpt TP1 E4

close all %cierra todas las ventanas

subplot(6,1,1);
[t,y]=senoidal(0,1,1,100,0,5);
stem(t,y);
subplot(6,1,2);
[t,y]=senoidal(0,1,1,25,0,5);
stem(t,y);
subplot(6,1,3);
[t,y]=senoidal(0,1,1,10,pi/2,5);
stem(t,y);
subplot(6,1,4);
[t,y]=senoidal(0,1,1,4,0,5);
stem(t,y);
subplot(6,1,5);
[t,y]=senoidal(0,1,1,1,0,5);
stem(t,y);
subplot(6,1,6);
[t,y]=senoidal(0,1,1,0.5,0,5);
stem(t,y);