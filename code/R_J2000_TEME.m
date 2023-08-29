function rot = R_J2000_TEME(JD, GMST, coeffs, inv)
% Calculates the rotation matrix between TEME and J2000
% 
% Inputs:
%   JD - julian date, days
%   GMST - greenwitch mean sidereal time, hr
%   coeffs - path to nutation coefficients
%   inv - inverse flag
%           0: J2000->TEME
%           1: TEME->J2000
% Outputs:
%   rot - rotation matrix

% Get rotation matricies for each effect
P = Precession(JD, inv);
N = Nutation(JD, coeffs, inv);
T = EarthRotation(GMST, JD, coeffs, inv);
R = R_Teme2Gtod(GMST, ~inv);

if inv
    rot = P * N * T * R;
else
    rot = R * T * N * P;
end