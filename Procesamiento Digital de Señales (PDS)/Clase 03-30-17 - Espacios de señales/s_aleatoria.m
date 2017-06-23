function [t,y]=s_aleatoria(tini,tfin,fm)

T = 1/fm;
t = [tini:T:tfin-T];
n = length(t);
y = rand(1,n)-0.5;

