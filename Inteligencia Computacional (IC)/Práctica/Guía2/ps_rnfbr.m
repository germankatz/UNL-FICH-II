function [w,wold,epoca,e] = ps_rnfbr(csv,epomax,tol,u,k,km)
  %csv: Archivo de datos.
  %epomax: Numero maximo de epocas.
  %tol: Tolerancia de error.
  %u: Velocidad de aprendizaje.
  M = csvread(csv); %LLeno M con el contenido del archivo CSV
  patrones = rows(M); %Numero de filas de M
  columnas = columns(M);
  yd = M(:,columnas);
  error = 0.25;
  sigma = 1;
  expo = exp((-k^2)/(2*sigma^2));
  epoca = 0; %Contador de epocas
  yc = zeros(patrones,1); %y calculada
  c = 0;
  if km == 1
    [U,s] = kmedias_batch(csv,k);
  elseif km == 2
    [U,s] = kmedias_online(csv,k,u,tol);
  endif
  col = rows(U);
  P = zeros(patrones,col);
  for i=1:patrones
      for j=1:col
        P(i,j) = exp((-norm(M(i,1:columnas-1)-U(j,:))^2)/(2*s(j)^2));
      endfor
  endfor
  entradas = columns(P);
  w = wold = rand(entradas+1,1)-0.5;
  while epoca<epomax
    for i=1:patrones %Recorre todas las filas de M
      yc(i) = [-1 P(i,:)]*w; %Funcion de activacion
      w = w - u*(yc(i)-yd(i))*expo; %Se actualizan los pesos
    endfor
    epoca = epoca+1;
    for i=1:patrones
      if (yc(i)-yd(i))<error
        c = c+1;
      endif
    endfor
    e=c/patrones;
    if e<tol
      break; %Corte por tolerancia
    endif
  endwhile
endfunction