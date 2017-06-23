function [t,y]=cuadrada(fm,fs,fi)

if fi<-pi
    fi = -pi;
elseif fi>pi
    fi = pi;
end %controla el rango de fi entre -pi y pi

T = 1/fm; %Paso
t = [0:T:1-T]; %vector de tiempos discretos
n = length(t); %cantidad de elementos de t
m = mod(2*pi*fs*t+fi,2*pi); %vector de modulos
y = zeros(n,1);
for i=1:n
    if m(i)>=pi
        y(i) = -1;
    else
        y(i) = 1;
    end
end