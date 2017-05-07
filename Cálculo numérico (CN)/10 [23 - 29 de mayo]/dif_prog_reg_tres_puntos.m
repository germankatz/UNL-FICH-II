function [df] = dif_prog_reg_tres_puntos(fx,xc,h)
  #Cuando h es positivo es progresiva
  #Cuando h es negativo es regresiva
  df = (1/(2*h))*(-3*feval(fx,xc)+4*feval(fx,xc+h)-feval(fx,xc+2*h));
endfunction