function [f, g, fdot, gdot] = fg_H(dH, dt, a, r0v, v0v, mu)
% Calculate f and g values for an elliptic orbit. Used to obtain new
% position and velocity vector based on a previous one.
% 
% Inputs:
%   dH - change in eccentric anomoly, rad
%   dt - change in time, sec
%   a - semi-major axis, km
%   r0v - initial position, km
%   v0v - initial velocity, km/s
%   mu - gavitational parameter, km^3/s^2 

r0 = norm(r0v);

f = 1 - abs(a)/r0 * (cosh(dH) - 1);
g = dt - sqrt(abs(a)^3/mu) * (sinh(dH) - dH);

rv = f*r0v + g*v0v;
r = norm(rv);

fdot = -sqrt(mu*abs(a))/(r*r0) * sinh(dH);
gdot = 1 - abs(a) / r * (cosh(dH) - 1);