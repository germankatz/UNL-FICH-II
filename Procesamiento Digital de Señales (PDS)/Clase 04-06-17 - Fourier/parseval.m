function [E]=parseval(s,S)

E1 = sum(s.^2);
E2 = sum(abs(S).^2)/length(s);

if round(E1-E2)==0
    E = true;
else
    E = false;
end
 