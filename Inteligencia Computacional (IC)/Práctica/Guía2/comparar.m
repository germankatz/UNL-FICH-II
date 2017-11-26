function [b] = comparar(M1,M2)
  if length(M1) != length(M2)
    b = false;
    break;
  endif
  if M1==M2
    b = 1;
  else
    b = 0;
  endif
endfunction