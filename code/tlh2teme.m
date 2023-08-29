function r_out = tlh2teme(r_in, LST, lat, invert)
% Converts from topocentric equitorial to topocentric local horizon
% 
% Inputs:
%   r_in - position of object in original frame 
%   LST - local sidereal time of observer, deg
%   lat - geographic latitude of observer, deg
%   invert - invert flag: 0 for tlh2teme, 1 for teme2tlh
% Outputs:
%   r_out - position of object in converted frame, 1-3

% Rotation matrices
S2 = [1 0 0; 0 -1 0; 0 0 1];
R3 = [cosd(LST) , sind(LST), 0;
      -sind(LST), cosd(LST), 0;
      0         , 0        , 1];
a = -(90-lat);
R2 = [cosd(a), 0, -sind(a);
      0      , 1, 0       ; 
      sind(a), 0, cosd(a)];

% Calculate rotation matrix
rot = S2*R3*R2;
if (invert)
    rot = inv(rot);
end

% Check orientation of r_in vector before multiplication
if size(r_in,2) > size(r_in,1)
    r_out = rot * r_in';
else
    r_out = rot * r_in;
end
r_out = r_out'; % output as a row vector