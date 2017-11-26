function [smas,smenos,pp,pn,a,ma,mg,MC] = estadisticas(yd,yc)
  n = length(yd); %Cantidad de elementos
  tmas = fmenos = fmas = tmenos = 0;
  %tmas: Verdaderos positivos.
  %fmenos: Falsos negativos.
  %fmas: Falsos positivos.
  %tmenos: Verdaderos negativos.
  for i=1:n
    if yd(i)==1 && yc(i)==1
      tmas = tmas+1;
    endif
    if yd(i)==1 && yc(i)==-1
      fmenos = fmenos+1;
    endif
    if yd(i)==-1 && yc(i)==1
      fmas = fmas+1;
    endif
    if yd(i)==-1 && yc(i)==-1
      tmenos = tmenos+1;
    endif
  endfor
  MC = [tmas fmenos;fmas tmenos];
  nmas = tmas+fmenos; %total de positivos
  nmenos = fmas+tmenos; %total de negativos
  N = nmas+nmenos; %total de patrones
  smas = tmas/(tmas+fmenos); %sensibilidad
  smenos = tmenos/(fmas+tmenos); %especificidad
  pp = tmas/(tmas+fmas); %presicion de positivos
  pn = tmenos/(fmenos+tmenos); %presicion de negativos
  a = (tmas+tmenos)/N; %Exactitud (Taza de acierto)
  ma = (2*smas*pp)/(smas+pp); %F1 Score/media armonica
  mg = sqrt(smas*pp); %media geometrica
endfunction