function [I]=i_lineal(t)

n = length(t);
I = zeros(n,1);
for i=1:n
    if abs(t(i))<1
        I(i) = 1-abs(t(i));
    else
        I(i) = 0;
    end
end