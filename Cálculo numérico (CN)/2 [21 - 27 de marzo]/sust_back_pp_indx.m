function [x] = sust_back_pp_indx(A,b,n,indx)
  x(indx(n)) = b(indx(n))/A(indx(n),n);
  for i=n-1:-1:1
    x(indx(i)) = (b(indx(i)) - sum(A(indx(i),i+1:n).*x(indx(i+1:n))))/A(indx(i),i);
  endfor
  x(1:n) = x(indx);
  x = x';
endfunction