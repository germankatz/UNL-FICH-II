%% Ejercicio 7 %%
%Advección-Difusión-Reacción con fuente no estacionario

%Cantidad de nodos
nodos = 10;
xlim = [0,1];
h = (xlim(2)-xlim(1))/(nodos-1);
x = xlim(1):h:xlim(2);
%Valores de contorno
r = [0,0];
%Tipos de contorno
tipo = ['r','d'];

%Difusivo
k = 1;
%Reactivo
c = 2;
%Fuente
Q = ones(nodos,1) * 50;
%Convectivo
v = 10;
%Constantes de Robin
hrobin = 0.2;
tinf = 100;
%Constantes para esquema temporal
nt = 300;
t0 = 0;
tol = 0.0001;

%Solucion aproximada con distintos esquemas temporales
theta = [-1 0 1 1/2];
T = zeros(nodos,4);
for i = 1:4
    [~,~,T(:,i),~] = FDM_1D(xlim,nodos,k,c,v,Q,r,tipo,hrobin,tinf,1,1,theta(i),nt,tol,t0);
end
