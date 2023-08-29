function lat = geo_c2g(latg)
% Calculate geographic latitude based on geocentric latitude
% 
% Inputs:
%   latg - geocentric latitude, deg
% Outputs:
%   lat - geographics latitude, deg

lat = latg - 0.1924*sind(latg);

end