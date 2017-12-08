function [K] = MatCondNat(xnode,kxx,ky)
%xnode son las cordenadas del ELEMENTO solo, no de todo el dominio

    k = [kxx 0;0 ky];
    if (size(xnode,1) == 3) % elemento triangular
        J = [xnode(2,1)-xnode(1,1)  xnode(2,2)-xnode(1,2);
             xnode(3,1)-xnode(1,1)  xnode(3,2)-xnode(1,2)];
        DN = [-1 1 0;
              -1 0 1];
        V = inv(J)*DN;
        A = 0.5;
        K = (V'*k*V)*det(J)*A;
    else% es cuadrangulo
        syms e n % son s y t en apunte...
        % N1 a N4 son las funciones de formas del LIBRO
        N1 = 0.25*(1-e)*(1-n); N2 = 0.25*(1+e)*(1-n);
        N3 = 0.25*(1+e)*(1+n); N4 = 0.25*(1-e)*(1+n);
        %agrupo las funciones de forma
        N = [N1 N2 N3 N4];
        
        %define el mapeo entre las coordenadas cartesianas a naturales 
        x = xnode(1,1)*N1+xnode(2,1)*N2+xnode(3,1)*N3+xnode(4,1)*N4;
        y = xnode(1,2)*N1+xnode(2,2)*N2+xnode(3,2)*N3+xnode(4,2)*N4;
        
        %defino jacobiano en simbolico
        J = [diff(x,e)  diff(y,e); diff(x,n)  diff(y,n)];
        
        %defino sus derivadas
        DNde = diff(N,e); DNdn = diff(N,n); DN = [DNde; DNdn];
        
        %en apuntes es B, no V.
        V = inv(J)*DN;
        
        %integro la expresion int Bt k B
        integ = V'*k*V*det(J);
        %lo hace la intregral en coordenadas naturales
        K = double(int(int(integ,e,-1,1),n,-1,1)); 
end