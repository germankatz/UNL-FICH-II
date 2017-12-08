function [Coef]=FFormTriCart(Puntos,Area)
%coeficientes de funciones de forma Triangular en coordenadas cartesianas


%Calculo los coefinicientes de Ni
%por lo tanto como son 3 Ni, entonces
%se tienen como resultado 9 coeficientes
Coef(1,1)=Puntos(2,1)*Puntos(3,2)-Puntos(3,1)*Puntos(2,2);
Coef(1,2)=Puntos(2,2)-Puntos(3,2);
Coef(1,3)=Puntos(3,1)-Puntos(2,1);

Coef(2,1)=Puntos(3,1)*Puntos(1,2)-Puntos(1,1)*Puntos(3,2);
Coef(2,2)=Puntos(3,2)-Puntos(1,2);
Coef(2,3)=Puntos(1,1)-Puntos(3,1);

Coef(3,1)=Puntos(1,1)*Puntos(2,2)-Puntos(2,1)*Puntos(1,2);
Coef(3,2)=Puntos(1,2)-Puntos(2,2);
Coef(3,3)=Puntos(2,1)-Puntos(1,1);


Coef=Coef./(2*Area);
end