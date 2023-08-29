function q = aa2q(ax, a)
% Construct a quaternion from an axis and angle
% 
% inputs:
%   ax - axis of rotation, [x,y,z]
%   a - angle of rotation, rad
% outputs:
%   q = quaternion, real component is q(4)

q(1) = ax(1) * sin(a/2);
q(2) = ax(2) * sin(a/2);
q(3) = ax(3) * sin(a/2);
q(4) = cos(a/2);
end