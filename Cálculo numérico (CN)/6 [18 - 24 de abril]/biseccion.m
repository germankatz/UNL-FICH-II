function [p,rh,it,t] = biseccion(f,a,b,maxit,tol)
  tic();
  fa = feval(f,a);
  fb = feval(f,b);
  if (sign(fa)*sign(fb)>0)
    error('No se cumple la regla de los signos');
  endif
  it = 0;
  while it<maxit
    it = it + 1;
    p = a + (b-a)/2;
    fp = feval(f,p);
    if(sign(fp)*sign(fb)<0)
      rh(it) = max(abs([fp,b-p]));
      fa = fp;
      a = p;
    else
      rh(it) = max(abs([fp,p-a]));
      fb = fp;
      b = p;
    endif
    if (rh(it)<tol)
      break;
    endif
  endwhile
  t = toc();
endfunction