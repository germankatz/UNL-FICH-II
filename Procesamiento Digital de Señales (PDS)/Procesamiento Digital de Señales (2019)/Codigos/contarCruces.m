function [Cx0] = contarCruces(x)
    N = length(x);
    cruces = sign(x);
    Cx0 = 0;
    for i=1:N-1
        if(cruces(i) ~= cruces(i+1))
            Cx0 = Cx0 + 1;
        end
    end
end