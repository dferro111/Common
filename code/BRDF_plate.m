function psi = BRDF_plate(thetas, thetao, ps, po, A, C, type)
% Computes the Bidirectional Reflection Function for spherical objects
% 
% Inputs:
%   thetao - angle of observer to plate normal, rad
%   thetas - angle of incident light to plate normal, rad
%   ps - angle about normal of incident light, rad
%   po - angle about normal of observed light, rad (ps + pi, if glint)
%   A - Aera of the plate, m
%   C - coefficient of diffusion/reflection
%   type - type of reflection
% Outputs:
%   psi - Bidirectional Reflection Function result

% Determine if the illuminated surface if visible
if thetas > 0.5*pi
    mu0 = 0;
else
    mu0 = 1;
end

% Compute phase function
if contains(type, 'lambert')
    psi = (C/pi) * A * mu0 * cos(thetao); % Lambertian
elseif contains(type, 'spec')
    psi = C * A * mu0 * deltaK(thetas, thetao) * deltaK(ps+pi, po); % spec
end
end