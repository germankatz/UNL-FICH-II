M = zeros(N,6);	%Matriz de distancias útiles
for i=2:N-1 %Calculo valores de distancias útiles de los nodos interiores
	aw = dx(i-1)/2; %Distancia entre W y fw (fw: cara entre W y P)
	bw = dx(i)/2; %Distancia entre fw y P
	dw = aw + bw; %Distancia entre P y W
	ae = bw; %Distancia entre P y E
	be = dx(i+1)/2; %Distancia entre E y fe (fe: cara entre E y P)
	de = ae + be; %Distancia entre P y E
	M(i,:) = [dw aw bw ae be de];
end

%Frontera Izquierda (primera fila de la matriz)
ae = dx(1)/2; %Distancia entre P y fe
be = dx(2)/2; %Distancia entre E y fe (fe: cara entre E y P)
de = ae + be; %Distancia entre P y E
dw = dx(1)/2; %Distancia entre P y frontera
aw = dw/2; 
bw = dw/2;
M(1,:) = [dw aw bw ae be de];

%Frontera Derecha (última fila de la matriz)
de = dx(N)/2; %Distancia entre E y frontera
ae = de/2; 
be = de/2;
aw = dx(N-1)/2; %Distancia entre W y fw (fw: cara entre W y P)
bw = dx(N)/2; %Distancia entre fw y P
dw = aw + bw; %Distancia entre P y W
M(N,:) = [dw aw bw ae be de];


kint = zeros(1,N-1); %Calculo los k en las caras interiores
for i=1:N-1
	kint(i) = interk(k(i),k(i+1),M(i+1,2),M(i+1,3)); 
end
