a=0;b=1;
N = 50; %Cantidad de celdas
dx = (b-a)/(N-1) * ones(1,N);

G = 50*ones(100,1);%[50 50 50];
k = ones(100,1);%[1 1 1];

cb_t = ['D','R']; %Tipo de las condiciones de borde
cb_v = [20 0;.2 30]; %Valore de las condiciones de borde


c = 0;


T = vol1D(dx,G,k,c,cb_t,cb_v);

%x = dominio(a,b,dx); %A partir del intervalo y los deltas, calculo los valores del eje x (SIN INCLUIR LOS EXTREMOS)

plot(T(1:40));
