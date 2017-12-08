function [K,F] = dirCond(K,F,dir)
%Formado de DIR=[nodo dimension desplazamiento]
%dimension es 1 si es en x, 2 si es en y
    for i=1:size(dir,1)
        p = 2*dir(i,1)+dir(i,2)-2; %posicion donde queda  en la matriz genral
        K(p,:) = 0;
        K(p,p) = 1;
        F(p) = dir(i,3);
    end
end