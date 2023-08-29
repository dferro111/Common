function R = R1(a)
% Counterclockwise rotation about Euler axis 1 by angle a
% 
% Inputs:
%   a - angle to rotate, rad
% Output:
%   R - rotation matrix

R = [1,       0,      0;
     0,  cos(a), sin(a);
     0, -sin(a), cos(a)];