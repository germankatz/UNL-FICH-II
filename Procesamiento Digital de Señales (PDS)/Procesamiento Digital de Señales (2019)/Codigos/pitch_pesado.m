function pitch_correcto = pitch_pesado(pitch)
    N = length(pitch);
    valores = [];
    pitch_correcto = [];
    octava1= 55;
    octava2= 110;
    octava3= 220;
    octava4= 440;
    octava5= 880;
    
    for i=1:N
        if isnan(pitch(i))
            pitch(i) = 10000;
            valores = [valores pitch(i)];
        else
           valores = [valores pitch(i)]; 
        end
    end
    
    N = length(valores);
    valor1 = octava1;
    
    for i=1:N
        valor= valores(i);
        if (valores(i)==10000)
            continue;
        end
        if (valores(i)>1.2*octava1)||(valores(i)<0.8*octava1)
            continue;
        else
            valor1 = valores(i);
            break;
        end
    end
    
    %pitch_correcto(1) = valor1;
    
    for i=1:N
        if (valores(i)==10000)
            pitch_correcto(i) = NaN;
            continue;
        end
        if (valores(i)>1.2*valor1)
            pitch_correcto(i) = pitch_correcto(i-1);
        else
           valor1 = valores(i);
           pitch_correcto = [pitch_correcto valores(i)];
        end
    end
    
    for i=1:N
        if isnan(pitch_correcto(i))
            pitch(i) = 0;
            valores = [valores pitch(i)];
        else
           valores = [valores pitch(i)]; 
        end
    end
end