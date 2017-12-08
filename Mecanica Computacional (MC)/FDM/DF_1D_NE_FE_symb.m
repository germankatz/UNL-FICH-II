syms Tima1n Tima1nm1 Time1n Time1nm1 Tin Tinm1 v k c G dx n q h Tinf ro cp dt a b N

%% Datos
v = subs(v,v,0);
%k = subs(k,k,1);
c = subs(c,c,0);
%G = subs(G,G,100);
%q = subs(q,q,1);
% h = subs(h,h,5);
% Tinf = subs(Tinf,Tinf,5);
%a = subs(a,a,0);
%b = subs(b,b,1);
%N = subs(N,N,5);
%ro = subs(ro,ro,1);
%cp = subs(cp,cp,1);

%dx = (b-a)/(N-1);
%dt = min((0.5*dx^2)/(k/(ro*cp)),dx/v);

%% Forward Euler. Nodos interiores (desde i=2 hasta i=N-1)
etc_ne = (ro*cp*((Tinm1-Tin)/dt)+v*((Tima1n-Time1n)/(2*dx))-k*((Time1n-2*Tin+Tima1n)/(dx^2))+c*Tin==G);
etc_ne = (Tinm1 == collect(solve(etc_ne,Tinm1),[Time1n Tima1n Tin]));

%% Condiciones de borde
neumann = (-k*((Tima1n-Time1n)/(2*dx))*n - q == 0);
robin = (-k*((Tima1n-Time1n)/(2*dx))*n - h*(Tin-Tinf) == 0);

%% Neumann en el ultimo nodo (i=N)
etc_ne_N_N = subs(etc_ne,Tima1n,solve(neumann,Tima1n));
etc_ne_N_N = collect(etc_ne_N_N,[Time1n,Tin]);
etc_ne_N_N = subs(etc_ne_N_N,n,1);

%% Neumann en el primer nodo (i=1)
etc_ne_1_N = subs(etc_ne,Time1n,solve(neumann,Time1n));
etc_ne_1_N = collect(etc_ne_1_N,[Tima1n,Tin]);
etc_ne_1_N = subs(etc_ne_1_N,n,-1);

%% Robin en el ultimo nodo (i=N)
etc_ne_N_R = subs(etc_ne,Tima1n,solve(robin,Tima1n));
etc_ne_N_R = collect(etc_ne_N_R,[Time1n,Tin]);
etc_ne_N_R = subs(etc_ne_N_R,n,1);

%% Robin en el primer nodo (i=1)
etc_ne_1_R = subs(etc_ne,Time1n,solve(robin,Time1n));
etc_ne_1_R = collect(etc_ne_1_R,[Tima1n,Tin]);
etc_ne_1_R = subs(etc_ne_1_R,n,-1);