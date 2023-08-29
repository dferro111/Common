function [f, g, fdot, gdot] = fg_E(dE, dt, a, r0, v0, mu)
% Calculate f and g values for an elliptic orbit. Used to obtain new
% position and velocity vector based on a previous one.
% 
% Inputs:
%   dE - change in eccentric anomoly, rad
%   dt - change in time, sec
%   a - semi-major axis, km
%   r0 - initial position, km
%   v0 - initial velocity, km/s
%   mu - gavitational parameter, km^3/s^2 
% 
% [f, g, fdot, gdot] = fg_E(dE, dt, a, r0, v0, mu)

r0m = norm(r0);

f = 1 - (a/r0m) * (1 - cos(dE));
g = dt - sqrt(a^3/mu) * (dE - sin(dE));

r = f * r0 + g * v0;
rm = norm(r);

fdot = -sqrt(mu*a) / (rm*r0m) * sin(dE);
gdot = 1 - (a/rm) * (1 - cos(dE));