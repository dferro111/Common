function R = R_Teme2Tod(JD, coeffs, inv)
% Rotate from TEME to TOD or vice versa
% 
% Inputs:
%   JD - julian date, days
%   coeffs - file path to nutation coefficients 
%   inv - inverse flag
%           0: TEME->TOD
%           1: TOD->TEME
% Outputs:
%   R - rotation

% Conversion factors
sec2days = 1/60/60/24;

% Time Parameter
JD = 64.184 * sec2days + JD; % Correct time to TT
T = (JD - 2451545.0) / 36525;

% ecliptic
eps = 23.43929111 - dms(0, 0, 46.8150) * T - dms(0, 0, 0.00059) * T^2 ...
    + dms(0, 0, 0.001813) * T^3;
eps = deg2rad(eps);

[dPsi, ~] = get_dPsi_dEps(T, coeffs);

if inv
    R = R3(dPsi*cos(eps));
else
    R = R3(-dPsi*cos(eps));
end