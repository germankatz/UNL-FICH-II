% Datos del problema

nu = 0.3;
E = 200*10^6;
t = 0.1;

%Dependiendo si pide deformacion plana o tension plana, comentar y descomentar
%la matriz D que sea correspondiente

%Matriz de tension plana
D = E/(1-nu^2) * [1  nu 0;
                  nu 1  0;
                  0  0  (1-nu)/2];

%Matriz de deformacion plana
%D = E/((1+nu)*(1-2*nu)) * [1-nu nu   0;
%                            nu   1-nu 0;
%                            0    0    (1-2*nu)/2];


%% Estructura del problema

xnode =[0 0; 
        1 0;
        2 0;
        2 0.5;
        1 0.5;
        0 0.5;
        ]; 
     
icone = [1 2 5 6;
         2 3 4 5;
        ];

Fg = 0; %fuerza de gravedad

%dir=[nodo direccion valor] [direccion en x = 1, direccion en y =2]
dir = [1 1 0;
       6 1 0;
       6 2 0;
       5 1 7071.07;
       5 2 7071.07;
      ];%condiciones dirichlet
   
%fuerza superficial (neumann) fs=[n1 n2 fx fy]   
fS = [1 2 0 -9000;
      2 3 0 -6000;
     ];   
    
%fuerzas puntuales (similar a  neumann)
%fPuntual = [nodo fx fy]
fPuntual = [];

%% ******************************


% Calculos

KK = zeros(length(xnode(:,1))*2);
FF = zeros(length(xnode(:,1))*2,1);

for i=1:length(icone(:,1))
  ele = icone(i,:);
  if(ele(4)==-1)
      ele = ele(1:3);
  end
  xnode_loc = xnode(ele,:);

  [K] = t*genK(xnode_loc,D);  %calculo de matriz K 
  [F] = genF(xnode_loc,Fg); %calculo F con fuerzas volumetricas
  
  ELEMS{i}.Kelem = K;
  ELEMS{i}.FgravElem = F;
  
  KK = assembly(KK,K,ele);
  FF = assembly(FF,F,ele);
end

%% *******************************************************************
% Condiciones de borde

%aplicar neumann
[FF] = fSupCond(FF,fS,xnode);

%aplicando fuerzas puntuales
[FF] = fPuntCond(FF,fPuntual,xnode);

%aplicar dirichlet
[KK,FF] = dirCond(KK,FF,dir);

T=KK\FF