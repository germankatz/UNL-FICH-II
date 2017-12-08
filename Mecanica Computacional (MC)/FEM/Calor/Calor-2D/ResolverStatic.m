function [Kfinal,Ffinal,KantesDir,FantesDir,ELEMS,Testacionaria] = ResolverStatic()
%% Datos del problema
DataProblem %archivo con los datos del problema

%% Desarrollo
% Matriz y vector final (para resolver KT=F ensamblada)
Kfinal = zeros(cantNodos,cantNodos);
Ffinal = zeros(cantNodos,1);


%recorro por elementos
for i=1:cantElementos       %filas de icone
    
    ele = icone(i,:);       %tengo el elemento i-esimo
    
    %separo si es triangulo o cuadrangulo
    if( ele(4) == -1) %es triangulo  
        ele = ele(1:3);
        xnode_loc = xnode(ele,:);  %tengo las coordenadas del elemento local
    else%es cuadrangulo
        xnode_loc = xnode(ele,:);       %tengo las coordenadas del elemento local
    end
    
    %Area del elemento
    Area = area_ele(xnode_loc);
       
      
    
    %Coeficientes de Funciones de Forma ya dividos por el area.
    if(length(xnode_loc) == 3)% triangulo
        %N1 = coef(1,1) + Coef(1,2)x + Coef(1,3)y
        %N2 = coef(2,1) + Coef(2,2)x + Coef(2,3)y
        %N1 = coef(3,1) + Coef(3,2)x + Coef(3,3)y
        Coef =FFormTriCart(xnode_loc,Area);
        
    else%cuadrangulo
        Coef = FFormRectCart(xnode_loc,Area);
    end
    
    
    %Matriz K del elemento 
    if(usarNaturales == 1)%utiliza coordenadas Naturales
        if(usarSimbolico == 1)%utiliza expresiones simbolicas
            Kdif = MatCondNat(xnode_loc,kxx,ky);    
        else %utiliza aproximacion de  Integral Numerica
            Kdif = MatCondNatIN(xnode_loc,kxx,ky);
        end
    else %utiliza coordenadas cartesianas
        Kdif = MatCondCar(xnode_loc,kxx,ky);
    end
        
    
    
    % calcular F con la fuente que existe en TODOS los elementos    
    Felem = genF(xnode_loc,Q, espesor);
    
    
    %%% calcular matriz C de CT SOLO SIRVE EN TRIANGULOS
    Kc_elem = MatReaccionCar(c, Area, espesor, xnode_loc);
    
    
    % ENSAMBLAR Kglobal y Fglobal
    Kfinal(ele,ele)=Kfinal(ele,ele)+Kdif+Kc_elem;
	Ffinal(ele)=Ffinal(ele)+Felem;
 
    %ELEMS son celdas con los datos de cada elemento, utilizado para
    %guardar datos de cada elemento y tenerlo separado
    ELEMS{i}.numeroElemento = i;
    ELEMS{i}.NodosElemento = ele;
    ELEMS{i}.Area = Area;
    ELEMS{i}.CoefFuncionesForma = Coef;
    ELEMS{i}.Kdifusivo  = Kdif;
    ELEMS{i}.FelemFuenteGlobal = Felem;
    ELEMS{i}.Kreactivo_Kc = Kc_elem;
end 

%% Fuentes Especiales

%%% calculo la fuente que viva en un solo elemento
for i=1:size(FuenteElemento,1)  
    
    indiceEle = FuenteElemento(i,1); %numero de elemento 
    Qfuente = FuenteElemento(i,end);
    Area = ELEMS{indiceEle}.Area;
    
    %Obtengo los nodos del elemento que tiene una fuente distribuida
    ele = icone(indiceEle,:); %ele son los nodos del elemento
    
    if(ele(4) == -1) %es triangulo
        ele = ele(1:3);
        FqElem=(Area*espesor*Qfuente/3).*[1 1 1]'; %Fuente  que vive en el elemento        
    else%es cuadrangulo
        FqElem=(Area*espesor*Qfuente/4).*[1 1 1 1]'; %Fuente  que vive en el elemento  
    end
    
    ELEMS{indiceEle}.FuenteEnElemento = FqElem;
    %ensamblo ya en la final
	Ffinal(ele)=Ffinal(ele)+FqElem;
end



%%% calculo la fuente puntual
for i=1:size(FuentePuntual,1)
   
    indiceEle = FuentePuntual(i,1);    %numero de elemento 
    Qp = FuentePuntual(i,end);         %valor fuente puntual
    Area = ELEMS{indiceEle}.Area;       %area del elemento
    %Obtengo los nodos del elemento que tiene una fuente distribuida
    ele = icone(indiceEle,:); %ele son los nodos del elemento
    Coef = ELEMS{indiceEle}.CoefFuncionesForma; %coeficientes de funciones de forma de ese elemento
    
   
    if(ele(4) == -1) %es triangulo
        ele = ele(1:3);
        %funcion  de forma es cte x y 
        x_ = FuentePuntual(i,2);
        y_ = FuentePuntual(i,3);
        puntito=[1 x_ y_ ]'; %punto donde esta aplicado
        res=Coef*puntito;%interpolacion con f de forma

        Fconc=[ res(1)*Qp;
                res(2)*Qp;
                res(3)*Qp];
    else %es cuadrangulo
        %funcion  de forma es cte x y xy
        x_ = FuentePuntual(i,2);
        y_ = FuentePuntual(i,3);
        xy_ = x_ * y_ ;
        puntito=[1 x_ y_ xy_ ]'; %punto donde esta aplicado
        res=Coef*puntito;%interpolacion con f de forma

        Fconc=[ res(1)*Qp;
                res(2)*Qp;
                res(3)*Qp;
                res(4)*Qp];
    end
    
    ELEMS{indiceEle}.Fpuntual = Fconc;
    %ensamblo el vector final
    Ffinal(ele)=Ffinal(ele)+Fconc;
end




%% Aplico condiciones de borde

%Condicion de borde robin
%Recorda que la condicion ROBIN es la unica que toca tanto la matriz K como
%el lado derecho F del sistema Kx=F
if(size(robin,1)>0)%solo si se tiene condiciones robin se reccorre
	for i=1:size(robin,1)   %Recorro las aristas que tenga.
		
        % [arista h Tamb]        
        arista=robin(i,1:2);
		h=robin(i,3);
		Tamb=robin(i,4);
		
        long=norm(xnode(arista(1),:)-xnode(arista(2),:));  %longitud de la arista
        
		frob=(h*Tamb*long*espesor)/2*[1 1]';           %solo los afectados por la cb
		Krob=espesor*h*(long/6)*[2,1;1,2];                 %solo los coef de dnd interviene
                                                    %El resto de los nodos del elemento son ceros 
        
        %Esta es la forma FEA de buscar en que elemento esta la arista para
        %guardar el dato en mis celdas elementales...
        for m=1:size(icone,1)          
            if (ismember(arista,icone(m,:)))
                elemento = icone(m,:);
                if elemento(4) == -1
                   kaux=zeros(3,3); 
                   faux=zeros(3,1);
                else
                   kaux=zeros(4,4); 
                   faux=zeros(4,1);
                end
                               
                [e,r]=find(icone(m,:)==arista(1));
                [e1,r1]=find(icone(m,:)==arista(2));                
                kaux(r,r)=Krob(1,1);
                kaux(r,r1)=Krob(1,2);
                kaux(r1,r)=Krob(2,1);
                kaux(r1,r1)=Krob(2,2);
                ELEMS{m}.Krob=kaux;                
                faux=zeros(3,1);
                faux(r)=frob(1);
                faux(r1)=frob(2);
                ELEMS{m}.frob=faux;
                
            end
        end
        
		Kfinal(arista,arista)=Kfinal(arista,arista)+Krob;
		Ffinal(arista)=Ffinal(arista)+frob;		
	end
end


%condicion borde noimann
%Aca tenes la arista, el procedimiento es similar al de robin, pero solo
%afecta al lado derecho de la ecuacion Kx=F

if(size(neuman,1)>0) %si hay condicion neumann recorro
    for i=1:size(neuman,1)
        % [arisata q]
		arista=neuman(i,1:2);       %arista que tiene la condicion neuman
		q=neuman(i,3);              %valor de "q" de la conicion
        
		long=norm(xnode(arista(1),:)-xnode(arista(2),:));  %Longitud de la arista
        
		fq=(q*long*espesor)/2*[1 1]';      %solo en los nodos que afecta, los otros nodos son ceros
        
        %mismo forma FEA  de buscar en que elemento esta la arista para
        %poder guardarla en mis celdas de elementos
        for m=1:size(icone,1)          
            if (ismember(arista,icone(m,:)))
                elemento = icone(m,:);
                if elemento(4) == -1
                	faux=zeros(3,1);
                else
                   	faux=zeros(4,1);
                end
                
                [e,r]=find(icone(m,:)==arista(1));
                [e1,r1]=find(icone(m,:)==arista(2));
                faux(r)=fq(1);
                faux(r1)=fq(2);
                ELEMS{m}.Fneuman=-faux; %Lo guardo como negativo 
                                       %para luego la f elemental completa 
                                       %solo sumar
            end
        end
        
		Ffinal(arista)=Ffinal(arista)-fq;%en el ensamble de la f global las neuman restan
	end
end


%IMPORTANTE Guardo todo antes de aplicar las Dirichlet asi tengo la matriz
%del ensamble de todo lo anterior sin pisar con dirichlet.
KantesDir=Kfinal; 
FantesDir=Ffinal;

%solo si se tiene condiciones dirichlet se reccorre
%[nodo - valor]
if(size(dirichlet,1)>0)
	for i=1:size(dirichlet,1)
		Kfinal(dirichlet(i,1),:)=zeros(1,cantNodos);%elimino el renglon metiendo ceros
		Kfinal(dirichlet(i,1),dirichlet(i,1))=1;    %agrego el 1 en la diagonal
		Ffinal(dirichlet(i,1))=dirichlet(i,2);      %impongo el valor en la F
	end
end


%resolver sistema
Testacionaria=Kfinal\Ffinal;
disp('Solucion Estacionaria:')
disp(Testacionaria)

%graficar gracias a https://stackoverflow.com/
figure(1);
visualizacionEst(Testacionaria,xnode,icone)
title('Solucion estacionaria')

end