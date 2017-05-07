function [fcg] = fcg(t)
  a = 0;
  b = pi/4;
  x = ((b+a)+(b-a)*t)/2;
  fcg = (x^2)*sin(x);
endfunction