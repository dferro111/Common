function R = R2(a)
% Counterclockwise rotation about Euler axis 2 by angle a
% 
% Inputs:
%   a - angle to rotate, rad
% Output:
%   R - rotation matrix

R = [cos(a), 0, -sin(a);
     0     , 1,       0;
     sin(a), 0,  cos(a)];