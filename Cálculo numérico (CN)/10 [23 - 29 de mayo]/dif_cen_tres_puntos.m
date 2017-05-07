function [df] = dif_cen_tres_puntos(fx,xc,h)
  df = (1/(2*h))*(feval(fx,xc+h)-feval(fx,xc-h));
endfunction