%ej7

clc; clear; close all;

M1=[-20 -20 -10 -5;
   -10 -5  -5  -2;
   -5  -2  -2   0;
   -2   0   0   2;
    0   2   2   5;
    2   5   5  10;
    5  10  20  20];

M2=[-20 -20 -10 -5;
    -10 -5  -4  -2;
    -4  -2  -1   0;
    -1   0   0   1;
     0   1   2   4;
     2   4   5   10;
     5   10  20  20];
    
S1=[-7 -5 -5 -3;
   -5 -3 -3 -1;
   -3 -1 -1  0;
   -1  0  0  1;
    0  1  1  3;
    1  3  3  5;
    3  5  5  7];
    
S2=[-7 -5 -5 -4;
    -5 -4 -4 -3;
    -4 -3 -3  0;
    -3  0  0  3;
     0  3  3  4;
     3  4  4  5;
     4  5  5  7];

r=[1:7];
[v,t1]=sistema_termico(M1,S1,r);
[v,t2]=sistema_termico(M1,S2,r);
[v,t3]=sistema_termico(M2,S1,r);
[v,t4]=sistema_termico(M2,S2,r);

figure;
hold on;

subplot(2,2,1);
plot(v,t1,'b');

subplot(2,2,2);
plot(v,t2,'r');

subplot(2,2,3);
plot(v,t3,'g');

subplot(2,2,4);
plot(v,t4,'m');

hold off;

figure;
plot(v,t1,'b');
hold on;
plot(v,t2,'r');
plot(v,t3,'g');
plot(v,t4,'m');
hold off;