function [phi] = fdm_explicito(K,f,nodos,x,r,tipo,p,Cp,dt,nt,tol,t0)
%FDM_explicito Esquema temporal de Forward Euler
%   K: matriz del sistema
%   f: vector del sistema
%   nodos: cantidad de nodos
%   x: dominio del sistema
%   r: vector con los valores de contorno
%   tipo: vector con la condición de contorno
%   p: presion
%   Cp: calor específico
%   dt: paso del tiempo
%   nt: numero de iteraciones para esquema temporal
%   tol: tolerancia de error para esquema temporal
%   t0: valor inicial de la temperatura

%Constante del esquema temporal
A = dt/(p*Cp);
%Matriz identidad
I = eye(nodos);

%Vectores para instante actual y siguiente
%phi_n = ones(nodos,1)*t0;
phi_n = t0;
phi = zeros(nodos,1);

%Bandera para saber si llego a un estado estacionario
no_est = 1;

%Bucle temporal
err = 1;
ti = 0;
disp('Metodo de integracion explicito');
figure;
while (ti<nt && err>tol)
    ti = ti + 1;
    
    if (tipo(1) == 'd')
        phi_n(1) = r(1);
    end
    if (tipo(2) == 'd')
        phi_n(end) = r(2);
    end
    
    phi = A*f + (I - A*K)*phi_n;
    
    plot(x,phi,'b');
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