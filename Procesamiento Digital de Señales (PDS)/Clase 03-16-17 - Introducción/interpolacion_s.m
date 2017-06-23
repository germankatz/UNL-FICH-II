function [ti,yi]=interpolacion_s(t,y,fmi,fs,I)

T = t(2)-t(1);
n = length(t);
tini = t(1);
tfin = t(n);
Ti = 1/fmi;
ti = [tini:Ti:tfin-Ti];
m = length(ti);
yi = zeros(m,1);

for i=1:m
    sum = 0;
    for j=1:n
        sum = sum + y(j)*feval(I,(i-1)*(Ti/T)-(j-1),fs);
    end
    yi(i) = sum;
end  