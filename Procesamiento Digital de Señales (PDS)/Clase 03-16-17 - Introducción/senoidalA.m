function [t,y,A]=senoidalA(tini,tfin,Aini,Afin,fm,fi,fs)
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
n=length(t);

p = (Afin-Aini)/n;

for i=1:n
    A(i)=((i-1)*p)+Aini;
end

y = A.*sin(2*pi*fs*t+fi);