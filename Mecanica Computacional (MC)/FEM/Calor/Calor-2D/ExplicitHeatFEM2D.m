function [T] = ExplicitHeatFEM2D(K,H,f,xnode,T_anterior,Dirichlet,dt)
    %DeltaT = getDeltaT(model,solve);
    DeltaT = dt;% DeltaT hardcodeado porque tengo mal el calculo del DeltaT
    

    nnodes = size(xnode,1);
    invH = inv(H);
    Kexp = eye(nnodes) - DeltaT*invH*K;
    fexp = DeltaT*invH*f;
    T = T_anterior;
    TPrev = T;
%     [~, TPrev] = dirCond([],TPrev,conds.Dir);
    
    for i = 1:1000000
        
    T = Kexp*TPrev + fexp;
        
        Error = norm(T-TPrev,2)/norm(TPrev,2);
        
       
        
        if Error < 1e-08
            fprintf('Explicito: \nSalida por tolerancia de error\n Error: %.8f - ItNum: %d\n',Error,i);
            fprintf(' Tiempo transcurrido: %.4f\n',DeltaT*i);
            return;
        end
        
        TPrev = T;
        
    end
    
    fprintf('Explicito: \nSalida por límite de iteraciones\n Error: %.8f - ItNum: %d\n',Error,i);
    fprintf(' Tiempo transcurrido: %.4f\n',DeltaT*i);
    
end
