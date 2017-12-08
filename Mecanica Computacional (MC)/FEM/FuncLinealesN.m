function [T,Kg,fg]=FuncLinealesN(nodos,sp,k,G,ti,td,q)
  [T,Kg,fg] = FuncLineales(nodos,sp,k,G,ti,td);
  [f c]=size(Kg);
  Kg(1,2)=Kg(2,1);
  Kg(1,1)=Kg(2,2)/2;
  %Kg(f,c-1)=Kg(f-1,c);
  %Kg(f,c)=Kg(f-1,c-1)/2;
  fg(1)=(fg(2)/2)+q;
  %fg(c)=(fg(c-1)/2)-q;
  T=Kg\fg;
end