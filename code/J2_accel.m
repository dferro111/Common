function [a, G] = J2_accel(r, mu, R)
% Computes the acceleration caused by the J2 Earth effects.
% 
% Inputs: 
%   r - position in ECEF, km
%   mu - grav param, km^3/s^2
%   R - Earth radius, km
% Outputs:
%   a - acceleration in ECEF
%   G - gravity gradient

% J2 constant
% (https://www.csr.utexas.edu/publications/statod/TabD.3.new.txt)
J2 = 0.1082635854e-2;

% Unit direction in r
uECEF = r / norm(r);
s = uECEF(1);
t = uECEF(2);
u = uECEF(3);

% Magnitude of r
r = norm(r);

% J2 Unit direction
uJ2 = 3/2 * [5*s*u^2 - s; 5*t*u^2 - t; 5*u^3 - 3*u];

% Acceleration
a = (mu * J2 / r^2) * (R / r)^2 * uJ2;

% Gravity Gradient
UJ2 = (3/2)*[5*u^2 - 2*s^2 - 1, -2*s*t, 8*s*u;
    -2*s*t, 5*u^2 - 2*t^2 - 1, 8*t*u;
    -6*s*u, -6*t*u, 9*u^2 - 3];
G = ((mu * J2)/r^3) * (R / r)^2 * (7*uJ2*uECEF' - UJ2);

