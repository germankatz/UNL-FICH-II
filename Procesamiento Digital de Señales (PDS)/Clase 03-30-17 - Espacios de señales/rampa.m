function [t,y]=rampa(tini,tfin,fm)

T = 1/fm;
t = [tini:T:tfin-T];
n = length(t);
y = zeros(1,n);

for i=1:n
    if (t(i)<0)
        y(i) = 0;
    else
        y(i) = t(i);
    end
end