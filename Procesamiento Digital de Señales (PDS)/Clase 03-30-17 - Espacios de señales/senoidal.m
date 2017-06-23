function [t,y]=senoidal(tini,tfin,A,fm,phi,fs)
%tini: tiempo inicial
%tfin: tiempo final
%A: amplitud
%fm: frecuencia de muestreo
%Cantidad de valores discretos por segundo
%fi: ángulo de fase
%fs: frecuencia de la senoidal

%T: intervalo de tiempo entre cada valor discreto
%y el siguiente
T = 1/fm;

%t: valores discretos de tiempo
t = [tini:T:tfin-T];

y = A*sin(2*pi*fs*t+phi);