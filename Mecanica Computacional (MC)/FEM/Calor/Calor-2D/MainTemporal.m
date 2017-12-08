%resolver estatico
[K,F,Kad,Fad,ELEMS,Testacionaria] = ResolverStatic();

%datos del problema

DataProblem

rho = 1;
Cp = 1;
tita = 1; % 0: explicito, 1: implicito 

%calculso dt
dt = fem2d_heat_explicit_delta_t(xnode,icone,kxx,rho,Cp);
dt=dt/10;
cantIter = 50;

aux = dt/(rho*Cp);
dt=dt*10;
aux2 = (rho*Cp)/dt;

Hg = zeros(size(K));

%calcular matriz M (H)
if (usarSimbolico == 1)
    for i=1:cantElementos       %filas de icone    
        ele = icone(i,:);       %tengo el elemento i-esimo

        %separo si es triangulo o cuadrangulo
        if( ele(4) == -1) %es triangulo  
            ele = ele(1:3);
            xnode_loc = xnode(ele,:);  %tengo las coordenadas del elemento local
        else%es cuadrangulo
            xnode_loc = xnode(ele,:);       %tengo las coordenadas del elemento local
        end  
        [H] = MatH_simb(xnode_loc,1,1);
        ELEMS{i}.matHelem = H;
        
        % ENSAMBLAR H
%         Hg(ele,ele)=Hg(ele,ele)+H;
          Hg = assembly(Hg,H,ele);
    end
else
    for i=1:cantElementos       %filas de icone    
        ele = icone(i,:);       %tengo el elemento i-esimo

        %separo si es triangulo o cuadrangulo
        if( ele(4) == -1) %es triangulo  
            ele = ele(1:3);
            xnode_loc = xnode(ele,:);  %tengo las coordenadas del elemento local
        else%es cuadrangulo
            xnode_loc = xnode(ele,:);       %tengo las coordenadas del elemento local
        end  
        [H] = MatH_IN(xnode_loc,1,1);
        ELEMS{i}.matHelem = H;
        
        % ENSAMBLAR H
%         Hg(ele,ele)=Hg(ele,ele)+H;
          Hg = assembly(Hg,H,ele);
    end
end


%*************************************
%   Calculos temporales
%*************************************


T_anterior = zeros(cantNodos,1);
T_nuevo= zeros(cantNodos,1);

%Piso dirichlet [nodo - valor]
% for i=1:size(dirichlet,1)
%     T_anterior(dirichlet(i,1))=dirichlet(i,2);      %impongo el valor en la F
% end
T_anterior(dirichlet(:,1))=dirichlet(:,2);
%fin dirichlet

%% ************************************************************************
% ESQUEMA EXPLICITO
%**************************************************************************

if tita == 0    %explicita FE
    display('buscando solucion explicita')
    [Texplicita] = ExplicitHeatFEM2D(K,Hg,F,xnode,T_anterior,dirichlet,dt);
end



%% ************************************************************************
% ESQUEMA IMPLICITO
%**************************************************************************

if tita == 1
    display('arranca implicito');
    [Timplicita] = ImplicitHeatFEM2D(K,Hg,F,xnode,icone,T_anterior,T_nuevo,dirichlet,dt,cantIter,cantNodos,aux2);
end