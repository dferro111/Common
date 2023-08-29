function p = QInv(q)
% Invert input quaternion
% 
% inputs:
%   q - quaternion, q(4) is the real component
% outputs:
%   p = inverse quaternion, [-q(1:3) q(4)]

p = [-q(1:3); q(4)];
end