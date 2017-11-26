function graficar_mapeo(M,S,x,r)
    %x: rango
    vx=[x(1):0.01:x(2)];
    n=length(vx);
    vy=zeros(1,n);
    for i=1:n
        vy(i)=rsc(M,S,vx(i),r);
    end
    plot(vx,vy);
end