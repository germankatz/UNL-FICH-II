function [F] = genF(xnode,Fg)
%Fuerza volumetrica
%xnode son las posiciones de los nodos del elemento..
% Ojo: no puede tener el -1, debe estar cortado
    Fel = Fg*area_ele(xnode);
    
    if (size(xnode,1) == 3) %Triangulos
        Fy = (Fel/3);
        F = [0; -Fy; 0; -Fy; 0; -Fy];
    else%Cuadrangulos
        Fy = (Fel/4);
        F = [0; -Fy; 0; -Fy; 0; -Fy; 0; -Fy];
    end
end