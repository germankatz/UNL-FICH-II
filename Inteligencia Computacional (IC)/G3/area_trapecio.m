function [A]=area_trapecio(ct,h)
    a=ct(1);
    b=ct(2);
    c=ct(3);
    d=ct(4);
    bM=d-a;
    bm=c-b;
    A=(bM+bm)*(h/2);
end