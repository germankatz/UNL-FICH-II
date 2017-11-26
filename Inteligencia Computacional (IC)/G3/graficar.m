function graficar(M,x)
    %x: rango
    %close all;
    P=['r' 'g' 'b' 'y' 'k' 'c' 'm'];
    [f c]=size(M);
    vx=[x(1):0.01:x(2)];
    n=length(vx);
    vy=zeros(1,n);
    %figure;
    hold on;
    if (c==4)
        for i=1:f
            for j=1:n
                vy(j)=membresia(M(i,:),[],vx(j));
            end
            plot(vx,vy,P(i));
        end
    else
        for i=1:f
            for j=1:n
                vy(j)=membresia([],M(i,:),vx(j));
            end
            plot(vx,vy,P(i));
        end
    end
    %hold off;
end