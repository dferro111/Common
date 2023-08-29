function diff = shortest_angle(a1, a2, unit)
% Compute the shortest angle between two angles
% 
% diff = shortest_angle(a1, a2, unit)

if (contains(unit, 'arcsec'))
    thresh = pi/deg2rad(1/3600);
elseif (contains(unit, 'rad'))
    thresh = pi;
elseif (contains(unit, 'deg'))
    thresh = 180;
end

diff = mod(a1 - a2 + thresh, 2*thresh) - thresh;
if diff < -thresh
    diff = diff + 2*thresh;
end