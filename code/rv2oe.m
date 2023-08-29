function [a, e, p, spece, h, incl, Omega, argp, Theta, TA, gamma, ...
    E, M, n, t] = rv2oe(r, v, mu)
% Converts position and velocity in J2000 to orbital elements
% 
% Inputs:
%   r - position vector, km
%   v - velocity vector, km
%   mu - gravitational parameter, km^3/s^2
% Outputs:
%   a - km
%   e - 
%   p - km
%   spece - km^3/s^2
%   h - km^2/s
%   incl - deg
%   Omega - deg
%   argp - deg
%   Theta - deg
%   TA - deg
%   gamma - deg
%   E - deg
%   M - deg
%   n - rad/s
%   t - sec
% 
% Function call:
% [a, e, p, spece, h, incl, Omega, argp, Theta, TA, gamma, ...
%     E, M, n, t] = rv2oe(r, v, mu)

% Magnitudes
rm = sqrt(r(1)^2 + r(2)^2 + r(3)^2); % km
vm = sqrt(v(1)^2 + v(2)^2 + v(3)^2); % km/s

% Specific energy
spece = vm^2 / 2 - mu / rm; % km^2/s^2 (negative == elliptic)

% Semi major axis
a = -mu / (2*spece);

% Eccentricity
h = cross(r, v);
hm = norm(h);
h_hat = h / hm;
p = hm^2 / mu;
e = sqrt(1 - p/a);

% Inclination (always take positive value)
z = [0;0;1];
incl = acosd(dot(z, h_hat));

% Longitude of ascending node
Omega = CheckQuadrant(asind(h_hat(1) / sind(incl)),...
                      acosd(-h_hat(2) / sind(incl)));

% Theta
r1_hat = r / rm;
t1_hat = cross(h_hat, r1_hat);
Theta = CheckQuadrant(asind(r1_hat(3) / sind(incl)),...
                      acosd(t1_hat(3) / sind(incl)));

% True anomoly
TA = acosd((1/e)*(p/rm - 1));
C = R3(deg2rad(Theta))*R1(deg2rad(incl))*R3(deg2rad(Omega));
vr = C*v;
if vr(1) < 0
    TA = -TA;
end

% Flight path angle
gamma = acosd(hm / (rm*vm));
if TA > 180 || TA < 0
    gamma = -gamma;
end

% argument of periapsis
argp = Theta - TA;

% Eccentric anomoly
E = 2 * atand(sqrt((1-e)/(1+e)) * tand(TA / 2));

% Time parameter and mean anomoly
n = sqrt(mu / a^3); % rad/s
t = (deg2rad(E) - e*sind(E)) / n; % sec
M = rad2deg(n*t); % degrees