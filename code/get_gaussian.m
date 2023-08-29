function gaussian = get_gaussian(A, sigma, xmax, ymax)
% Generates a 2-dimensional gaussian array to model an image with a random
% center and a given variance. It is assumed that the variance is the same
% in the x and y directions. The center of the gaussian random within 20% 
% of the edges of the image.
% 
% Inputs:
%   A - amplitude of the gaussian
%   sigma - variance of the x and y directions
%   xmax - number of pixels in the x direction
%   ymax - number of pixels in the y direction
% Outputs:
%   gaussian - 


% Get a random number not close to the edge of the gaussian
x0 = (xmax * 0.2) + rand() * (xmax * 0.6);
y0 = (ymax * 0.2) + rand() * (ymax * 0.6);

for x = 1:xmax
    for y = 1:ymax
        % Terms in the exponent
        xexp = (x - x0)^2 / (2 * sigma^2);
        yexp = (y - y0)^2 / (2 * sigma^2);
        
        % gaussian distribution
        gaussian(x, y) = A * exp(-(xexp + yexp));
    end
end

end