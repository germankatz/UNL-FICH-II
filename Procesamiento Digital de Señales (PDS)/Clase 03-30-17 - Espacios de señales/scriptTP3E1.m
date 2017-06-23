%Scrpt TP3 E1

close all %cierra todas las ventanas

figure;

%[t,y]=senoidal(tini,tfin,A,fm,phi,fs)
[t,sen]=senoidal(-2,2,1,25,0,1);
subplot(4,1,1);
stem(t,sen);

SEN=[mean(sen);
     max(sen);
     min(sen);
     norm(sen,inf)
     norm(sen,2)^2;
     norm(sen,1);
     (norm(sen,2)^2)/length(sen);
     sqrt((norm(sen,2)^2)/length(sen));]

%[t,y]=rampa(tini,tfin,fm)
[t,ram]=rampa(-2,2,25);
subplot(4,1,2);
stem(t,ram);

RAM=[mean(ram);
     max(ram);
     min(ram);
     norm(ram,inf)
     norm(ram,2)^2;
     norm(ram,1);
     (norm(ram,2)^2)/length(ram);
     sqrt((norm(ram,2)^2)/length(ram));]

%[t,y]=cuadrada(tini,tfin,fm,fs,phi)
[t,cua]=cuadrada(-2,2,25,1,0);
subplot(4,1,3);
stem(t,cua);

CUA=[mean(cua);
     max(cua);
     min(cua);
     norm(cua,inf)
     norm(cua,2)^2;
     norm(cua,1);
     (norm(cua,2)^2)/length(cua);
     sqrt((norm(cua,2)^2)/length(cua));]

%[t,y]=s_aleatoria(tini,tfin,fm)
[t,sa]=s_aleatoria(-2,2,25);
subplot(4,1,4);
stem(t,sa);

SA=[mean(sa);
    max(sa);
    min(sa);
    norm(sa,inf)
    norm(sa,2)^2;
    norm(sa,1);
    (norm(sa,2)^2)/length(sa);
    sqrt((norm(sa,2)^2)/length(sa));]

%figure;