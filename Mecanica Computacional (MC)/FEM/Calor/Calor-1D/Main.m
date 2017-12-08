xnode = [0 0.25 0.5 0.75 1];
k = 2;
G = 10;
sp=0;
TipoCB = ['D' ; 'N'];
ValorCB =  [1 0;            %lado izquierdo   Dirichlet=[Td 0]
            -1.2 30];           %lado derecho     Neumann = [q 0]
                            %                 robin = [h Tinf]                            
                            
[T,Kg,fg] = FuncLineales(xnode,sp,k,G,TipoCB,ValorCB)