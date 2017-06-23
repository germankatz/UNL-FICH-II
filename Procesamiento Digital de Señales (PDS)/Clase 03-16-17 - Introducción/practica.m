% Ejercicios de parcialitos

close all %cierra todas las ventanas

figure
subplot(3,1,1);
[t,y1]=senoidal(0,3,1,200,0,30);
plot(t,y1);

subplot(3,1,2);
[t,y2]=senoidal(0,3,1,200,0,1);
plot(t,y2);

% Ambas señales deben muestrearse con la misma frecuencia

subplot(3,1,3);
plot(t,y1.*y2);

figure

subplot(4,1,1);
[t,y1]=senoidal(0,0.1,1,1500,0,200);
plot(t,y1);

subplot(4,1,2);
[t,y2]=senoidal(0,0.1,1,1500,0,300);
plot(t,y1);

subplot(4,1,3);
plot(t,y1+y2);

[t,f1]=senoidal(0,0.1,1,1500,0,200);
[t,f2]=senoidal(0,0.1,1,1500,0,300);
t=linspace(0,1500,150);
subplot(4,1,4);
plot(t,abs(f1.*f1));

figure % Operaciones unitarias sobre señales
% Reversión
subplot(3,3,2);
[t,y]=senoidal(0,10,1,50,0,1);
stem(t,y);
subplot(3,3,1);
stem(-t,y);
% Inversión
subplot(3,3,4);
stem(t,y);
subplot(3,3,5);
stem(t,-y);
% Rectificación de media onda y de onda completa
subplot(3,3,7)
stem(t,y)
subplot(3,3,8)
stem(t,subplus(y))
subplot(3,3,9)
stem(t,abs(y))

figure

