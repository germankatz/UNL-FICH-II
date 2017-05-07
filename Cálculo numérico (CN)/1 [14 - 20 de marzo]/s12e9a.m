function [px1,px2,atanx1,atanx2,fx,px,ea,er] = s12e9a(x1,x2)
  px1 = x1 - 1/3 * x1^3 + 1/5 * x1^5;
  px2 = x2 - 1/3 * x2^3 + 1/5 * x2^5;
  atanx1 = atan(x1);
  atanx2 = atan(x2);
  fx = 4*(atan(1/2)+atan(1/3));
  px = 4*(px1+px2);
  ea = abs(fx-px);
  er = abs(fx-px)/abs(fx);
endfunction