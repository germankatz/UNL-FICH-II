function [eG] = assembly(eG,eL,ele)
% ele = conectividad del elemento
% eG estructura global (matriz global o vector global segun quiero)
% eL estructura Local que quiero ensamblar


    if (size(eG,2) == 1) % es vector lo q quiero ensamblar
        eG(ele) = eG(ele) + eL;
    else % es matriz lo q quiero ensamblar
        eG(ele,ele) = eG(ele,ele) + eL;

    end
end