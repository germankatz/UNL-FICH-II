%% Ejercicio 1 %%
%Difusion con fuente estacionaria

%% a)
%Cantidad de nodos
nodos = 10;
xlim = [0,1];
x = xlim(1):1/(nodos-1):xlim(2);
%Difusivo y fuente
k = 2;
G = ones(nodos,1)*10;
%Solucion analitica
Tx = -5/2*x.^2 + 3/2*x + 1;
figure;
subplot(1,2,1);
scatter(x,Tx);
title('Temperatura');

%% b)
qx = -k*(-5*x + 3/2);
subplot(1,2,2);
scatter(x,qx);
title('Flujo de calor');

%% c)
%T(i-1)-2*T(i)+T(i+1) = -G*h^2/k

%% d)
%Valores de contorno
r = [1,0];
%Tipos de contorno
tipo = ['d','d'];

[~,~,T,q] = FDM_1D(xlim,nodos,k,0,0,G,r,tipo,0,0,0,0,-1,0,0,0);
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

%% e)
tipo = ['d' 'n'];
%Solucion analitica
Tx2 = -5/2*x.^2 + 5*x + 1;
figure;
subplot(1,2,1);
scatter(x,Tx2);
title('Temperatura');

qx2 = -k*(-5*x + 5);
subplot(1,2,2);
scatter(x,qx2);
title('Flujo de calor');

[~,~,T2,q2] = FDM_1D(xlim,nodos,k,0,0,G,r,tipo,0,0,0,0,-1,0,0,0);
subplot(1,2,1);
hold on
plot(x,T2,'r');
hold on
subplot(1,2,2);
hold on
plot(x,q2,'r');
hold off

Error2 = Tx2 - T2';
