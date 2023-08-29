function phi = correct_latitude(lat)
% Correct the latitude to be geocentric latitude and not latitude of vector
% normal to the surdace of the earth. Does so with an iterrative process.
% 
% Inputs: 
%   lat - latitude in degrees
% Output:
%   phi - geocentric latitude in degrees


phiLast = lat;
phi = lat + 0.1924*sind(2*phiLast);
while (abs(phi - phiLast) > 1e-6)
    phiLast = phi;
    phi = lat + 0.1924*sind(2*phiLast);
end

end