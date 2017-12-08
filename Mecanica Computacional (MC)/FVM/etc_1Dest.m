function etc_1Dest(k,G,c,a,b,N)
	A = eye(N);
	h = (b-a) / (N-1);
	ind = -G';

	q = zeros(1,N);

	for i=2:N-1
		A(i,i-1:i+1) = [2/h -4/h 2/h];
    end
    
%-----------Condiciones de borde
	
	for i=1:rows(neum)
		if(neum(i,1) == 1)
			A(1,1:2) = [2*ck+c -2*ck];
			ind(1) = ind(1) - neum(i,2) * -(v/k + 2/h);
			q = [neum(i,2) q];
		else
			A(N,N-1:N) = [-2*ck 2*ck-c];
			ind(N) = ind(N) - neum(i,2) * (-v/k + 2/h);
			q = [q neum(i,2)];
		end
	end

	for i=1:rows(rob)
		hr = rob(i,2);
		tref = rob(i,3);
		if(rob(i,1) == 1)
			A(1,1:2) = [(2*ck + c + 2*hr/h - v*hr/k) v/h];
			ind(1) = ind(1) - (v*hr/k + 2*hr/h)*tref;
		else
			A(N,N-1:N) = [v/h (2*ck + c + 2*hr/h - v*hr/k)];
			ind(N) = ind(N) - (v*hr/k - 2*hr/h)*tref;
		end		
	end

	for i=1:rows(dirich)
		ind(dirich(i,1)) = dirich(i,2);
	end

	T = A\ind;

	for i=2:N-1
		q(i) = -k * (T(i+1)-T(i-1))/(2*h); 
	end
end
