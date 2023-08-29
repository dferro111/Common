function [r, v] = Laplace_IOD(t, ra, dec, R, mu)
% Laplace Initial Orbit Determination of optical measurements.
% 
% Inputs:
%   t - time of the observations, sec
%   ra - right ascension of the observations, rad
%   dec - declination of the observations, rad
%   R - topocenter location of the second observations, km
%   mu - gravitational parameter, km^3/s^2
% Outputs:
%   r - position of second observation, km
%   v - velocity at the second observation, km/s
% 
% [r, v] = Laplace_IOD(t, ra, dec, R, mu)


% Angular velocity of the Earth % rad/sec
omega = [0; 0; 2*pi] / (23 * 3600 + 56 * 60 + 4); 

% Earth Radius
Re = 6378.1363; % km

% Observer velocity and acceleration
Rd = cross(omega, R); % km/s
Rdd = cross(omega, Rd); % km/s^2

% LOS vectors
L1 = radec2r(ra(1), dec(1));
L2 = radec2r(ra(2), dec(2));
L3 = radec2r(ra(3), dec(3));

% Lagrange interpolation coefficients 
s1 = (t(2)-t(3)) / ((t(1)-t(2)) * (t(1)-t(3))); % [1/s]
s2 = (2*t(2) - t(1) - t(3)) / ((t(2)-t(1)) * (t(2)-t(3)));
s3 = (t(2)-t(1)) / ((t(3)-t(1)) * (t(3)-t(2)));
s4 = 2 / ((t(1)-t(2)) * (t(1)-t(3))); % [1/s^2]
s5 = 2 / ((t(2)-t(1)) * (t(2)-t(3)));
s6 = 2 / ((t(3)-t(1)) * (t(3)-t(2)));

% LOS and associated rates
L = L2;
Ld = s1*L1 + s2*L2 + s3*L3; % [1/s]
Ldd = s4*L1 + s5*L2 + s6*L3; % [1/s^2]

% Determinants
D0 = 2*det([L, Ld, Ldd]);
D1 = det([L, Ld, Rdd]);
D2 = det([L, Ld, R]);
D3 = det([L, Rdd, Ldd]);
D4 = det([L, R, Ldd]);

% Polynomial Coefficients
a = -4*(D1/D0)^2 + 4*(D1/D0)*dot(L,R) - norm(R)^2;
b = -8*mu*(D1/D0)*(D2/D0) + 4*mu*(D2/D0)*dot(L,R);
c = -4*mu^2*(D2/D0)^2;

% Position vector magnitude root finding
rm = roots([1, 0, a, 0, 0, b, 0, 0, c]);

% Take the root that is positive real and valid. Stop function if no roots
rm = rm(real(rm) > Re & imag(rm) == 0);
if isempty(rm)
    fprintf('No valid root found!!\n')
    r = zeros(3,1);
    v = zeros(3,1);
    return
end

% Range and range rate
rho = -2*(D1/D0) - 2*mu*rm^(-3)*(D2/D0);
rhod = -(D3/D0) - mu*rm^(-3)*(D4/D0);

% Object position and velocity
r = R + rho*L;
v = Rd + rhod*L + rho*Ld;

