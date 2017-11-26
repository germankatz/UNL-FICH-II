function [P] = patrones(csv,C,s)
  M = csvread(csv); %LLeno M con el contenido del archivo CSV
  filas = rows(M); %Numero de filas de M
  columnas = rows(C);
  entradas = columns(M)-1; %Numero de entradas de M
  P = zeros(filas,columnas);
  for i=1:filas
      for j=1:columnas
        P(i,j) = exp((-norm(M(i,1:entradas)-C(j,:))^2)/(2*s(j)^2));
      endfor
  endfor
endfunction