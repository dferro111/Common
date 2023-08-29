function T = EarthRotation(GMST, JD, coeffs, inv)
% Rotation matrix due to Earths rotation
% 
% Inputs:
%   GMST - greenwitch mean sidereal time, hr
%   JD - julian date, days
%   coeffs - file path to nutation coefficients
%   inv - inverse flag
%           0: TOD->GTOD 
%           1: GTOD->TOD
% Outputs:
%   T - rotation matrix

% Converstion factors
sec2days = 1/24/60/60;

% Angle corresponding to the GMST
a = deg2rad(GMST * 15);

% Time Parameter in TT
JD = 64.184 * sec2days + JD; % Correct time to TT
T = (JD - 2451545.0) / 36525;

% ecliptic
eps = 23.43929111 - dms(0, 0, 46.8150) * T - dms(0, 0, 0.00059) * T^2 ...
    + dms(0, 0, 0.001813) * T^3;
eps = deg2rad(eps);

% delta psi
[dPsi, ~] = get_dPsi_dEps(T, coeffs);

% Rotation about Earth Rotation Axis by true sidereal time
T = R3(a + dPsi*cos(eps));
if inv
    T = T';
end