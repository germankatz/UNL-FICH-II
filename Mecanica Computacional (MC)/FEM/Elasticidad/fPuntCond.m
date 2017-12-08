function [F] = fPuntCond(F,fPuntual,xnode)
%by Cheche
    for i=1:size(fPuntual,1)
        x=xnode(fPuntual(i,1),:);                           % Side Coordinaates

        indN1 = [fPuntual(i,1)*2-1 fPuntual(i,1)*2];        % Node 1 of side
        indx = [indN1];                                     % Side Nodes
        Fx = (fPuntual(i,2));
        Fy = (fPuntual(i,3));
        force = [Fx Fy];
        F(indx) = F(indx) + force';     
    end
end
