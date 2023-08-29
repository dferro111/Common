function [dPsi, dEps] = get_dPsi_dEps(T, c)
% Calculates dPsi and dEps parameters for coordinate transforms
% 
% Inputs:
%   T - time parameter days since J2000 in centuries, TT
%   c - coefficient table
% Outputs:
%   dPsi - change in polar direction, rad
%   dEps - change in eliptic direction, rad

% Converstion factors
arcsec2rad = deg2rad(1/3600);

% Calculate the parameters [deg]
l = dms(134, 57, 46.733) + dms(477189, 52, 2.633) * T ...
    + dms(0, 0, 31.310) * T^2 + dms(0, 0, 0.064) * T^3; 
lp = dms(357, 31, 39.804) + dms(35999, 3, 1.244) * T ...
    - dms(0, 0, 0.577) * T^2 - dms(0, 0, 0.012) * T^3;
F = dms(93, 16, 18.877) + dms(483202, 1, 3.137) * T ...
    - dms(0, 0, 13.257) * T^2 + dms(0, 0, 0.011) * T^3;
D = dms(297, 51, 1.307) + dms(445267, 6, 41.328) * T ...
    - dms(0, 0, 6.891) + T^2 + dms(0, 0, 0.019) * T^3;
O = dms(125, 2, 40.280) - dms(1934, 8, 10.539) * T ...
    + dms(0, 0, 7.445) + T^2 + dms(0, 0, 0.008) * T^3;

% Initialize the series
dPsi = 0;
dEps = 0;

% Series evolution
for ii = 1:106
    % Parameters for the summation
    phi = c.Var2(ii) * l + c.Var3(ii) * lp + c.Var4(ii) * F ...
        + c.Var5(ii) * D + c.Var6(ii) * O; % deg
    dp = (c.Var7(ii) + c.Var8(ii) * T) * 0.0001; % Arcsec
    de = (c.Var9(ii) + c.Var10(ii) * T) * 0.0001; % Arcsec
    
    % Add [arcsec]
    dPsi = dPsi + dp*sind(phi);
    dEps = dEps + de*cosd(phi);
end

% Convert to rad
dPsi = dPsi * arcsec2rad;
dEps = dEps * arcsec2rad;