%Scrpt TP1 E5

close all %cierra todas las ventanas

subplot(2,1,1);
[t,y]=senoidal(0,2,1,129,0,4000);
stem(t,y);
subplot(2,1,2);
[t,y]=senoidal(0,2,1,129,0,1);
stem(t,y);