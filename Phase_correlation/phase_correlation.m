function [max3, ind, R_tilda] = phase_correlation(img1, img2)
% Description: Calculates the Phase correlation matrix and the index of the
% maximum value in it
% Input: img1, img2: Images between which motion is to be estimated 
% Output: max3 = Maximum value of the inverse DFT matrix
%         ind = Index of the maximum value of the inverse DFT matrix
%         R_tilda = Inverse DFT matrix
    ft_a = fft2(img1);
    ft_b = fft2(img2);

    psi = ft_a .* conj(ft_b);
    psi_tilda = psi ./ abs(psi);
    R_tilda = ifft2(psi_tilda);

    [max3, ind] = find_3_max(R_tilda); 
end