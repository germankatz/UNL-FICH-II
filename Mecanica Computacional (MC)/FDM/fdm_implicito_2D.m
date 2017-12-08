function [phi] = fdm_implicito_2D(K,f,nodos,x,y,r,tipo,p,Cp,dt,nt,tol,t0)
%fdm_implicito Esquema temporal de Backward Euler
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

%Vector para instante actual
phi_n = ones(n,1)*t0;
[K,f,phi_n] = dirichlet_2D(K,f,phi_n,nx,ny,r,tipo,'p');

%Matriz identidad
I = eye(n);
%Modifico la matriz K agregando valores a la diagonal
K = K + (p*Cp/dt)*I;
%Guardo una copia del vector f
f0 = f;

%Bandera para saber si llego a un estado estacionario
no_est = 1;

%Bucle temporal
err = 1;
ti = 0;
disp('Metodo de integracion implicito');
figure;
while (ti<nt && err>tol)
    ti = ti + 1;
    
    %Actualizo el vector f en cada instante de tiempo
    f = f0 + (p*Cp/dt)*phi_n;
    %Vuelvo a setear las condiciones de borde en caso de ser Dirichlet
    [K,f,phi_n] = dirichlet_2D(K,f,phi_n,nx,ny,r,tipo,'s');
    
    %Resolucion del sistema
    phi = K\f;
    
    phi_grid = reshape(phi,ny,nx);
    surf(x,y,phi_grid);
    xlabel('Eje x'); ylabel('Eje y');
    title('Esquema implicito - Backward Euler');
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