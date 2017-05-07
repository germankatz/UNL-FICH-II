function [x,indx,t] = e_gauss_pp_indx(A,b)
  tic();
  #b debe ser un vector columna
  n = length(A); #n = length(b);
  indx = [1:n]';
  for d=1:n #Pivot, recorre la diagonal
    [val p] = max(abs(A(indx(d:n),d))); #Fila del pivot
    p = p + d - 1; #Actualiza la posicion para lo que queda de la matriz
    indx([p d]) = indx([d p]);
    m = A(indx(d+1:n),d)/A(indx(d),d);
    A(indx(d+1:n),d:n) = A(indx(d+1:n),d:n) - m*A(indx(d),d:n);
    b(indx(d+1:n)) = b(indx(d+1:n)) - m*b(indx(d));
  endfor
  x = sust_back_pp_indx(A,b,n,indx);
  t = toc();
endfunction