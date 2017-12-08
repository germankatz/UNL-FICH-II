function [phi] = fdm_explicito_2D(K,f,nodos,x,y,r,tipo,p,Cp,dt,nt,tol,t0)
%FDM_explicito Esquema temporal de Forward Euler
%   K: matriz del sistema
%   f: vector del sistema
%   nodos: cantidad de nodos en x e y -> [nx,ny]
%   x: dominio del sistema en x
%   y: dominio del sistema en y
%   r: vector con los valores de contorno
%   tipo: vector con la condición de contorno
%   p: presion
%   Cp: calor específico
%   dt: paso del tiempo
%   nt: numero de iteraciones para esquema temporal
%   tol: tolerancia de error para esquema temporal
%   t0: valor inicial de la temperatura

%Cantidad de nodos
nx = nodos(1);
ny = nodos(2);
n = nx*ny;

%Constante del esquema temporal
A = dt/(p*Cp);
%Matriz identidad
I = eye(n);

%Vectores para instante actual y siguiente
phi_n = ones(n,1)*t0;
phi = zeros(n,1);

[K,f,phi_n] = dirichlet_2D(K,f,phi_n,nx,ny,r,tipo,'p');

%Bandera para saber si llego a un estado estacionario
no_est = 1;

%Bucle temporal
err = 1;
ti = 0;
disp('Metodo de integracion explicito');
figure;
while (ti<nt && err>tol)
    ti = ti + 1;
    
    phi = A*f + (I - A*K)*phi_n;
    
    %Vuelvo a setear las condiciones de borde en caso de ser Dirichlet
    [K,f,phi] = dirichlet_2D(K,f,phi,nx,ny,r,tipo,'p');
    
    phi_grid = reshape(phi,ny,nx);
    surf(x,y,phi_grid);
    xlabel('Eje x'); ylabel('Eje y');
    title('Esquema explícito - Forward Euler');
    drawnow;
    
    err = norm(phi-phi_n,2)/norm(phi_n,2);
    if (err < tol)
        no_est = 0;
    end
    
    phi_n = phi;
end

if (no_est)
    disp ('La solucion no llego a un estado estacionario, se requieren mas pasos de simulacion');
else
    disp ('La solucion ha llegado a un estado estacionario');
    fprintf('Los pasos realizados fueron: %d\n',ti);
    fprintf('El tiempo transcurrido fue de: %f segundos\n',ti*dt);
end

end