function [v1m, v1p, dv1, v2m, v2p, dv2, dvt, a, e] = compute_Hohmann(r1, r2, mu)
% Computes relevent information for a Hohmann transfer
%
% Inputs:
%   r1 - radius of the first planet orbit [km]
%   r2 - radius of the second planet orbit [km]
%   mu - gravitational parameter of the atracting body [km^3/s^2]
% Outputs:
%   v1m - velocity before the first maneuver [km/s]
%   v1p - velocity after the first maneuver [km/s]
%   dv1 - delta v of the first maneuver [km/s]
%   v2m - velocity before the second maneuver [km/s]
%   v2p - velocity after the second maneuver [km/s]
%   dv2 - delta v of the second maneuver [km/s]
%   dvt - total delta v of the Hohmann Transfer [km/s]
%   a - semi-major axis of the transfer orbit [km]
%   e - eccentricity of the transfer oribt [--]
%
% [v1m, v1p, dv1, v2m, v2p, dv2, dvt, a, e] = compute_Hohmann(r1, r2, mu)

% Circular Velocities
v1m = sqrt(mu/r1);
v2p = sqrt(mu/r2);

% Semi-major axis
a = 0.5*(r1 + r2);

% Velocities at the ends of the transfer orbit
v1p = sqrt(2*mu/r1 - mu/a);
v2m = sqrt(2*mu/r2 - mu/a);

% Delta v's
dv1 = v1p - v1m;
dv2 = v2p - v2m;
dvt = abs(dv1) + abs(dv2);

% Eccentricity - uses apogee definition
if r1 < r2
    e = r2/a - 1;
elseif r2 < r1
    e = r1/a - 1;
else
    e = 0;
end