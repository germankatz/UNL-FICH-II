syms Tima1n Tima1nm1 Time1n Time1nm1 Tin Tinm1 v k c G dx n q h Tinf ro cp dt

%% Datos
v = subs(v,v,5);
k = subs(k,k,1);
c = subs(c,c,0);
G = subs(G,G,0);
q = subs(q,q,5);
h = subs(h,h,5);
Tinf = subs(Tinf,Tinf,5);
a = subs(a,a,0);
b = subs(b,b,1);
N = subs(N,N,5);
ro = subs(ro,ro,1);
cp = subs(cp,cp,1);

dx = (b-a)/(N-1);
dt = min((0.5*dx^2)/(k/(ro*cp)),dx/v);

%% Cracnk-Nocholson. Nodos interiores (desde i=2 hasta i=N-1)
etc_ne = (ro*cp*((Tinm1-Tin)/dt)+v*((Tima1nm1+Tima1n-Time1nm1-Time1n)/(4*dx))-k*((Time1nm1+Time1n-2*Tinm1-2*Tin+Tima1nm1+Tima1n)/(2*dx^2))+c*((Tinm1-Tin)/2)==G);
etc_ne = collect(etc_ne,[Time1nm1 Tima1nm1 Tinm1 Time1n Tima1n Tin]);

%% Condiciones de borde
neumann = (-k*((Tima1nm1+Tima1n-Time1nm1-Time1n)/(4*dx))*n - q == 0);
robin = (-k*((Tima1nm1+Tima1n-Time1nm1-Time1n)/(4*dx))*n - h*(((Tinm1+Tin)/2)-Tinf) == 0);

%% Neumann en el ultimo nodo (i=N)
etc_ne_N_N = subs(etc_ne,Tima1nm1,solve(neumann,Tima1nm1));
etc_ne_N_N = collect(etc_ne_N_N,[Time1nm1,Tinm1,Time1n,Tima1n,Tin]);
etc_ne_N_N = subs(etc_ne_N_N,n,1);

%% Neumann en el primer nodo (i=1)
etc_ne_1_N = subs(etc_ne,Time1nm1,solve(neumann,Time1nm1));
etc_ne_1_N = collect(etc_ne_1_N,[Tima1nm1,Tinm1,Time1n,Tima1n,Tin]);
etc_ne_1_N = subs(etc_ne_1_N,n,-1);

%% Robin en el ultimo nodo (i=N)
etc_ne_N_R = subs(etc_ne,Tima1nm1,solve(robin,Tima1nm1));
etc_ne_N_R = collect(etc_ne_N_R,[Time1nm1,Tinm1,Time1n,Tima1n,Tin]);
etc_ne_N_R = subs(etc_ne_N_R,n,1);

%% Robin en el primer nodo (i=1)
etc_ne_1_R = subs(etc_ne,Time1nm1,solve(robin,Time1nm1));
etc_ne_1_R = collect(etc_ne_1_R,[Tima1nm1,Tinm1,Time1n,Tima1n,Tin]);
etc_ne_1_R = subs(etc_ne_1_R,n,-1);