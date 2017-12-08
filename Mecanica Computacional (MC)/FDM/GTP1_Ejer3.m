%% Ejercicio 3 %%
%Difusion con fuente no estacionaria

%% a)
%Cantidad de nodos
nodos = 10;
xlim = [0,1];
h = (xlim(2)-xlim(1))/(nodos-1);
x = xlim(1):h:xlim(2);
%Difusivo y fuente
k = 1;
G = 100*x;
%Valores iniciales
r = [1,0];
tipo = ['d','d'];
nt = 150;
t0 = 0;
tol = 0.0001;

%Solucion analitica
Tx = (-50/3)*(x.^3) + (47/3)*x + 1;

%Solucion aproximada con distintos esquemas temporales
[~,~,Te,~] = FDM_1D(xlim,nodos,k,0,0,G,r,tipo,0,0,1,1,0,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;
 
[~,~,Ti,~] = FDM_1D(xlim,nodos,k,0,0,G,r,tipo,0,0,1,1,1,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

[~,~,Tcn,~] = FDM_1D(xlim,nodos,k,0,0,G,r,tipo,0,0,1,1,1/2,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

figure;
plot(x,Te,'+r--',x,Ti,'*g--',x,Tcn,'xb--',x,Tx,'k');
legend('Metodo explicito','Metodo implicito','Crank Nicholson','Analitica');
