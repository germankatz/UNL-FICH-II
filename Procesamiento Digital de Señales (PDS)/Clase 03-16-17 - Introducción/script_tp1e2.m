%Scrpt TP1 E2

close all %cierra todas las ventanas

figure %inversion
subplot(1,2,2);
[t,y]=senoidal(0,10,1,50,0,1);
stem(t,y);
subplot(1,2,1);
[t,y]=inversion(0,10,1,50,0,1);
stem(t,y);

figure %rectificacion
subplot(3,1,1);
[t,y]=senoidal(0,10,1,50,0,1);
stem(t,y);
subplot(3,1,2);
[t,y]=r_media_onda(0,10,1,50,0,1);
stem(t,y);
subplot(3,1,3);
[t,y]=r_onda_completa(0,10,1,50,0,1);
stem(t,y);

figure %cuantización en 8 niveles
subplot(2,1,1);
[t,y]=senoidal(0,4,1,20,0,1);
plot(t,y);
subplot(2,1,2);
[t,y]=cuant_8_niveles(8,2/8,0,4,1,20,0,1);
stem(t,y);