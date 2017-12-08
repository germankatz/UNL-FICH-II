%Data problem

%coeficientes
kxx=2.37;
ky=2.37;
c = 0;
espesor = 1;
Q = 0;              %fuente global en todo El dominio
usarNaturales = 1;  %si esta en 1 usa coordenadas naturales, sino cartesianas
usarSimbolico = 1;  %Solo para Coordenadas Naturales es valido el uso de simbolico

%% Mallado
%posicion de los nodos
xnode =[0 0;
        12 5;
        0 15;
        20 15;
        20 3;
        ];
%conexion de elementos
% si el cuarto numero es -1 entonces es triangulo, sino es cuadrangulo. (no existe indice negativo)
icone = [1 2 3 -1;
         2 4 3 -1;
         5 4 2 -1;
        ];

%% Condiciones de borde

%nodo global- valor                            
dirichlet = [1 100;
             3 100;
             4 150;
             5 150;
            ];  
       
%ariastas  - valor q       
neuman=[1 2 0;
        2 5 0;
        3 4 5;
       ];
%neuman=[];    
%arista h tamb    
% robin=[3 6 1.2 30;
%        6 9 1.2 30;
%        1 2 1.2 30;
%        2 3 1.2 30;
%        ];       
%robin=[4 5 20 300;
%       5 6 20 300];
robin=[];
%% Fuentes Particulares
%Fuentes que existe solo en un elemento
%elemento - valor
FuenteElemento=[]; 

%Fuente puntual
%[elemento coord_x coord_y valorQ]
FuentePuntual=[];

%% Cantidad de elementos
cantElementos = size(icone,1);  %cantidad elementos
cantNodos = length(xnode(:,1)); %cantidad de nodos en la malla