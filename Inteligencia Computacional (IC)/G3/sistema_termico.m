function [v,t]=sistema_termico(M,S,r)
  it=200;
  v=[1:it+1];
  t=zeros(1,it+1);
  t(1)=15;
  e=zeros(1,it);
  q=zeros(1,it);
  g=40/41;
  a=g;
  tref=15;
  for i=2:31
    e(i-1)=tref-t(i-1);
    q(i-1)=rsc(M,S,e(i-1),r);
    if q(i-1)>7
      q(i-1)=7;
    elseif q(i-1)<-7
      q(i-1)=-7;
    end
    t(i)=tref+g*q(i-1)+a*(t(i-1)-tref);
  end
  tref=25;
  for i=32:it+1
    e(i-1)=tref-t(i-1);
    q(i-1)=rsc(M,S,e(i-1),r);
    if q(i-1)>7
      q(i-1)=7;
    elseif q(i-1)<-7
      q(i-1)=-7;
    end
    t(i)=tref+g*q(i-1)+a*(t(i-1)-tref);
  end
end