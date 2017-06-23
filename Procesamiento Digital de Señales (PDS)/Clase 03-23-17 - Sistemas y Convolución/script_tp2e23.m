%Script TP2 E2.3

clear;

a = 0.5;
n = 3;
x = entradas(a,n);

ha = zeros(1,n)+sin(8*n);
y1 = sum_convolucion(x,ha);

n = 2*n-1;

hb = zeros(1,n)+a^n;
y2 = sum_convolucion(y1,hb);

n = 3;

hb = zeros(1,n)+a^n;
y3 = sum_convolucion(x,hb);

n = 2*n-1;

ha = zeros(1,n)+sin(8*n);
y4 = sum_convolucion(y3,ha);