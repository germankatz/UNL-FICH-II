function [Te]=ps_prueba(M,w)
    [f,~]=size(M);
    entradas=[-ones(f,1),M(:,1:end-1)];
    yd=M(:,end);
    error=0;
    for p=1:f
        z=entradas(p,:)*w;
        yc=signo(z);
        if (yd(p)~=yc)
            error=error+1;
        end
    end
    Te=error/f;
end
