function [gm]=trapecio(ct,x)
    a=ct(1);
    b=ct(2);
    c=ct(3);
    d=ct(4);
    if ~(a<=b && b<=c && c<=d)
        return;
    end
    if (x<a || x>d)
        gm=0;
    elseif (a<=x && x<b)
        gm=(x-a)/(b-a);
    elseif (b<=x && x<=c)
        gm=1;
    else
        gm=1-((x-c)/(d-c));
    end
end