function [x,t] = eliminacion_gauss(A,b)
  tic();
  #b debe ser un vector columna
  n = length(A); #n = length(b);
  for d=1:n #Pivot, recorre la diagonal
    m = A(d+1:n,d)/A(d,d);
    A(d+1:n,d:n) = A(d+1:n,d:n) - m*A(d,d:n);
    b(d+1:n) = b(d+1:n) - m*b(d);
  endfor
  x = sust_back(A,b,n);
  t = toc();
endfunction