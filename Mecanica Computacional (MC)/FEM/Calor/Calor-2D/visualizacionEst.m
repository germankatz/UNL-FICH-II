function [] = visualizacionEst(TEMP,xnod,icone)
    warning('off','all');
	drawnow    
	TempMin=min(min(TEMP));
    TempMax=max(max(TEMP));
    caxis([TempMin-1,TempMax+1]); %Pseudocolor axis scaling
    xmin=min(xnod(:,1)); xmax=max(xnod(:,1));
    ymin=min(xnod(:,2)); ymax=max(xnod(:,2));
    wx=xmax-xmin; wy=ymax-ymin;
    axes=[xmin-wx*0.1, xmax+wx*0.1, ymin-wy*0.1, ymax+wy*0.1];
    % axis('equal');
    axis(axes); axis('equal');
    
    
    %correccion de icone para no tener indices negativos
    for i=1:length(icone(:,1))
        if(icone(i,4) == -1)
            icone(i,4) = icone(i,3);
        end
    end
    %fin correccion
    patch('Faces',icone, 'Vertices',xnod, 'FaceVertexCData',TEMP, ...
        'FaceColor','interp', 'EraseMode','normal');
%     fi3=patch('Faces',icone, 'Vertices',xnod, 'FaceVertexCData',TEMP, ...
%         'FaceColor','interp', 'EdgeColor','k', 'EraseMode','normal');
    % dibujar una marca en los nodos
    %lin=line(xnod(:,1),xnod(:,2),'LineStyle','none','Marker','o');.
    colorbar;
    
    %agregar numeros en los nodos
    hold on
    for i=1:length(xnod(:,1))
       xcord = xnod(i,1);
       ycord = xnod(i,2);
       text(xcord,ycord,num2str(i),'Color','red','FontSize',14);
    end
    hold off
end
