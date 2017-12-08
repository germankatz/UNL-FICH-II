%Volúmenes finitos en 1 Dimensión (sólo términos difusivo, fuente, reactivo).
%dx: Vector con distancias entre celdas
%G: Fuente para cada celda
%k: Conductividad para cada celda
%cb_t, cb_c: Condiciones de borde. cb_t es matriz (para cada frontera, y dentro para cada celda), y cb_t es de 3 dimensiones (frontera,celda,valores de la condicion -que pueden ser dos si es Robin-). Ejemplo:
%	cb_t(1,:) = ['N','N','R'] <-- En la frontera sur (1) dos celdas tienen Neumann y una Robin
%	cb_v(1,1,:) = [0 0;10 0;0.2 50] <-- En la frontera sur, y en la 1er celda el flujo vale 0, en la 2da vale 10, y en la 3ra 	el h vale 0.2 y tref vale 50.
% Fronteras: 1->Sur 2->Este 3->Norte 4->Oeste

function T = vol1D(dx,G,k,c,cb_t,cb_v)
	N = max(size(dx)); %No importa si es fila o columna, es de 1xN.
	T = zeros(1,N);	
	calculardistancias %Calcular distancias que se usarán
	
	K = zeros(N,N); %Matriz del sistema de ecuaciones
	b = zeros(N,1);

	%Cálculo de las celdas interiores
	for i=2:N-1
		kfw = kint(i-1);
		dw = M(i,1);
		kfe = kint(i);
		de = M(i,6);
		K(i,i-1:i+1) = [kfw/dw -(kfw/dw + kfe/de + c*dx(i)) kfe/de];
		b(i) = -G(i) * dx(i);
	end
	
	%Cálculo de las celdas frontera

	%Frontera Izquierda
	if cb_t(1) == 'D' %Cond. Dirichlet
		kw = k(1);
		kfe = kint(1);
		de = M(1,6);		
		K(1,1:2) = [-(2*kw/dx(1) + kfe/de + c*dx(1)) kfe/de];
		b(1) = -G(1)*dx(1) - 2*kw/dx(1) * cb_v(1);
	elseif cb_t(1) == 'N'
		kw = k(1);
		kfe = kint(1);
		de = M(1,6);
		K(1,1:2) = [-(kfe/de + c*dx(1)) kfe/de];
		b(1) = -G(1)*dx(1) + cb_v(1);
	else %Robin
		kw = k(1);
		kfe = kint(1);
		de = M(1,6);
		K(1,1:2) = [-((cb_v(1,1)*kw/(kw-cb_v(1,1)*dx(1)*.5))+kfe/de + c*dx(1)) kfe/de];
		b(1) = -G(1)*dx(1) - cb_v(1,1) * cb_v(1,2)-((cb_v(1,1)^2)*cb_v(1,2)*dx(1)*.5/(kw - (cb_v(1,1)*dx(1)*.5)) );
	end

	%Frontera Derecha
	if cb_t(2) == 'D' %Cond. Dirichlet
		kfw = kint(N-1);
		dw = M(N,1);
		ke = kint(N-1);
		K(N,N-1:N) = [kfw/dw -(kfw/dw + 2*ke/dx(N) + c*dx(N))];
		b(N) = -G(N) * dx(N) - 2*ke/dx(N) * cb_v(2);
	elseif cb_t(2) == 'N' %Neumann
		kfw = kint(N-1);
		dw = M(N,1);
		ke = kint(N-1);
		K(N,N-1:N) = [kfw/dw -(kfw/dw+c*dx(N))];
		b(N) = -G(N)*dx(N) + cb_v(2);
	else %Robin
		kfw = kint(N-1);
		dw = M(N,1);
		ke = kint(N-1);
		K(N,N-1:N) = [kfw/dw -((cb_v(2,1)*ke/(ke+cb_v(2,1)*dx(N)*.5))+kfw/dw + c*dx(N))];
		b(N) = -G(N)*dx(N) - cb_v(2,1) * cb_v(2,2)+((cb_v(2,1)^2)*cb_v(2,2)*dx(N)*.5/(ke + (cb_v(2,1)*dx(N)*.5)) );
	end

	%Resolución del sistema de ecuaciones
	T = K\b;
end
