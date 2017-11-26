function [y]=defuzz(S,ga)
    [f c]=size(S);
    suma1=0;
    suma2=0;
    if (c==4)
        for i=1:f
            A=area_trapecio(S(i,:),ga(i));
            ycg=cg_trapecio(S(i,:),ga(i));
            suma1=suma1+(A*ycg);
            suma2=suma2+A;
        end
    else
        for i=1:f
            A=S(i,:);
            ycg=S(i,2)*(2*pi)^(1/2);
            suma1=suma1+(A*ycg);
            suma2=suma2+A;
        end
    end
    y=suma1/suma2;
end