function [phi] = fdm_semi_implicito(K,f,nodos,x,r,tipo,p,Cp,dt,nt,tol,t0)
%FDM_semi_implicito Esquema temporal de Crank Nicolson
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

%Vector para instante actual
%phi_n = ones(nodos,1)*t0;
phi_n = t0;
if (tipo(1) == 'd')
    phi_n(1) = r(1);
end
if (tipo(2) == 'd')
    phi_n(end) = r(2);
end

%Matriz identidad
I = eye(nodos);
%Guardo una copia de la matriz K y del vector f
K0 = K;
f0 = f;
%Modifico la matriz K agregando valores a la diagonal
K = (p*Cp/dt)*I + 0.5*K0;

%Bandera para saber si llego a un estado estacionario
no_est = 1;

%Bucle temporal
err = 1;
ti = 0;
disp('Metodo de integracion Crank Nicholson');
figure;
while (ti<nt && err>tol)
    ti = ti + 1;
    
    %Actualizo el vector f en cada instante de tiempo
    f = f0 + ((p*Cp/dt)*I - 0.5*K0)*phi_n;
    %Vuelvo a setear las condiciones de borde en caso de ser Dirichlet
    if (tipo(1) == 'd')
        K(1,1) = 1;
        f(1) = r(1);
    end
    if (tipo(2) == 'd')
        K(end,end) = 1;
        f(end) = r(2);
    end
    
    %Resolucion del sistema
    phi = K\f;
    
    plot(x,phi,'b');
    title('Esquema semi-implicito - Crank Nicolson');
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