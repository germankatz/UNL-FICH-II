syms Twn Tpn Ten Tpnm1 fe Tfw Tfe umefe fw umefw Ax Vp Kfe Kfw v k dw dwme de dema dx dy dz c G q h Tinf a b N ro cp

%% Datos
v = subs(v,v,5);
k = subs(k,k,1);
dw = subs(dw,dw,1);
dwme = subs(dwme,dwme,1/2);
de = subs(de,de,1);
dema = subs(dema,dema,1/2);
dx = subs(dx,dx,1);
dy = subs(dy,dy,1);
dz = subs(dz,dz,1);
c = subs(c,c,0);
G = subs(G,G,100);
a = subs(a,a,0);
b = subs(b,b,1);
N = subs(N,N,5);
ro = subs(ro,ro,1);
cp = subs(cp,cp,1);

fe = dema/de;
umefe = 1 - fe;
fw = dwme/dw;
umefw = 1 - fw;
Ax = dy*dz;
Vp = dx*dy*dz;
Kfe = 1/((umefe/k)+(fe/k));
Kfw = 1/((umefw/k)+(fw/k));
Tfw = fw*Tpn+umefw*Twn;
Tfe = fe*Tpn+umefe*Ten;

dx = (b-a)/N;
dt = min((0.5*dx^2)/(k/(ro*cp)),dx/v);

%% Celdas interiores (cuando la celda p no es frontera)
etc_ne = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Tfe-Tfw)-Ax*(k*((Ten-Tpn)/de)-k*((Tpn-Twn)/dw))+c*Vp*Tpn == G*Vp);
etc_ne = (Tpnm1 == collect(solve(etc_ne,Tpnm1),[Twn Ten Tpn]));

%% Dirichlet en la ultima celda (cuando la celda p es la frontera derecha)
etc_ne_N_D = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Ten-(fw*Tpn+umefw*Twn))-Ax*(k*((Ten-Tpn)/(dx/2))-k*((Tpn-Twn)/dw))+c*Vp*Tpn == G*Vp);
etc_ne_N_D = (Tpnm1 == collect(solve(etc_ne_N_D,Tpnm1),[Twn Ten Tpn]));
etc_ne_N_D = subs(etc_ne_N_D,Ten,50);

%% Dirichlet en la primera celda (cuando la celda p es la frontera izquierda)
etc_ne_1_D = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((fe*Tpn+umefe*Ten)-Twn)-Ax*(k*((Ten-Tpn)/de)-k*((Tpn-Twn)/(dx/2)))+c*Vp*Tpn == G*Vp);
etc_ne_1_D = (Tpnm1 == collect(solve(etc_ne_1_D,Tpnm1),[Twn Ten Tpn]));
etc_ne_1_D = subs(etc_ne_1_D,Twn,50);

%% Dirichlet-Dirichlet cuando la celda p es unica
etc_ne_u_DD = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+(v*Ax*(Ten-Twn))-Ax*(k*((Ten-Tpn)/(dx/2))-k*((Tpn-Twn)/(dx/2)))+c*Vp*Tpn == G*Vp);
etc_ne_u_DD = (Tpnm1 == collect(solve(etc_ne_u_DD,Tpnm1),[Twn Ten Tpn]));
etc_ne_u_DD = subs(etc_ne_u_DD,[Twn Ten],[100 100]);

%% Neumann en la ultima celda (cuando la celda p es la frontera derecha)
etc_ne_N_N = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((Tpn-((q*dx)/(2*k)))-(fw*Tpn+umefw*Twn))-Ax*(-q-k*((Tpn-Twn)/dw))+c*Vp*Tpn == G*Vp);
etc_ne_N_N = (Tpnm1 == collect(solve(etc_ne_N_N,Tpnm1),[Twn Ten Tpn]));
etc_ne_N_N = subs(etc_ne_N_N,q,1);

%% Neumann en la primera celda (cuando la celda p es la frontera izquierda)
etc_ne_1_N = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((fe*Tpn+umefe*Ten)-(Tpn+((q*dx)/(2*k))))-Ax*(k*((Ten-Tpn)/de)+q)+c*Vp*Tpn == G*Vp);
etc_ne_1_N = (Tpnm1 == collect(solve(etc_ne_1_N,Tpnm1),[Twn Ten Tpn]));
etc_ne_1_N = subs(etc_ne_1_N,q,1);
 
%% Dirichlet-Neumann cuando la celda p es unica
etc_ne_u_DN = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((Tpn-((q*dx)/(2*k)))-Twn)-Ax*(-q-k*((Tpn-Twn)/(dx/2)))+c*Vp*Tpn == G*Vp);
etc_ne_u_DN = (Tpnm1 == collect(solve(etc_ne_u_DN,Tpnm1),[Twn Ten Tpn]));
etc_ne_u_DN = subs(etc_ne_u_DN,[Twn q],[50 1]);

%% Neumann-Dirichlet cuando la celda p es unica
etc_ne_u_ND = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Ten-(Tpn+(q*dx/2*k)))-Ax*(k*((Ten-Tpn)/(dx/2))+q)+c*Vp*Tpn == G*Vp);
etc_ne_u_ND = (Tpnm1 == collect(solve(etc_ne_u_ND,Tpnm1),[Twn Ten Tpn]));
etc_ne_u_ND = subs(etc_ne_u_ND,[q Ten],[1 50]);

%% Robin en la ultima celda (cuando la celda p es la frontera derecha)
etc_ne_N_R = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((((Tpn*k)/(k+h*(dx/2)))+((Tinf*h*(dx/2))/(k+h*(dx/2))))-(fw*Tpn+umefw*Twn))-Ax*(((Tinf*h)/(k+h*(dx/2)))-((Tpn*h)/(k+(h*(dx/2))))-Kfw*((Tpn-Twn)/dw))+c*Vp*Tpn == G*Vp);
etc_ne_N_R = (Tpnm1 == collect(solve(etc_ne_N_R,Tpnm1),[Twn Ten Tpn]));
etc_ne_N_R = subs(etc_ne_N_R,[h Tinf],[10 30]);

%% Robin en la primera celda (cuando la celda p es la frontera izquierda)
etc_ne_1_R = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((fe*Tpn+umefe*Ten)-(((Tpn*k)/(k+h*(-dx/2)))+((Tinf*h*(-dx/2))/(k+h*(-dx/2)))))-Ax*(Kfe*((Ten-Tpn)/de)-(((Tinf*h)/(k+h*(-dx/2)))-((Tpn*h)/(k+(h*(-dx/2))))))+c*Vp*Tpn == G*Vp);
etc_ne_1_R = (Tpnm1 == collect(solve(etc_ne_1_R,Tpnm1),[Twn Ten Tpn]));
etc_ne_1_R = subs(etc_ne_1_R,[h Tinf],[2 30]);

%% Dirichlet-Robin cuando la celda p es unica
etc_ne_u_DR = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*((((Tpn*k)/(k+h*(dx/2)))+((Tinf*h*(dx/2))/(k+h*(dx/2))))-Twn)-Ax*((((Tinf*h)/(k+h*(dx/2)))-((Tpn*h)/(k+(h*(dx/2)))))-k*((Tpn-Twn)/(dx/2)))+c*Vp*Tpn == G*Vp);
etc_ne_u_DR = (Tpnm1 == collect(solve(etc_ne_u_DR,Tpnm1),[Twn Ten Tpn]));
etc_ne_u_DR = subs(etc_ne_u_DR,[Twn h Tinf],[50 10 30]);

%% Robin-Dirichlet cuando la celda p es unica
etc_ne_u_RD = (ro*cp*Ax*((Tpnm1-Tpn)/dt)+v*Ax*(Ten-(((Tpn*k)/(k+h*(-dx/2)))+((Tinf*h*(-dx/2))/(k+h*(-dx/2)))))-Ax*(k*((Ten-Tpn)/(dx/2))-(((Tinf*h)/(k+h*(-dx/2)))-((Tpn*h)/(k+(h*(-dx/2))))))+c*Vp*Tpn == G*Vp);
etc_ne_u_RD = (Tpnm1 == collect(solve(etc_ne_u_RD,Tpnm1),[Twn Ten Tpn]));
etc_ne_u_RD = subs(etc_ne_u_RD,[h Tinf Ten],[12 30 50]);