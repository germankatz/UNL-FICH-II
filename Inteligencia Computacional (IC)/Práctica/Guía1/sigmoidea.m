function [y] = sigmoidea(x,b)
  y = (2./(1+e.^(-b.*x)))-1;
endfunction