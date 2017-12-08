% Resolucion de un problema de conduccion de calor por FEM
% COORDENADAS CARTESIANAS - Funciones de forma lineales
% PDE a resolver: k*(d2T_dx2) + G = 0
% Parametros de entrada: 
%   xnode: conjuntos de nodos
%   sp: bandera para trabajar o no con matrices sparse
%       sp != 0 --> matriz sparse
%       sp == 0 --> matriz llena
%   k: difusion; G: fuente; 
function [T,Kg,fg] = FuncLineales(xnode,sp,k,G,TipoCB,ValorCB)
    % dirichlet Tipo D, Valor = Timpuesta zeros
    % neumann   Tipo N, Valor = q zeros
    % Robin     Tipo R, Valor = h Tambiente
    % Primer fila es lado izquierdo
    % Segunda fila es lado derecho
    
    % Cantidad de nodos y elementos
    Nnod = length(xnode);
    Nelem = Nnod - 1;
            
    % Derivadas de funciones de forma para cada elemento 
    dN_dx = @(h)[-1/h,1/h];
    
    Kele = zeros(Nelem,2,2);
    fele = zeros(Nelem,2);
    
    % Calculo de cada elemento: matriz y termino derecho
    for ele=1:Nelem
        h = xnode(ele+1)-xnode(ele);
        Kele(ele,:,:) = (k*h)*(dN_dx(h)'*dN_dx(h));
        fele(ele,:) = G*(h/2);
    end
    
    if sp
        rows = [];
        cols = [];
        coef = [];
    else
        Kg = zeros(Nnod,Nnod);
    end
    fg = zeros(Nnod,1);
    for ele=1:Nelem
        in_gl = [ele ele+1];
        if sp
            for il=1:2
                ig = in_gl(il);
                for jl=1:2
                    jg = in_gl(jl);
                    rows = [rows;ig];
                    cols = [cols;jg];    
                    coef = [coef;Kele(ele,il,jl)];
                end
            end
            Kg = sparse(rows,cols,coef);
            fg(in_gl) = fg(in_gl) + fele(ele,:)';
        else
            Klocal = reshape(Kele(ele,:,:),2,2);
            Kg(in_gl,in_gl) = Kg(in_gl,in_gl) + Klocal;
            fg(in_gl) = fg(in_gl) + fele(ele,:)';
        end
    end

    % Condicion de borde en lado izquierdo
    % x = 0
    if(TipoCB(1) == 'D') 
        Kg(1,:) = 0;
        Kg(1,1) = 1;
        fg(1) = ValorCB(1,1);
    end
    if(TipoCB(1) == 'N')
        q = ValorCB(1,1);
        h = xnode(2)-xnode(1);    %paso de la malla
        fg(1) = fg(1) + q*(h/2);
    end
    if(TipoCB(1) == 'R')
        coefH = ValorCB(1,1);
        Tamb = ValorCB(1,2);
        
        h = xnode(2)-xnode(1);    %paso de la malla
        
        Kg(1,1) = Kg(1,1) + coefH*(h/6);
        fg(1) =  fg(1) + coefH*Tamb*(h/2);
    end
    
    
    
    %Lado derecho
    % x = 1
    if(TipoCB(2) == 'D')        
        Kg(Nnod,:) = 0;
        Kg(Nnod,Nnod) = 1;
        fg(Nnod) = ValorCB(2,1);
    end
    if(TipoCB(2) == 'N')      
        q = ValorCB(2,1);
        h = xnode(end)-xnode(end-1);    %paso de la malla
        fg(Nnod) =  fg(Nnod) - q*(h/2);
    end
    if(TipoCB(2) == 'R')      
        coefH = ValorCB(2,1);
        Tamb = ValorCB(2,2);
        h = xnode(end)-xnode(end-1);    %paso de la malla
        
        Kg(Nnod,Nnod) = Kg(Nnod,Nnod) + coefH*(h/6);
        fg(Nnod) =  fg(Nnod) + coefH*Tamb*(h/2);
    end
    
    
    % Resolucion del sist. de ecuaciones
    T = Kg\fg;
    
    
    % Grafica de comparacion: analitica vs FEM
%     aux = G/(2*k);
%     a = ValorCB(2,1)-ValorCB(1,1)+aux;
%     xref=0:0.01:1;
%     T_an = (-aux)*(xref.^2)+a*xref+ValorCB(1,1);
    figure(1);clf;plot(xnode,T,'o-');   
end
