function a = drag_accel(r, v, CD, A, mass, tbl)
% Calculates acceleration due to drag.
%
% Inputs:
%   r - position in eci, km
%   v - velocity in eci, km/s
%   CD- coefficient of drag
%   A - characteristic area, km^2
%   mass - mass, kg
%   tbl - table of reference drag parameters
% 
% Outputs:
%   a - acceleration in eci, km/s^2
% 
% a = drag_accel(r, v, CD, A, mass, tbl)


% Conversion factors
m2km = 1/1000;

% Earth Radius
Re = 6.3781e3; % km

% Relative velocity
omega = [0;0;2*pi] / (24*3600); % rad/s
vp = v - cross(omega, r);

% Get rho by the largest altitude that we are greater than 
isrho = 0; % flag to check if rho got assigned
for ii = length(tbl.Var1):-1:1
    if (norm(r) > (tbl.Var1(ii) + Re)) && ~isrho
        rho = (tbl.Var3(ii) / m2km^3) * exp(-(norm(r)-Re) / tbl.Var2(ii));
        isrho = 1;
    end
end
if ~isrho
    rho = 0;
    fprintf('ERROR: density not assigned\n')
end

a = -(CD/2) * rho * (A/mass) * dot(vp, vp) * (vp/norm(vp));

