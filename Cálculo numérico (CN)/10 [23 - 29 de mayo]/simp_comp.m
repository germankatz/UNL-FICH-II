function [s] = simp_comp(f,a,b,M)
  s = 0;
  h = (b-a)/(2*M);
  x = a+h;
  while x<b
    s = s+feval(f,x-h)+4*feval(f,x)+feval(f,x+h);
    x = x+2*h;
  endwhile
  s = h*s/3;
endfunction