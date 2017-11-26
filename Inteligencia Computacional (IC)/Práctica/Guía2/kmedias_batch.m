function [U,s] = kmedias_batch(csv,k)
  %csv: Archivo de datos.
  %k: Numero de conjuntos disjuntos a encontrar
  M = csvread(csv); %LLeno M con el contenido del archivo CSV
  C = cell(3,k); %Numero de conjuntos
  filas = rows(M); %Numero de filas de M
  entradas = columns(M)-1; %Numero de entradas de M
  indx = randperm(filas); %Vector de indices aleatorios
  M = M(indx,:); %Mezcla los datos de entrada
  d = zeros(1,k); %Vector de distancias
  v1 = 1;
  v2 = inc = floor(filas/k);
  b = 0;
  U = zeros(k,entradas);
  s = zeros(k,1);
  %1: Inicialización
  for i=1:k
    C(1,i) = M(v1:v2,1:entradas); 
    v1 = v2+1;
    v2 = v2+inc;
  endfor
  %---
  while b!=1
    %2: Calcular centroides
    for i=1:k
      if length(C{1,i})!=0
        C(2,i) = sum(C{1,i})/(length(C{1,i})); 
      endif
    endfor
    %3: Se reasignas las entradas al centroide mas cercano
    for i=1:filas
      for j=1:k
        d(j) = norm(M(i,1:entradas)-C{2,j})^2;
      endfor
      [m,p] = min(d);
      C{3,p} = [C{3,p};M(i,1:entradas)];
    endfor
    %---
    for i=1:k
      b = comparar(C{1,k},C{3,k});
      if (b==0)
        break;
      endif
    endfor
    for i=1:k
      C(1,i) = C(3,i);
    endfor
    C(3,:) = cell(1,k);
  endwhile
  for i=1:k
    U(i,:) = C{2,i};
    desvio = mean(std(C{1,i}));
    if isnan(desvio)
      s(i) = 0;
    else
      s(i) = desvio;
    endif
  endfor
endfunction