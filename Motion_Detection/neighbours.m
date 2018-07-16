function [Qs, Qm] = neighbours(n, image, i,j, rows, cols)

% Function: Returns the indices of the 4 or 8 neighbours
% Inputs: 
%   n: no of neighbours, options: 4 or 8
%   image: Image in which neighbours are to be found
%   i,j: row and column of the pixel whose neighbour is to be calculated
%   rows, cols: no of rows and columns in the image
% Output:
%   Qs: no of static neighbours around pixel (i,j)
%   Qm: no of moving neighbours around pixel (i,j)

    Qs = 0;
    Qm = 0;
    if n==4
        neigh(1:4,1:2) = [ i+[0;-1;0;1] j+[-1;0;1;0] ];
    elseif n==8
        neigh(1:8,1:2) = [i+[-1;0;1;-1;1;-1;0;1] j+[-1;-1;-1;0;0;1;1;1] ];
    end
    neigh = neigh(all(neigh,2) & neigh(:,1) <= rows & neigh(:,2) <= cols,:);
    for i = 1:length(neigh)
        if image(neigh(i,1), neigh(i,2)) == 0
            Qs = Qs + 1;
        else
            Qm = Qm + 1;
        end
    end
end

    
    