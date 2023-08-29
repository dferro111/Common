function R_topo =  get_R_topo_ITRF(long, lat, h)
% Calculates the position of the topocenter from the geocenter given the
% position of the observer and time of observation
% 
% Inputs:
%   long - longitude of observation, deg E
%   lat - corrected latitude of observation, deg N
%   h - height of the observer, km
% Outputs:
%   R_topo - position of the topocenter in ITRF, km

% Modified Radius of the Earth
R = 6378.14 - 21.38*(sind(lat))^2 + h;

% inertial position of the observer
R_topo = [R*cosd(lat)*cosd(long); ...
          R*cosd(lat)*sind(long); ...
          R*sind(lat)];

