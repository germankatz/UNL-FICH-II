function [x]= sust_back(A,b,n)
  x(n) = b(n)/A(n,n);
  for i=n-1:-1:1
    x(i) = (b(i) - sum(A(i,i+1:n).*x(i+1:n)))/A(i,i);
  endfor
  x = x';
endfunction