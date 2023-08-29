function R = refraction(h, T, P)
% Calculates refraction due to the atmosphere
% 
% Inputs
%   h - observed elevation. deg
%   T - temperature of the observer, K
%   P - pressure at the observer, hPa
% Outputs
%   R - refraction R=h'-h

z = deg2rad(90 - h);
R = (P/T)*(3.430289*(z - asin(0.9986047*sin(0.996714*z))) - 0.01115929*z);