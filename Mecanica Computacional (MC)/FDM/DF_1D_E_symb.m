syms Tima1 Time1 Ti v k c G dx n q h Tinf a b N

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

dx = (b-a)/(N-1);

%% Nodos interiores (desde i=2 hasta i=N-1)
etc_e = (v*((Tima1-Time1)/(2*dx))-k*((Time1-2*Ti+Tima1)/(dx^2))+c*Ti==G);
etc_e = collect(etc_e,[Tima1,Time1,Ti]);

%% Condiciones de borde
neumann = (-k*((Tima1-Time1)/(2*dx))*n - q == 0);
robin = (-k*((Tima1-Time1)/(2*dx))*n - h*(Ti-Tinf) == 0);

%% Neumann en el ultimo nodo (i=N)
etc_e_N_N = subs(etc_e,Tima1,solve(neumann,Tima1));
etc_e_N_N = collect(etc_e_N_N,[Time1,Ti]);
etc_e_N_N = subs(etc_e_N_N,n,1);

%% Neumann en el primer nodo (i=1)
etc_e_1_N = subs(etc_e,Time1,solve(neumann,Time1));
etc_e_1_N = collect(etc_e_1_N,[Tima1,Ti]);
etc_e_1_N = subs(etc_e_1_N,n,-1);

%% Robin en el ultimo nodo (i=N)
etc_e_N_R = subs(etc_e,Tima1,solve(robin,Tima1));
etc_e_N_R = collect(etc_e_N_R,[Time1,Ti]);
etc_e_N_R = subs(etc_e_N_R,n,1);

%% Robin en el primer nodo (i=1)
etc_e_1_R = subs(etc_e,Time1,solve(robin,Time1));
etc_e_1_R = collect(etc_e_1_R,[Tima1,Ti]);
etc_e_1_R = subs(etc_e_1_R,n,-1);