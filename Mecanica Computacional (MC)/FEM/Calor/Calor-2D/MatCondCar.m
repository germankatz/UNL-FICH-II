function [K] = MatCondCar(xnode,kxx,ky)
    if (size(xnode,1) == 3) % elemento triangular
        
        A = 0.5*det([1 xnode(1,1) xnode(1,2);
                     1 xnode(2,1) xnode(2,2);
                     1 xnode(3,1) xnode(3,2);]);
                 
%       a1=(xnode(2,1)*xnode(3,2)-xnode(3,1)*xnode(2,2) )/(2*A);         
        b1=(xnode(2,2)-xnode(3,2))/(2*A); 
        c1=(xnode(3,1)-xnode(2,1))/(2*A); 
        
%       a2=(xnode(3,1)*xnode(1,2)-xnode(1,1)*xnode(3,2) )/(2*A);
        b2=(xnode(3,2)-xnode(1,2))/(2*A); 
        c2=(xnode(1,1)-xnode(3,1))/(2*A);
        
%       a3=(xnode(1,1)*xnode(2,2)-xnode(2,1)*xnode(1,2) )/(2*A);
        b3=(xnode(1,2)-xnode(2,2))/(2*A); 
        c3=(xnode(2,1)-xnode(1,1))/(2*A);
        
       
        B = [b1 b2 b3;c1 c2 c3];
        k = [kxx 0;0 ky];
        K = A*(B'*k*B);
        
    else %elemento cuadrangular
        if (xnode(1,1)==xnode(2,1))
            hx = abs(xnode(2,1)-xnode(3,1));
            hy = abs(xnode(1,2)-xnode(2,2));
        else
            hx = abs(xnode(2,1)-xnode(1,1));
            hy = abs(xnode(3,2)-xnode(2,2));
        end
        A = hx*hy;
        C = 1/(3*A);
        X = kxx*hx^2; Y = ky*hy^2;
        K = C*[X+Y          0.5*X-Y       -0.5*(X+Y)   -X+0.5*Y;
               0.5*X-Y      X+Y           -X+0.5*Y     -0.5*(X+Y);
               -0.5*(X+Y)   -X+0.5*Y      X+Y          0.5*X-Y;         
               -X+0.5*Y     -0.5*(X+Y)    0.5*X-Y      X+Y];
    end