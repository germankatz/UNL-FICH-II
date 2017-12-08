function [K,f,phi_n] = dirichlet_2D(K,f,phi_n,nx,ny,r,tipo,modif)

if (modif == 'p') %modifico solo el phi_n
    for i = 1:nx
        for j = 1:ny
            p = (i-1)*ny + j;
            if (j == 1) %FRONTERA INFERIOR (SUR)
                if (i == 1) %ESQUINA INFERIOR IZQUIERDA
                    if ((tipo(1) == 'd') && (tipo(4) == 'd')) %Dirichlet-Dirichlet
                        %Esquina inferior izquierda D-D
                        phi_n(p) = (r(1)+r(4))/2;
                    elseif ((tipo(1) == 'd') || (tipo(4) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina inferior izquierda con alguna Dirichlet
                        if (tipo(1) == 'd')
                            phi_n(p) = r(1);
                        else
                            phi_n(p) = r(4);
                        end
                    end
                elseif ((i ~= 1) && (i ~= nx)) %INTERIOR FRONTERA INFERIOR
                    if (tipo(1) == 'd') %Interior de la frontera inferior con Dirichlet
                        phi_n(p) = r(1);
                    end
                elseif (i == nx) %ESQUINA INFERIOR DERECHA
                    if ((tipo(1) == 'd') && (tipo(2) == 'd')) %Dirichlet-Dirichlet
                        %Esquina inferior derecha D-D
                        phi_n(p) = (r(1)+r(2))/2;
                    elseif ((tipo(1) == 'd') || (tipo(2) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina inferior derecha con alguna Dirichlet
                        if (tipo(1) == 'd')
                            phi_n(p) = r(1);
                        else
                            phi_n(p) = r(2);
                        end
                    end
                end
            end
            if (i == nx) %FRONTERA DERECHA (ESTE)
                if ((j ~= 1) && (j ~= ny)) %INTERIOR FRONTERA DERECHA
                    if (tipo(2) == 'd')
                        %Interior de la frontera derecha con Dirichlet
                        phi_n(p) = r(2);
                    end
                elseif (j == ny) %ESQUINA SUPERIOR DERECHA
                    if ((tipo(2) == 'd') && (tipo(3) == 'd')) %Dirichlet-Dirichlet
                        %Esquina superior derecha D-D
                        phi_n(p) = (r(2)+r(3))/2;
                    elseif ((tipo(2) == 'd') || (tipo(3) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina superior derecha con alguna Dirichlet
                        if (tipo(2) == 'd')
                            phi_n(p) = r(2);
                        else
                            phi_n(p) = r(3);
                        end
                    end
                end
            end
            if (j == ny) %FRONTERA SUPERIOR (NORTE)
                if ((i ~= 1) && (i ~= nx)) %INTERIOR FRONTERA SUPERIOR
                    if (tipo(3) == 'd')
                        %Interior de la frontera superior con Dirichlet
                        phi_n(p) = r(3);
                    end
                elseif (i == 1) %ESQUINA SUPERIOR IZQUIERDA
                    if ((tipo(3) == 'd') && (tipo(4) == 'd')) %Dirichlet-Dirichlet
                        %Esquina superior izquierda D-D
                        phi_n(p) = (r(3)+r(4))/2;
                    elseif ((tipo(3) == 'd') || (tipo(4) == 'd')) %Alguna frontera con Dirichlet
                        %Esquina superior izquierda con alguna Dirichlet
                        if (tipo(3) == 'd')
                            phi_n(p) = r(3);
                        else
                            phi_n(p) = r(4);
                        end
                    end
                end
            end
            if (i == 1) %FRONTERA IZQUIERDA (OESTE)
                if ((j ~= 1) && (j ~= ny)) %INTERIOR FRONTERA IZQUIERDA
                    if (tipo(4) == 'd')
                        %Interior de la frontera izquierda con Dirichlet
                        phi_n(p) = r(4);
                    end
                end
            end
        end
    end
else %modifico el sistema -> K y f
    for i = 1:nx
        for j = 1:ny
            p = (i-1)*ny + j;
            if (j == 1) %FRONTERA INFERIOR (SUR)
                if (i == 1) %ESQUINA INFERIOR IZQUIERDA
                    if ((tipo(1) == 'd') && (tipo(4) == 'd')) %Dirichlet-Dirichlet
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
                    if (tipo(1) == 'd') %Interior de la frontera inferior con Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = r(1);
                    end
                elseif (i == nx) %ESQUINA INFERIOR DERECHA
                    if ((tipo(1) == 'd') && (tipo(2) == 'd')) %Dirichlet-Dirichlet
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
                    if (tipo(2) == 'd')
                        %Interior de la frontera derecha con Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = r(2);
                    end
                elseif (j == ny) %ESQUINA SUPERIOR DERECHA
                    if ((tipo(2) == 'd') && (tipo(3) == 'd')) %Dirichlet-Dirichlet
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
                    if (tipo(3) == 'd')
                        %Interior de la frontera superior con Dirichlet
                        K(p,:) = 0;
                        K(p,p) = 1;
                        f(p) = r(3);
                    end
                elseif (i == 1) %ESQUINA SUPERIOR IZQUIERDA
                    if ((tipo(3) == 'd') && (tipo(4) == 'd')) %Dirichlet-Dirichlet
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
                    if (tipo(4) == 'd')
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

end
