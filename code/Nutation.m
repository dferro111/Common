function N = Nutation(JD, coeffs, inv)
% Calculates nutation matrix using extended parameters and the series
% expansion using 106 terms in the coeffs file. MOD->TOD
% 
% Inputs:
%   JD - Julian Date
%   coeffs - file path to a text file with Nutation coefficients
%   inv - inverse flag
%           0: MOD->TOD
%           1: TOD->MOD
% Outputs:
%   N - nutation matrix

% Converstion factors
sec2days = 1/24/60/60;

% Time parameter
JD = 64.184 * sec2days + JD; % Correct time to TT
T = (JD - 2451545.0) / 36525;

% ecliptic
eps = 23.43929111 - dms(0, 0, 46.8150) * T - dms(0, 0, 0.00059) * T^2 ...
    + dms(0, 0, 0.001813) * T^3;
eps = deg2rad(eps);

% Get the parameters for the nutation matrix
[dPsi, dEps] = get_dPsi_dEps(T, coeffs);

% Contruct rotation matrix
N = R1(-eps - dEps) * R3(-dPsi) * R1(eps);

if inv
    N = N';
end
