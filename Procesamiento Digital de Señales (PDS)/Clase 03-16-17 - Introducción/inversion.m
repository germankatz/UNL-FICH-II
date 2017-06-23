function [t,y]=inversion(tini,tfin,A,fm,fi,fs)

[t,y]=senoidal(tini,tfin,A,fm,fi,fs);
t = -t;