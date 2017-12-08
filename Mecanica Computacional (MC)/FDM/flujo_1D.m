function [q] = flujo_1D(T,nodos,dx,k,r,tipo,hrobin,tinf)
%flujo_1D Calcula el flujo de calor
%   T: valores de temperaturas ya calculados
%   nodos: cantidad de nodos
%   dx: paso de la malla
%   k: valor del término difusivo
%   r: vector con los valores de contorno
%   tipo: vector con la condición de contorno
%         d -> Dirichlet
%         n -> Neumann
%         r -> Robin
%   hrobin: constante h asociada a la condición de Robin
%   tinf: constante Tinf asociada a la condición de Robin

%Flujo de calor
q = zeros(nodos,1);

%Nodos interiores
for j = 2:nodos-1
    q(j) = -k*(T(j+1)-T(j-1))/(2*dx);
end

%En los bordes
if (tipo(1) == 'd')
    q(1) = -k*(T(2)-T(1))/dx;
elseif (tipo(1) == 'n')
    q(1) = r(1);
else
    q(1) = hrobin*(T(1)-tinf);
end

if (tipo(2) == 'd')
    q(end) = -k*(T(end)-T(end-1))/dx;
elseif (tipo(2) == 'n')
    q(end) = r(2);
else
    q(end) = hrobin*(T(end)-tinf);
end

end