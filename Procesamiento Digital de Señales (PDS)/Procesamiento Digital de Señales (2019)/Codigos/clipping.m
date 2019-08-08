%CLIPPING
tramo = ones(100,1);
        
N = length(tramo);
porc_clip = 0.3;
inicio_clip = (1-porc_clip)/2;
fin_clip = inicio_clip + porc_clip;
for j=ceil(N*inicio_clip):ceil(N*fin_clip)
    tramo(j) = 0;
end
tramo
