function [Coef]=FFormRectCart(Puntos,Area)

    M=[ones(4,1) Puntos Puntos(:,1).*Puntos(:,2)];
    b=eye(4,4);
    Coef=zeros(4,4);
    for i=1:4
        Coef(i,:)=(M\b(:,i))';
    end
    
    
    Coef=Coef./(2*Area);
end