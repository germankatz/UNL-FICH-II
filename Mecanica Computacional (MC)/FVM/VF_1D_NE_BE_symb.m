syms Twnm1 Tpn Tenm1 Tpnm1 fe Tfw Tfe umefe fw umefw Ax Vp Kfe Kfw v k dw dwme de dema dx dy dz c G q h Tinf a b N ro cp dt

%% Datos
v = subs(v,v,0);
%k = subs(k,k,1);
%dx = subs(dx,dx,1);
%a = subs(a,a,0);
%b = subs(b,b,1);
%N = subs(N,N,4);
%dx = (b-a)/N;
%dy = subs(dy,dy,1);
%dz = subs(dz,dz,1);
%dw = subs(dw,dw,dx);
%dwme = subs(dwme,dwme,dx/2);
%de = subs(de,de,dx);
%dema = subs(dema,dema,dx/2);
c = subs(c,c,0);
%G = subs(G,G,100);
%ro = subs(ro,ro,1);
%cp = subs(cp,cp,1);

%fe = dema/de;
%umefe = 1 - fe;
%fw = dwme/dw;
%umefw = 1 - fw;
Ax = dy*dz;
Vp = dx*dy*dz;
%Kfe = 1/((umefe/k)+(fe/k));
%Kfw = 1/((umefw/k)+(fw/k));
%Tfw = fw*Tpnm1+umefw*Twnm1;
%Tfe = fe*Tpnm1+umefe*Tenm1;

%dt = min((0.5*dx^2)/(k/(ro*cp)),dx/v);

%% Celdas interiores (cuando la celda p no es frontera)
etc_ne = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Tfe-Tfw)-Ax*(k*((Tenm1-Tpnm1)/de)-k*((Tpnm1-Twnm1)/dw))+c*Vp*Tpnm1 == G*Vp);
etc_ne = collect(etc_ne,[Twnm1 Tenm1 Tpnm1 Tpn]);

%% Dirichlet en la ultima celda (cuando la celda p es la frontera derecha)
etc_ne_N_D = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Tenm1-(fw*Tpnm1+umefw*Twnm1))-Ax*(k*((Tenm1-Tpnm1)/(dx/2))-k*((Tpnm1-Twnm1)/dw))+c*Vp*Tpnm1 == G*Vp);
etc_ne_N_D = collect(etc_ne_N_D,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_N_D = subs(etc_ne_N_D,Tenm1,50);

%% Dirichlet en la primera celda (cuando la celda p es la frontera izquierda)
etc_ne_1_D = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((fe*Tpnm1+umefe*Tenm1)-Twnm1)-Ax*(k*((Tenm1-Tpnm1)/de)-k*((Tpnm1-Twnm1)/(dx/2)))+c*Vp*Tpnm1 == G*Vp);
etc_ne_1_D = collect(etc_ne_1_D,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_1_D = subs(etc_ne_1_D,Twnm1,100); % agregar valor dirichlet

%% Dirichlet-Dirichlet cuando la celda p es unica
etc_ne_u_DD = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+(v*Ax*(Tenm1-Twnm1))-Ax*(k*((Tenm1-Tpnm1)/(dx/2))-k*((Tpnm1-Twnm1)/(dx/2)))+c*Vp*Tpnm1 == G*Vp);
etc_ne_u_DD = collect(etc_ne_u_DD,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_u_DD = subs(etc_ne_u_DD,[Twnm1 Tenm1],[100 100]);

%% Neumann en la ultima celda (cuando la celda p es la frontera derecha)
etc_ne_N_N = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((Tpnm1-((q*dx)/(2*k)))-(fw*Tpnm1+umefw*Twnm1))-Ax*(-q-k*((Tpnm1-Twnm1)/dw))+c*Vp*Tpnm1 == G*Vp);
etc_ne_N_N = collect(etc_ne_N_N,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_N_N = subs(etc_ne_N_N,q,5);

%% Neumann en la primera celda (cuando la celda p es la frontera izquierda)
etc_ne_1_N = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((fe*Tpnm1+umefe*Tenm1)-(Tpnm1+((q*dx)/(2*k))))-Ax*(k*((Tenm1-Tpnm1)/de)+q)+c*Vp*Tpnm1 == G*Vp);
etc_ne_1_N = collect(etc_ne_1_N,[Twnm1 Tenm1 Tpnm1 Tpn]);
%etc_ne_1_N = subs(etc_ne_1_N,q,1);
 
%% Dirichlet-Neumann cuando la celda p es unica
etc_ne_u_DN = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((Tpnm1-((q*dx)/(2*k)))-Twnm1)-Ax*(-q-k*((Tpnm1-Twnm1)/(dx/2)))+c*Vp*Tpnm1 == G*Vp);
etc_ne_u_DN = collect(etc_ne_u_DN,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_u_DN = subs(etc_ne_u_DN,[Twnm1 q],[50 1]);

%% Neumann-Dirichlet cuando la celda p es unica
etc_ne_u_ND = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Tenm1-(Tpnm1+(q*dx/2*k)))-Ax*(k*((Tenm1-Tpnm1)/(dx/2))+q)+c*Vp*Tpnm1 == G*Vp);
etc_ne_u_ND = collect(etc_ne_u_ND,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_u_ND = subs(etc_ne_u_ND,[q Tenm1],[1 50]);

%% Robin en la ultima celda (cuando la celda p es la frontera derecha)
etc_ne_N_R = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((((Tpnm1*k)/(k+h*(dx/2)))+((Tinf*h*(dx/2))/(k+h*(dx/2))))-(fw*Tpnm1+umefw*Twnm1))-Ax*(((Tinf*h)/(k+h*(dx/2)))-((Tpnm1*h)/(k+(h*(dx/2))))-Kfw*((Tpnm1-Twnm1)/dw))+c*Vp*Tpnm1 == G*Vp);
etc_ne_N_R = collect(etc_ne_N_R,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_N_R = subs(etc_ne_N_R,[h Tinf],[10 30]);

%% Robin en la primera celda (cuando la celda p es la frontera izquierda)
etc_ne_1_R = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((fe*Tpnm1+umefe*Tenm1)-(((Tpnm1*k)/(k+h*(-dx/2)))+((Tinf*h*(-dx/2))/(k+h*(-dx/2)))))-Ax*(Kfe*((Tenm1-Tpnm1)/de)-(((Tinf*h)/(k+h*(-dx/2)))-((Tpnm1*h)/(k+(h*(-dx/2))))))+c*Vp*Tpnm1 == G*Vp);
etc_ne_1_R = collect(etc_ne_1_R,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_1_R = subs(etc_ne_1_R,[h Tinf],[12 30]);

%% Dirichlet-Robin cuando la celda p es unica
etc_ne_u_DR = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((((Tpnm1*k)/(k+h*(dx/2)))+((Tinf*h*(dx/2))/(k+h*(dx/2))))-Twnm1)-Ax*((((Tinf*h)/(k+h*(dx/2)))-((Tpnm1*h)/(k+(h*(dx/2)))))-k*((Tpnm1-Twnm1)/(dx/2)))+c*Vp*Tpnm1 == G*Vp);
etc_ne_u_DR = collect(etc_ne_u_DR,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_u_DR = subs(etc_ne_u_DR,[Twnm1 h Tinf],[50 10 30]);

%% Robin-Dirichlet cuando la celda p es unica
etc_ne_u_RD = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Tenm1-(((Tpnm1*k)/(k+h*(-dx/2)))+((Tinf*h*(-dx/2))/(k+h*(-dx/2)))))-Ax*(k*((Tenm1-Tpnm1)/(dx/2))-(((Tinf*h)/(k+h*(-dx/2)))-((Tpnm1*h)/(k+(h*(-dx/2))))))+c*Vp*Tpnm1 == G*Vp);
etc_ne_u_RD = collect(etc_ne_u_RD,[Twnm1 Tenm1 Tpnm1 Tpn]);
etc_ne_u_RD = subs(etc_ne_u_RD,[h Tinf Tenm1],[12 30 50]);