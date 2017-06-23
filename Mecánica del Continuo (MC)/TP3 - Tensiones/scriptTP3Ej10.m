% scriptTP3Ej10

close all;

figure

fig = gcf;
fig.PaperPositionMode = 'auto';

[x y]=meshgrid(-4:0.3:4,-4:0.3:4);
n = length(x);
dy=0.*[ones(size(y))]%fi1(1,0,0,x,y);
dx=ones(size(dy));
L=sqrt(1+dy.^2);
quiver(-x,y,dx./L,dy./L,'r');
axis tight

figure

[x y]=meshgrid(-4:0.3:4,-4:0.3:4);
dy=fi1(0,1,0,x,y);
dx=ones(size(dy));
L=sqrt(1+dy.^2);
quiver(x,y,dx./L,dy./L,'r');
axis tight

figure

[x y]=meshgrid(-4:0.3:4,-4:0.3:4);
dy=fi1(0,0,1,x,y);
dx=ones(size(dy));
L=sqrt(1+dy.^2);
quiver(x,y,dx./L,dy./L,'r');
axis tight

figure

[x y]=meshgrid(-4:0.3:4,-4:0.3:4);
dy=fi2(0,0,0,1,x,y);
dx=ones(size(dy));
L=sqrt(1+dy.^2);
quiver(x,y,dx./L,dy./L,'g');
axis tight

figure

[x y]=meshgrid(-4:0.3:4,-4:0.3:4);
dy=fi2(1,0,0,0,x,y);
dx=ones(size(dy));
L=sqrt(1+dy.^2);
quiver(x,y,dx./L,dy./L,'g');
axis tight

figure

[x y]=meshgrid(-4:0.3:4,-4:0.3:4);
dy=fi2(0,1,0,0,x,y);
dx=ones(size(dy));
L=sqrt(1+dy.^2);
quiver(x,y,dx./L,dy./L,'g');
axis tight