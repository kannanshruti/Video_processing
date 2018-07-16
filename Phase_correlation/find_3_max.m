function [max3, ind] = find_3_max(R_tilda)
% Description: Finds the top 3 values (with indices) of a matrix
% Input: R_tilda = Matrix whose top 3 highest values are to be found
% Output: max3, ind: Maximum values and their indices
    max3 = zeros(3,1);
    tmp = 1;
    for i = 1:3
        [max3(i),I] = max(R_tilda(:));
        [ind(tmp,1), ind(tmp+1,1)] = ind2sub(size(R_tilda),I);
        R_tilda(ind(tmp,1), ind(tmp+1,1)) = 0.0000000001;
        tmp = tmp+2;
    end
    max3
    ind
    ind = ind(:)'
end