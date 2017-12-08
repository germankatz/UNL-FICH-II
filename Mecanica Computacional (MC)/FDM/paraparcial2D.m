% diferencias finitas 2D

%FDM_2D Método de diferencias finitas para la ecuación de transporte en 2D

Lx = 1;
Ly = 1;
xlim = [0 Lx];%   xlim: vector con los límites del intervalo en x -> [x0,xn]
ylim = [0 Ly];%   ylim: vector con los limites del intervalo en y -> [y0,yn]
nx = 3;
ny = 3;
nodos = [nx ny];%   nodos: cantidad de nodos en x e y -> [nx,ny]
hx = (xlim(2)-xlim(1))/(nx-1);
hy = (ylim(2)-ylim(1))/(ny-1);
x = xlim(1):hx:xlim(2);
y = ylim(1):hy:ylim(2);
Q = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
        %Q(i,j) = 2*(x(i)^2+y(j)^2);
        Q(i,j) = 75;
    end
end
k = 2;%   k: valor del término difuso
c = 0;%   c: valor del término reactivo
%Q = 100;%   Q: valor de la fuente
r = [2 0 30 100];%   r: vector con los valores de contorno
%   r: valores de contorno  -> [(x,y0),(xL,y),(x,yL),(x0,y)]
tipo = ['n' 'n' 'd' 'd'];%   tipo: tipos de contorno -> [inf,der,sup,izq] = [sur,este,norte,oeste]
hrobin = [0 0 0 0];%   hrobin: constante h asociada a la condición de Robin
tinf = [0 0 0 0];%   tinf: constante Tinf asociada a la condición de Robin
p = 1;%   p: presión
Cp = 1;%   Cp: calor específico
theta = -1;%   theta: parámetro temporal
%          0  -> Forward-Euler (esquema explícito)
%          1  -> Backward-Euler (esquema implícito)
%         1/2 -> Crank-Nicolson (esquema semi-implícito)
%         -1  -> No hay término temporal
nt = 30;%   nt: numero de iteraciones para esquema temporal
tol = 1e-3;%   tol: tolerancia de error para esquema temporal
t0 = 0;%   t0: valor inicial de la temperatura
%dx = (xlim(2)-xlim(1))/(nodos-1);
%t0 = 100-5.*[xlim(1):dx:xlim(2)]';

[K,f,phi] = FDM_2D(xlim,ylim,nodos,k,c,Q,r,tipo,hrobin,tinf,p,Cp,theta,nt,tol,t0);

% Forma de numeracion de los nodos
% 3 6 9
% 2 5 8
% 1 4 7