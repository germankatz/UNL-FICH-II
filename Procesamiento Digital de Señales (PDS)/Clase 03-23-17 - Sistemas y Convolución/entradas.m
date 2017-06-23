function x=entradas(a,n)

delta = zeros(1,n);
delta(1) = 1;
x= zeros(1,n);

for i=1:n
   if i-1<=0
       ant = 0;
   else
       ant = delta(i-1);
   end
   x(i)=delta(i)-abs(a)*ant;
end
