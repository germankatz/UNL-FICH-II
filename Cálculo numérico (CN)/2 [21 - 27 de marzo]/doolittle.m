function [L,U,t] = doolittle(A)
  tic();
  n = length(A);
  for d=1:n #Pivot, recorre la diagonal
    m = A(d+1:n,d)/A(d,d);
    A(d+1:n,d+1:n) = A(d+1:n,d+1:n) - m*A(d,d+1:n);
    A(d+1:n,d) = m;
  endfor
  L = eye(n,n) + tril(A,-1);
  U = triu(A);
  t = toc();
endfunction