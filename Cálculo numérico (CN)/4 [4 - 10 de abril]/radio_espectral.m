function [re] = radio_espectral(M)
  re = max(abs(eig(M)));
endfunction