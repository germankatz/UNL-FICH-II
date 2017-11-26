% ej1

clc; clear; close all;

figure;
x=-1.5;
ct=[-2 -1 1 2];
cg=[0 2];
rango=[-3 3];
[gm_t]=membresia(ct,[],x);
subplot(1,2,1);
graficar(ct,rango);
plot(x,gm_t,'*');
[gm_g]=membresia([],cg,x);
subplot(1,2,2);
graficar(cg,rango);
plot(x,gm_g,'*');
hold off;