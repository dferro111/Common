function image = add_noise(img, SNR, C, xPix, yPix)
% Adds noise from celestial sources to an image. Assumes that all the noise
% is from celectial origin and therefore uses a poisson distribution to
% sample noise for specific pixels
% 
% Inputs:
%   img - image without noise
%   SNR - signal to noise ratio
%   C - count rate of noiseless signal
%   xPix, yPix - number of pixels in the x and y directions
% Outputs:
%   image - image with celestial noise introduced via Poisson distribution

% Calculate expected value for the celestial noise
lambda = ((C/SNR)^2 - C) / (xPix * yPix);

% Generate noisy image by adding noise to the signal
image = img + get_poisson(lambda, xPix, yPix);

end