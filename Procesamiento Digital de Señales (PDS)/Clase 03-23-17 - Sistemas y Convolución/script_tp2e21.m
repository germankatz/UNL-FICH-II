%Script TP2 E2.1

h = [2 1 0.5]; %Respuestas del sistema
x = [1 2 2]; %Entradas del sistema
xf = [1 2 2 0 0]; %Entradas del sistema

y1 = sum_convolucion(x,h) %Mio
y2 = conv(x,h) %De Matlab
y3 = filter(h,1,xf) %De MatLab

y4 = cconv(x,h) %Convolución circular MatLab

