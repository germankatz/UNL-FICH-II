syms Tw Tp Te fe Tfw Tfe umefe fw umefw Ax Vp Kfe Kfw v Kw Kp Ke dw dwme de dema dx dy dz c G q h Tinf

%% Datos
v = subs(v,v,5);
Kw = subs(Kw,Kw,1);
Kp = subs(Kp,Kp,1);
Ke = subs(Ke,Ke,1);
dw = subs(dw,dw,1);
dwme = subs(dwme,dwme,1/2);
de = subs(de,de,1);
dema = subs(dema,dema,1/2);
dx = subs(dx,dx,1);
dy = subs(dy,dy,1);
dz = subs(dz,dz,1);
c = subs(c,c,0);
G = subs(G,G,100);

fe = dema/de;
umefe = 1 - fe;
fw = dwme/dw;
umefw = 1 - fw;
Ax = dy*dz;
Vp = dx*dy*dz;
Kfe = 1/((umefe/Kp)+(fe/Ke));
Kfw = 1/((umefw/Kp)+(fw/Kw));
Tfw = fw*Tp+umefw*Tw;
Tfe = fe*Tp+umefe*Te;

% temperatura robin:
%Tfe = (((Tp*Kp)/(Kp+h*(dx/2)))+((Tinf*h*(dx/2))/(Kp+h*(dx/2))));
%Tfw = (((Tp*Kp)/(Kp+h*(-dx/2)))+((Tinf*h*(-dx/2))/(Kp+h*(-dx/2))));

% flujo robin:
%Kfe*(Te-Tp)/de = (((Tinf*h)/(Kp+h*(dx/2)))-((Tp*h)/(Kp+(h*(dx/2)))));
%Kfw*(Tp-Tw)/dw = (((Tinf*h)/(Kp+h*(-dx/2)))-((Tp*h)/(Kp+(h*(-dx/2)))));

%% Celdas interiores (cuando la celda p no es frontera)
etc_e = (v*Ax*(Tfe-Tfw)-Ax*(Kfe*((Te-Tp)/de)-Kfw*((Tp-Tw)/dw))+c*Vp*Tp == G*Vp);
etc_e = collect(etc_e,[Tw Tp Te]);

%% Dirichlet en la ultima celda (cuando la celda p es la frontera derecha)
etc_e_N_D = (v*Ax*(Te-(fw*Tp+umefw*Tw))-Ax*(Kp*((Te-Tp)/(dx/2))-Kfw*((Tp-Tw)/dw))+c*Vp*Tp == G*Vp);
etc_e_N_D = collect(etc_e_N_D,[Tw Tp Te]);
etc_e_N_D = subs(etc_e_N_D,Te,50);

%% Dirichlet en la primera celda (cuando la celda p es la frontera izquierda)
etc_e_1_D = (v*Ax*((fe*Tp+umefe*Te)-Tw)-Ax*(Kfe*((Te-Tp)/de)-Kp*((Tp-Tw)/(dx/2)))+c*Vp*Tp == G*Vp);
etc_e_1_D = collect(etc_e_1_D,[Tw Tp Te]);
etc_e_1_D = subs(etc_e_1_D,Tw,50);

%% Dirichlet-Dirichlet cuando la celda p es unica
etc_e_u_DD = ((v*Ax*(Te-Tw))-Ax*(Kp*((Te-Tp)/(dx/2))-Kp*((Tp-Tw)/(dx/2)))+c*Vp*Tp == G*Vp);
etc_e_u_DD = collect(etc_e_u_DD,[Tw Tp Te]);
etc_e_u_DD = subs(etc_e_u_DD,[Tw Te],[100 100]);

%% Neumann en la ultima celda (cuando la celda p es la frontera derecha)
etc_e_N_N = (v*Ax*((Tp-((q*dx)/(2*Kp)))-(fw*Tp+umefw*Tw))-Ax*(-q-Kfw*((Tp-Tw)/dw))+c*Vp*Tp == G*Vp);
etc_e_N_N = collect(etc_e_N_N,[Tw Tp Te]);
etc_e_N_N = subs(etc_e_N_N,q,1);

%% Neumann en la primera celda (cuando la celda p es la frontera izquierda)
etc_e_1_N = (v*Ax*((fe*Tp+umefe*Te)-(Tp+((q*dx)/(2*Kp))))-Ax*(Kfe*((Te-Tp)/de)+q)+c*Vp*Tp == G*Vp);
etc_e_1_N = collect(etc_e_1_N,[Tw Tp Te]);
etc_e_1_N = subs(etc_e_1_N,q,1);

%% Dirichlet-Neumann cuando la celda p es unica
etc_e_u_DN = (v*Ax*((Tp-((q*dx)/(2*Kp)))-Tw)-Ax*(-q-Kp*((Tp-Tw)/(dx/2)))+c*Vp*Tp == G*Vp);
etc_e_u_DN = collect(etc_e_u_DN,[Tw Tp Te]);
etc_e_u_DN = subs(etc_e_u_DN,[Tw q],[50 1]);

%% Neumann-Dirichlet cuando la celda p es unica
etc_e_u_ND = (v*Ax*(Te-(Tp+(q*dx/2*Kp)))-Ax*(Kp*((Te-Tp)/(dx/2))+q)+c*Vp*Tp == G*Vp);
etc_e_u_ND = collect(etc_e_u_ND,[Tw Tp Te]);
etc_e_u_ND = subs(etc_e_u_ND,[q Te],[1 50]);

%% Robin en la ultima celda (cuando la celda p es la frontera derecha)
etc_e_N_R = (v*Ax*((((Tp*Kp)/(Kp+h*(dx/2)))+((Tinf*h*(dx/2))/(Kp+h*(dx/2))))-(fw*Tp+umefw*Tw))-Ax*(((Tinf*h)/(Kp+h*(dx/2)))-((Tp*h)/(Kp+(h*(dx/2))))-Kfw*((Tp-Tw)/dw))+c*Vp*Tp == G*Vp);
etc_e_N_R = collect(etc_e_N_R,[Tw Tp Te]);
etc_e_N_R = subs(etc_e_N_R,[h Tinf],[10 30]);

%% Robin en la primera celda (cuando la celda p es la frontera izquierda)
etc_e_1_R = (v*Ax*((fe*Tp+umefe*Te)-(((Tp*Kp)/(Kp+h*(-dx/2)))+((Tinf*h*(-dx/2))/(Kp+h*(-dx/2)))))-Ax*(Kfe*((Te-Tp)/de)-(((Tinf*h)/(Kp+h*(-dx/2)))-((Tp*h)/(Kp+(h*(-dx/2))))))+c*Vp*Tp == G*Vp);
etc_e_1_R = collect(etc_e_1_R,[Tw Tp Te]);
etc_e_1_R = subs(etc_e_1_R,[h Tinf],[10 30]);

%% Dirichlet-Robin cuando la celda p es unica
etc_e_u_DR = (v*Ax*((((Tp*Kp)/(Kp+h*(dx/2)))+((Tinf*h*(dx/2))/(Kp+h*(dx/2))))-Tw)-Ax*((((Tinf*h)/(Kp+h*(dx/2)))-((Tp*h)/(Kp+(h*(dx/2)))))-Kp*((Tp-Tw)/(dx/2)))+c*Vp*Tp == G*Vp);
etc_e_u_DR = collect(etc_e_u_DR,[Tw Tp Te]);
etc_e_u_DR = subs(etc_e_u_DR,[Tw h Tinf],[50 10 30]);

%% Robin-Dirichlet cuando la celda p es unica
etc_e_u_RD = (v*Ax*(Te-(((Tp*Kp)/(Kp+h*(-dx/2)))+((Tinf*h*(-dx/2))/(Kp+h*(-dx/2)))))-Ax*(Kp*((Te-Tp)/(dx/2))-(((Tinf*h)/(Kp+h*(-dx/2)))-((Tp*h)/(Kp+(h*(-dx/2))))))+c*Vp*Tp == G*Vp);
etc_e_u_RD = collect(etc_e_u_RD,[Tw Tp Te]);
etc_e_u_RD = subs(etc_e_u_RD,[Te h Tinf],[50 10 30]);