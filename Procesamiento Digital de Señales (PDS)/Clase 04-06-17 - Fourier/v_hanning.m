function [oh]=v_hanning(s,ini,N)

n = length(s);
for i=1:n
   if i<ini
       oh(i) = 0;
   elseif i>ini+N
       oh(i) = 0;
   else
       oh(i) = 1/2 - 1/2*cos(2*pi*s(i)/N);
   end
end