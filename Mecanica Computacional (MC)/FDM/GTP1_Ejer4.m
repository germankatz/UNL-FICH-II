%% Ejercicio 4 %%
%Difusion con fuente en dos dimensiones

%% a)
%Dimensiones
Lx = 3;
Ly = 1;
xlim = [0,Lx];
ylim = [0,Ly];
%Cantidad de nodos
nx = 20; %hx = 0.5;
ny = 15; %hy = 0.25;
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
        Q(i,j) = 2*(x(i)^2+y(j)^2);
    end
end
%Condiciones de contorno
r1 = [0,0,0,0];
tipo1 = ['d','d','d','d'];
%Solucion
[K1,f1,T1] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r1,tipo1,[0 0 0 0],[0 0 0 0],0,0,-1,0,0,0);

%% b)
r2 = [100,100,100,100];
tipo2 = ['d','d','d','d'];
[K2,f2,T2] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r2,tipo2,[0 0 0 0],[0 0 0 0],0,0,-1,0,0,0);

%% c)
r3 = [0,100,100,100];
tipo3 = ['n','d','d','d'];
[K3,f3,T3] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r3,tipo3,[0 0 0 0],[0 0 0 0],0,0,-1,0,0,0);
