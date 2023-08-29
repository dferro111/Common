function rot = R_J2000_ITRS(JD, MJD, GMST, coeffs, eop2, inv)
% Convert position between J2000 frame and ITRS frame
% 
% Inputs:
%   JD - julian date, days
%   MJD - modified julian date, days
%   GMST - greenwitch mean sidereal time, hours
%   coeffs - file path for Nutation coefficients
%   eop2 - file path for Polar motion parameters
%   inv - inverse flag
%           0: J2000->ITRS
%           1: ITRS->J2000
% Outputs:
%   rot - rotation matrix
% 
% rot = R_J2000_ITRS(JD, MJD, GMST, coeffs, eop2, inv)

% Get rotation matricies for each effect
P = Precession(JD, inv);
N = Nutation(JD, coeffs, inv);
T = EarthRotation(GMST, JD, coeffs, inv);
PM = PolarMotion(MJD, eop2, inv);

% Convert from ITRS frame to J2000 frame
if inv
    rot = P * N * T * PM;
else
    rot = PM * T * N * P;
end