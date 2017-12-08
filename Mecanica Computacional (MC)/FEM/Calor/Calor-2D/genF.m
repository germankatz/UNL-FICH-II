function [F] = genF(xnode,Qglobal, espesor)
%genera el F del lado derecho,
%Q es la fuente
    if (size(xnode,1) == 3)
        F = (Qglobal*area_ele(xnode)*espesor/3)*ones(3,1);
    else
        F = (Qglobal*area_ele(xnode)*espesor/4)*ones(4,1);
    end
end