function [x,rh,it,t] = Newton_Raphson (f,x0,maxit,tol)
  tic();
  it=0;
  [fx,dfx]=f(x0);
  while it<maxit
    it++;
    x=x0-fx/dfx;
    [fx,dfx]=f(x);
    rh(it)=max(abs([fx,x-x0]));
    if rh(it)<tol
      break;
    endif
    x0=x;
  endwhile
  t = toc();
endfunction