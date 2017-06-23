function [e]=energia(y)

e = 0;
n = length(y);

e = norm(y,2)^2;

%for i=1:n
%    e = e + y(i)^2;
%end