function [Kc] = MatReaccionCar(c, Area, esp, xnode)
%Matriz del termino reactivo en coordenadas cartesianas

 if (size(xnode,1) == 3) % Triangular element
     Kc= ((c*Area*esp)/12)*(eye(3)+ones(3));
     
 else
     Kc = zeros(4,4);
 end

 
end