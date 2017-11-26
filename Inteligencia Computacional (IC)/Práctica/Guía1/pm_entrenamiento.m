function [cw,cwold,epoca,cy] = pm_entrenamiento(csv,epomax,tol,u,capas,b)
  %csv: Archivo csv que contiene los datos
  %epomax: limite de epocas para entrenar
  %tol: cota de error
  %u: velocidad de aprendizaje
  %capas: vector con tantos elementos como capas,
  %cada elemento indica la cantidad de neuronas por capa
  %b: parametro de la funcion sigmoidea
  A = csvread(csv); %LLeno M con el contenido del archivo CSV
  filas = rows(A); %Numero de filas de M
  A = [-ones(filas,1) A]; %Agrega x0=-1 como primer columna de A
  epoca = 0; %Contador de epocas
  e = 0; %Taza de error del perceptron
  entradas = columns(A)-1; %Numero de entradas de la capa 1
  ncapas = length(capas); %Numero de capas
  cw = cy = cwold = cell(1,ncapas);
  %cw es un arreglo de una fila y tantas columnas como capas haya
  %Cada columna contiene la matriz de pesos de la capa correspondiente
  
  %---Genera las matrices de pesos aleatorios
  cw(1,1) = cwold(1,1) = rand(entradas,capas(1))-0.5;
  for i=2:ncapas
    cw(1,i) = cwold(1,i) = rand(capas(i-1)+1,capas(i))-0.5;
  endfor
  %---
  
% while epoca<epomax
    c = 0; %Contador de distintos
    
    %---Calcula las salidas de la capa 1
    M = zeros(filas,columns(cell2mat(cw(1,1))));
    for i=1:filas %Recorre todas las filas de A
        M(i,:) = [sigmoidea(A(i,1:entradas)*cell2mat(cw(1,1)),b)];
    endfor
    cy(1,1) = M;
    %---
    %---Calcula las salidas de las capas restantes
    for k=2:ncapas
      M = zeros(filas,columns(cell2mat(cw(1,k))));
      for i=1:filas %Recorre todas las filas de A
        M(i,:) = [sigmoidea([-1 cell2mat(cy(1,k-1))(i,:)]*cell2mat(cw(1,k)),b)];
      endfor
      cy(1,k) = M;
    endfor
    %---
    
% endwhile
  
  
endfunction