function [I]=i_escalon(t)

n = length(t);
I = zeros(n,1);
for i=1:n
    if 0<=t(i) & t(i)<1
        I(i)=1;
    else
        I(i)=0;
    end
end