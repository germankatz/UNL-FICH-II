function [x,th,it,t] = puntofijo(g,x0,maxit,tol)
  tic();
  it = 0;
  x = x0;
  while it<maxit
    it = it+1;
    x = feval(g,x0);
    rh(it) = abs(x-x0);
    if (rh(it)<tol)
      break;
    endif
    x0 = x;
  endwhile
  t = toc();
endfunction