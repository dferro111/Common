function [ra, dec] = get_ra_dec(r)
% Calculates the right ascension and declination of vector r. This code
% assumes that r is already in the coordinate frame it needs to be in to
% find these angles.
% Assumes x is the mean equininox and xy plane is the true equator
% 
% Inputs:
%   r - radius / direction to object
% Outputs:
%   ra - right ascention based off x, rad
%   dec - declination based off xy-plane, rad

r = r / norm(r);
dec = asin(r(3));
ra = acos(r(1) / cos(dec));
if asin(r(2) / cos(dec)) < 0
    ra = 2*pi - ra;
end