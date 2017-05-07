function [L,U,t] = crout(A)
  tic();
  n = length(A);
  for d=1:n #Pivot, recorre la diagonal
    m = A(d,d+1:n)/A(d,d);
    A(d+1:n,d+1:n) = A(d+1:n,d+1:n) - A(d+1:n,d)*m;
    A(d,d+1:n) = m;
  endfor
  L = tril(A);
  U = eye(n,n) + triu(A,1);
  t = toc();
endfunction