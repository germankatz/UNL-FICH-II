function [t,y]=r_onda_completa(tini,tfin,A,fm,fi,fs)

[t,y]=senoidal(tini,tfin,A,fm,fi,fs)
n = length(y);
for i=1:n
    if y(i)<0
        y(i)=-y(i);
    end
end