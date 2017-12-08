%% Ejercicio 5 %%
%Difusión con fuente no estacionario en 2 dimensiones

%Dimensiones
xlim = [0,2];
ylim = [0,1];
%Cantidad de nodos
nx = 10;
ny = 10;
%Espaciamiento
hx = (xlim(2)-xlim(1))/(nx-1);
hy = (ylim(2)-ylim(1))/(ny-1);
%Intervalo
x = xlim(1):hx:xlim(2);
y = ylim(1):hy:ylim(2);
%Difusivo
k = 1;
%Fuente
Q = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
        Q(i,j) = 100*(x(i)+y(j));
    end
end
%Tolerancia
tol = 0.0001;
%Cantidad de iteraciones
nt = 300;
%Condiciones de contorno
r = [10,10,0,10];
t0 = 0;
tipo = ['d','d','n','d'];

%Solucion aproximada con distintos esquemas temporales
[~,~,Te] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,[0 0 0 0],[0 0 0 0],1,1,0,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

[~,~,Ti] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,[0 0 0 0],[0 0 0 0],1,1,1,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

[~,~,Tcn] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,[0 0 0 0],[0 0 0 0],1,1,1/2,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

[~,~,T] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,[0 0 0 0],[0 0 0 0],0,0,-1,nt,tol,t0);
