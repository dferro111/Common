function P = PolarMotion(MJD, eop2, inv)
% Determines polar motino matrix given a file of eop2. 
% 
% Inputs:
%   MJD - modified julian date
%   eop2 - table with eop2 data
%   inv - inverse flag
%           0: GTOD->ITRF
%           1: ITRF->GTOD
% Outputs:
%   P - Polar Motion matrix

% mas 2 rad
mas2rad = deg2rad((1/1000)*(1/3600));

% Find the PMx and PMy for the MJD
PMx = eop2.Var2(round(MJD) == eop2.Var1);
PMy = eop2.Var3(round(MJD) == eop2.Var1);

% Convert to rad
PMx = PMx * mas2rad;
PMy = PMy * mas2rad;

% Generate matrix
P = R2(-PMx) * R1(-PMy);

if inv
    P = P';
end