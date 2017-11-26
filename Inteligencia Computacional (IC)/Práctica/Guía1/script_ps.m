function [w,wold,e] = script_ps()
  e = 1;
  while e>0.3
    [w,wold,epoca,e] = ps_entrenamiento("E:/Descargas/XOR_trn.csv",5,0.3,0.2);
    e
  endwhile
endfunction