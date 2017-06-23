function [t,y]=cuadrada(tini,tfin,fm,fs,phi)

T = 1/fm; %Paso
t = [tini:T:tfin-T]; %vector de tiempos discretos
n = length(t); %cantidad de elementos de t
y = zeros(1,n);

for i=1:n
    m = mod(2*pi*fs*t(i)+phi,2*pi); %vector de modulos
    if m>=pi
        y(i) = -1;
    else
        y(i) = 1;
    end
end