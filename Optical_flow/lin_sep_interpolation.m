function I_tilda = lin_sep_interpolation(img1, u, v)
% Description: Calculates image values at locations specified by the velocity vectors u, v
% Input: img1: Image whose interpolated values are to be calculated
%        u, v: vecolity vectors (x and y displacement values)
% Output: I_tilda: Image with interpolated values
    [rows,cols] = size(img1);
    I_tilda = zeros(rows, cols);
    for row = 1:rows
        for col = 1:cols
            b = row + u(row, col);
            a = col + v(row, col);
            if row+1 > rows % Handling boundary conditions
                if col+1 > cols
                    next_row = 0;
                    next_col = 0;
                    next_r_c = 0;
                else
                    next_row = 0;
                    next_col = img1(row, col+1);
                    next_r_c = 0;
                end
            else
                if col+1 > cols
                    next_row = img1(row+1, col);
                    next_col = 0;
                    next_r_c = 0;
                else
                    next_row = img1(row+1, col);
                    next_col = img1(row, col+1);
                    next_r_c = img1(row+1,col+1);
                end
            end
           
            I_tilda(row, col) = (1-a)*(1-b)*img1(row,col)  + a*(1-b)*next_row+...
                                (1-a)*  b  *next_col       + a*  b  *next_r_c; % Cross check formula
        end
    end
end
