function [YR]=retardo(Y,m)

n = length(Y);
for j=1:n
    YR(j) = Y(j)*exp(-(2*pi*j*m/n)*i);
end
