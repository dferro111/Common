function a3B = Third_Body_accel(r, ri, muB)
% Computes the relative acceleration caused by a third body
% 
% Inputs:
%   r - position of the object in ECI, km
%   ri - position of the third body in ECI, km
%   mui - grav param of the third body, km^3/s^2
% Outputs:
%   a3b - accleration, km/s^2

if size(r,2) ~= size(ri,2)
    ri = ri';
end

a3B = -muB * (ri / norm(ri)^3 + (r-ri) / (norm(r-ri))^3);