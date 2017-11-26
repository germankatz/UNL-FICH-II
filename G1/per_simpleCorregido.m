function [w0]=per_simple(epo,M,tol,f)
    l=length(M(:,1));
    n=length(M(1,:));
    w0=rand(n,1)-0.5;
    x=[-ones(l,1),M(:,1:end-1)];
    yd=M(:,end);
    k=0;
    while (k<epo)
       for p=1:l
            z=x(p,:)*w0;
            yc=signo(z);
            w0=w0+f*(yd(p)-yc)*x(p,:)';
       end
       error=0;
       for p=1:l
           z=x(p)*w0; %%aca error, nos olvidamos de poner x(p,:) en lugar de x(p)
           yc=signo(z);
           if (yd(p)~=yc)
               error=error+1;
           end
       end
       Terror=error/l
       if (Terror<=tol)
           break;
       end
       k=k+1;
    end
end
