function img_res = fixed_threshold(img_a, img_b, variance_s, theta)

% Function: Returns the frame on which fixed thresholding has been done
% Inputs: 
%   img_a: Frame Tk-1
%   img_b: Frame Tk
%   variance_s: Variance of the static pixels
%   theta: Function of the cost parameters
% Output:
%   img_res: Image with fixed thresholding performed

    psi_1 =  (img_b - img_a).^2;
    threshold = 2 * variance_s * log(theta * sqrt(2*pi*variance_s));
    [r,c] = size(img_a);
    img_res = zeros(r,c);
    for i = 1:r
        for j = 1:c
            if psi_1(i,j) > threshold
                img_res(i,j) = 1;
            end
        end
    end
end


