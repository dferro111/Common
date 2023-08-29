function vp = QoV(q, v)
% Multiply input quaternion and vector
% 
% inputs:
%   q - quaternion, q(4) is the real component
%   v - vector, [x,y,z]
% outputs:
%   vp = rotated vector, [x,y,z]

p = [v; 0];
qinv = QInv(q);

qinvp = QoQ(qinv, p);
pp = QoQ(qinvp, q);

vp = pp(1:3);


end