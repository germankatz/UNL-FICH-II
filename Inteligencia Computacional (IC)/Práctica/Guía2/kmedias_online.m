function [U,s] = kmedias_online(csv,k,v,tol)
  %csv: Archivo de datos.
  %k: Numero de conjuntos disjuntos a encontrar
  %sigma: Suavidad de la funcion interpolante
  M = csvread(csv); %LLeno M con el contenido del archivo CSV
  filas = rows(M); %Numero de filas de M
  entradas = columns(M)-1; %Numero de entradas de M
  indx = randperm(filas)'; %Vector de indices aleatorios
  %M = M(indx,:);
  C = cell(1,k);
  D = cell(1,k);
  d = zeros(1,k);
  e = 1;
  U = zeros(k,entradas);
  s = zeros(k,1);
  %1: Inicializacion
  for i=1:k
    C(1,i) = M(indx(i),1:entradas); 
  endfor
  %2: Seleccion
  for i=1:filas
    while e>tol
      for j=1:k
        d(j) = norm(M(i,1:entradas)-C{1,j});
      endfor
      [m,p] = min(d);
      aux = C{1,p};
      C{1,p} = C{1,p} + v*(M(i,1:entradas)-C{1,p});
      e = norm(C{1,p}-aux);
    endwhile
  endfor
  for i=1:filas
    for j=1:k
      d(j) = norm(M(i,1:entradas)-C{1,j});
      U(j,:) = C{1,j};
    endfor
    [m,p] = min(d);
    D{1,p} = [D{1,p};M(i,1:entradas)];
  endfor
  for i=1:k
    desvio = mean(std(D{1,i}));
    if isnan(desvio)
      s(i) = 0;
    else
      s(i) = desvio;
    endif
  endfor
endfunction