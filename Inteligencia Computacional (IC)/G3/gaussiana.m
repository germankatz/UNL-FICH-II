function [gm]=gaussiana(cg,x)
    m=cg(1);
    stdev=cg(2);
    gm=exp((-1/2)*((x-m)/stdev)^2);
end