figure(4);
hold on;
t=[];
T=[];
for i=1:1065
    t=[t i];
    T=[T pitch_grabado_correcto(i)];
    plot(t,T,'rx');
    drawnow;
    pause(0.0001)
end