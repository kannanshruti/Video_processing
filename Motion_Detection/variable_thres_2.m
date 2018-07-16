function var_res = variable_thres_2(img_a, img_b, sigma_ratio, T, variance_s, theta)

% Function: Returns the frame on which Variable thresholding of the second order has been done
% Inputs: 
%   img_a: Frame Tk-1
%   img_b: Frame Tk
%   sigma_ratio: Ratio of standard deviation of the moving pixels to standard deviation of the static pixels
%   variance_s: Variance of the static pixels
%   theta: Function of the cost parameters
% Output:
%   var_res: Image with variable thresholding performed

    q_k = img_a - img_b;
    [rows,cols] = size(q_k);
    var_res = img_b - img_a;
    for iter = 1:3
        for i = 1:rows
            for j = 1:cols
                [Qs, Qm] = neighbours(8, var_res, i, j, rows, cols);
                threshold = 2 * variance_s * (log(theta*sigma_ratio) + (Qs-Qm)/T);
                if q_k(i,j)^2 > threshold
                    var_res(i,j) = 255;
                else
                    var_res(i,j) = 0;
                end
            end
        end
    end
end