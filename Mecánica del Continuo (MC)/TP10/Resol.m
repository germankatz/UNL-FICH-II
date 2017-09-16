%% Datos del problema
grPol = 5;
v = -10;
%
modVelBusc = 33;
posVelBusc = [2.5,2.5];

%% Datos gráfico
%Número de divisiones de cada rama de la L.
nPartx = 30;
nParty = 30;
%Número de divisiones de la línea A-B.
nPartAB = (nPartx+nParty)/2-4;

%% Matriz simbólica de producto coordenadas polinomio 
syms x y
nCoef = ((grPol+1)^2+(grPol+1))/2;
ms_X = sym(zeros(nCoef,1));
ind = 0;
for iy = 0:grPol
   for ix = 0:grPol-iy
      ind = ind+1;
      ms_X(ind) = (y+5)*x^ix*y^iy;
   end
end

%% Matriz de deformación simbólica
syms ms_B
ms_B = simplify([diff(ms_X.',x);diff(ms_X.',y)]);

%% Matriz de rigidez (matriz de coeficiente del sistema lineal)
syms ms_K
ms_K = int(int(ms_B.'*ms_B,x,-5,0),y,0,5)+int(int(ms_B.'*ms_B,x,0,5),y,-5,5);
m_K = double(ms_K);

%% Vector de fuerza (vector de términos independientes)
syms ms_Fr ms_F
ms_Fr = -int(subs(ms_X,x,-5),y,0,5);
ms_F = sym(v)*ms_Fr;
m_F = double(ms_F);

%% Resolución del sistema en forma simbólica
syms ms_A
ms_A = ms_K\ms_F;

%% Resolución del sistema en forma numérica
m_A = m_K\m_F;

%% Gráfico de la función potencial
figure(1)
%La grilla tiene que ser rectangular.
%[m_CoordX1,m_CoordY1] = meshgrid(linspace(-5,0,nPartx+1),linspace(0,5,nParty+1));
%[m_CoordX2,m_CoordY2] = meshgrid(linspace(0,5,nPartx+1),linspace(-5,5,nParty+1));
%m_Coord = [m_CoordX1(:),m_CoordY1(:);m_CoordX2(:),m_CoordY2(:)];
%m_CoordX = [m_CoordX1(:);m_CoordX2(:)];
%m_CoordY = [m_CoordY1(:);m_CoordY2(:)];
[m_CoordX,m_CoordY] = meshgrid(linspace(-5,5,2*nPartx+1),linspace(-5,5,2*nParty+1));
%Para graficar la L se pone NaN en las coordenadas fuera del dominio.
m_CoordX(m_CoordX<0&m_CoordY<0) = NaN;
m_CoordY(m_CoordX<0&m_CoordY<0) = NaN;
%
%m_FunPot = subs(ms_X,x,m_CoordX); %No funciona bien.
nPuntos = numel(m_CoordX);
m_XGraf = zeros(nPuntos,nCoef);
%Se evalua cada uno de los elementos de ms_X para todos los puntos de grilla de la gráfica.
for iCoef = 1:nCoef   
   m_XGraf(:,iCoef) = subs(ms_X(iCoef),{x,y},{m_CoordX(:),m_CoordY(:)});
end
%Función potencial
m_FunPot = reshape(m_XGraf*m_A,size(m_CoordX));
%Gráfico
surf(m_CoordX,m_CoordY,m_FunPot)
view(2)
m_RelEjeOrig = get(gca,'DataAspectRatio');
set(gca,'DataAspectRatio',[1,1,m_RelEjeOrig(3)]);

%% Gráfico del campo velocidad
figure(2)
[m_CoordX1,m_CoordY1] = meshgrid(linspace(-5,0,nPartx+1),linspace(0,5,nParty+1));
[m_CoordX2,m_CoordY2] = meshgrid(linspace(0,5,nPartx+1),linspace(-5,5,2*nParty+1));
%m_Coord = [m_CoordX1(:),m_CoordY1(:);m_CoordX2(:),m_CoordY2(:)];
m_CoordXVel = [m_CoordX1(:);m_CoordX2(:)];
m_CoordYVel = [m_CoordY1(:);m_CoordY2(:)];
%
nPuntos = numel(m_CoordXVel);
%Se divide en dos líneas la matriz de deformación.
m_BGraf1 = zeros(nPuntos,nCoef);
m_BGraf2 = zeros(nPuntos,nCoef);
%Se evalua cada uno de los elementos de ms_B para todos los puntos de grilla de la gráfica.
for iCoef = 1:nCoef   
   m_BGraf1(:,iCoef) = subs(ms_B(1,iCoef),{x,y},{m_CoordXVel,m_CoordYVel});
   m_BGraf2(:,iCoef) = subs(ms_B(2,iCoef),{x,y},{m_CoordXVel,m_CoordYVel});
end
%Vector de velocidad
m_VecVelX = -m_BGraf1*m_A;
m_VecVelY = -m_BGraf2*m_A;
%Gráfico
plot([0,0,5,5,-5,-5,0],[0,-5,-5,5,5,0,0],'k','LineWidth',2)
hold on
%El quiver escala a partir del tamaño automático que pone automáticamente.
quiver(m_CoordXVel,m_CoordYVel,m_VecVelX,m_VecVelY,1.5)
hold off
axis equal
%Plot de la velocidad en dirección X en el lado izquierdo
figure(3)
m_IndLadIzq = abs(m_CoordXVel-(-5))<1e-5;
plot(m_CoordYVel(m_IndLadIzq),m_VecVelX(m_IndLadIzq))
hold on
plot(m_CoordYVel(m_IndLadIzq),-v*ones(sum(m_IndLadIzq),1),'-k','LineWidth',1.5)
hold off

%% Gráfico de módulo de velocidad sobre la línea AB
figure(4)
m_CoordXAB = linspace(0,5,nPartAB);
m_CoordYAB = linspace(0,5,nPartAB);
%
%Para usar interp2 necesita ser una grilla uniforme hecha con meshgrid, se puede usar TriScatteredInterp.
nPuntos = numel(m_CoordXAB);
%Se divide en dos líneas la matriz de deformación.
m_BGraf1 = zeros(nPuntos,nCoef);
m_BGraf2 = zeros(nPuntos,nCoef);
%Se evalua cada uno de los elementos de ms_B para todos los puntos de grilla de la gráfica.
for iCoef = 1:nCoef   
   m_BGraf1(:,iCoef) = subs(ms_B(1,iCoef),{x,y},{m_CoordXAB,m_CoordYAB});
   m_BGraf2(:,iCoef) = subs(ms_B(2,iCoef),{x,y},{m_CoordXAB,m_CoordYAB});
end
%Vector de velocidad
m_VecVelX = -m_BGraf1*m_A;
m_VecVelY = -m_BGraf2*m_A;
%Gráfico del módulo de velocidad
%Se grafica en función de las coordenadas x de los puntos.
plot(m_CoordXAB,hypot(m_VecVelX,m_VecVelY),'-k','LineWidth',1.5);

%% Determinación de la velocidad de entrada para que un cierto punto tenga un módulo de velocidad dado
m_BGrafposVelBusc = subs(ms_B,{x,y},{posVelBusc(1),posVelBusc(2)});
m_VecVelposVelBusc = m_BGrafposVelBusc*m_A;
absVelEntr = modVelBusc/norm(m_VecVelposVelBusc)*abs(v);
 