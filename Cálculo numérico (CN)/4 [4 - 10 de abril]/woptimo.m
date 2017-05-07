function [w,t] = woptimo(A)
  tic();
  [Tj] = matrizt(A,1);
  w = 2/(1+sqrt(1-(max(abs(eig(Tj))))^2));
  t = toc();
endfunction