syms dxdf dxvf Pe v k Fo dt ro cp nd Co a b N

v = subs(v,v,1);
k = subs(k,k,1);
ro = subs(ro,ro,1);
cp = subs(cp,cp,1);
nd = subs(nd,nd,1);
a = subs(a,a,0);
b = subs(b,b,1);
N = subs(N,N,5);

dx = (b-a)/(N-1); % VF: (b-a)/N
Pe = (v*dx)/(2*k);
dt = min(((0.5*ro*cp*dx^2)/(k*nd)),(dx/v));
Fo = (k*dt)/(ro*cp*dx^2);
Co = (v*dt)/dx;