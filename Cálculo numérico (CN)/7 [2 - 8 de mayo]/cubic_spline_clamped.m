function [a,b,c,d] = cubic_spline_clamped(x,f,df)
    n = length(x);
    b = zeros(n,1);
    c = zeros(n,1);
    d = zeros(n,1);
    for i=1:n-1
        h(i)=x(i+1)-x(i);
    end
    alfa(1) = ((3*(f(2)-f(1)))/h(1)) - (3*df(1));
    alfa(n) = (3*df(2)) - ((3*(f(n)-f(n-1)))/h(n-1));
    for i=2:n-1
        alfa(i) = ((3*(f(i+1)-f(i)))/h(i)) - ((3*(f(i)-f(i-1)))/h(i-1));
    end
    l(1) = 2*h(1);
    u(1) = 0.5;
    z(1) = alfa(1)/l(1);
    for i=2:n-1
        l(i) = (2*(x(i+1)-x(i-1))) - (h(i-1)*u(i-1));
        u(i) = h(i)/l(i);
        z(i) = (alfa(i)-(h(i-1)*z(i-1)))/l(i);
    end
    l(n) = h(n-1)*(2-u(n-1));
    z(n) = (alfa(n)-(h(n-1)*z(n-1)))/l(n);
    c(n) = z(n);
    for j=n-1:-1:1
        c(j) = z(j)-(u(j)*c(j+1));
        b(j) = ((f(j+1)-f(j))/h(j)) - ((h(j)*(c(j+1)+(2*c(j))))/3);
        d(j) = (c(j+1)-c(j))/(3*h(j));
    end
    a = f';
endfunction