function [Ix, Iy, It] = compute_derivatives(img1, img2)
% Description: Compute derivatives (spatial and temporal)
% Input: img1, img2: Images whose derivatives are to be computed
% Output: Ix: Spatial derivative x direction (columns)
%         Iy: Spatial derivative y direction (rows)
%         It: Temporal derivative t direction (between both images)
    [rows, cols] = size(img1);
    Ix = zeros(rows, cols);
    Iy = zeros(rows, cols);

    Ix = img2(:,2:cols) - img2(:,1:cols-1);
    Ix(:,cols) = img2(:, cols); % Last column 
    Iy = img2(2:rows,:) - img2(1:rows-1,:);
    Iy(rows,:) = img2(rows,:); % Last row
    It = img2 - img1;
end