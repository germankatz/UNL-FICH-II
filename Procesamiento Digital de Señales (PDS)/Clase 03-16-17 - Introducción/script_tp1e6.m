%Scrpt TP1 E6

close all %cierra todas las ventanas

figure %interpoladores
subplot(3,1,1);
[t,y]=senoidal(-10,10,1,50,0,1);
[I]=i_escalon(t);
plot(t,I);
subplot(3,1,2);
[I]=i_lineal(t);
plot(t,I);
subplot(3,1,3);
[I]=i_sinc(t,1);
plot(t,I);

figure %interpolacion
subplot(4,1,1);
[t,y]=senoidal(0,4,1,10,0,0.5);
stem(t,y);
subplot(4,1,2);
[ti,yi]=interpolacion(t,y,4*10,@i_escalon);
plot(ti,yi);
subplot(4,1,3);
[ti,yi]=interpolacion(t,y,4*10,@i_lineal);
plot(ti,yi);
subplot(4,1,4);
[ti,yi]=interpolacion_s(t,y,4*10,0.5,@i_sinc);
plot(ti,yi);