function [w,w0,epo,Te]=ps_entrenamiento(epomax,M,tol,ta)
    [f,c]=size(M);
    w0=rand(c,1)-0.5;
    w=w0;
    entradas=[-ones(f,1),M(:,1:end-1)];
    yd=M(:,end);
    epo=0;
    while (epo<epomax)
       for p=1:f
            z=entradas(p,:)*w;
            yc=signo(z);
            w=w+ta*(yd(p)-yc)*entradas(p,:)';
       end
       error=0;
       for p=1:f
           z=entradas(p,:)*w;
           yc=signo(z);
           if (yd(p)~=yc)
               error=error+1;
           end
       end
       Te=error/f;
       if (Te<=tol)
           break;
       end
       epo=epo+1;
    end
end