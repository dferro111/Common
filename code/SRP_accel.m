function a = SRP_accel(r, rSun, d, h, S, N, Cs, Cd, mass, type)
% Calculates acceleration due to solar radiation pressure
% 
% Inputs:
%   r - position in ECI, km
%   rSun - Sun position in ECI, km
%   A - area of the object, km^2
%   S - sun unit vector
%   N - solar panel normal vector
%   Cs - coefficient of specular reflection
%   Cd - coefficient of lambertian reflection
%   mass - mass of object, kg
%   type - type of surface (currently only 'flat')
% Outputs:
%   a - acceleration in ECI, km/s


% Conversion factors
m2km = 1/1000;

% Constants
E = 1000; % W/m^2 = kg/s^3

% Astronomical units
AU = 149597870; % km

% Speed of light
c = 299792458 * m2km; % km/s

% SRP
a = 0;
A = d*h;
if contains(type, 'flat')
    a = a - (A/mass) * (E/c) * (AU/norm(r-rSun))^2 * dot(S,N) ...
        * ((1-Cs)*S + 2*(Cs*dot(S,N) + (1/3)*Cd)*N);
end
if contains(type, 'cylinder')
    phi = acos(dot(N, S));
    a = a + (A/mass) * (E/c) * (AU^2/(norm(r-rSun)^2)) ...
        *((sin(phi)*(1 + (1/3) * Cs) * A + (1-Cs)*cos(phi) ...
        * pi*(d/2)^2) * S + ((-(3/4)*Cs*sin(phi) - (pi/6)*Cd) * cos(phi)...
        * A + 2*(Cs*cos(phi) + (1/3)*Cd)*cos(phi)*pi*(d/2)^2) * N);
end
if contains(type, 'sphere')
    a = a - (A/mass) * (E/c) * (AU^2/(norm(r-rSun)^2)) ...
        * ((1/4) + (Cd/9)) * S;
end
