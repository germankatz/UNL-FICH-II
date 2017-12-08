syms Tw Tp Te Ts Tn fe umefe fw umefw fs umefs fn umefn Ax Ay Vp Kfe Kfw Kfs Kfn Kw Kp Ke Ks Kn dw dwme de dema ds dsme dn dnma dx dy dz c G q h Tinf q1 q2

%% Datos
Kp = subs(Kp,Kp,2); % se reemplaza localmente
Kw = subs(Kw,Kw,2);
Ke = subs(Ke,Ke,2);
Ks = subs(Ke,Ke,2);
Kn = subs(Ke,Ke,2);
dx = subs(dx,dx,1); % ancho de la celda, se reemplaza localmente
dy = subs(dy,dy,1); % alto de la celda, se reemplaza localmente
dz = subs(dz,dz,1); % espesor
dw = subs(dw,dw,1/2); % se reemplaza localmente
dwme = subs(dwme,dwme,(0.2/2)); % se reemplaza localmente
de = subs(de,de,(0.2/2+0.1/2)); % se reemplaza localmente
dema = subs(dema,dema,(0.1/2)); % se reemplaza localmente
ds = subs(ds,ds,1); % se reemplaza localmente
dsme = subs(dsme,dsme,1/2); % se reemplaza localmente
dn = subs(dn,dn,1); % se reemplaza localmente
dnma = subs(dnma,dnma,1/2); % se reemplaza localmente
c = subs(c,c,0);
G = subs(G,G,75);

fe = dema/de;
umefe = 1 - fe;
fw = dwme/dw;
umefw = 1 - fw;
fn = dnma/dn;
umefn = 1 - fn;
fs = dsme/ds;
umefs = 1 - fs;
Ax = dy*dz;
Ay = dx*dz;
Vp = dx*dy*dz;
Kfe = 1/((umefe/Kp)+(fe/Ke));
Kfw = 1/((umefw/Kp)+(fw/Kw));
Kfn = 1/((umefn/Kp)+(fn/Kn));
Kfs = 1/((umefs/Kp)+(fs/Ks));

% Temperatura Robin:
%Tfe = (((Tp*Kp)/(Kp+h*(dx/2)))+((Tinf*h*(dx/2))/(Kp+h*(dx/2))));
%Tfw = (((Tp*Kp)/(Kp+h*(-dx/2)))+((Tinf*h*(-dx/2))/(Kp+h*(-dx/2))));
%Tfn = (((Tp*Kp)/(Kp+h*(dy/2)))+((Tinf*h*(dy/2))/(Kp+h*(dy/2))));
%Tfs = (((Tp*Kp)/(Kp+h*(-dy/2)))+((Tinf*h*(-dy/2))/(Kp+h*(-dy/2))));

% Flujo Robin:
%Kfe*(Te-Tp)/de = (((Tinf*h)/(Kp+h*(dx/2)))-((Tp*h)/(Kp+(h*(dx/2)))));
%Kfw*(Tp-Tw)/dw = (((Tinf*h)/(Kp+h*(-dx/2)))-((Tp*h)/(Kp+(h*(-dx/2)))));
%Kfn*(Tn-Tp)/dn = (((Tinf*h)/(Kp+h*(dy/2)))-((Tp*h)/(Kp+(h*(dy/2)))));
%Kfs*(Tp-Ts)/ds = (((Tinf*h)/(Kp+h*(-dy/2)))-((Tp*h)/(Kp+(h*(-dy/2)))));

%% Celdas interiores (cuando la celda p no es frontera)
etc_e = (-(Ax*(Kfe*((Te-Tp)/de)-Kfw*((Tp-Tw)/dw))+Ay*(Kfn*((Tn-Tp)/dn)-Kfs*((Tp-Ts)/ds)))+c*Vp*Tp == G*Vp); %Ecuacion general (adaptar a problema)
etc_e = collect(etc_e,[Tp Tw Te Ts Tn]);

%% Neumann-Neumann-Dirichlet-Dirichlet (Sur-Este-Norte-Oeste)
etc_e_u_NNDD = (-(Ax*(-q2-Kp*((Tp-Tw)/(dx/2)))+Ay*(Kp*((Tn-Tp)/(dy/2))-(-q1)))+c*Vp*Tp == G*Vp);
etc_e_u_NNDD = collect(etc_e_u_NNDD,[Tp Tw Te Ts Tn]);
etc_e_u_NNDD = subs(etc_e_u_NNDD,[q1 q2 Tn Tw],[2 0 30 100]);

% %% Neumann-Dirichlet-Robin-Dirichlet (Sur-Este-Norte-Oeste)
% etc_e_u_NDRD = (-(Ax*(Kp*((Te-Tp)/(dx/2))-Kp*((Tp-Tw)/(dx/2)))+Ay*((((Tinf*h)/(Kp+h*(dy/2)))-((Tp*h)/(Kp+(h*(dy/2)))))-(-q)))+c*Vp*Tp == G*Vp); %Ecuacion general (adaptar a problema)
% etc_e_u_NDRD = collect(etc_e_u_NDRD,[Tp Tw Te Ts Tn]);
% etc_e_u_NDRD = subs(etc_e_u_NDRD,[Tw Te q h Tinf],[100 50 0 10 30]); % Valores de condiciones de borde

% %% Celda 1 - Izquierda - Neumann-Robin-Dirichlet (Sur-Norte-Oeste)
% etc_e_1_NRD = (-(Ax*(Kfe*((Te-Tp)/de)-Kp*((Tp-Tw)/(dx/2)))+Ay*(-h*(Tp-Tinf)-(-q)))+c*Vp*Tp == G*Vp);
% etc_e_1_NRD = collect(etc_e_1_NRD,[Tp Tw Te Ts Tn]);
% etc_e_1_NRD = subs(etc_e_1_NRD,[Tw q h Tinf],[100 0 10 30]); %reemplazar condiciones de borde
% 
% %% Celda 2 - Derecha - Neumann-Dirichlet-Robin (Sur-Este-Norte)
% etc_e_2_NDR = (-(Ax*(Kp*((Te-Tp)/(dx/2))-Kfw*((Tp-Tw)/dw))+Ay*(-h*(Tp-Tinf)-(-q)))+c*Vp*Tp == G*Vp);
% etc_e_2_NDR = collect(etc_e_2_NDR,[Tp Tw Te Ts Tn]);
% etc_e_2_NDR = subs(etc_e_2_NDR,[q Te h Tinf],[0 50 10 30]);