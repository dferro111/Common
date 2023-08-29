function [pos, vel] = coe2rv(a, e, incl, RAAN, argp, M, mu)
% Converts from Classical Orbital Elements to position and velocity in ECI
% Input angles in degrees
% 
% [pos, vel] = coe2rv(a, e, incl, RAAN, argp, M, mu)

% Get true anomoly
E = calculate_E(M, e);
nu = 2*atan2d(sqrt(1+e)*sind(E/2), sqrt(1-e)*cosd(E/2));
theta = nu + argp;

% Semi-latus rectum
p = a*(1-e^2);

% Orbit frame
% Position
r = p / (1 + e*cosd(nu));
% Velocity
spece = -mu / (2*a);
v = sqrt(2*(mu / r + spece));

% Flight path angle with quadrant check
gamma = acosd(sqrt(mu*p) / (r*v)) * sign(nu);

% Vectorize
r_rtn = [r; 0; 0];
v_rtn = v * [sind(gamma); cosd(gamma); 0];

% Rotate
C_eci2rtn = EulerAngle2DCM(deg2rad(RAAN), deg2rad(incl), ...
    deg2rad(theta), 313);
pos = C_eci2rtn' * r_rtn;
vel = C_eci2rtn' * v_rtn;


