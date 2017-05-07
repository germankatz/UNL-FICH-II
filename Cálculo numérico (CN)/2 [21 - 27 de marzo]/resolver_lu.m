function [x] = resolver_lu(L,U,b)
  n = length(L); #n = length(U); #n = length(b);
  [y] = sust_front(L,b,n);
  [x] = sust_back(U,y,n);
endfunction