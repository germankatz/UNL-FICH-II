function [oR]=v_rectangular(s,ini,N)

n = length(s);
for i=1:n
   if i<ini
       oR(i) = 0;
   elseif i>ini+N
       oR(i) = 0;
   else
       oR(i) = s(i);
   end
end