function [ga]=g_activacion(M,x)
    [f c]=size(M);
    ga=zeros(1,f);
    if (c==4)
        for i=1:f
            ga(i)=membresia(M(i,:),[],x);
        end
    else
        for i=1:f
            ga(i)=membresia([],M(i,:),x);
        end
    end
end