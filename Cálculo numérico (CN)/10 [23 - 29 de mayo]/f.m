function [y] = f(x)
  t = [1.00 1.01 1.02 1.03 1.04];
  i = [3.10 3.12 3.14 3.18 3.24];
  n = length(t);
  for k=1:n
    if (x == t(k))
      y = i(k);
      break;
    endif
  endfor
endfunction