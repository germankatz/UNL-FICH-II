function [oH]=v_hamming(s,ini,N)

n = length(s);
for i=1:n
   if i<ini
       oH(i) = 0;
   elseif i>ini+N
       oH(i) = 0;
   else
       oH(i) = 27/50 - 23/50*cos(2*pi*s(i)/N);
   end
end