%% Ejercicio 8 %%

%Discretizacion en x
xlim = [0,60];
nx = 10;
dx = (xlim(2)-xlim(1))/(nx-1);
x = xlim(1):dx:xlim(2);
%Discretizacion en y
ylim = [0,80];
ny = 12;
dy = (ylim(2)-ylim(1))/(ny-1);
y = ylim(1):dy:ylim(2);

%Presión y calor especifico
p = 2700;
Cp = 0.9;
%Difusivo
k = 237;
%Fuente
Q = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
        if ((x(i) >= 20) && (x(i) <= 40))
            if (((y(j) >= 20) && (y(j) <= 30)) || ((y(j) >= 50) && (y(j) <= 60)))
                Q(i,j) = 100;
            end
        end
    end
end
                
%Condiciones de frontera
r = [0,100,0,0];
tipo = ['n','d','r','n'];
hrobin = [0,0,25,0];
Tamb = [0,0,20,0];

%Temporal
nt = 300;
tol = 0.0001;
t0 = 0;

%Solucion aproximada con distintos esquemas temporales
[~,~,Te] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,hrobin,Tamb,p,Cp,0,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

[~,~,Ti] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,hrobin,Tamb,p,Cp,1,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

[~,~,Tcn] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,hrobin,Tamb,p,Cp,1/2,nt,tol,t0);
fprintf('Presione una tecla para continuar \n\n');
pause;

[~,~,T] = FDM_2D(xlim,ylim,[nx ny],k,0,Q,r,tipo,hrobin,Tamb,p,Cp,-1,nt,tol,t0);
