%pderect([-5,0,0,5])
%pderect([0,5,-5,5])
nPartABPDE = nPartAB*5;

%% Se llama a la funcisn creada con PDETool
f_PDEToolSol

%% Grafica de vectores de velocidad
%Exportar la malla del GUI y la solucisn.
%Devuelve el gradiente en los centros de los elementos.
[ux,uy] = pdegrad(p,t,u);
%Devuelve el gradiente en los nodos de los elementos.
ux = -pdeprtni(p,t,ux);
uy = -pdeprtni(p,t,uy);
%
figure(2)
%hold on
%quiver(p(1,:)',p(2,:)',ux,uy,1.5,'r')
%hold off
%Interpolacisn de los valores para que coincidan con el resultado obtenido con los puntos de la solucisn por
%los principios variacionales.
m_uxDT = TriScatteredInterp(p(1,:)',p(2,:)',ux);
m_uyDT = TriScatteredInterp(p(1,:)',p(2,:)',uy);
hold on
m_VecVelXPDE = m_uxDT(m_CoordXVel,m_CoordYVel);
m_VecVelYPDE = m_uyDT(m_CoordXVel,m_CoordYVel);
quiver(m_CoordXVel,m_CoordYVel,m_uxDT(m_CoordXVel,m_CoordYVel),m_uyDT(m_CoordXVel,m_CoordYVel),1.5,'r')
hold off

%% Plot de la velocidad en direccisn X en el lado izquierdo
figure(3)
m_IndLadIzq = abs(m_CoordXVel-(-5))<1e-5;
hold on
plot(m_CoordYVel(m_IndLadIzq),m_VecVelXPDE(m_IndLadIzq),'r')
hold off

%% Grafico de msdulo de velocidad sobre la lmnea AB
figure(4)
m_CoordXABPDE = linspace(0,5,nPartABPDE);
m_CoordYABPDE = linspace(0,5,nPartABPDE);
m_VecVelXABPDE = m_uxDT(m_CoordXABPDE,m_CoordYABPDE);
m_VecVelYABPDE = m_uyDT(m_CoordXABPDE,m_CoordYABPDE);
hold on
plot(m_CoordXABPDE,hypot(m_VecVelXABPDE,m_VecVelYABPDE),'-r','LineWidth',1.5);
hold off
