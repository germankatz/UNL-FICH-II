function ejercicio2(csv,np)
  c = particionar(csv,np,0.8); %Crea un arreglo con datos de E y P
  for i=1:np
    w = ps_entrenamiento2(cell2mat(c(1,i)),5,0.2,0.4); %Entrenamiento
    w %Muestra el w de la iteracion i
    ta = ps_prueba2(cell2mat(c(2,i)),w); %Prueba
    ta %Muestra la taza de aprendizaje de la iteracion i
  endfor
endfunction