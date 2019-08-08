function error = puntaje_aux(pitch_bueno,pitch_grabado)
vector_octavas = [55;
                  58.27;
                  61.735; 
                  65.406;
                  69.296;
                  73.416;
                  77.782;
                  82.407;
                  87.307;
                  92.499;
                  97.999;
                  103.83;
                  110;
                  116.54;
                  123.47; 
                  130.81;
                  138.59;
                  146.83;
                  155.56;
                  164.81;
                  174.61;
                  185;
                  196;
                  207.65;
                  220;
                  233.08;
                  246.94;
                  261.6;
                  277.18;
                  293.67;
                  311.13;
                  329.63;
                  349.23;
                  369.99;
                  392;
                  415.3;
                  440;
                  466.16;
                  493.88;
                  523.25;
                  554.37;
                  587.33;
                  622.25;
                  659.26;
                  698.46;
                  739.99;
                  783.99;
                  830.61;
                  880;
                  932.33;
                  987.77;
                  1046.5;
                  1108.7;
                  1174.7;
                  1244.5;
                  1318.5;
                  1396.9;
                  1480];
matriz_octavas = [55 61.735 65.406 73.416 82.407 87.307 97.999;
                  110 123.47 130.81 146.83 164.81 174.61 196;
                  220 246.94 261.6 293.67 329.63 349.23 392;
                  440 493.88 523.25 587.33 659.26 698.46 783.99;
                  880 987.77 1046.5 1174.7 1318.5 1396.9 1568];
M = length(pitch_bueno);
N = length(pitch_grabado);
cant_tonos = 7;
porc_tramo = 0.3;
tam_tramo = floor(M/cant_tonos);
error = [];
minimo = [];
    if (M==N)
        for i=0:cant_tonos-1
            tramo_bueno = pitch_bueno(floor(tam_tramo*i+tam_tramo*porc_tramo):floor(tam_tramo*(i+1)-tam_tramo*porc_tramo));
            tramo_grabado = pitch_grabado(floor(tam_tramo*i+tam_tramo*porc_tramo):floor(tam_tramo*(i+1)-tam_tramo*porc_tramo));

            m = floor(length(tramo_bueno));
            n = floor(length(tramo_grabado));
            err = [];
            min = 10000;
            
    %         if (m==n)
                for j=1:n
                    tb = tramo_bueno(j);
                    tg = tramo_grabado(j);
                    if isnan(tb)
                        tb = 0;
                    end;
                    if isnan(tg)
                        tg = 0;
                    end;
                    e = abs(tb-tg);
                    if (e~=0)
                        if (e<min)
                            min = e;
                            min1 = tb;
                            min2 = tg;
                        end
                    end
                    err=[err e];
                end
                minimo=[minimo min1 min2];                
    %         else disp('Los tramos de señales deben tene r la misma cantidad de muestras');
    %         end
        end
        j=1;
        N=length(vector_octavas);
        while j<length(minimo)
            for i=1:(N-1)
               if ((minimo(j)<vector_octavas(i+1)) && (minimo(j)>=vector_octavas(i)))
                    indice_bueno =  i;
               end
               j = j+1;
               if ((minimo(j)<vector_octavas(i+1)) && (minimo(j)>=vector_octavas(i)))
                    indice_grabado =  i;
               end
               j = j-1;
            end
            j = j+1;
            error_semitono = indice_bueno - indice_grabado;
            error = [error error_semitono];
        end
    else disp('Las señales deben tener la misma cantidad de muestras');
    end
end