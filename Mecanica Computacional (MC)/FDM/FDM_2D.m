function [K,f,phi] = FDM_2D(xlim,ylim,nodos,k,c,Q,r,tipo,hrobin,tinf,p,Cp,theta,nt,tol,t0)
%FDM_2D Método de diferencias finitas para la ecuación de transporte en 2D
%   xlim: vector con los límites del intervalo en x -> [x0,xn]
%   ylim: vector con los limites del intervalo en y -> [y0,yn]
%   nodos: cantidad de nodos en x e y -> [nx,ny]
%   k: valor del término difuso
%   c: valor del término reactivo
%   Q: valor de la fuente
%   r: vector con los valores de contorno
%   r: valores de contorno  -> [(x,y0),(xL,y),(x,yL),(x0,y)]
%   tipo: tipos de contorno -> [inf,der,sup,izq] = [sur,este,norte,oeste]
%   hrobin: constante h asociada a la condición de Robin
%   tinf: constante Tinf asociada a la condición de Robin
%   p: presión
%   Cp: calor específico
%   theta: parámetro temporal
%          0  -> Forward-Euler (esquema explícito)
%          1  -> Backward-Euler (esquema implícito)
%         1/2 -> Crank-Nicolson (esquema semi-implícito)
%         -1  -> No hay término temporal
%   nt: numero de iteraciones para esquema temporal
%   tol: tolerancia de error para esquema temporal
%   t0: valor inicial de la temperatura

nx = nodos(1);
ny = nodos(2);

dx = (xlim(2)-xlim(1))/(nx-1);
dy = (ylim(2)-ylim(1))/(ny-1);

dx2 = dx^2;
dy2 = dy^2;

% if (nx < ny)
%     aux = ny;
%     ny = nx;
%     nx = aux;
%     Q = G';
% else
%     Q = G;
% end

K = eye(nx*ny);
f = zeros(nx*ny,1);

for i = 1:nx
    for j = 1:ny
        p = (i-1)*ny + j;
        if ((i ~= 1) && (j ~= 1) && (i ~= nx) && (j ~= ny)) %Nodos interiores
            K(p,p-ny) = -k/dx2;
            K(p,p+ny) = -k/dx2;
            K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
            K(p,p-1) = -k/dy2;
            K(p,p+1) = -k/dy2;
            f(p) = Q(i,j);
        else %Nodos fronteras
            if (j == 1) %FRONTERA INFERIOR (SUR)
                if (i == 1) %ESQUINA INFERIOR IZQUIERDA
                    if ((tipo(1) == 'n') && (tipo(4) == 'n')) %Neumann-Neumann
                        %Esquina inferior izquierda N-N
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(4) - (2/dy)*r(1);
                    elseif ((tipo(1) == 'n') && (tipo(4) == 'r')) %Neumann-Robin
                        %Esquina inferior izquierda N-R
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(4);
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dy)*r(1) + (2/dx)*hrobin(4)*tinf(4);
                    elseif ((tipo(1) == 'r') && (tipo(4) == 'n')) %Robin-Neumann
                        %Esquina inferior izquierda R-N
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dy)*hrobin(1);
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(4) + (2/dy)*hrobin(1)*tinf(1);
                    elseif ((tipo(1) == 'r') && (tipo(4) == 'r')) %Robin-Robin
                        %Esquina inferior izquierda R-R
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(4) + (2/dy)*hrobin(1);
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) + (2/dx)*hrobin(4)*tinf(4) + (2/dy)*hrobin(1)*tinf(1);
                    elseif ((tipo(1) == 'd') && (tipo(4) == 'd')) %Dirichlet-Dirichlet
                        %Esquina inferior izquierda D-D
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = (r(1)+r(4))/2;
                    elseif ((tipo(1) == 'd') || (tipo(4) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina inferior izquierda con alguna Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        if (tipo(1) == 'd')
                            f(p) = r(1);
                        else
                            f(p) = r(4);
                        end
                    end
                elseif ((i ~= 1) && (i ~= nx)) %INTERIOR FRONTERA INFERIOR
                    if (tipo(1) == 'n')
                        %Interior de la frontera inferior con Neumann
                        K(p,p-ny) = -k/dx2;
                        K(p,p+ny) = -k/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dy)*r(1);
                    elseif (tipo(1) == 'r')
                        %Interior de la frontera inferior con Robin
                        K(p,p-ny) = -k/dx2;
                        K(p,p+ny) = -k/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dy)*hrobin(1);
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) + (2/dy)*hrobin(1)*tinf(1);
                    elseif (tipo(1) == 'd')
                        %Interior de la frontera inferior con Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = r(1);
                    end
                elseif (i == nx) %ESQUINA INFERIOR DERECHA
                    if ((tipo(1) == 'n') && (tipo(2) == 'n')) %Neumann-Neumann
                        %Esquina inferior derecha N-N
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(2) - (2/dy)*r(1);
                    elseif ((tipo(1) == 'n') && (tipo(2) == 'r')) %Neumann-Robin
                        %Esquina inferior derecha N-R
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(2);
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dy)*r(1) + (2/dx)*hrobin(2)*tinf(2);
                    elseif ((tipo(1) == 'r') && (tipo(2) == 'n')) %Robin-Neumann
                        %Esquina inferior derecha R-N
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dy)*hrobin(1);
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(2) + (2/dy)*hrobin(1)*tinf(1);
                    elseif ((tipo(1) == 'r') && (tipo(2) == 'r')) %Robin-Robin
                        %Esquina inferior derecha R-R
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(2) + (2/dy)*hrobin(1);
                        K(p,p+1) = -(2*k)/dy2;
                        f(p) = Q(i,j) + (2/dx)*hrobin(2)*tinf(2) + (2/dy)*hrobin(1)*tinf(1);
                    elseif ((tipo(1) == 'd') && (tipo(2) == 'd')) %Dirichlet-Dirichlet
                        %Esquina inferior derecha D-D
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = (r(1)+r(2))/2;
                    elseif ((tipo(1) == 'd') || (tipo(2) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina inferior derecha con alguna Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        if (tipo(1) == 'd')
                            f(p) = r(1);
                        else
                            f(p) = r(2);
                        end
                    end
                end
            end
            if (i == nx) %FRONTERA DERECHA (ESTE)
                if ((j ~= 1) && (j ~= ny)) %INTERIOR FRONTERA DERECHA
                    if (tipo(2) == 'n')
                        %Interior de la frontera derecha con Neumann
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p-1) = -k/dy2;
                        K(p,p+1) = -k/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(2);
                    elseif (tipo(2) == 'r')
                        %Interior de la frontera derecha con Robin
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(2);
                        K(p,p-1) = -k/dy2;
                        K(p,p+1) = -k/dy2;
                        f(p) = Q(i,j) + (2/dx)*hrobin(2)*tinf(2);
                    elseif (tipo(2) == 'd')
                        %Interior de la frontera derecha con Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = r(2);
                    end
                elseif (j == ny) %ESQUINA SUPERIOR DERECHA
                    if ((tipo(2) == 'n') && (tipo(3) == 'n')) %Neumann-Neumann
                        %Esquina superior derecha N-N
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(2) - (2/dy)*r(3);
                    elseif ((tipo(2) == 'n') && (tipo(3) == 'r')) %Neumann-Robin
                        %Esquina superior derecha N-R
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dy)*hrobin(3);
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(2) + (2/dy)*hrobin(3)*tinf(3);
                    elseif ((tipo(2) == 'r') && (tipo(3) == 'n')) %Robin-Neumann
                        %Esquina superior derecha R-N
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(2);
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dy)*r(3) + (2/dx)*hrobin(2)*tinf(2);
                    elseif ((tipo(2) == 'r') && (tipo(3) == 'r')) %Robin-Robin
                        %Esquina superior derecha R-R
                        K(p,p-ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(2) + (2/dy)*hrobin(3);
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) + (2/dx)*hrobin(2)*tinf(2) + (2/dy)*hrobin(3)*tinf(3);
                    elseif ((tipo(2) == 'd') && (tipo(3) == 'd')) %Dirichlet-Dirichlet
                        %Esquina superior derecha D-D
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = (r(2)+r(3))/2;
                    elseif ((tipo(2) == 'd') || (tipo(3) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina superior derecha con alguna Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        if (tipo(2) == 'd')
                            f(p) = r(2);
                        else
                            f(p) = r(3);
                        end
                    end
                end
            end
            if (j == ny) %FRONTERA SUPERIOR (NORTE)
                if ((i ~= 1) && (i ~= nx)) %INTERIOR FRONTERA SUPERIOR
                    if (tipo(3) == 'n')
                        %Interior de la frontera superior con Neumann
                        K(p,p-ny) = -k/dx2;
                        K(p,p+ny) = -k/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dy)*r(3);
                    elseif (tipo(3) == 'r')
                        %Interior de la frontera superior con Robin
                        K(p,p-ny) = -k/dx2;
                        K(p,p+ny) = -k/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dy)*hrobin(3);
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) + (2/dy)*hrobin(3)*tinf(3);
                    elseif (tipo(3) == 'd')
                        %Interior de la frontera superior con Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = r(3);
                    end
                elseif (i == 1) %ESQUINA SUPERIOR IZQUIERDA
                    if ((tipo(3) == 'n') && (tipo(4) == 'n')) %Neumann-Neumann
                        %Esquina superior izquierda N-N
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(4) - (2/dy)*r(3);
                    elseif ((tipo(3) == 'n') && (tipo(4) == 'r')) %Neumann-Robin
                        %Esquina superior izquierda N-R
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(4);
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dy)*r(3) + (2/dx)*hrobin(4)*tinf(4);
                    elseif ((tipo(3) == 'r') && (tipo(4) == 'n')) %Robin-Neumann
                        %Esquina superior izquierda R-N
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dy)*hrobin(3);
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(4) + (2/dy)*hrobin(3)*tinf(3);
                    elseif ((tipo(3) == 'r') && (tipo(4) == 'r')) %Robin-Robin
                        %Esquina superior izquierda R-R
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(4) + (2/dy)*hrobin(3);
                        K(p,p-1) = -(2*k)/dy2;
                        f(p) = Q(i,j) + (2/dx)*hrobin(4)*tinf(4) + (2/dy)*hrobin(3)*tinf(3);
                    elseif ((tipo(3) == 'd') && (tipo(4) == 'd')) %Dirichlet-Dirichlet
                        %Esquina superior izquierda D-D
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = (r(3)+r(4))/2;
                    elseif ((tipo(3) == 'd') || (tipo(4) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina superior izquierda con alguna Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        if (tipo(3) == 'd')
                            f(p) = r(3);
                        else
                            f(p) = r(4);
                        end
                    end
                end
            end
            if (i == 1) %FRONTERA IZQUIERDA (OESTE)
                if ((j ~= 1) && (j ~= ny)) %INTERIOR FRONTERA IZQUIERDA
                    if (tipo(4) == 'n')
                        %Interior de la frontera izquierda con Neumann
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c;
                        K(p,p-1) = -k/dy2;
                        K(p,p+1) = -k/dy2;
                        f(p) = Q(i,j) - (2/dx)*r(4);
                    elseif (tipo(4) == 'r')
                        %Interior de la frontera izquierda con Robin
                        K(p,p+ny) = -(2*k)/dx2;
                        K(p,p) = (2*k)/dx2 + (2*k)/dy2 + c + (2/dx)*hrobin(4);
                        K(p,p-1) = -k/dy2;
                        K(p,p+1) = -k/dy2;
                        f(p) = Q(i,j) + (2/dx)*hrobin(4)*tinf(4);
                    elseif (tipo(4) == 'd')
                        %Interior de la frontera izquierda con Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = r(4);
                    end
                end
            end
        end
    end
end

x = xlim(1):dx:xlim(2);
y = ylim(1):dy:ylim(2);

%Selección del método para resolución
if (theta == -1) %estacionario
    phi = K\f;
    phi_grid = reshape(phi,ny,nx);
    figure;
    surf(x,y,phi_grid);
    xlabel('Eje x'); ylabel('Eje y');
    title('Solucion estacionaria');
else
    alfa = k/(p*Cp);
    nd = 2;
    dt = min((0.5*dx2)/(alfa*nd),(0.5*dy2)/(alfa*nd));
    if (theta == 0) %explicito
        [phi] = fdm_explicito_2D(K,f,nodos,x,y,r,tipo,p,Cp,dt,nt,tol,t0);
    elseif (theta == 1) %implicito
        [phi] = fdm_implicito_2D(K,f,nodos,x,y,r,tipo,p,Cp,dt,nt,tol,t0);
    elseif (theta == 1/2) %semi-implicito
        [phi] = fdm_semi_implicito_2D(K,f,nodos,x,y,r,tipo,p,Cp,dt,nt,tol,t0);
    end
end

end