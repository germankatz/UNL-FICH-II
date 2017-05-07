function [M,b,t] = matriz(n) #Crea la matriz de coeficientes
  tic();
  M = zeros(n,n);
  for i=1:n
    M(i,i) = 2*i;
    if (i+2 <= n)
      M(i,i+2) = 0.5*i;
    endif
    if (i-2 >= 1)
      M(i,i-2) = 0.5*i;
    endif
    if (i+4 <= n)
      M(i,i+4) = 0.25*i;
    endif
    if (i-4 >= 1)
      M(i,i-4) = 0.25*i;
    endif
    b(i) = pi;
  endfor
  b = b';
  t = toc();
endfunction