function [cg3] = cuad_gauss_tres_puntos(a,b,f)
  t1 = 0.7745966692;
  t2 = 0;
  t3 = -0.7745966692;
  c1 = 0.5555555556;
  c2 = 0.8888888889;
  c3 = 0.5555555556;
  cg3 = ((b-a)/2)*(c1*feval(f,t1)+c2*feval(f,t2)+c3*feval(f,t3));
endfunction