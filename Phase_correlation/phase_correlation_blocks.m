function min_d = phase_correlation_blocks(img1, img2, N)
% Description: Calculates phase correlation between blocks in 2 images
% Input: img1, img2: Images between which motion is to be estimated
%        N: Block size
% Output: min_d: Block start row, col; block end row, col, phase correlation coordinates
    b=1;
    [rows, cols] = size(img1);
    for m = 1:N:(rows-N+1) % Loop over blocks
        for n = 1:N:(cols-N+1)
            block1 = img1(m:m+N-1, n:n+N-1);
            block2 = img2(m:m+N-1, n:n+N-1);
            [~, ind, ~] = phase_correlation(block1, block2);
            min_d(b,1) = m; % Block start row
            min_d(b,2) = n; % Block start col
            min_d(b,3) = m+N-1; % Block end row
            min_d(b,4) = n+N-1; % Block end col            
            min_d(b,5:10) = ind;
            b = b+1;
        end
    end
end