function [smas,smenos,pp,pn,e,ma,mg,MC] = ps_prueba(csv,w)
  %csv: Archivo de datos.
  %w: Vector columna de pesos.
  M = csvread(csv); %LLeno M con el contenido del archivo CSV
  patrones = rows(M); %Numero de filas de M
  entradas = columns(M)-1; %Numero de entradas
  yc = zeros(patrones,1); %y calculada
  for i=1:patrones
    yc(i) = signo([-1 M(i,1:entradas)]*w); %Funcion de activacion 
  endfor
  [smas,smenos,pp,pn,a,ma,mg,MC] = estadisticas(M(:,entradas+1),yc);
  e = 1-a;
endfunction