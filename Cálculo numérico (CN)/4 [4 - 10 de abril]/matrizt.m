function [Tj,Tgs,Tsor,t] = matrizt(A,w)
  tic();
  D = diag(diag(A));
  L = tril(A,-1);
  U = triu(A,1);
  Tj = -inv(D)*(L+U);
  Tgs = -inv(D+L)*U;
  Tsor = inv(D-w*(-L))*((1-w)*D+w*(-U));
  t = toc();
endfunction