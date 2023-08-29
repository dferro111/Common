function [az, h] = aberration_correction(r, tau, JD, long, lat, ht)
% Corrects for aberration effects
% 
% Inputs:
%   r - observed position of the object(corrected for light travel time),km
%   tau - light travel time, sec
%   JD - julian date of the observation time, days
%   long - observer longitude, deg E
%   lat - oberver latitude (geographic), deg N
%   ht - height of observer, km
% Outputs:
%   az - topocentric local horizon azimuth, rad
%   h - topocentric local horizon elevation, rad

days2min = 24*60; % conversion factor

% Get times
jd = JD - (tau/60)/days2min;
jd0 = jd - mod(jd, 1) + 0.5;
gmst = get_sidereal_time(jd0, jd, 0);
lst = gmst * 15 + long;

% Location of the observer at corrected time
latgc = correct_latitude(lat);
R = get_R_topo(long, latgc, ht, gmst);

% Coord transforms to get az and h
if size(r, 2) > size(r, 1)
    teme = r - R';
else
    teme = r - R;
end
tlh = tlh2teme(teme, lst, lat, 1);
[az, h] = get_ra_dec(tlh);

end