function [df] = dif_prog_reg_dos_puntos(fx,xc,h)
  #Cuando h es positivo es progresiva
  #Cuando h es negativo es regresiva
  df = (feval(fx,xc+h)-feval(fx,xc))/h;
endfunction