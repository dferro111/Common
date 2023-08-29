function p = plot_pos_vel(r, ta, v, gamma, s, sv)
% 
% Inputs:
%   r - position magnitude
%   ta - true anomoly, deg
%   v - velocity magnitude
%   gamma - flight path angle, deg
%   s - unit vector scale factor
%   sv - velocity vector scale factor

ta = deg2rad(ta);
rep = R_rt2ep(ta) * [r;0];
v1ep = R_rt2ep(ta) * v*[sind(gamma); cosd(gamma)];

% lh
that = R_rt2ep(ta) * [0;s];
p(1) = quiver(rep(1), rep(2),  that(1),  that(2), '--', ...
    'color', 'k', 'ShowArrowHead','off');
quiver(rep(1), rep(2), -that(1), -that(2), '--', ...
    'color', 'k', 'ShowArrowHead','off');

% r
p(2) = quiver(0,0,rep(1), rep(2), 'AutoScale', 'off');

% v
if v ~= 0
    p(3) = quiver(rep(1), rep(2), sv*v1ep(1), sv*v1ep(2),'AutoScale', 'off');
end