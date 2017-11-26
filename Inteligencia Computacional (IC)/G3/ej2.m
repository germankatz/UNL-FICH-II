% ej2

clc; clear; close all;

M1=[-20 -20 -10 -5;
   -10 -5  -5  -2;
   -5  -2  -2   0;
   -2   0   0   2;
    0   2   2   5;
    2   5   5  10;
    5  10  20  20];
    
S2=[-7 -5 -5 -4;
    -5 -4 -4 -3;
    -4 -3 -3  0;
    -3  0  0  3;
     0  3  3  4;
     3  4  4  5;
     4  5  5  7];

G1=[-20 20;
    -10  5;
    -5   2;
    -2   0;
     0   2;
     2   5;
     5  10];
     
G2=[-7 5;
    -5 4;
    -4 3;
    -3 0;
     0 3;
     3 4;
     4 5];

figure;
x=[-20 20];
subplot(4,1,1);
graficar(M1,x);
subplot(4,1,2);
graficar(G1,x);
subplot(4,1,3);
graficar(S2,x);
subplot(4,1,4);
graficar(G2,x);
hold off;