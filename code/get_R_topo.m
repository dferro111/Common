function R_topo = get_R_topo(long, lat, h, GMST)
% Calculates the position of the topocenter from the geocenter given the
% position of the observer and time of observation
% 
% Inputs:
%   long - longitude of observation, deg E
%   lat - corrected latitude of observation, deg N
%   h - height of the observer, km
%   GMST - greenwich mean sidereal time of observation
% Outputs:
%   R_topo - position of the topocenter, km

% Modified Radius of the Earth
R = 6378.14 - 21.38*(sind(lat))^2 + h;

% Local sidereal time in degrees
LST = (GMST * 15) + long; 

% inertial position of the observer
R_topo = [R*cosd(lat)*cosd(LST), ...
          R*cosd(lat)*sind(LST), ...
          R*sind(lat)];
end
          