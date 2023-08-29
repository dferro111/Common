function xdot = orbit_eoms(t, x, mu, varargin)
% Equations of motion for the two body point mass problem. Includes
% additional acceleration terms.
% 
% Additional inputs:
%   mu - grav param, km^3/s^2
%   varargin - acceleration terms in ECI, km/^s
%       all get summed together
% 
% xdot = EOMs(t, x, mu, varargin)

% Magnitude of the radius
xm = sqrt(x(1)^2 + x(2)^2 + x(3)^2);

a = zeros(3,1);
for ii = 1:length(varargin)
    a = a + varargin{ii};
end

xdot = zeros(6,1);
xdot(1) = x(4);
xdot(2) = x(5);
xdot(3) = x(6);
xdot(4) = -mu/xm^3 * x(1) + a(1);
xdot(5) = -mu/xm^3 * x(2) + a(2);
xdot(6) = -mu/xm^3 * x(3) + a(3);