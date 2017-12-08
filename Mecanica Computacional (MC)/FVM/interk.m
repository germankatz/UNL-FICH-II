function k = interk(kw,ke,dw,de)
	%k = (dw*kw+de*ke)/(dw+de);	
	dt = de/(de+dw);
	k = (ke*kw)/(dt*ke+(1-dt)*kw);
end
