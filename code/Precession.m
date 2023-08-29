function P = Precession(JD, inv)
% Calculates rotation matrix due to Precession. Can rotate between r_GCRF
% to r_MOD and back based on a flag.
% 
% Inputs:
%   JD - julian date, days
%   inv - inverse flag
%           0: GCRF->MOD
%           1: MOD->GCRF
% Outputs:
%   P - precession matrix

% Arcsec 2 radians conversion
arcsec2rad = deg2rad(1/3600);
sec2days = 1/24/60/60;

% Time parameter with TT Correction
JD = 64.184 * sec2days + JD; % Correct time to TT
T = (JD - 2451545.0)/36525;

% Euler angles [arcsec]
zeta = 2306.2181 * T + 0.30188 * T^2 + 0.017998 * T^3;
theta = 2004.3109 * T - 0.42665 * T^2 - 0.041833 * T^3;
z = zeta + 0.79280 * T^2 + 0.000205 * T^3;

% Convert to radians
zeta = arcsec2rad * zeta;
theta = arcsec2rad * theta;
z = arcsec2rad * z;

% Calculate precession matrix to or from MOD
if inv
    P = R3(z) * R2(-theta) * R3(zeta);
else
    P = R3(-z) * R2(theta) * R3(-zeta);
end
