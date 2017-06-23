function [y]=conv_circular(x,h)

n = length(x);

for k=1:n
    sum = 0;
    for l=1:n
        y(k) = sum + h(l)*x(mod((n+k-l),n)+1);
    end
end