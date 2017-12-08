%% Ejercicio 2 %%
%Difusion-reaccion con fuente estacionaria

%% a)
%Cantidad de nodos
nodos = 10;
L = 1;
xlim = [0,L];
x = xlim(1):1/(nodos-1):xlim(2);
%Difusivo, reactivo y fuente
k = 1;
c = 1;
G = ones(nodos,1)*1;
%Solucion analitica
A = exp(-L)/(exp(L)-exp(-L));
Tx = A*exp(x) - (A+1)*exp(-x) + 1;
figure;
subplot(1,2,1);
scatter(x,Tx);
title('Temperatura');
qx = -k*(A*exp(x) + (A+1)*exp(-x));
subplot(1,2,2);
scatter(x,qx);
title('Flujo de calor');

%% b)
%Valores de contorno
r = [0,1];
%Tipos de contorno
tipo = ['d','d'];

[~,~,T,q] = FDM_1D(xlim,nodos,k,c,0,G,r,tipo,0,0,0,0,-1,0,0,0);
subplot(1,2,1);
hold on
plot(x,T,'r');
hold on
subplot(1,2,2);
hold on
plot(x,q,'r');
hold off

%Error
Error = Tx - T';

%% c)
tipo = ['d' 'r'];
hrobin = 1;
tinf = 0;
%Solucion analitica
A = -1/(2*exp(L));
Tx2 = A*exp(x) - (A+1)*exp(-x) + 1;
figure;
subplot(1,2,1);
scatter(x,Tx2);
title('Temperatura');

qx2 = -k*(A*exp(x) + (A+1)*exp(-x));
subplot(1,2,2);
scatter(x,qx2);
title('Flujo de calor');

[~,~,T2,q2] = FDM_1D(xlim,nodos,k,c,0,G,r,tipo,hrobin,tinf,0,0,-1,0,0,0);
subplot(1,2,1);
hold on
plot(x,T2,'r');
hold on
subplot(1,2,2);
hold on
plot(x,q2,'r');
hold off

Error2 = Tx2 - T2';
