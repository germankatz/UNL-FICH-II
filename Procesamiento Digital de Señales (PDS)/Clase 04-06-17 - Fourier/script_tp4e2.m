%Scrpt TP4 E2

close all %cierra todas las ventanas

%---
figure;

tini = 0;
tfin = 1;
A = 1;
fm = 100;
fi = 0;

%[t,y]=senoidal(tini,tfin,A,fm,fi,fs)
%[t,y]=cuadrada(fm,fs,fi)

[t,s1]=senoidal(tini,tfin,A,fm,fi,2);
[t,c]=cuadrada(fm,2,fi);
[t,s2]=senoidal(tini,tfin,A,fm,fi,4);

subplot(4,2,1);
stem(t,s1);
hold on;
stem(t,c);
stem(t,s2);

subplot(4,2,3);
stem(t,s1);

subplot(4,2,5);
stem(t,c);

subplot(4,2,7);
stem(t,s2);
%---

% 1 Ortogonalidad
s1*c' %no son ortogonales
round(s1*s2') %son ortogonales
round(c*s2') %son ortogonales

% 2 
subplot(4,2,4)
S1 = fft(s1);
[x,s1a]=acomodar_fft(S1,1/fm);
stem(x,s1a);

subplot(4,2,6)
C = fft(c);
[x,Ca]=acomodar_fft(C,1/fm);
stem(x,Ca);

subplot(4,2,8)
S2 = fft(s2);
[x,S2a]=acomodar_fft(S2,1/fm);
stem(x,S2a);

norm(dot(S1,C),2)
round(norm(dot(S1,S2)))
round(norm(dot(C,S2)))

% 3
[t,s2]=senoidal(tini,tfin,A,fm,fi,3.5);
S2 = fft(s2);
[x,S2a]=acomodar_fft(S2,1/fm);
round(s1*s2')
round(norm(dot(S1,S2)))