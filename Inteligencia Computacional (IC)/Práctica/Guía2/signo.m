function [s] = signo(n)
  if sign(n) == 0
    s = 1;
  else 
    s = sign(n);
  endif
endfunction