function s = get_poisson(lambda, i, j)
% Function to get an image of random noise from a poisson distribution with
% given expectation value.
% 
% Inputs:
%   lambda - expectation value for the Poisson distribution
%   i - number of pixels to sample in the x direction
%   j - number of pixels to sample in the y direction
% Outputs:
%   s - signal of the noise for each pixel

for x = 1:i
    for y = 1:j
        % Sample a poisson distribution
        s(x,y) = poissrnd(lambda);
    end
end

end