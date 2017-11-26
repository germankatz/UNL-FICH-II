function [gm]=membresia(ct,cg,x)
    if isempty(ct)
        gm=gaussiana(cg,x);
    else
        gm=trapecio(ct,x);
    end
end