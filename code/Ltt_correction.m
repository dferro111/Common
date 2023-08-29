function [tau, r, az, h] = Ltt_correction(satrec, R, tsince, LST, lat)
% Corrects for light travel time, but not aberration
% 
% Inputs:
%   satrec - satrec structure of the object
%   R - topocenter of observer, km
%   tsince - time to initial propogation, min
%   LST - local sidereal time of observation, degrees
%   lat - geographic latitude of observer, deg N
% Outputs:
%   tau - light travel time, sec
%   r - corrected position of the object in ECI, km
%   az - azimuth of the object, rad
%   h - elevation of the object, rad

% Calculate light travel time, sec
tau = light_travel_time(satrec, R);

% Corrected position of the object ECI
[~, r, ~] = sgp4(satrec, tsince+(tau/60));

% Azimuth and elevation
teme = r - R';
tlh = tlh2teme(teme, LST, lat, 1);
[az, h] = get_ra_dec(tlh);


end