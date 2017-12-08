function [K] = MatCondNatIN(xnode,kx,ky)
%xnode es del elemento en particular.

    k = [kx 0;0 ky];
    if (size(xnode,1) == 3) % elemento triangular
        J = [xnode(2,1)-xnode(1,1)  xnode(2,2)-xnode(1,2);
             xnode(3,1)-xnode(1,1)  xnode(3,2)-xnode(1,2)];
        DN = [-1 1 0;-1 0 1];
        V = inv(J)*DN;
        A = 0.5;
        K = (V'*k*V)*det(J)*A;
    else % elemento cuadrangulo
        % funcion en linea, con @ expreso una funcion.
        DN = @(s,t)[(-1+t)/4,( 1-t)/4,( 1+t)/4,(-1-t)/4;
                    (-1+s)/4,(-1-s)/4,( 1+s)/4,( 1-s)/4]; 
        
        % cuatro puntos de Gauss con peso w=1
        p = sqrt(3)/3;
        pospg = [-p,p]; %puntos de gauss a plicados en raiz 3/3
        K = zeros(4,4);
        
        %recorro los 4 puntos de gauss
        for i=1:2
            for j=1:2
                DNnum = DN(pospg(i),pospg(j)); %aca uso la funion en linea y la evaluo en los puntos
                J = DNnum*xnode; %jacobiano en cada pto de gauss
                V = inv(J)*DNnum;% la B del apunte
                K = K + V'*k*V*det(J); % Kc utilizada 
            end
        end
    end
end