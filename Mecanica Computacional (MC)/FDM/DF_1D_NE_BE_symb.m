syms Tima1n Tima1nm1 Time1n Time1nm1 Tin Tinm1 v k c G dx n q h Tinf ro cp dt

%% Datos
v = subs(v,v,10);
k = subs(k,k,2);
c = subs(c,c,0);
G = subs(G,G,1);
q = subs(q,q,1);
h = subs(h,h,5);
Tinf = subs(Tinf,Tinf,5);
a = subs(a,a,1);
b = subs(b,b,2);
N = subs(N,N,5); % cantidad de nodos
ro = subs(ro,ro,1);
cp = subs(cp,cp,1);

dx = (b-a)/(N-1);
dt = min((0.5*dx^2)/(k/(ro*cp)),dx/v);

%% Backward Euler. Nodos interiores (desde i=2 hasta i=N-1)
etc_ne = (ro*cp*((Tinm1-Tin)/dt)+v*((Tima1nm1-Time1nm1)/(2*dx))-k*((Time1nm1-2*Tinm1+Tima1nm1)/(dx^2))+c*Tinm1==G);
etc_ne = collect(etc_ne,[Time1nm1 Tima1nm1 Tinm1 Tin]);
%subs(etc_ne,[v k c G ro cp],[0 1 0 10 1 1])

%% Condiciones de borde
neumann = (-k*((Tima1nm1-Time1nm1)/(2*dx))*n - q == 0);
robin = (-k*((Tima1nm1-Time1nm1)/(2*dx))*n - h*(Tinm1-Tinf) == 0);

%% Neumann en el ultimo nodo (i=N)
etc_ne_N_N = subs(etc_ne,Tima1nm1,solve(neumann,Tima1nm1));
etc_ne_N_N = collect(etc_ne_N_N,[Time1nm1,Tinm1,Tin]);
etc_ne_N_N = subs(etc_ne_N_N,n,1);
%subs(etc_ne_N_N,[v k c G q ro cp],[5 1 0 0 5 1 1])

%% Neumann en el primer nodo (i=1)
etc_ne_1_N = subs(etc_ne,Time1nm1,solve(neumann,Time1nm1));
etc_ne_1_N = collect(etc_ne_1_N,[Tima1nm1,Tinm1,Tin]);
etc_ne_1_N = subs(etc_ne_1_N,n,-1);
%subs(etc_ne_1_N,[v k c G q ro cp],[5 1 0 1 5 1 1])

%% Robin en el ultimo nodo (i=N)
etc_ne_N_R = subs(etc_ne,Tima1nm1,solve(robin,Tima1nm1));
etc_ne_N_R = collect(etc_ne_N_R,[Time1nm1,Tinm1,Tin]);
etc_ne_N_R = subs(etc_ne_N_R,n,1);
%subs(etc_ne_N_R,[v k c G h Tinf ro cp],[0 1 0 10 1.2 30 1 1])

%% Robin en el primer nodo (i=1)
etc_ne_1_R = subs(etc_ne,Time1nm1,solve(robin,Time1nm1));
etc_ne_1_R = collect(etc_ne_1_R,[Tima1nm1,Tinm1,Tin]);
etc_ne_1_R = subs(etc_ne_1_R,n,-1);
%subs(etc_ne_1_R,[v k c G h Tinf ro cp],[0 1 0 10 1.2 30 1 1])