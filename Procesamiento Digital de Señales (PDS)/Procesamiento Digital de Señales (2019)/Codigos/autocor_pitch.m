function [pitch_bueno,pitch_grabado,pitch_grabado2] = autocor_pitch(audio_bueno,audio_grabado) % Calcula el pitch de la señal a lo largo del tiempo con autocorrelacion
%audio: señal de audio a analizar

%Método: transformada de autocorrelacion con clipping

[s_bueno,fm_bueno] = audioread(audio_bueno); 
s_grabado=audio_grabado(:,1); %comentar si se usa archivos de audio
%[s_grabado,fm_grabado] = audioread(audio_grabado);% comentar si se graba
%el audio por medio de la funcion tiempo real
%s_bueno=s_bueno(:,1); %para archivos de audio de whatsapp
%s_grabado=s_grabado(:,1); %para archivos de audio de whatsapp

fm_grabado=16000; %comentar si se usa archivo de audio

s_bueno = resample(s_bueno,16000,fm_bueno);
s_grabado = resample(s_grabado,32000,fm_grabado);

fm=16000;
dt = 1/fm;

% N_bueno = length(s_bueno);
% N_grabado = length(s_grabado);
tamvent = 480; % 30 ms

vent = hanning(tamvent);
k = 1;
dk = floor(tamvent*0.5); %ventanas solapadas la mitad

pitch_bueno = calcularPitch(s_bueno,vent,tamvent,fm,k,dk);
pitch_grabado = calcularPitch(s_grabado,vent,tamvent,fm_grabado,k,dk);
pitch_grabado2 = calcularPitch2(s_grabado,vent,tamvent,fm_grabado,k,dk);

end
