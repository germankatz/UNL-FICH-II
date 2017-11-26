% ej3

clc; clear; close all;

M=[-20 -20 -10 -5;
   -10 -5  -5  -2;
   -5  -2  -2   0;
   -2   0   0   2;
    0   2   2   5;
    2   5   5  10;
    5  10  20  20];

x=-7.5;
rango=[-20 20];
    
[ga]=g_activacion(M,x)