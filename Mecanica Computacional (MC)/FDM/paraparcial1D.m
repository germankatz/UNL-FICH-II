% diferencias finitas 1D

%FDM Método de diferencias finitas para la ecuación de transporte
xlim = [0 1]; %   xlim: vector con los límites del intervalo [x0,xn] 
nodos = 5 %   nodos: cantidad de nodos
k = 1;%   k: valor del término difuso
c = 0;%   c: valor del término reactivo
v = 5;%   v: valor del término convectivo
Q = ones(nodos,1)*0;%   Q: valor de la fuente
r = [100 5]%   r: vector con los valores de contorno
tipo = ['d' 'n']%   tipo: vector con la condición de contorno
%         d -> Dirichlet
%         n -> Neumann
%         r -> Robin
hrobin = 1.2;%   hrobin: constante h asociada a la condición de Robin
tinf = 30;%   tinf: constante Tinf asociada a la condición de Robin
p = 1;%   p: presión, rho
Cp = 1;%   Cp: calor específico
theta = 1;%   theta: parámetro temporal
%          0  -> Forward-Euler (esquema explícito)
%          1  -> Backward-Euler (esquema implícito)
%         1/2 -> Crank-Nicolson (esquema semi-implícito)
%         -1  -> No hay término temporal
nt = 1;%   nt: numero de iteraciones para esquema temporal
tol = 10e-3;%   tol: tolerancia de error para esquema temporal
t0 = 0;%   t0: valor inicial de la temperatura
dx = (xlim(2)-xlim(1))/(nodos-1);
t0 = 100-5.*[xlim(1):dx:xlim(2)]'; % valor de t en tiempo n

[K,f,phi,q] = FDM_1D(xlim,nodos,k,c,v,Q,r,tipo,hrobin,tinf,p,Cp,theta,nt,tol,t0);
