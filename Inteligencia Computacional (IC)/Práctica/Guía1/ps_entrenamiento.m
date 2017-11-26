function [w,wold,epoca,e] = ps_entrenamiento(csv,epomax,tol,u)
  %csv: Archivo de datos.
  %epomax: Numero maximo de epocas.
  %tol: Tolerancia de error.
  %u: Velocidad de aprendizaje.
  M = csvread(csv); %LLeno M con el contenido del archivo CSV
  patrones = rows(M); %Numero de filas de M
  entradas = columns(M)-1; %Numero de entradas
  w = wold = rand(entradas+1,1)-0.5; %Vector de pesos aleatorios entre -1 y 1
  epoca = 0; %Contador de epocas
  yc = zeros(patrones,1); %y calculada
  while epoca<epomax
    for i=1:patrones %Recorre todas las filas de M
      yc(i) = signo([-1 M(i,1:entradas)]*w); %Funcion de activacion
      w = w + ((u*(M(i,entradas+1)-yc(i))/2)*[-1 M(i,1:entradas)]'); %Se actualizan los pesos
    endfor
    epoca = epoca+1;
    [smas,smenos,pp,pn,a,ma,mg] = estadisticas(M(:,entradas+1),yc);
    e = 1-a;
    if e<tol
      break; %Corte por tolerancia
    endif
  endwhile
endfunction