syms Tima1j Time1j Tij Tijme1 Tijma1 k G dx dy n q h Tinf a b N

%% Datos
%v = subs(v,v,5);
%k = subs(k,k,1);
%c = subs(c,c,0);
%G = subs(G,G,0);
%q = subs(q,q,5);
%h = subs(h,h,5);
%Tinf = subs(Tinf,Tinf,5);
%a = subs(a,a,0);
%b = subs(b,b,1);
%N = subs(N,N,5);

%dx = (b-a)/(N-1);

%% Nodos interiores (desde i=2 hasta i=N-1)
etc_e = (k*(((Time1j-2*Tij+Tima1j)/(dx^2))+((Tijme1-2*Tij+Tijma1)/(dy^2))) == G);
etc_e = collect(etc_e,[Tima1j,Time1j,Tij,Tijma1,Tijme1]);

%% Condiciones de borde
neumanni = (-k*((Tima1j-Time1j)/(2*dx))*n - q == 0);
neumannj = (-k*((Tijma1-Tijme1)/(2*dy))*n - q == 0);

%% Neumann en la frontera derecha
etc_e_Ni_N = subs(etc_e,Tima1j,solve(neumanni,Tima1j));
etc_e_Ni_N = collect(etc_e_Ni_N,[Tima1j,Time1j,Tij,Tijma1,Tijme1]);
etc_e_Ni_N = subs(etc_e_Ni_N,n,1);

%% Neumann en la frontera inferior
etc_e_1j_N = subs(etc_e,Tijme1,solve(neumannj,Tijme1));
etc_e_1j_N = collect(etc_e_1j_N,[Tima1j,Time1j,Tij,Tijma1,Tijme1]);
etc_e_1j_N = subs(etc_e_1j_N,n,-1);