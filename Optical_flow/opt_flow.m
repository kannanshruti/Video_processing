function [u,v,E] = opt_flow(Ix, Iy, It, lambda, rows, cols, N)
% Description: Calculates optical flow velocity vectors and cost function
% Input: Ix, Iy, It: Derivatives w.r.t. x, y, time
%       lambda: Constant in the equation
%       rows, cols: Size fo image
%       N: No of iterations
% Output: u,v: Velocity vectors
%       E: Cost function 

    u = zeros(rows, cols, N); % Initialising u to 0
    v = zeros(rows, cols, N); % Initialising v to 0
    for n = 2:N % Looping over #iterations
        for i = 2:rows-1 % Looping through each pixel of the image
            for j = 2:cols-1
                u_n(i,j) =  0.25 * (u(i-1, j, n) + u(i+1, j, n-1) + u(i, j-1, n) + u(i, j+1, n-1)); %  Gauss-Siedel update
                v_n(i,j) =  0.25 * (v(i-1, j, n) + v(i+1, j, n-1) + v(i, j-1, n) + v(i, j+1, n-1));

                tmp = (Ix(i,j)*u_n(i,j) + Iy(i,j)*v_n(i,j) + It(i,j)) / (8*lambda + Ix(i,j)^2 + Iy(i,j)^2); % Update equation for Horn Schunck Optical Flow
                u(i,j,n) = u_n(i,j) - tmp * Ix(i,j);
                v(i,j,n) = v_n(i,j) - tmp * Iy(i,j);

                tmp1 = (Ix(i,j)*u(i,j,n) + Iy(i,j)*v(i,j,n) + It(i,j)).^2; % Cost function calculation
                tmp2 = lambda * ((u(i,j,n) - u(i-1,j,n)).^2 + (u(i,j,n) - u(i,j-1,n)).^2 + ...
                    (v(i,j,n) - v(i-1,j,n)).^2 + (v(i,j,n) - v(i,j-1,n)).^2);
                E(n,1) = E(n,1) + sum(sum(tmp1 + tmp2));
            end
        end
    end
end


