function [c] = particionar(csv,np,ent)
  %csv: ruta del archivo csv
  %np: numero de particiones
  %ent: porcentaje de datos a usar en el entrenamiento (0.#)  
  M = csvread(csv); %Paso el contenido de csv a M
  n = length(M); %Numero de final de M
  e = floor(n*ent); %Cantidad de elemento para entrenamiento
  c = cell(2,np);
  %c es un arreglo de dos filas y tantas columnas como particiones
  %La primer fila contendra las matrices de entrenamiento
  %La segunda fila contendra las matrices de prueba
  for i=1:np
    indx = randperm(n)'; %Vector de indices aleatorios
    M = M(indx,:); %Reordeno las filas de la matriz aleatoriamente
    c(1,i) = M(1:e,:); %Los primeros e elementos seran entrenamiento
    c(2,i) = M(e+1:n,:); %El resto de los elementos son de prueba
  endfor
endfunction