function [t,y]=r_media_onda(tini,tfin,A,fm,fi,fs)

[t,y]=senoidal(tini,tfin,A,fm,fi,fs)
n = length(y);
for i=1:n
    if y(i)<0
        y(i)=0;
    end
end