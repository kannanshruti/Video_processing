function [mp_error, img3] = prediction_error(min_d, img1, img2, D)
% Description: Get the block differences for a particular block shift
% Input: min_d: Contains row, col of closely matched blocks for both images
%        img1, img2: images for which block motion is to be estimated
%        D: Search range
% Output: mp_error: Error values for the block in img1 and its closely matched block in img2
%         img3: Corrected block, to check whether if the blocks in img2 are moved, are we obtaining img1
    [rows, cols] = size(img1);
    for m = 1:length(min_d) % Loop over blocks
        for row = min_d(m,1):min_d(m,5)
            for col = min_d(m,2):min_d(m,6)
                mp_error(row,col) = (img2(row,col)) - (img1(row+min_d(m,3), col+min_d(m,4))); % Difference between block and shifted block
                img3(row, col) = img1(row+min_d(m,3), col+min_d(m,4));
            end
        end
    end
    mp_error(min_d(end,5)-1:rows,min_d(end,6)-1:cols) = 0; 
    img3(min_d(end,5):rows,min_d(end,6):cols) = img2(min_d(end,5)-D:rows-D,min_d(end,6)-D:cols-D);  
end