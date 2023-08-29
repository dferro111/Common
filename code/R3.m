function R = R3(a)
% Counterclockwise rotation about Euler axis 3 by angle a
% 
% Inputs:
%   a - angle to rotate, rad
% Output:
%   R - rotation matrix

R = [cos(a), sin(a), 0;
    -sin(a), cos(a), 0;
     0     ,      0, 1];
