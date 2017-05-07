function [P,L,U,t] = crout_pp_indx(A)
  tic();
  n = length(A);
  indx = [1:n]';
  for d=1:n #Pivot, recorre la diagonal
    [val p] = max(abs(A(d,indx(d:n)))); #Fila del pivot
    p = p + d - 1; #Actualiza la posicion para lo que queda de la matriz
    indx([p d]) = indx([d p]);
    m = A(d,indx(d+1:n))/A(d,indx(d));
    A(d+1:n,indx(d+1:n)) = A(d+1:n,indx(d+1:n)) - A(d+1:n,indx(d))*m;
    A(d,indx(d+1:n)) = m;
  endfor
  P = eye(n,n)(indx,:);
  L = tril(A(:,indx));
  U = eye(n,n) + triu(A(:,indx),1);
  t = toc();
endfunction

#P*A = U'*L' ???????