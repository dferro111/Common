function R = R_Teme2Gtod(GMST, inv)
% Rotate between TEME and GTOD
% 
% Inputs:
%   GMST - greenwitch mean sidereal time, hr
%   inv - inverse flag
%           0: TEME->GTOD
%           1: GTOD->TEME
% Outputs:
%   R - rotation matrix

% Convert GMST to rad
GMST = deg2rad(GMST * 15);

if inv
    R = R3(-GMST);
else
    R = R3(GMST);
end