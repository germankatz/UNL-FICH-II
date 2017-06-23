%Scrpt TP4 E2

close all %cierra todas las ventanas

%---1
figure;

%[t,y]=senoidal(tini,tfin,A,fm,fi,fs)
T = 1/fm;
fm = 50;
[t,s1]=senoidal(0,1,1,fm,0,10);
length(t)
[t,s2]=senoidal(0,1,4,fm,0,20);
s = s1+s2;
subplot(3,1,1);
stem(t,s);

%fft: transformada discretade Fourier

subplot(3,1,2);
S = fft(s);
%[x,sa]=acomodar_fft(s,T)
[x,sa]=acomodar_fft(S,T);
stem([1:1/(1/fm)],abs(S));

subplot(3,1,3);
I = ifft(S);
stem(t,I);
%---

%---2
parseval(s,S)
%---

%---3
figure;
%a - primer columna
subplot(3,4,1)
s = s1+s2+4;
stem(t,s);

subplot(3,4,5);
S = fft(s);
%[x,sa]=acomodar_fft(s,T)
[x,sa]=acomodar_fft(S,T);
stem(x,sa);

subplot(3,4,9);
I = ifft(S);
stem(t,I);

%b - segunda columna
subplot(3,4,2)
[t,s2]=senoidal(0,1,4,fm,0,11);
s = s1+s2;
stem(t,s);

subplot(3,4,6);
S = fft(s);
[x,sa]=acomodar_fft(S,T);
stem(x,sa);

subplot(3,4,10);
I = ifft(S);
stem(t,I);

%c - tercer columna
subplot(3,4,3)
[t,s2]=senoidal(0,1,4,fm,0,10.5);
s = s1+s2;
stem(t,s);

subplot(3,4,7);
S = fft(s);
[x,sa]=acomodar_fft(S,T);
stem(x,sa);

subplot(3,4,11);
I = ifft(S);
stem(t,I);

%d - cuarta columna
subplot(3,4,4)
[t,s1]=senoidal(0,2,1,fm,0,10);
[t,s2]=senoidal(0,2,4,fm,0,20);
s = s1+s2;
stem(t,s);

subplot(3,4,8);
S = fft(s);
[x,sa]=acomodar_fft(S,T);
stem(x,sa);

subplot(3,4,12);
I = ifft(S);
stem(t,I);

%---
figure;
[t,s1]=senoidal(0,1,1,fm,pi/2,10);
[t,s2]=senoidal(0,1,1,fm,pi/2,10.5);
%--
subplot(3,2,1);
stem(t,s1);

subplot(3,2,3);
S = fft(s1);
[x,sa]=acomodar_fft(S,T);
stem(x,sa);

subplot(3,2,5);
I = ifft(S);
stem(t,I);
%--
subplot(3,2,2);
stem(t,s2);

subplot(3,2,4);
S = fft(s2);
[x,sa]=acomodar_fft(S,T);
stem(x,sa);

subplot(3,2,6);
I = ifft(S);
stem(t,I);