function [nc] = num_cond(M)
  nc = norm(M)*norm(inv(M));
endfunction