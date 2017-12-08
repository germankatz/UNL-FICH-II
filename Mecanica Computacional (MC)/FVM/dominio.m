function x = dominio(a,b,dx)
	x = zeros(length(dx)+1,1);
	x(1) = a;
	for i=2:length(dx)+1
		x(i) = x(i-1)+dx(i-1);
	end
end
