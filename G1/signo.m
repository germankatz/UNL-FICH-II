function [s]=signo(x)
 if (x==0)
     s=1;
 else
     s=sign(x);
 end
end