function [sonoro] = esSonoro(E,Cx0)
    MIN_ENERGIA = 4;
    MIN_CRUCES = 0;
    if(E >= MIN_ENERGIA) %compara energia, mientras mas, es mas sonoro
        sonoro = 1;
    else
        if(Cx0 < MIN_CRUCES) %compara cruces, mientras menos, es mas sonoro
            sonoro = 1;
        else
            sonoro = 0;
        end
    end
end