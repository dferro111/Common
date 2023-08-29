function psi = BRDF_sphere(alpha, r, C, type)
% Computes the Bidirectional Reflection Function for spherical objects
% 
% Inputs:
%   alpha - phase angle of object, rad
%   r - radius if sphere or area if a plate, m
%   C - coefficient of diffusion/reflection
%   type - type of the object
%           Ex:
%              'lambertian'
%              'specular'
% Outputs:
%   psi - Bidirectional Reflection Function result

if contains(type, 'lambert')
    % Compute phase function
    psi = (2/3) * (C/pi) * r^2 * (sin(alpha) + (pi - alpha)*cos(alpha));
end

end