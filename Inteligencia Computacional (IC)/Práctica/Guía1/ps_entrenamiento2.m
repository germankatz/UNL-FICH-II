function [w] = ps_entrenamiento2(M,epomax,tol,u)
  n = length(M); %Numero de filas de M
  M = [-ones(n,1) M]; %Matriz M aumentada x0,x1,x2,Yd
  n2 = length(M(1,:))-1; %Numero de entradas
  w = wold = rand(n2,1)-0.5; %Vector de pesos aleatorios entre -1 y 1
  epoca = 0; %Contador de epocas
  e = 0; %Taza de error del perceptron
  while epoca<epomax
    c = 0; %Contador de distintos
    for i=1:n %Recorre todas las filas de M
      z = M(i,1:n2)*w; %Producto interno Xi*Wi
      y = signo(z); %Funcion de activacion
      if (M(i,n2+1) != y)
        c = c+1;
      endif
      w = w + ((u*(M(i,n2+1)-y)/2)*M(i,1:n2)'); %Se actualizan los pesos
    endfor
    e = c/n; %Taza de error
    epoca = epoca+1;
    if e<tol
      break; %Corte por tolerancia
    endif
  endwhile
endfunction