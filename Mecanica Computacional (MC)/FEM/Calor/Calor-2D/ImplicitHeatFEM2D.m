function [T_nuevo] = ImplicitHeatFEM2D(K,Hg,F,xnode,icone,T_anterior,T_nuevo,dirichlet,dt,cantIter,cantNodos,aux2)

    for j=1:cantIter
        K_imp = (aux2)*Hg+K;
        F_imp = F + (aux2)*Hg*T_anterior;
        %Aplico Dirichlet
        for i=1:size(dirichlet,1)
            K_imp(dirichlet(i,1),:)=zeros(1,cantNodos);%elimino el renglon metiendo ceros
            K_imp(dirichlet(i,1),dirichlet(i,1))=1;    %agrego el 1 en la diagonal
            F_imp(dirichlet(i,1))=dirichlet(i,2);      %impongo el valor en la F
        end

        T_nuevo = K_imp\F_imp;


        %figure(3);
        %visualizacionEst(T_nuevo,xnode,icone)
        %title('Esquema temporal implicito')

        % Cortar xq ya es estacionario y no hace falta iterar mas
        tmp = T_anterior-T_nuevo;
        if(norm(tmp) < 10e-6)
            display('Solucion estacionaria alcanzada')     
            T_nuevo
            break
        end

        T_anterior=T_nuevo;
    end
    
end