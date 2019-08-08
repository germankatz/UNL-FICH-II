function [pitch] = calcularPitch(s,vent,tamvent,fm,k,dk)
    pitch = [];
    inicio = ceil(2*(fm/1000));
    tiempo_ventana=tamvent/fm;
    
    while k+tamvent < length(s)
        %VENTANEO
        tramo = s(k:k+tamvent-1).*vent;

        %TIENE ENERGIA SUFICIENTE?
        e_tramo = energia(tramo);
%         if e_tramo < 4 %sonido sordo
%             pitch = [pitch NaN]; %no lo analizo
%             k = dk+k;
%             continue;
%         end
        
        %ES SONORO?
        cruces_tramo = contarCruces(tramo);
        sonoro = esSonoro(e_tramo,cruces_tramo);
        if sonoro == 0 %sonido sordo
            pitch = [pitch NaN]; %no lo analizo
            k = dk+k;
            continue;
        end
        
        %CLIPPING
        N = length(tramo);
        porc_clip = 0.2;
        inicio_clip = (1-porc_clip)/2;
        fin_clip = inicio_clip + porc_clip;
        for j=ceil(N*inicio_clip):ceil(N*fin_clip)
            tramo(j) = 0;
        end
        
        %subplot(2,1,1),plot(tramo);
        %autocorrelacion de la señal:
        autocor = xcorr(tramo, tramo);
%         figure();
        %subplot(2,1,2),plot(autocor);
        %encontramos el pico de la ventana de autocorrelacion:
        M = length(autocor);
        autocor = autocor(ceil(M/2):M);
        M = length(autocor);
        
        [~,idx] = max(autocor(inicio:M));
        %plot(autocor);
        
        %calculo el pitch de la ventana
        %T=(idx+inicio)*tiempo_ventana/tamvent;   %tiempo_ventana=tamvent/fm;
        %p=1/T;
        p = (fm/(idx+inicio));
        pitch = [pitch p];
        k = dk + k;
    end
end