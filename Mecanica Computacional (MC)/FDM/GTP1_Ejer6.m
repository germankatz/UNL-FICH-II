%% Ejercicio 6 %%
%Adveccion - Difusion

%% a)
%Cantidad de nodos
nodos = 10;
xlim = [0,1];
h = (xlim(2)-xlim(1))/(nodos-1);
x = xlim(1):h:xlim(2);
%Valores de contorno
r = [1,0];
%Tipos de contorno
tipo = ['d','d'];

%Solucion analitica expresada en funcion de k y v
% Peclet -> Pe = v*dx/2*k
% T(x) = ((1-exp(2*Pe*x)) / (exp(2*Pe)-1)) + 1

%% b)
%Difusivo y convectivo
k = 1;
v = 1;
Q = zeros(nodos,1);
%Peclet
Pe = v/(2*k);
%Solucion analitica
Tx = (1-exp(2*Pe*x))/(exp(2*Pe)-1) + 1;
qx = -k*((-2*Pe*exp(2*Pe*x))/(exp(2*Pe)-1));

figure(1);
subplot(1,2,1);
plot(x,Tx);
title('Temperatura');
subplot(1,2,2);
plot(x,qx);
title('Flujo de calor');

%Solucion aproximada
[~,~,T,q] = FDM_1D(xlim,nodos,k,0,v,Q,r,tipo,0,0,0,0,-1,0,0,0);

subplot(1,2,1);
hold on
plot(x,T,'r');
hold on
subplot(1,2,2);
hold on
plot(x,q,'r');
hold off

%% c)
k = 0.1;
Pe = v/(2*k);
%Solucion analitica
Tx = (1-exp(2*Pe*x))/(exp(2*Pe)-1) + 1;
qx = -k*((-2*Pe*exp(2*Pe*x))/(exp(2*Pe)-1));
%Solucion aproximada
[~,~,T,q] = FDM_1D(xlim,nodos,k,0,v,Q,r,tipo,0,0,0,0,-1,0,0,0);

figure(2);
subplot(1,2,1);
plot(x,Tx);
title('Temperatura');
subplot(1,2,2);
plot(x,qx);
title('Flujo de calor');
subplot(1,2,1);
hold on
plot(x,T,'r');
hold on
subplot(1,2,2);
hold on
plot(x,q,'r');
hold off

k = 0.01;
Pe = v/(2*k);
%Solucion analitica
Tx = (1-exp(2*Pe*x))/(exp(2*Pe)-1) + 1;
qx = -k*((-2*Pe*exp(2*Pe*x))/(exp(2*Pe)-1));
%Solucion aproximada
[~,~,T,q] = FDM_1D(xlim,nodos,k,0,v,Q,r,tipo,0,0,0,0,-1,0,0,0);

figure(3);
subplot(1,2,1);
plot(x,Tx);
title('Temperatura');
subplot(1,2,2);
plot(x,qx);
title('Flujo de calor');
subplot(1,2,1);
hold on
plot(x,T,'r');
hold on
subplot(1,2,2);
hold on
plot(x,q,'r');
hold off
