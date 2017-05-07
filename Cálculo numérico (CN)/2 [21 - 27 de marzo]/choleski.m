function [L,U,t] = choleski(A)
  tic();
  n = length(A);
  A(1,1) = sqrt(A(1,1));
  A(2:n,1) = A(2:n,1)/A(1,1);
  for d=2:n-1 #Pivot, recorre la diagonal
    A(d,d) = sqrt(A(d,d) - sum(A(d,1:d-1).^2));
    A(d+1,d) = (A(d+1,d) - sum(A(d+1,1:d-1).*A(d,1:d-1)))/A(d,d);
  endfor
  A(n,n) = sqrt(A(n,n) - sum(A(n,1:n-1).^2));
  L = + tril(A);
  U = L';
  t = toc();
endfunction