function [t,y]=cuant_8_niveles(N,H,tini,tfin,A,fm,fi,fs)

[t,y]=senoidal(tini,tfin,A,fm,fi,fs);
n = length(y);
for i=1:n
   if y(i)<-(N-1)*H
       y(i) = -(N-1)*H;
   elseif y(i)>=-(N-1)*H & y(i)<0
       y(i) = H*fix(y(i)/H);
   end
   if y(i)>=(N-1)*H
       y(i) = (N-1)*H;
   elseif y(i)<(N-1)*H & y(i)>=0
       y(i) = H*floor(y(i)/H);
   end
end