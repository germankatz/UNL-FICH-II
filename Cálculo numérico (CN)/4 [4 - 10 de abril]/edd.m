function [b,t] = edd(A) #Verifica que una matriz sea estrictamente diagonal dominante
  tic();
  n = length(A);
  for i=1:n
    if (abs(A(i,i)) <= (sum(abs(A(i,:))) - abs(A(i,i))))
      b = false;
      return;
    endif
  endfor
  b = true;
  t = toc();
endfunction