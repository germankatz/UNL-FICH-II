L = 5;
tfinal = 1;

y_0 = [L 0 L L 2*L 0 2*L L 3*L 0 zeros(1,10)];

[tout, yout] = ode23s(@odefunTP1Ej6,[0 tfinal],y_0);
