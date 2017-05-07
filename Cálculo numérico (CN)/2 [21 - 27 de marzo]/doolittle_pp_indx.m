function [P,L,U,t] = doolittle_pp_indx(A)
  tic();
  n = length(A);
  indx = [1:n]';
  for d=1:n #Pivot, recorre la diagonal
    [val p] = max(abs(A(indx(d:n),d))); #Fila del pivot
    p = p + d - 1; #Actualiza la posicion para lo que queda de la matriz
    indx([p d]) = indx([d p]);
    m = A(indx(d+1:n),d)/A(indx(d),d);
    A(indx(d+1:n),d+1:n) = A(indx(d+1:n),d+1:n) - m*A(indx(d),d+1:n);
    A(indx(d+1:n),d) = m;
  endfor
  P = eye(n,n)(indx,:);
  L = eye(n,n) + tril(A(indx,:),-1);
  U = triu(A(indx,:));
  t = toc();
endfunction