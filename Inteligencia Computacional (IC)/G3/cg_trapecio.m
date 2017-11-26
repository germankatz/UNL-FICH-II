function [ycg]=cg_trapecio(ct,h)
    a=ct(1);
    b=ct(2);
    c=ct(3);
    d=ct(4);
    if h==0
      ycg=0;
      return;
    end
    if a==b && b==c && c==d
      ycg=a;
    else
      b1=b-a;
      b2=c-b;
      b3=d-c;
      A1=b1*h/2;
      A2=b2*h;
      A3=b3*h/2;
      cg1=a+b1*(2/3); 
      cg2=b+(b2/2);
      cg3=c+b3*(1/3);
      s1=cg1*A1+cg2*A2+cg3*A3;
      s2=A1+A2+A3;
      ycg=s1/s2;
    end 
end