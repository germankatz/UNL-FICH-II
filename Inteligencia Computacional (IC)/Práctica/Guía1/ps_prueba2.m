function [ta] = ps_prueba(M,w)
  n = length(M); %Numero de filas de M
  M = [-ones(n,1) M]; %Matriz M aumentada x0,x1,x2,Yd
  n2 = length(M(1,:))-1; %Numero de entradas
  c = 0; %Contador de exitos
  for i=1:n
    z = M(i,1:n2)*w; %Producto interno Xi*Wi
    y = signo(z); %Funcion de activacion
    if (M(i,n2+1) == y)
      c = c+1;
    endif
  endfor
  ta = c/n; %Taza de acierto del perceptron
endfunction