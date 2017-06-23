function f = odefunTP1Ej6(t,y)
% f = odefun3(t,f)

% DATOS
m = 0.5;
k = 20;
L = 5;

% Masas de las partículas
m_1 = m;
m_2 = m;
m_3 = m;
m_4 = m;
m_5 = m;
m_6 = m;
m_7 = m;

% Coordenadas iniciales de las partículas
x0_1 = [0 0];
x0_2 = [0 L];
x0_3 = [L 0];
x0_4 = [L L];
x0_5 = [2*L 0];
x0_6 = [2*L L];
x0_7 = [3*L 0];

% Constantes elásticas de los resortes
k_13 = k;
k_23 = k;
k_24 = k;
k_34 = k;
k_35 = k;
k_45 = k;
k_46 = k;
k_56 = k;
k_57 = k;
k_67 = k;

% Longitudes iniciales de los resortes
L0_13 = norm(x0_1-x0_3);
L0_23 = norm(x0_2-x0_3);
L0_24 = norm(x0_2-x0_4);
L0_34 = norm(x0_3-x0_4);
L0_35 = norm(x0_3-x0_5);
L0_45 = norm(x0_4-x0_5);
L0_46 = norm(x0_4-x0_6);
L0_56 = norm(x0_5-x0_6);
L0_57 = norm(x0_5-x0_7);
L0_67 = norm(x0_6-x0_7);

% Carga
W = [0 -5];

% Coordenadas actuales de las partículas
x_1 = x0_1;
x_2 = x0_2;
x_3 = ;
x_4 = ;
x_5 = ;
x_6 = ;
x_7 = ;
