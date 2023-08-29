function r = radec2r(ra, dec)
% Converts from right ascension and declination to a position vector
% 
% Inputs:
%   ra - right ascension, rad
%   dec - declination, rad
% Outputs:
%   r - unit position vector


r = [cos(ra)*cos(dec);
     sin(ra)*cos(dec);
     sin(dec)];

end