function y = sum_convolucion(x,h)

% x: Entradas del sistema
% h: Respuestas del sistema

n = length(x);
y = zeros(1,2*n-1); %Salidas del sistema

for k=1:n
    aux = x(k)*h;
    for i=1:n
       y(i+k-1) = y(i+k-1) + aux(i);
    end    
end