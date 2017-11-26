function [y]=rsc(M,S,x,r)
    ga=g_activacion(M,x);
    y=defuzz(S(r,:),ga);
end